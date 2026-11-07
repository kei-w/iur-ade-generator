"""Add the JAXB renames needed by the generators to an ade-xjc binding file. Idempotent.

* uro feature types: ade-xjc binds the whole content of a type as a generic "rest" list when an element clashes with an
  inherited JAXB property (AbstractConstruction/boundedBy with gml:boundedBy, PublicLand/id with gml:id); renaming the
  properties keeps the usual accessors. Editions without these types (uro 2.0) are left untouched because xjc rejects
  bindings that match nothing.
* urf 3.x: the package of the urf section follows the schema version; the feature types with an id or location element
  (DisasterDamage, Zone, ...) get the same renames as above; and elements with a hyphen (lod-1MultiSurface), which
  collide with lod1MultiSurface in the JAXB property and factory names, are renamed lodMinus1MultiSurface (the model
  accessors are named alike, see urospec.java_name).

Usage: patch_binding.py <citygml4j repo or folder with binding.xjb and schemas/>
"""

import io
import os
import re
import sys
import xml.etree.ElementTree as ET

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from .urospec import FEATURE_FIELD_NAMES, java_name

XS = "{http://www.w3.org/2001/XMLSchema}"
RENAMES = [("AbstractConstructionType", "boundedBy"), ("PublicLandType", "id")]
NL = chr(10)


def rename_block(type_name, element, indent="    "):
    node = "xs:complexType[@name='%s']//xs:element[@name='%s']" % (type_name, element)
    return node, NL.join(
        [
            indent + '<jaxb:bindings node="%s">' % node,
            indent + '  <jaxb:property name="%s"/>' % FEATURE_FIELD_NAMES[element],
            indent + "</jaxb:bindings>",
        ]
    )


def derived_type_renames(xsd_path):
    """(type, element) pairs of the derived complex types whose own elements clash with inherited GML properties."""
    pairs = []
    for ct in ET.parse(xsd_path).getroot().findall(XS + "complexType"):
        if ct.find(".//" + XS + "extension") is None:
            continue
        for e in ct.iter(XS + "element"):
            if e.get("name") in FEATURE_FIELD_NAMES:
                pairs.append((ct.get("name"), e.get("name")))
    return pairs


def main():
    folder = sys.argv[1]
    folder = (
        folder if os.path.isfile(os.path.join(folder, "binding.xjb")) else os.path.join(folder, "resources", "ade-xjc")
    )
    xsd = io.open(os.path.join(folder, "schemas", "urbanObject.xsd"), encoding="utf-8").read()
    p = os.path.join(folder, "binding.xjb")
    s = io.open(p, encoding="utf-8").read()
    added = []
    for type_name, element in RENAMES:
        node, block = rename_block(type_name, element)
        if 'name="%s"' % type_name not in xsd or node in s:
            continue
        anchor = "    <jaxb:bindings node=\"xs:element[@name='buildingDetailAttribute']\">"
        assert anchor in s, "anchor not found in " + p
        s = s.replace(anchor, block + NL + anchor, 1)
        added.append("%s/%s" % (type_name, element))
    urf_path = os.path.join(folder, "schemas", "urbanFunction.xsd")
    urf = io.open(urf_path, encoding="utf-8").read() if os.path.exists(urf_path) else ""
    m = re.search(r'targetNamespace="https://www.geospatial.jp/iur/urf/([0-9.]+)"', urf)
    if m:
        pkg = "jp.geospatial.iur._%s.urf" % m.group(1).replace(".", "_")
        a = s.index('  <jaxb:bindings schemaLocation="schemas/urbanFunction.xsd" node="/xs:schema">')
        b = s.index(NL + "  </jaxb:bindings>", a)
        section = s[a:b]
        new_section = re.sub(r'<jaxb:package name="[A-Za-z0-9_.]+"/>', '<jaxb:package name="%s"/>' % pkg, section)
        renames = derived_type_renames(urf_path)
        for type_name, element in renames:
            node, block = rename_block(type_name, element)
            if node not in new_section:
                new_section += NL + block
        names = sorted(set(re.findall(r'<xs:element name="(lod-[0-9][A-Za-z0-9]*)"', urf)))
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
        if new_section != section:
            s = s[:a] + new_section + s[b:]
            added.append(
                "urf %s package, %d feature renames and hyphenated elements %s" % (m.group(1), len(renames), names)
            )
    if added:
        io.open(p, "w", encoding="utf-8", newline=NL).write(s)
    print("binding renames added:", added or "none (already applied or not needed)")
    return bool(added)


if __name__ == "__main__":
    main()
