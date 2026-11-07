"""The CHANGES.md sections of both forks: the 'ADE feature types' changes (``iur-ade changes-features``) and the 'Urban
Function module' changes (``iur-ade changes-urf``) of the current version, each with its 'Known limitations'.
Idempotent: an existing section of the same heading is replaced."""

from __future__ import annotations

import logging
import re
import sys
from pathlib import Path

from .errors import GeneratorError

log = logging.getLogger(__name__)

DATE = "2026-11-07"
FEATURES_HEADING = "Changes (ADE feature types, %s)" % DATE
URF_HEADING = "Changes (Urban Function module, %s)" % DATE
CONTROL_POINT = "* `uro:ControlPoint/uro:parameter` is not supported: the %s XSD declares it with the type of `uro:ControlPoint` itself.\n"
GML_POS = (
    "* `gml:pos` values (`uro:Elevation/elevationValue`, `uro:OffsetDepth/pos`) keep their coordinates only; `srsName` and\n"
    "  `srsDimension` are not stored.\n"
)


def patch(path: Path, version: str, heading: str, changes: str, known: str, hashes: str) -> None:
    """Replaces (or adds) the section ``heading`` and the 'Known limitations' of the version's entry in CHANGES.md."""
    s = path.read_text(encoding="utf-8")
    m = re.search(r"### %s - %s\n(.*?)(?=\n### |\Z)" % (re.escape(version), DATE), s, re.S)
    if m is None:
        raise GeneratorError(f"no section '### {version} - {DATE}' in {path}")
    section = m.group(0)
    section = re.sub(r"\n#{4,5} Known limitations\n.*", "", section, flags=re.S).rstrip("\n") + "\n"
    section = re.sub(r"\n#{4,5} %s\n.*" % re.escape(heading), "", section, flags=re.S).rstrip("\n") + "\n"
    section += "\n" + hashes + " " + heading + "\n" + changes + "\n\n" + hashes + " Known limitations\n" + known
    s = s[: m.start()] + section + s[m.end() :]
    path.write_text(s, encoding="utf-8", newline="\n")


# ------------------------------------------------------------------ features
def features_known_limitations(uro: str) -> str:
    limits = []
    if uro in ("2.0", "3.0"):
        limits.append(CONTROL_POINT % uro)
    if uro == "3.2":
        limits.append(
            "* The feature-typed hook `uro:pointCloud` (`core:_GenericApplicationPropertyOfCityObject`) is not supported;\n"
            "  `uro:PointCloud` itself is modelled.\n"
        )
    if uro != "2.0":
        limits.append(GML_POS)
    limits.append("* `urf`, `urg` and `urt` remain at 1.4.\n")
    return "".join(limits)


def features_changes(uro: str) -> tuple[str, str]:
    """(citygml4j changes, citydb changes) of the edition."""
    if uro == "2.0":
        return (
            "* The i-UR 2.0 XSD defines no ADE feature types; regenerated with the generator that supports them (no code change).",
            "* The i-UR 2.0 XSD defines no ADE feature types; regenerated with the generator that supports them.",
        )
    cg_changes = (
        "* The ADE feature types of the i-UR %s Urban Object module are modelled, (un)marshalled and walked:\n"
        "  `OtherConstruction` with its boundary surfaces and `ConstructionInstallation`, `UndergroundBuilding`, `Waterway`,\n"
        "  `PublicLand` and the utility network elements (`Pipe`, `SewerPipe`, `ThermalPipe`, `WaterPipe`, `OilGasChemicalsPipe`,\n"
        "  `Duct`, `Cable`, `ElectricityCable`, `TelecommunicationsCable`, `Appurtenance`, `Manhole`, `Handhole`)%s.\n"
        "  `UrbanObjectModule` registers them as features.\n"
        "* The JAXB properties `AbstractConstructionType/boundedBy` and `PublicLandType/id` are renamed to `boundedBySurface` and\n"
        "  `identifier` in `binding.xjb` (ade-xjc otherwise binds the whole content model as a generic list); the model accessors\n"
        "  are named alike." % (uro, " and `PointCloud`" if uro == "3.2" else "")
    )
    db_changes = (
        "* Import/export of the ADE feature types of the i-UR %s Urban Object module (`uro:OtherConstruction` with its boundary\n"
        "  surfaces and installations, `uro:UndergroundBuilding`, `uro:Waterway`, `uro:PublicLand` and the utility network\n"
        "  elements), one importer and exporter per table in the style of the `urf` feature classes. Nested features are imported\n"
        "  through the Importer/Exporter with the parent id as foreign key and exported through the extension's own exporters\n"
        "  (the Importer/Exporter creates nested ADE objects as stubs).\n"
        "* `OtherConstruction` and `UndergroundBuilding` are marked top-level in the schema mapping (the ADE Manager left them\n"
        "  without `topLevel`)." % uro
    )
    return cg_changes, db_changes


def update_features(citygml4j: Path, citydb: Path, citygml4j_version: str, citydb_version: str, uro: str) -> None:
    cg_changes, db_changes = features_changes(uro)
    known = features_known_limitations(uro)
    patch(citygml4j / "CHANGES.md", citygml4j_version, FEATURES_HEADING, cg_changes, known, "#####")
    patch(citydb / "CHANGES.md", citydb_version, FEATURES_HEADING, db_changes, known, "####")


def features_main(argv: list[str] | None = None) -> None:
    """Usage: iur-ade changes-features <citygml4j repo> <citydb repo> <citygml4j version> <citydb version> <uro version>"""
    argv = sys.argv[1:] if argv is None else list(argv)
    g, d, gv, dv, uro = argv[0:5]
    update_features(Path(g), Path(d), gv, dv, uro)
    log.info("CHANGES updated for %s", uro)


# ----------------------------------------------------------------------- urf
def urf_texts(ver: str, features: str, data_types: str) -> tuple[str, str, str, str]:
    """(citygml4j known limitations, citydb known limitations, citygml4j changes, citydb changes)."""
    pkg = "jp.geospatial.iur._%s.urf" % ver.replace(".", "_")
    limits = []
    if ver in ("2.0", "3.0"):
        limits.append(CONTROL_POINT % ver)
    if ver != "2.0":
        limits.append(GML_POS)
    limits.append("* `urg` and `urt` remain at 1.4.\n")
    known_cg = "".join(limits)
    known_db = known_cg + (
        "* `impexp delete` leaves the rows of data types reached through join tables and the nested `uro` features behind\n"
        "  (the delete functions generated by the ADE Manager treat join tables as aggregations).\n"
    )
    cg_changes = (
        "* **Breaking:** the Urban Function module (`urf`) is updated to version %s of the i-UR ADE\n"
        "  (`https://www.geospatial.jp/iur/urf/%s`): %s feature types and %s data types generated from the schema shipped\n"
        "  with the PLATEAU datasets replace the hand-written 1.4 model, binding and walker classes; JAXB classes are\n"
        "  generated into `%s` (the `urt` classes refer to the `urf` feature classes and are regenerated with them).\n"
        "* Every concrete `urf` feature is registered as a top-level feature (PLATEAU writes them all as city object members);\n"
        "  references to other members (`urf:districtDevelopmentPlan`, `urf:promotionDistrict`, ...) and to city objects\n"
        "  (`urf:target`) are feature properties that carry an xlink.\n"
        "* `urf` feature types with an `id` or `location` element are bound under the properties `identifier` and\n"
        "  `locationDescription`, and the `lod-N` geometries under `lodMinusN...` (`binding.xjb`); the model accessors are named\n"
        "  alike. `uro` and `urf` classes of the same simple name (`Waterway`, `LandPrice`, `LandUseDiversion`) are referred to\n"
        "  qualified where both are in scope.\n"
        "* The top-level `Unmarshaller` dispatches JAXB objects by their JAXB package, so `urf` properties of `uro` types\n"
        "  (`keyValuePairAttribute`, `dataQualityAttribute`, `urfDmAttribute`) are unmarshalled."
        % (ver, ver, features, data_types, pkg)
    )
    if ver == "3.2":
        cg_changes += (
            "\n* The hook `uro:pointCloud` (`core:_GenericApplicationPropertyOfCityObject`, a `uro:PointCloud` feature) is\n"
            "  modelled and (un)marshalled as `PointCloudPropertyElement` on every city object."
        )
    db_changes = (
        "* **Breaking:** import/export of the Urban Function module (`urf`) version %s of the i-UR ADE: %s feature types and\n"
        "  %s data types. The `urf` tables are generated in the style of the ADE Manager (`iur-ade gen-mapping` of the\n"
        "  `iur-ade-generator` repository; the ADE Manager itself does not finish the transformation of the urban function\n"
        "  hierarchy) and replace the 1.4 tables; every concrete `urf` feature is top-level, references between members and\n"
        "  `urf:target` are join tables exported as xlinks.\n"
        "* **Breaking:** multi-valued data type properties of all modules are stored in join tables (`ur_<owner>_to_<type>`)\n"
        "  instead of one foreign key column per owner in the type's table: the Importer/Exporter orders its batch commits by\n"
        "  table weights summed along the schema mapping joins in `int` arithmetic, and the shared `uro` data types made the\n"
        "  weights overflow, which scrambles the commit order (foreign key violations on import). An owner with several list\n"
        "  properties of one type keeps the foreign key columns (the ADE Manager's delete functions reject two join tables\n"
        "  between the same tables). Subtype rows are deleted with their base rows (`ON DELETE CASCADE`).\n"
        "* Lists of simple values and of measures are stored as joined strings like the lists of dates."
        % (ver, features, data_types)
    )
    if ver == "3.2":
        db_changes += (
            "\n* Import/export of the hook `uro:pointCloud` of every city object: the `uro:PointCloud` feature is stored as a\n"
            "  city object of its own (`ur_pointcloud`) and referenced from the injection table `ur_cityobject_2`\n"
            "  (base `AbstractCityObjectType`; the ADE Manager put the reference into the vegetation injection)."
        )
    return known_cg, known_db, cg_changes, db_changes


def update_urf(
    citygml4j: Path, citydb: Path, citygml4j_version: str, citydb_version: str, ver: str, features: str, data_types: str
) -> None:
    known_cg, known_db, cg_changes, db_changes = urf_texts(ver, features, data_types)
    patch(citygml4j / "CHANGES.md", citygml4j_version, URF_HEADING, cg_changes, known_cg, "#####")
    patch(citydb / "CHANGES.md", citydb_version, URF_HEADING, db_changes, known_db, "####")


def urf_main(argv: list[str] | None = None) -> None:
    """Usage: iur-ade changes-urf <citygml4j repo> <citydb repo> <citygml4j version> <citydb version> <i-UR version>
    <feature types> <data types>"""
    argv = sys.argv[1:] if argv is None else list(argv)
    g, d, gv, dv, ver, features, data_types = argv[0:7]
    update_urf(Path(g), Path(d), gv, dv, ver, features, data_types)
    log.info("CHANGES updated for urf %s", ver)
