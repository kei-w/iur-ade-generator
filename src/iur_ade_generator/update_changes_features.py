"""Add the 'ADE feature types' changes to the current version section of both CHANGES.md files and rewrite its
'Known limitations'. Idempotent.
Usage: update_changes_features.py <citygml4j repo> <citydb repo> <citygml4j version> <citydb version> <uro version>"""
import io
import re
import sys

g, d, gv, dv, uro = sys.argv[1:6]
NL = "\n"
HEADING = "Changes (ADE feature types, 2026-11-07)"
has_features = uro != "2.0"

limits = []
if uro in ("2.0", "3.0"):
    limits.append("* `uro:ControlPoint/uro:parameter` is not supported: the %s XSD declares it with the type of `uro:ControlPoint` itself.\n" % uro)
if uro == "3.2":
    limits.append("* The feature-typed hook `uro:pointCloud` (`core:_GenericApplicationPropertyOfCityObject`) is not supported;\n"
                  "  `uro:PointCloud` itself is modelled.\n")
if has_features:
    limits.append("* `gml:pos` values (`uro:Elevation/elevationValue`, `uro:OffsetDepth/pos`) keep their coordinates only; `srsName` and\n"
                  "  `srsDimension` are not stored.\n")
limits.append("* `urf`, `urg` and `urt` remain at 1.4.\n")
known = "".join(limits)

if has_features:
    cg_changes = (
        "* The ADE feature types of the i-UR %s Urban Object module are modelled, (un)marshalled and walked:\n"
        "  `OtherConstruction` with its boundary surfaces and `ConstructionInstallation`, `UndergroundBuilding`, `Waterway`,\n"
        "  `PublicLand` and the utility network elements (`Pipe`, `SewerPipe`, `ThermalPipe`, `WaterPipe`, `OilGasChemicalsPipe`,\n"
        "  `Duct`, `Cable`, `ElectricityCable`, `TelecommunicationsCable`, `Appurtenance`, `Manhole`, `Handhole`)%s.\n"
        "  `UrbanObjectModule` registers them as features.\n"
        "* The JAXB properties `AbstractConstructionType/boundedBy` and `PublicLandType/id` are renamed to `boundedBySurface` and\n"
        "  `identifier` in `binding.xjc` (ade-xjc otherwise binds the whole content model as a generic list); the model accessors\n"
        "  are named alike." % (uro, " and `PointCloud`" if uro == "3.2" else ""))
    db_changes = (
        "* Import/export of the ADE feature types of the i-UR %s Urban Object module (`uro:OtherConstruction` with its boundary\n"
        "  surfaces and installations, `uro:UndergroundBuilding`, `uro:Waterway`, `uro:PublicLand` and the utility network\n"
        "  elements), one importer and exporter per table in the style of the `urf` feature classes. Nested features are imported\n"
        "  through the Importer/Exporter with the parent id as foreign key and exported through the extension's own exporters\n"
        "  (the Importer/Exporter creates nested ADE objects as stubs).\n"
        "* `OtherConstruction` and `UndergroundBuilding` are marked top-level in the schema mapping (the ADE Manager left them\n"
        "  without `topLevel`)." % uro)
else:
    cg_changes = "* The i-UR 2.0 XSD defines no ADE feature types; regenerated with the generator that supports them (no code change)."
    db_changes = "* The i-UR 2.0 XSD defines no ADE feature types; regenerated with the generator that supports them."
cg_changes = cg_changes.replace("binding.xjc", "binding.xjb")


def patch(path, version, changes, known, hashes):
    s = io.open(path, encoding="utf-8").read()
    m = re.search(r"### %s - 2026-11-07\n(.*?)(?=\n### |\Z)" % re.escape(version), s, re.S)
    assert m, version
    section = m.group(0)
    section = re.sub(r"\n#{4,5} Known limitations\n.*", "", section, flags=re.S).rstrip(NL) + NL
    section = re.sub(r"\n#{4,5} %s\n.*" % re.escape(HEADING), "", section, flags=re.S).rstrip(NL) + NL
    section += NL + hashes + " " + HEADING + NL + changes + NL + NL + hashes + " Known limitations" + NL + known
    s = s[:m.start()] + section + s[m.end():]
    io.open(path, "w", encoding="utf-8", newline="\n").write(s)


patch(g + "/CHANGES.md", gv, cg_changes, known, "#####")
patch(d + "/CHANGES.md", dv, db_changes, known, "####")
print("CHANGES updated for", uro)
