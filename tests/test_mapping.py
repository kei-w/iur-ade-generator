"""The ADE Manager patches and the generated urf mapping on the mini modules (golden files under tests/golden/mini)."""

from __future__ import annotations

from pathlib import Path

from iur_ade_generator.mapping import ddl, generate, patch

from .conftest import MINI_GOLDEN, VERSION, assert_golden

PATCHES = [
    "ur_detailattribute.notes -> join table ur_detailatt_to_noteattri",
    "ur_building.miniNoteAttribute -> join table ur_building_to_noteattri",
    "pg: 3 subtype foreign keys cascade",
    "ora: 3 subtype foreign keys cascade",
    "MiniFeatureType marked top-level",
]
SUMMARY = (
    "urf 9.9: 3 types (3 features) in 2 tables, 2 join tables, object class ids 60008-60010, previous tables removed: 0"
)


def test_patch_then_generate_matches_the_golden_resources(mini: Path, update_golden: bool) -> None:
    citydb, cg4j = str(mini / "citydb"), str(mini / "citygml4j")
    assert patch.patch(citydb, cg4j, VERSION, ["uro"]) == PATCHES
    assert patch.patch(citydb, cg4j, VERSION, ["uro"]) == [], "the patches are idempotent"
    assert generate.generate(citydb, cg4j, VERSION, "urf", ["uro"]) == SUMMARY
    assert_golden(mini / "citydb" / "resources", MINI_GOLDEN / "resources", update_golden)
    # a second generation replaces the module's previous mapping and tables with the same result
    assert generate.generate(citydb, cg4j, VERSION, "urf", ["uro"]) == SUMMARY.replace("removed: 0", "removed: 4")
    assert_golden(mini / "citydb" / "resources", MINI_GOLDEN / "resources", False)


def test_patch_leaves_the_patched_resources_alone(mini: Path) -> None:
    from .conftest import golden_resources

    golden_resources(mini / "citydb")
    assert patch.patch(str(mini / "citydb"), str(mini / "citygml4j"), VERSION, ["uro", "urf"]) == []


SECTIONS = (
    "-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n"
    "-- *********************************** Create tables ************************************** \n"
    "-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n\n"
    "CREATE TABLE ur_a\n(\n    id BIGINT NOT NULL,\n    PRIMARY KEY (id)\n);\n\n"
    "-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n"
    "-- *********************************** Create foreign keys ******************************** \n"
    "-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ \n\n"
)


def test_append_to_section_inserts_before_the_next_section() -> None:
    out = ddl.append_to_section(
        SECTIONS, "Create tables", "CREATE TABLE ur_b\n(\n    id BIGINT NOT NULL,\n    PRIMARY KEY (id)\n);\n\n"
    )
    tables, keys = out.split("-- *********************************** Create foreign keys")
    assert "CREATE TABLE ur_a" in tables and "CREATE TABLE ur_b" in tables
    assert tables.index("ur_a") < tables.index("ur_b")
    assert "ur_b" not in keys


def test_add_column_is_idempotent() -> None:
    once = ddl.add_column(SECTIONS, "ur_a", "extra_id", True)
    assert "    extra_id BIGINT,\n    PRIMARY KEY (id)" in once
    assert ddl.add_column(once, "ur_a", "extra_id", True) == once
    assert "    extra_id NUMBER,\n" in ddl.add_column(SECTIONS, "ur_a", "extra_id", False)
