"""Generate a CityGML 2.0 test file that carries every generic application property and every ADE feature type of the
generated modules with all fields populated.

Usage: iur-ade fixture <citygml4j repo> <citydb repo> <uro version e.g. 3.1> <preset> <out.gml> [modules: uro,urf]
"""

from __future__ import annotations

import logging
import os
import sys
from collections import OrderedDict
from collections.abc import Sequence

from .citygml4j.generator import select_hooks
from .errors import GeneratorError
from .spec import Field, Hook, Spec, Type, modules_for

log = logging.getLogger(__name__)

NS = OrderedDict(
    [
        ("core", "http://www.opengis.net/citygml/2.0"),
        ("gml", "http://www.opengis.net/gml"),
        ("bldg", "http://www.opengis.net/citygml/building/2.0"),
        ("brid", "http://www.opengis.net/citygml/bridge/2.0"),
        ("tun", "http://www.opengis.net/citygml/tunnel/2.0"),
        ("luse", "http://www.opengis.net/citygml/landuse/2.0"),
        ("frn", "http://www.opengis.net/citygml/cityfurniture/2.0"),
        ("dem", "http://www.opengis.net/citygml/relief/2.0"),
        ("tran", "http://www.opengis.net/citygml/transportation/2.0"),
        ("veg", "http://www.opengis.net/citygml/vegetation/2.0"),
        ("wtr", "http://www.opengis.net/citygml/waterbody/2.0"),
        ("grp", "http://www.opengis.net/citygml/cityobjectgroup/2.0"),
        ("xAL", "urn:oasis:names:tc:ciq:xsdschema:xAL:2.0"),
        ("xlink", "http://www.w3.org/1999/xlink"),
        ("xsi", "http://www.w3.org/2001/XMLSchema-instance"),
    ]
)
SRS = "urn:ogc:def:crs:EPSG::6697"
POS = "36.39 139.06 100.0"
RING = "36.39 139.06 100.0 36.39 139.061 100.0 36.391 139.061 100.0 36.391 139.06 100.0 36.39 139.06 100.0"
LINE = "36.39 139.06 100.0 36.391 139.061 101.0"
TRIANGLE = "36.39 139.06 100.0 36.39 139.061 100.0 36.391 139.061 100.0 36.39 139.06 100.0"

# CityGML base type of the ADE feature types -> hook targets whose generic application properties they carry
FEATURE_HOOK_TARGETS = {
    "bldg:AbstractBuildingType": ["AbstractBuilding"],
    "tran:TransportationComplexType": ["TransportationObject", "TransportationComplex"],
    "frn:CityFurnitureType": ["CityFurniture"],
    "luse:LandUseType": ["LandUse"],
}
# hook targets of the building parts and the city object members written with their hooks only
BUILDING_TARGETS = {
    "Room",
    "Opening",
    "BoundarySurface",
    "BuildingInstallation",
    "IntBuildingInstallation",
    "BuildingFurniture",
}
SIMPLE_MEMBERS = [
    ("AbstractBridge", "brid:Bridge"),
    ("AbstractTunnel", "tun:Tunnel"),
    ("LandUse", "luse:LandUse"),
    ("CityFurniture", "frn:CityFurniture"),
    ("Railway", "tran:Railway"),
    ("Track", "tran:Track"),
    ("Square", "tran:Square"),
    ("VegetationObject", "veg:SolitaryVegetationObject"),
    ("WaterBody", "wtr:WaterBody"),
    ("CityObjectGroup", "grp:CityObjectGroup"),
]


class Fixture:
    def __init__(self, spec: Spec, hooks: Sequence[Hook], features: Sequence[Type], version: str, label: str) -> None:
        self.spec = spec
        self.hooks = list(hooks)
        self.features = list(features)
        self.version = version
        self.label = label
        self.counter = 0
        self.first_gid = ""
        self.member_gid: dict[str, str] = {}

    # ----------------------------------------------------------------- values
    def value(self, f: Field, idx: int) -> str:
        k = f.kind
        n = f.name
        if k == "string":
            if f.enum_values:
                return f.enum_values[idx % len(f.enum_values)]
            return "%s %d" % (n, idx)
        if k == "integer":
            return str(10 + idx)
        if k == "double":
            return "%.1f" % (1.5 + idx)
        if k == "boolean":
            return "true" if idx % 2 == 0 else "false"
        if k == "date":
            return "2024-01-%02d" % (2 + idx % 26)
        if k == "time":
            return "08:%02d:00" % (idx % 60)
        if k == "year":
            return str(2020 + idx)
        if k == "yearMonth":
            return "2024-%02d" % (3 + idx % 9)
        if k == "doubleList":
            return "1.0 2.0 3.0"
        if k == "directPosition":
            return POS
        if k == "enum":
            values = f.enum_type.values
            return values[idx % len(values)]
        raise GeneratorError(f"no fixture value for a field of kind {k}")

    def element(self, f: Field, depth: int, idx: int, lines: list[str], ind: str) -> None:
        owner = f.owner
        if owner is None:
            raise GeneratorError(f"field {f} has no owner")
        tag = owner.module.prefix + ":" + f.name
        k = f.kind
        if k == "code":
            lines.append('%s<%s codeSpace="../../codelists/Test_%s.xml">%d</%s>' % (ind, tag, f.name, idx + 1, tag))
        elif k == "stringOrRef":
            lines.append("%s<%s>%s %d</%s>" % (ind, tag, f.name, idx, tag))
        elif k == "measure":
            lines.append('%s<%s uom="m2">%.1f</%s>' % (ind, tag, 12.5 + idx, tag))
        elif k == "length":
            lines.append('%s<%s uom="m">%.1f</%s>' % (ind, tag, 3.5 + idx, tag))
        elif k == "geometry":
            if idx % 2 == 0:
                lines.append(
                    '%s<%s><gml:Point srsName="%s" srsDimension="3"><gml:pos>%s</gml:pos></gml:Point></%s>'
                    % (ind, tag, SRS, POS, tag)
                )
            else:
                lines.append(
                    '%s<%s><gml:Polygon srsName="%s" srsDimension="3"><gml:exterior><gml:LinearRing><gml:posList>%s'
                    "</gml:posList></gml:LinearRing></gml:exterior></gml:Polygon></%s>" % (ind, tag, SRS, RING, tag)
                )
        elif k == "point":
            lines.append(
                '%s<%s><gml:Point srsName="%s" srsDimension="3"><gml:pos>%s</gml:pos></gml:Point></%s>'
                % (ind, tag, SRS, POS, tag)
            )
        elif k == "multiSurface":
            lines.append(
                '%s<%s><gml:MultiSurface srsName="%s" srsDimension="3"><gml:surfaceMember><gml:Polygon><gml:exterior>'
                "<gml:LinearRing><gml:posList>%s</gml:posList></gml:LinearRing></gml:exterior></gml:Polygon>"
                "</gml:surfaceMember></gml:MultiSurface></%s>" % (ind, tag, SRS, RING, tag)
            )
        elif k == "multiCurve":
            lines.append(
                '%s<%s><gml:MultiCurve srsName="%s" srsDimension="3"><gml:curveMember><gml:LineString><gml:posList>%s'
                "</gml:posList></gml:LineString></gml:curveMember></gml:MultiCurve></%s>" % (ind, tag, SRS, LINE, tag)
            )
        elif k == "multiPoint":
            lines.append(
                '%s<%s><gml:MultiPoint srsName="%s" srsDimension="3"><gml:pointMember><gml:Point><gml:pos>%s</gml:pos>'
                "</gml:Point></gml:pointMember></gml:MultiPoint></%s>" % (ind, tag, SRS, POS, tag)
            )
        elif k == "cityObjectRef":
            lines.append('%s<%s xlink:href="#%s"/>' % (ind, tag, self.first_gid))
        elif f.is_feature_property:
            target = self.pick(f.nested, idx)
            if target.qname in self.member_gid:
                # a city object member (urf): referenced by xlink, as the Importer/Exporter writes it
                lines.append('%s<%s xlink:href="#%s"/>' % (ind, tag, self.member_gid[target.qname]))
                return
            lines.append("%s<%s>" % (ind, tag))
            self.feature_instance(target, depth + 1, idx, lines, ind + "  ")
            lines.append("%s</%s>" % (ind, tag))
        elif k == "complex":
            lines.append(
                '%s<%s><gml:GeometricComplex srsName="%s" srsDimension="3"><gml:element><gml:LineString><gml:posList>%s'
                "</gml:posList></gml:LineString></gml:element></gml:GeometricComplex></%s>" % (ind, tag, SRS, LINE, tag)
            )
        elif k == "address":
            lines.append(
                "%s<%s><core:Address><core:xalAddress><xAL:AddressDetails><xAL:Country><xAL:CountryName>Japan"
                '</xAL:CountryName><xAL:Locality Type="City"><xAL:LocalityName>Maebashi</xAL:LocalityName></xAL:Locality>'
                "</xAL:Country></xAL:AddressDetails></core:xalAddress></core:Address></%s>" % (ind, tag, tag)
            )
        elif k == "property":
            target = self.pick(f.nested, idx)
            if not f.required and any(d.required for d in target.dropped):
                return  # the target cannot be written completely (unsupported mandatory field)
            lines.append("%s<%s>" % (ind, tag))
            self.instance(target, depth + 1, idx, lines, ind + "  ")
            lines.append("%s</%s>" % (ind, tag))
        elif k == "inline":
            lines.append("%s<%s>" % (ind, tag))
            self.fields(f.nested, depth + 1, idx, lines, ind + "  ")
            lines.append("%s</%s>" % (ind, tag))
        else:
            lines.append("%s<%s>%s</%s>" % (ind, tag, self.value(f, idx), tag))

    @staticmethod
    def pick(t: Type, idx: int) -> Type:
        """A concrete type for a (possibly polymorphic) target: alternate between the first and the last concrete one."""
        concrete = [x for x in [t, *t.descendants()] if not x.abstract]
        return concrete[0] if idx % 2 == 0 else concrete[-1]

    def fields(self, t: Type, depth: int, idx: int, lines: list[str], ind: str) -> None:
        # of each choice group only the first alternative is written
        skip: set[str] = set()
        for a in [t, *t.ancestors()]:
            for group in a.choice_groups:
                skip.update(group[1:])
        for f in t.all_fields():
            if f.kind == "unsupported" or depth > 6 or f.name in skip:
                continue
            # references to members are written once: a repeated reference would duplicate a join table row
            count = (
                2
                if f.multi
                and f.kind != "cityObjectRef"
                and not (f.is_feature_property and self.pick(f.nested, idx).qname in self.member_gid)
                else 1
            )
            for i in range(count):
                self.element(f, depth, idx + i, lines, ind)

    def instance(self, t: Type, depth: int, idx: int, lines: list[str], ind: str) -> None:
        lines.append("%s<%s:%s>" % (ind, t.module.prefix, t.element_name))
        self.fields(t, depth, idx, lines, ind + "  ")
        lines.append("%s</%s:%s>" % (ind, t.module.prefix, t.element_name))

    def feature_instance(self, t: Type, depth: int, idx: int, lines: list[str], ind: str) -> None:
        """An ADE feature: gml:id and name, the generic application properties of its CityGML base type, then its
        fields."""
        element = t.element_name
        gid = self.member_gid[t.qname] if depth == 0 and t.qname in self.member_gid else self.gid(element.lower())
        lines.append('%s<%s:%s gml:id="%s">' % (ind, t.module.prefix, element, gid))
        lines.append("%s  <gml:name>Fixture %s</gml:name>" % (ind, element))
        if depth == 0 and t.root().core_base != "gml:AbstractFeatureType":
            self.hook_elements("CityObject", lines, ind + "  ")  # core hooks precede the base type's content
        for target in FEATURE_HOOK_TARGETS.get(t.root().core_base or "", []):
            self.hook_elements(target, lines, ind + "  ")
        self.fields(t, depth, idx, lines, ind + "  ")
        lines.append("%s</%s:%s>" % (ind, t.module.prefix, element))

    def hook_elements(self, target: str, lines: list[str], ind: str) -> None:
        for h in self.hooks:
            if h.target != target:
                continue
            if h.prop_type is None:
                if h.element == "fiscalYearOfPublication":
                    lines.append(
                        "%s<%s:fiscalYearOfPublication>2024</%s:fiscalYearOfPublication>"
                        % (ind, h.module.prefix, h.module.prefix)
                    )
                else:
                    lines.append(
                        '%s<%s:language codeSpace="../../codelists/Language.xml">jpn</%s:language>'
                        % (ind, h.module.prefix, h.module.prefix)
                    )
                continue
            t = h.nested
            concrete = [x for x in [t, *t.descendants()] if not x.abstract]
            if not h.multi:
                concrete = [self.pick(t, self.hooks.index(h))]
            for i, c in enumerate(concrete):
                lines.append("%s<%s:%s>" % (ind, h.module.prefix, h.element))
                if c.is_feature:
                    self.feature_instance(c, 1, i, lines, ind + "  ")
                else:
                    self.instance(c, 0, i, lines, ind + "  ")
                lines.append("%s</%s:%s>" % (ind, h.module.prefix, h.element))

    def gid(self, prefix: str) -> str:
        self.counter += 1
        gid = "%s_%s_%s_%04d" % (prefix, self.version.replace(".", "_"), self.label, self.counter)
        if self.counter == 1:
            self.first_gid = gid
        return gid

    # --------------------------------------------------------------- features
    def document(self) -> str:
        # gml:ids of the ADE feature members, assigned first so that member references can point at them
        self.member_gid = {t.qname: self.gid(t.element_name.lower()) for t in self.features if t.top_level}
        out = ['<?xml version="1.0" encoding="UTF-8"?>']
        attrs = " ".join('xmlns:%s="%s"' % (p, u) for p, u in NS.items())
        modules = list(self.spec.modules.values())
        attrs += " " + " ".join('xmlns:%s="%s"' % (m.prefix, m.namespace) for m in modules)
        out.append(
            '<core:CityModel %s xsi:schemaLocation="%s">'
            % (attrs, " ".join("%s %s" % (m.namespace, m.schema_url) for m in modules))
        )
        out.append(
            "  <gml:name>%s %s all-attribute fixture</gml:name>" % ("/".join(m.prefix for m in modules), self.version)
        )
        targets = {h.target for h in self.hooks}
        if "AbstractBuilding" in targets or targets & BUILDING_TARGETS:
            self.building(targets, out)
        for target, elem in SIMPLE_MEMBERS:
            if target not in targets and not (
                target in ("Railway", "Track", "Square") and "TransportationComplex" in targets
            ):
                continue
            out.append("  <core:cityObjectMember>")
            out.append('    <%s gml:id="%s">' % (elem, self.gid(elem.split(":")[1].lower())))
            out.append("      <gml:name>Fixture %s</gml:name>" % elem)
            self.hook_elements("CityObject", out, "      ")
            if target in ("Railway", "Track", "Square"):
                self.hook_elements("TransportationObject", out, "      ")
                self.hook_elements("TransportationComplex", out, "      ")
            self.hook_elements(target, out, "      ")
            out.append("    </%s>" % elem)
            out.append("  </core:cityObjectMember>")
        if targets & {"TransportationComplex", "Road", "TrafficArea", "TransportationObject"}:
            self.road(targets, out)
        if targets & {"ReliefFeature", "ReliefComponent"}:
            self.relief(out)
        # ADE feature types: one member per top-level concrete type (nested features and all fields inside)
        for i, t in enumerate(x for x in self.features if x.top_level):
            out.append("  <core:cityObjectMember>")
            self.feature_instance(t, 0, i, out, "    ")
            out.append("  </core:cityObjectMember>")
        out.append("</core:CityModel>")
        return "\n".join(out) + "\n"

    def building(self, targets: set[str], out: list[str]) -> None:
        out.append("  <core:cityObjectMember>")
        out.append('    <bldg:Building gml:id="%s">' % self.gid("bldg"))
        out.append("      <gml:name>Fixture building</gml:name>")
        self.hook_elements("CityObject", out, "      ")
        out.append('      <bldg:measuredHeight uom="m">12.0</bldg:measuredHeight>')
        if "BuildingInstallation" in targets:
            out.append('      <bldg:outerBuildingInstallation><bldg:BuildingInstallation gml:id="%s">' % self.gid("bi"))
            self.hook_elements("BuildingInstallation", out, "        ")
            out.append("      </bldg:BuildingInstallation></bldg:outerBuildingInstallation>")
        if "IntBuildingInstallation" in targets:
            out.append(
                '      <bldg:interiorBuildingInstallation><bldg:IntBuildingInstallation gml:id="%s">' % self.gid("ibi")
            )
            self.hook_elements("IntBuildingInstallation", out, "        ")
            out.append("      </bldg:IntBuildingInstallation></bldg:interiorBuildingInstallation>")
        if targets & {"BoundarySurface", "Opening"}:
            out.append('      <bldg:boundedBy><bldg:WallSurface gml:id="%s">' % self.gid("wall"))
            if "Opening" in targets:
                out.append('        <bldg:opening><bldg:Door gml:id="%s">' % self.gid("door"))
                self.hook_elements("Opening", out, "          ")
                out.append("        </bldg:Door></bldg:opening>")
            self.hook_elements("BoundarySurface", out, "        ")
            out.append("      </bldg:WallSurface></bldg:boundedBy>")
        if targets & {"Room", "BuildingFurniture"}:
            out.append('      <bldg:interiorRoom><bldg:Room gml:id="%s">' % self.gid("room"))
            if "BuildingFurniture" in targets:
                out.append('        <bldg:interiorFurniture><bldg:BuildingFurniture gml:id="%s">' % self.gid("furn"))
                # furniture without geometry is exported as an empty element by the Importer/Exporter
                out.append(
                    '          <bldg:lod4Geometry><gml:Point srsName="%s" srsDimension="3"><gml:pos>%s</gml:pos>'
                    "</gml:Point></bldg:lod4Geometry>" % (SRS, POS)
                )
                self.hook_elements("BuildingFurniture", out, "          ")
                out.append("        </bldg:BuildingFurniture></bldg:interiorFurniture>")
            self.hook_elements("Room", out, "        ")
            out.append("      </bldg:Room></bldg:interiorRoom>")
        self.hook_elements("AbstractBuilding", out, "      ")
        out.append("    </bldg:Building>")
        out.append("  </core:cityObjectMember>")

    def road(self, targets: set[str], out: list[str]) -> None:
        out.append("  <core:cityObjectMember>")
        out.append('    <tran:Road gml:id="%s">' % self.gid("road"))
        out.append("      <gml:name>Fixture road</gml:name>")
        self.hook_elements("TransportationObject", out, "      ")
        if "TrafficArea" in targets:
            out.append('      <tran:trafficArea><tran:TrafficArea gml:id="%s">' % self.gid("ta"))
            self.hook_elements("TransportationObject", out, "        ")
            out.append('        <tran:function codeSpace="../../codelists/TrafficArea_function.xml">1</tran:function>')
            self.hook_elements("TrafficArea", out, "        ")
            out.append("      </tran:TrafficArea></tran:trafficArea>")
        self.hook_elements("TransportationComplex", out, "      ")
        self.hook_elements("Road", out, "      ")
        out.append("    </tran:Road>")
        out.append("  </core:cityObjectMember>")

    def relief(self, out: list[str]) -> None:
        out.append("  <core:cityObjectMember>")
        out.append('    <dem:ReliefFeature gml:id="%s">' % self.gid("dem"))
        out.append("      <gml:name>Fixture relief</gml:name>")
        out.append("      <dem:lod>1</dem:lod>")
        # TINRelief: Importer/Exporter 5.5.0 fails to export MassPointRelief and BreaklineRelief components
        out.append('      <dem:reliefComponent><dem:TINRelief gml:id="%s">' % self.gid("tin"))
        out.append("        <dem:lod>1</dem:lod>")
        self.hook_elements("ReliefComponent", out, "        ")
        out.append(
            '        <dem:tin><gml:TriangulatedSurface srsName="%s" srsDimension="3"><gml:trianglePatches><gml:Triangle>'
            "<gml:exterior><gml:LinearRing><gml:posList>%s</gml:posList></gml:LinearRing></gml:exterior></gml:Triangle>"
            "</gml:trianglePatches></gml:TriangulatedSurface></dem:tin>" % (SRS, TRIANGLE)
        )
        out.append("      </dem:TINRelief></dem:reliefComponent>")
        self.hook_elements("ReliefFeature", out, "      ")
        out.append("    </dem:ReliefFeature>")
        out.append("  </core:cityObjectMember>")


def write_fixture(
    cg4j: str, citydb: str, version: str, preset: str, out: str, prefixes: Sequence[str] = ("uro",)
) -> str:
    """Writes the fixture file; returns a summary line."""
    spec = Spec(
        modules_for(cg4j, prefixes, version),
        os.path.join(citydb, "resources", "database", "schema-mapping", "schema-mapping.xml"),
        os.path.join(citydb, "resources", "database", "3dcitydb", "postgreSQL", "CREATE_ADE_DB.sql"),
    )
    hooks = select_hooks(spec, preset)
    features = spec.feature_types() if preset == "all" else []
    doc = Fixture(spec, hooks, features, version, preset).document()
    with open(out, "w", encoding="utf-8", newline="\n") as fp:
        fp.write(doc)
    return "hooks: %d features: %d lines: %d" % (len(hooks), len(features), doc.count("\n"))


def main(argv: list[str] | None = None) -> None:
    argv = sys.argv[1:] if argv is None else list(argv)
    cg4j, citydb, version, preset, out = argv[0:5]
    prefixes = argv[5].split(",") if len(argv) > 5 else ["uro"]
    log.info("%s", write_fixture(cg4j, citydb, version, preset, out, prefixes))
