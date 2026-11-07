"""The specification model built from the XSDs, the JAXB stubs and the mapping of the mini modules, and the real urf
schemas of the repository."""

from __future__ import annotations

import pytest

from iur_ade_generator.config import REPO_ROOT
from iur_ade_generator.spec import Module, Spec, modules_for
from iur_ade_generator.spec.spec import link_types
from iur_ade_generator.spec.xsd import read_xsd

from .conftest import MINI, MINI_GOLDEN, VERSION

RESOURCES = MINI_GOLDEN / "resources" / "database"


@pytest.fixture(scope="module")
def spec() -> Spec:
    return Spec(
        modules_for(str(MINI / "citygml4j"), ["uro", "urf"], VERSION),
        str(RESOURCES / "schema-mapping" / "schema-mapping.xml"),
        str(RESOURCES / "3dcitydb" / "postgreSQL" / "CREATE_ADE_DB.sql"),
    )


def test_modules(spec: Spec) -> None:
    uro, urf = spec.modules["uro"], spec.modules["urf"]
    assert (uro.version, uro.schema_id, uro.jaxb_pkg) == ("9.9", "ur_0", "jp.geospatial.iur._9_9.uro")
    assert (urf.version, urf.schema_id, urf.version_const) == ("9.9", "ur_1", "v9_9")
    assert urf.schema_url == "https://www.geospatial.jp/iur/schemas/urf/9.9/urbanFunction.xsd"
    assert uro.factory["miniDetailAttribute"] == "createMiniDetailAttribute"
    assert "DetailAttributeType" in uro.jaxb_classes


def test_data_type_fields(spec: Spec) -> None:
    t = spec.type("uro:DetailAttributeType")
    assert (t.model, t.mapping_path, t.is_feature, t.is_property) == (
        "DetailAttribute",
        "DetailAttribute",
        False,
        False,
    )
    kinds = {f.name: (f.kind, f.multi, f.required) for f in t.fields}
    assert kinds == {
        "name": ("string", False, True),
        "count": ("integer", False, False),
        "area": ("measure", False, False),
        "kind": ("code", False, False),
        "date": ("date", False, False),
        "tags": ("string", True, False),
        "color": ("enum", False, False),
        "grade": ("string", False, False),
        "geometry": ("multiSurface", False, False),
        "extra": ("property", False, False),
        "notes": ("property", True, False),
        "base": ("property", False, False),
    }
    fields = {f.name: f for f in t.fields}
    assert fields["color"].enum_type.values == ["red", "green"]
    assert fields["grade"].enum_values == ["1", "2"], "an enumeration of non-identifiers is bound as a string"
    assert fields["count"].jaxb_property.java_type == "BigInteger"
    assert fields["tags"].model_type == "List<String>" and fields["area"].model_type == "Measure"
    assert fields["extra"].nested.qname == "uro:ExtraAttributeType"
    assert fields["base"].nested.qname == "uro:AbstractBaseAttributeType"
    assert fields["base"].property_type.polymorphic and not fields["extra"].property_type.polymorphic
    notes = t.mapped.props["notes"]
    assert notes.join_table is not None and notes.join_table.table == "ur_detailatt_to_noteattri"
    assert t.mapped.table == "ur_detailattribute" and t.mapped.object_class_id == 60001


def test_type_hierarchy_and_mapping(spec: Spec) -> None:
    base, sub = spec.type("uro:AbstractBaseAttributeType"), spec.type("uro:SubAttributeType")
    assert base.abstract and sub.base is base and base.subtypes == [sub]
    assert sub.ancestors() == [base] and sub.root() is base
    assert [f.name for f in sub.all_fields()] == ["baseField", "subField"]
    assert base.mapped.table == sub.mapped.table == "ur_baseattribute"
    assert sub.mapped.base is base.mapped


def test_feature_types(spec: Spec) -> None:
    feature, part = spec.type("uro:MiniFeatureType"), spec.type("uro:MiniPartType")
    assert feature.is_feature and feature.core_base == "core:AbstractCityObjectType"
    assert feature.feature_base.model == "org.citygml4j.model.citygml.core.AbstractCityObject"
    assert feature.top_level and not part.top_level, "a feature nested in another ADE feature is no member"
    assert spec.nested_features == {"uro:MiniPartType", "urf:MiniZoneType"}, "members referenced by members too"
    fields = {f.name: f for f in feature.fields}
    assert fields["part"].is_feature_property and fields["part"].multi and not fields["part"].is_member_reference
    assert fields["lod1MultiSurface"].lod == 1 and fields["label"].lod is None
    root, zone, district = (spec.type(q) for q in ("urf:_MiniFunctionType", "urf:MiniZoneType", "urf:MiniDistrictType"))
    assert root.model == "AbstractMiniFunction" and root.mapping_path == "_MiniFunction"
    assert zone.top_level and district.top_level, "every concrete urf feature is a city object member"
    assert [t.qname for t in spec.feature_types()] == [
        "uro:MiniFeatureType",
        "uro:MiniPartType",
        "urf:_MiniFunctionType",
        "urf:MiniZoneType",
        "urf:MiniDistrictType",
    ]
    zone_fields = {f.name: f for f in zone.fields}
    assert zone_fields["relatedZone"].is_member_reference
    assert zone_fields["detail"].foreign and zone_fields["detail"].nested.module is spec.modules["uro"]
    target = next(f for f in root.fields if f.name == "target")
    assert target.kind == "cityObjectRef" and target.property_type.foreign_target == "core:_CityObject"


def test_hooks(spec: Spec) -> None:
    hooks = {h.element: h for h in spec.hooks}
    assert set(hooks) == {"miniDetailAttribute", "miniNoteAttribute"}
    detail, note = hooks["miniDetailAttribute"], hooks["miniNoteAttribute"]
    assert (detail.target, detail.prefix, detail.model_element) == (
        "AbstractBuilding",
        "bldg",
        "MiniDetailAttributePropertyElement",
    )
    assert detail.nested.qname == "uro:DetailAttributeType" and not detail.multi
    assert detail.injected.table == "ur_building" and detail.mapped.join is not None
    assert note.multi and note.mapped.join_table is not None


def test_closure_and_property_types(spec: Spec) -> None:
    features = spec.feature_types()
    closure = [t.qname for t in spec.closure(spec.hooks, features)]
    assert closure == [
        "uro:DetailAttributeType",
        "uro:ExtraAttributeType",
        "uro:NoteAttributeType",
        "uro:AbstractBaseAttributeType",
        "uro:SubAttributeType",
    ]
    props = [t.qname for t in spec.property_types(spec.closure(spec.hooks, features) + features)]
    assert props == [
        "uro:DetailAttributePropertyType",
        "uro:NoteAttributePropertyType",
        "uro:ExtraAttributePropertyType",
        "uro:BaseAttributePropertyType",
        "uro:MiniPartPropertyType",
        "urf:TargetPropertyType",
        "urf:MiniZonePropertyType",
    ]


def test_ddl(spec: Spec) -> None:
    assert spec.ddl_tables["ur_detailatt_to_noteattri"] == ["noteattribute_id", "detailattribute_id"]
    assert spec.table_sequence["ur_detailattribute"] == "ur_detailattribute_seq"
    assert "ur_detailattribute_seq" in spec.sequences


@pytest.mark.parametrize(
    ("version", "types", "features", "abstract"),
    [("2.0", 128, 119, 3), ("3.0", 158, 129, 2), ("3.1", 160, 131, 2), ("3.2", 161, 132, 2)],
)
def test_the_real_urf_schemas(version: str, types: int, features: int, abstract: int) -> None:
    uro = Module(
        "uro",
        str(MINI / "citygml4j" / "resources" / "ade-xjc" / "schemas" / "urbanObject.xsd"),
        "x",
        "x",
        "https://www.geospatial.jp/iur/uro/9.9",
    )
    xsd = REPO_ROOT / "schemas" / "iur" / "urf" / version / "urbanFunction.xsd"
    urf = Module("urf", str(xsd), "x", "x", f"https://www.geospatial.jp/iur/urf/{version}")
    read_xsd(uro)
    read_xsd(urf)
    link_types([uro, urf])
    data_and_feature_types = [t for t in urf.types.values() if not t.is_property]
    assert len(data_and_feature_types) == types
    assert sum(1 for t in data_and_feature_types if t.is_feature) == features
    assert sum(1 for t in data_and_feature_types if t.is_feature and t.abstract) == abstract
