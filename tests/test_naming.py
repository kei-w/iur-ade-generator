"""Naming helpers shared by the generators."""

from iur_ade_generator import naming


def test_java_name_renames_the_lod_minus_elements_only() -> None:
    assert naming.java_name("lod-1MultiSurface") == "lodMinus1MultiSurface"
    assert naming.java_name("lod1MultiSurface") == "lod1MultiSurface"
    # other punctuation is dropped (urf:FishingPortCapacity/waterDepth-2m)
    assert naming.java_name("waterDepth-2m") == "waterDepth2m"


def test_cap_and_uncap_change_the_first_letter_only() -> None:
    assert naming.cap("urbanFunction") == "UrbanFunction"
    assert naming.uncap("UrbanFunction") == "urbanFunction"
    assert naming.cap("ADE") == "ADE"


def test_norm_ignores_case_and_punctuation() -> None:
    assert naming.norm("lod-1MultiSurface") == naming.norm("lodMinus1MultiSurface".replace("Minus", "-"))
    assert naming.norm("BranchID") == "branchid"


def test_model_field_names() -> None:
    assert naming.model_field("class") == "classifier"
    assert naming.model_field("default") == "defaultValue"
    assert naming.model_field("id") == "id"
    assert naming.model_field("id", feature=True) == "identifier"
    assert naming.model_field("boundedBy", feature=True) == "boundedBySurface"
    assert naming.model_field("lod-2MultiSurface", feature=True) == "lodMinus2MultiSurface"


def test_sql_name_lowercases_and_replaces_other_characters() -> None:
    assert naming.sql_name("BuildingDetailAttribute") == "buildingdetailattribute"
    assert naming.sql_name("lod-1 Surface.x") == "lod_1_surface_x"


def test_words_splits_camel_case() -> None:
    assert naming.words("DataQualityAttribute") == "data quality attribute"


def test_reserved_words_include_the_citydb_column_names() -> None:
    assert {"id", "objectclass_id", "offset", "select"} <= naming.RESERVED


def test_unique_names_are_truncated_and_numbered() -> None:
    names = naming.Names(["ur_short"])
    assert names.unique("ur_short", 25) == "ur_short_2"
    assert names.unique("ur_short", 25) == "ur_short_3"
    long = "ur_" + "x" * 40
    assert names.unique(long, 25) == long[:25]
    assert names.unique(long, 25) == long[:23] + "_2"
    assert names.unique("ur_other", 25, taken=set()) == "ur_other"
    assert "ur_other" not in names.taken


def test_unique_adds_the_name_to_the_taken_set() -> None:
    taken = {"ur_a"}
    assert naming.unique("ur_a", 10, taken) == "ur_a_2"
    assert naming.unique("ur_abcdefghijk", 10, taken) == "ur_abcdefg"
    assert taken == {"ur_a", "ur_a_2", "ur_abcdefg"}
