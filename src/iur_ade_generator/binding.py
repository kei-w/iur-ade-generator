"""Add the JAXB renames needed by the generators to an ade-xjc binding file. Idempotent.

* uro feature types: ade-xjc binds the whole content of a type as a generic "rest" list when an element clashes with an
  inherited JAXB property (AbstractConstruction/boundedBy with gml:boundedBy, PublicLand/id with gml:id); renaming the
  properties keeps the usual accessors. Editions without these types (uro 2.0) are left untouched because xjc rejects
  bindings that match nothing.
* urf, urg and urt: the package of the module's section follows the schema version; the feature types with an id,
  boundedBy or location element (DisasterDamage, Zone, ...) get the same renames as above, a name or description
  element of a feature type (urt Agency, Route) is prefixed with the type (agencyName, routeDescription); and elements with a hyphen
  (lod-1MultiSurface), which collide with lod1MultiSurface in the JAXB property and factory names, are renamed
  lodMinus1MultiSurface (the model accessors are named alike, see naming.java_name).

Usage: iur-ade patch-binding <citygml4j repo or folder with binding.xjb and schemas/>
"""

from __future__ import annotations

import logging
import os
import re
import sys
import xml.etree.ElementTree as ET

from .naming import feature_field, java_name

log = logging.getLogger(__name__)

XS = "{http://www.w3.org/2001/XMLSchema}"
RENAMES = [("AbstractConstructionType", "boundedBy"), ("PublicLandType", "id")]
# the generated modules besides uro: schema file -> prefix
VERSIONED_SCHEMAS = {"urbanFunction.xsd": "urf", "statisticalGrid.xsd": "urg", "publicTransit.xsd": "urt"}
NL = "\n"


def rename_block(type_name: str, element: str, indent: str = "    ") -> tuple[str, str]:
    node = "xs:complexType[@name='%s']//xs:element[@name='%s']" % (type_name, element)
    return node, NL.join(
        [
            indent + '<jaxb:bindings node="%s">' % node,
            indent + '  <jaxb:property name="%s"/>' % feature_field(type_name, element),
            indent + "</jaxb:bindings>",
        ]
    )


def has_rename(section: str, type_name: str, element: str) -> bool:
    """Whether the section binds the element of the type already (also in the nested form of the hand-written
    sections: a binding of the type with a binding of the element inside)."""
    nested = r"@name='%s'\]\">\s*<jaxb:bindings node=\"\.//xs:element\[@name='%s'\]\">" % (type_name, element)
    return rename_block(type_name, element)[0] in section or re.search(nested, section) is not None


def derived_type_renames(xsd_path: str) -> list[tuple[str, str]]:
    """(type, element) pairs of the derived complex types whose own elements clash with inherited GML properties."""
    pairs = []
    for ct in ET.parse(xsd_path).getroot().findall(XS + "complexType"):
        if ct.find(".//" + XS + "extension") is None:
            continue
        for e in ct.iter(XS + "element"):
            if feature_field(ct.get("name", ""), e.get("name", "")) is not None:
                pairs.append((ct.get("name", ""), e.get("name", "")))
    return pairs


def module_section(s: str, xsd_name: str, xsd_path: str, prefix: str) -> tuple[str, str] | None:
    """(the section of the module in the binding file, its new content) or None when the schema is not versioned."""
    with open(xsd_path, encoding="utf-8") as f:
        xsd = f.read()
    m = re.search(r'targetNamespace="https://www.geospatial.jp/iur/%s/([0-9.]+)"' % prefix, xsd)
    if not m:
        return None
    pkg = "jp.geospatial.iur._%s.%s" % (m.group(1).replace(".", "_"), prefix)
    a = s.index('  <jaxb:bindings schemaLocation="schemas/%s" node="/xs:schema">' % xsd_name)
    b = s.index(NL + "  </jaxb:bindings>", a)
    section = s[a:b]
    new_section = re.sub(r'<jaxb:package name="[A-Za-z0-9_.]+"/>', '<jaxb:package name="%s"/>' % pkg, section)
    renames = derived_type_renames(xsd_path)
    for type_name, element in renames:
        if not has_rename(new_section, type_name, element):
            new_section += NL + rename_block(type_name, element)[1]
    names = sorted(set(re.findall(r'<xs:element name="(lod-[0-9][A-Za-z0-9]*)"', xsd)))
    for n in names:
        if "@name='%s'" % n in new_section:
            continue
        new_section += NL + NL.join(
            [
                '    <jaxb:bindings node="//xs:element[@name=\'%s\']" multiple="true">' % n,
                '      <jaxb:property name="%s"/>' % java_name(n),
                "    </jaxb:bindings>",
            ]
        )
    log.debug("%s %s: %d feature renames, hyphenated elements %s", prefix, m.group(1), len(renames), names)
    return section, new_section


def patch_binding(folder: str) -> list[str]:
    """Adds the renames to ``binding.xjb`` of the folder (or of ``resources/ade-xjc`` of a citygml4j repository);
    returns the descriptions of the additions."""
    folder = (
        folder if os.path.isfile(os.path.join(folder, "binding.xjb")) else os.path.join(folder, "resources", "ade-xjc")
    )
    with open(os.path.join(folder, "schemas", "urbanObject.xsd"), encoding="utf-8") as f:
        xsd = f.read()
    p = os.path.join(folder, "binding.xjb")
    with open(p, encoding="utf-8") as f:
        s = f.read()
    added = []
    for type_name, element in RENAMES:
        node, block = rename_block(type_name, element)
        if 'name="%s"' % type_name not in xsd or node in s:
            continue
        anchor = "    <jaxb:bindings node=\"xs:element[@name='buildingDetailAttribute']\">"
        if anchor not in s:
            raise ValueError("anchor not found in " + p)
        s = s.replace(anchor, block + NL + anchor, 1)
        added.append("%s/%s" % (type_name, element))
    for xsd_name, prefix in VERSIONED_SCHEMAS.items():
        xsd_path = os.path.join(folder, "schemas", xsd_name)
        if not os.path.exists(xsd_path):
            continue
        result = module_section(s, xsd_name, xsd_path, prefix)
        if result is None:
            continue
        section, new_section = result
        if new_section != section:
            s = s.replace(section, new_section, 1)
            added.append("%s section" % prefix)
    if added:
        with open(p, "w", encoding="utf-8", newline=NL) as f:
            f.write(s)
    return added


def main(argv: list[str] | None = None) -> None:
    argv = sys.argv[1:] if argv is None else list(argv)
    added = patch_binding(argv[0])
    log.info("binding renames added: %s", added or "none (already applied or not needed)")
