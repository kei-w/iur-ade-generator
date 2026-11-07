"""Golden tests of the generated Java code on the mini modules (tests/golden/mini/citygml4j and citydb)."""

from __future__ import annotations

from pathlib import Path

from iur_ade_generator import citydb, citygml4j
from iur_ade_generator.citygml4j.generator import load_spec, select_hooks
from iur_ade_generator.spec import Spec

from .conftest import MINI_GOLDEN, VERSION, assert_golden, golden_resources

MODULES = ["uro", "urf"]


def mini_spec(mini: Path) -> Spec:
    golden_resources(mini / "citydb")
    return load_spec(str(mini / "citygml4j"), str(mini / "citydb"), VERSION, MODULES)


def test_citygml4j_model_and_bind_classes(mini: Path, update_golden: bool) -> None:
    spec = mini_spec(mini)
    gen = citygml4j.Generator(spec, str(mini / "citygml4j"), select_hooks(spec, "all"))
    assert [t.model for t in gen.items] == [
        "DetailAttribute",
        "DetailAttributeProperty",
        "ExtraAttribute",
        "ExtraAttributeProperty",
        "NoteAttribute",
        "NoteAttributeProperty",
        "AbstractBaseAttribute",
        "SubAttribute",
        "BaseAttributeProperty",
        "MiniFeature",
        "MiniPart",
        "MiniPartProperty",
        "AbstractMiniFunction",
        "MiniZone",
        "MiniZoneProperty",
        "MiniDistrict",
        "TargetProperty",
    ]
    assert gen.clashing_models(spec.modules["uro"]) == set()
    gen.gen_model()
    for m in gen.modules:
        gen.gen_marshaller(m)
        gen.gen_unmarshaller(m)
    src = mini / "citygml4j" / "src" / "main" / "java" / "org" / "citygml4j" / "ade" / "iur"
    # the stub of the hand-written class whose license header the generator copies is not generated
    (src / "UrbanRevitalizationADEContext.java").unlink()
    assert_golden(src, MINI_GOLDEN / "citygml4j", update_golden)


def test_citydb_tables_and_classes(mini: Path, update_golden: bool) -> None:
    spec = mini_spec(mini)
    gen = citydb.Generator(spec, str(mini / "citydb"), select_hooks(spec, "all"))
    assert list(gen.tables) == ["ur_detailattribute", "ur_extraattribute", "ur_noteattribute", "ur_baseattribute"]
    assert list(gen.feature_tables) == ["ur_minifeature", "ur_minipart", "ur_abstractminifunction", "ur_minizone"]
    base = gen.tables["ur_baseattribute"]
    assert gen.dispatch_style(base), "a property type with a JAXBElement content dispatches by object class"
    assert [t.model for t in base.row_types] == ["AbstractBaseAttribute", "SubAttribute"] and base.has_objectclass
    assert base.concrete.model == "SubAttribute" and base.importer == "SubAttributeImporter"
    note = gen.tables["ur_noteattribute"]
    assert note.used_single and not note.used_multi and note.parent_columns == []
    part = gen.feature_tables["ur_minipart"]
    assert part.parent_columns == ["minifeature_part_id"] and part.parent is None
    zone = gen.feature_tables["ur_minizone"]
    assert zone.parent is gen.feature_tables["ur_abstractminifunction"] and zone.depth == 1
    assert gen.feature_tables["ur_abstractminifunction"].merged[0].model == "MiniDistrict"
    assert list(gen.injections) == ["ur_building"]
    assert gen.lazy_imp == set() and gen.lazy_exp == set()
    importers, exporters, join_importers, hook_importers, hook_exporters = gen.generate_classes()
    assert importers == [
        "DetailAttributeImporter",
        "DetailAttributeToNoteAttributeImporter",
        "ExtraAttributeImporter",
        "NoteAttributeImporter",
        "SubAttributeImporter",
        "MiniZoneImporter",
        "MiniZoneToMiniZoneImporter",
        "MiniFeatureImporter",
        "MiniPartImporter",
        "AbstractMiniFunctionImporter",
        "AbstractMiniFunctionToCityObjectImporter",
        "BuildingToNoteAttributeImporter",
    ]
    assert exporters == [
        "DetailAttributeExporter",
        "ExtraAttributeExporter",
        "NoteAttributeExporter",
        "SubAttributeExporter",
        "MiniZoneExporter",
        "MiniFeatureExporter",
        "MiniPartExporter",
        "AbstractMiniFunctionExporter",
    ]
    assert join_importers == [
        ("ur_detailatt_to_noteattri", "DetailAttributeToNoteAttributeImporter"),
        ("ur_minizone_to_minizone", "MiniZoneToMiniZoneImporter"),
        ("ur_abstractm_to_cityobjec", "AbstractMiniFunctionToCityObjectImporter"),
        ("ur_building_to_noteattri", "BuildingToNoteAttributeImporter"),
    ]
    assert hook_importers == [("ur_building", "BuildingPropertiesImporter")]
    assert hook_exporters == [("ur_building", "BuildingPropertiesExporter")]
    src = mini / "citydb" / "src" / "main" / "java" / "org" / "citydb" / "ade" / "iur"
    (src / "importer" / "ImportManager.java").unlink()
    assert_golden(src, MINI_GOLDEN / "citydb", update_golden)
