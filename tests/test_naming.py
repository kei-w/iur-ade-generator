"""Naming helpers shared by the generators (urospec, gen_mapping, patch_mapping)."""

from iur_ade_generator import gen_mapping, patch_mapping, urospec


def test_java_name_renames_the_lod_minus_elements_only() -> None:
    assert urospec.java_name("lod-1MultiSurface") == "lodMinus1MultiSurface"
    assert urospec.java_name("lod1MultiSurface") == "lod1MultiSurface"
    # other punctuation is dropped (urf:FishingPortCapacity/waterDepth-2m)
    assert urospec.java_name("waterDepth-2m") == "waterDepth2m"


def test_cap_and_uncap_change_the_first_letter_only() -> None:
    assert urospec.cap("urbanFunction") == "UrbanFunction"
    assert urospec.uncap("UrbanFunction") == "urbanFunction"
    assert urospec.cap("ADE") == "ADE"


def test_sql_name_lowercases_and_replaces_other_characters() -> None:
    assert gen_mapping.sql_name("BuildingDetailAttribute") == "buildingdetailattribute"
    assert gen_mapping.sql_name("lod-1 Surface.x") == "lod_1_surface_x"


def test_reserved_words_include_the_citydb_column_names() -> None:
    assert {"id", "objectclass_id", "offset", "select"} <= gen_mapping.RESERVED


def test_unique_names_are_truncated_and_numbered() -> None:
    names = gen_mapping.Names(["ur_short"])
    assert names.unique("ur_short", 25) == "ur_short_2"
    assert names.unique("ur_short", 25) == "ur_short_3"
    long = "ur_" + "x" * 40
    assert names.unique(long, 25) == long[:25]
    assert names.unique(long, 25) == long[:23] + "_2"
    assert names.unique("ur_other", 25, taken=set()) == "ur_other"
    assert "ur_other" not in names.taken


def test_patch_mapping_unique_behaves_like_the_mapping_generator() -> None:
    taken = {"ur_a"}
    assert patch_mapping.unique("ur_a", 10, taken) == "ur_a_2"
    assert patch_mapping.unique("ur_abcdefghijk", 10, taken) == "ur_abcdefg"
    assert taken == {"ur_a", "ur_a_2", "ur_abcdefg"}
