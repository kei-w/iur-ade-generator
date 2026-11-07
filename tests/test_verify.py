"""File selection and summary classification of iur-ade verify."""

from pathlib import Path

import pytest

from iur_ade_generator import verify
from iur_ade_generator.errors import GeneratorError


def test_gml_files_takes_files_and_folders_recursively(tmp_path: Path) -> None:
    (tmp_path / "b" / "c").mkdir(parents=True)
    for name in ("b/c/z.gml", "b/y.gml", "b/notes.txt", "a.gml"):
        (tmp_path / name).write_text("", encoding="utf-8")
    files = verify.gml_files([tmp_path / "b", tmp_path / "a.gml"])
    assert [f.name for f in files] == ["z.gml", "y.gml", "a.gml"]
    assert all(f.is_absolute() for f in files)


def test_gml_files_reports_missing_paths_and_empty_folders(tmp_path: Path) -> None:
    with pytest.raises(GeneratorError, match="not a file or folder"):
        verify.gml_files([tmp_path / "nowhere"])
    with pytest.raises(GeneratorError, match=r"no .gml files"):
        verify.gml_files([tmp_path])


SUMMARY = (
    "city objects compared: 3, ADE properties in original: 10, objects with ADE differences: {ade}, "
    "objects with ADE properties in a different order: {order}, objects with standard-content differences: {std}"
)


def test_summary_classification() -> None:
    clean = SUMMARY.format(ade=0, order=0, std=0)
    assert verify.CLEAN.search(clean) and verify.CLEAN_DB.search(clean)
    reordered = SUMMARY.format(ade=0, order=2, std=0)
    assert not verify.CLEAN.search(reordered) and not verify.CLEAN_DB.search(reordered)
    assert verify.NO_ADE_DIFFERENCE.search(reordered)
    std_only = SUMMARY.format(ade=0, order=0, std=1)
    assert not verify.CLEAN.search(std_only) and verify.CLEAN_DB.search(std_only)
    assert not verify.NO_ADE_DIFFERENCE.search(SUMMARY.format(ade=1, order=0, std=0))


SAMPLE = (
    '<?xml version="1.0" encoding="UTF-8"?>\n<core:CityModel xmlns:core="http://www.opengis.net/citygml/2.0" '
    'xmlns:grp="http://www.opengis.net/citygml/cityobjectgroup/2.0" xmlns:gml="http://www.opengis.net/gml" '
    'xmlns:urt="https://www.geospatial.jp/iur/urt/3.1">\n'
    "  <core:cityObjectMember>\n    <grp:CityObjectGroup>\n      <grp:groupMember>\n"
    '        <urt:Route gml:id="route1"/>\n      </grp:groupMember>\n      <grp:groupMember>\n'
    "        <urt:Stop>\n        </urt:Stop>\n      </grp:groupMember>\n"
    "    </grp:CityObjectGroup>\n  </core:cityObjectMember>\n</core:CityModel>\n"
)


def test_with_ids_gives_every_city_object_a_gml_id(tmp_path: Path) -> None:
    f = tmp_path / "PublicTransit.xml"
    f.write_text(SAMPLE, encoding="utf-8")
    copy = verify.with_ids(f, tmp_path)
    assert copy == tmp_path / "PublicTransit.in.xml"
    text = copy.read_text(encoding="utf-8")
    assert '<grp:CityObjectGroup gml:id="PublicTransit_1">' in text
    assert '<urt:Route gml:id="route1"/>' in text, "existing ids are kept"
    assert '<urt:Stop gml:id="PublicTransit_2">' in text
    assert verify.with_ids(copy, tmp_path) == copy, "a file whose objects all have ids is used as it is"


def test_gml_files_takes_xml_files_in_folders(tmp_path: Path) -> None:
    for name in ("a.xml", "b.gml", "c.txt"):
        (tmp_path / name).write_text("", encoding="utf-8")
    assert [f.name for f in verify.gml_files([tmp_path])] == ["a.xml", "b.gml"]
