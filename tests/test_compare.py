"""Semantic comparison of two CityGML files (iur-ade compare)."""

from pathlib import Path

import pytest

from iur_ade_generator import compare

HEADER = """<?xml version="1.0" encoding="UTF-8"?>
<core:CityModel xmlns:core="http://www.opengis.net/citygml/2.0"
  xmlns:bldg="http://www.opengis.net/citygml/building/2.0"
  xmlns:gen="http://www.opengis.net/citygml/generics/2.0" xmlns:gml="http://www.opengis.net/gml"
  xmlns:uro="https://www.geospatial.jp/iur/uro/3.1" xmlns:xlink="http://www.w3.org/1999/xlink">
"""
FOOTER = "</core:CityModel>\n"

CREATION_DATE = "      <core:creationDate>2026-01-01</core:creationDate>\n"
ENVELOPE = (
    '      <gml:boundedBy><gml:Envelope srsName="EPSG:6697"><gml:lowerCorner>0 0 0</gml:lowerCorner>'
    "<gml:upperCorner>1 1 1</gml:upperCorner></gml:Envelope></gml:boundedBy>\n"
)
GENERIC_A = '      <gen:stringAttribute name="a"><gen:value>x</gen:value></gen:stringAttribute>\n'
GENERIC_B = '      <gen:stringAttribute name="b"><gen:value>y</gen:value></gen:stringAttribute>\n'
HEIGHT = '      <bldg:measuredHeight uom="m">4.0</bldg:measuredHeight>\n'
DETAIL = """      <uro:buildingDetailAttribute>
        <uro:BuildingDetailAttribute>
          <uro:totalFloorArea uom="m2">120.50</uro:totalFloorArea>
          <uro:buildingStructureType codeSpace="../../codelists/Building_buildingStructureType.xml">610\
</uro:buildingStructureType>
        </uro:BuildingDetailAttribute>
      </uro:buildingDetailAttribute>
"""
ID_ATTRIBUTE = (
    "      <uro:buildingIDAttribute><uro:BuildingIDAttribute><uro:buildingID>B-1</uro:buildingID>"
    "</uro:BuildingIDAttribute></uro:buildingIDAttribute>\n"
)
STANDARD = CREATION_DATE + ENVELOPE + GENERIC_A + GENERIC_B + HEIGHT


def building(gid: str, body: str) -> str:
    return (
        f'  <core:cityObjectMember>\n    <bldg:Building gml:id="{gid}">\n{body}'
        "    </bldg:Building>\n  </core:cityObjectMember>\n"
    )


ORIGINAL = building("b1", STANDARD + DETAIL + ID_ATTRIBUTE)


def write(tmp_path: Path, name: str, *members: str) -> str:
    path = tmp_path / name
    path.write_text(HEADER + "".join(members) + FOOTER, encoding="utf-8")
    return str(path)


def test_identical_files_compare_equal(tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    a = write(tmp_path, "a.gml", ORIGINAL)
    b = write(tmp_path, "b.gml", ORIGINAL)
    assert compare.main([a, b]) == 0
    out = capsys.readouterr().out
    assert "city objects compared: 1, ADE properties in original: 2, objects with ADE differences: 0" in out


def test_numbers_are_compared_as_decimals(tmp_path: Path) -> None:
    a = write(tmp_path, "a.gml", ORIGINAL)
    b = write(tmp_path, "b.gml", ORIGINAL.replace("4.0<", "4<").replace("120.50<", "120.5<"))
    assert compare.main([a, b]) == 0


def test_a_changed_ade_value_is_reported(tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    a = write(tmp_path, "a.gml", ORIGINAL)
    b = write(tmp_path, "b.gml", ORIGINAL.replace(">B-1<", ">B-2<"))
    assert compare.main([a, b]) == 1
    out = capsys.readouterr().out
    assert "ADE content differs for b1" in out
    assert "only in ORIGINAL" in out and "buildingID = B-1" in out
    assert "only in ROUNDTRIP" in out and "buildingID = B-2" in out
    assert "objects with ADE differences: 1" in out


def test_a_missing_ade_property_is_reported(tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    a = write(tmp_path, "a.gml", ORIGINAL)
    b = write(tmp_path, "b.gml", building("b1", STANDARD + DETAIL))
    assert compare.main([a, b]) == 1
    assert "buildingIDAttribute" in capsys.readouterr().out


def test_the_order_of_different_ade_properties_is_only_counted(
    tmp_path: Path, capsys: pytest.CaptureFixture[str]
) -> None:
    a = write(tmp_path, "a.gml", ORIGINAL)
    b = write(tmp_path, "b.gml", building("b1", STANDARD + ID_ATTRIBUTE + DETAIL))
    assert compare.main([a, b]) == 0
    assert "objects with ADE properties in a different order: 1" in capsys.readouterr().out


def test_the_order_of_repeated_ade_properties_is_a_difference(
    tmp_path: Path, capsys: pytest.CaptureFixture[str]
) -> None:
    second = ID_ATTRIBUTE.replace("B-1", "B-2")
    a = write(tmp_path, "a.gml", building("b1", STANDARD + ID_ATTRIBUTE + second))
    b = write(tmp_path, "b.gml", building("b1", STANDARD + second + ID_ATTRIBUTE))
    assert compare.main([a, b]) == 1
    assert "(order of repeated buildingIDAttribute differs)" in capsys.readouterr().out


def test_missing_and_extra_city_objects(tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    other = building("b2", "")
    a = write(tmp_path, "a.gml", ORIGINAL, other)
    b = write(tmp_path, "b.gml", ORIGINAL)
    assert compare.main([a, b]) == 1
    assert "MISSING city objects in roundtrip: ['b2']" in capsys.readouterr().out
    # the round trip may contain more objects than the file compared with it (--subset)
    assert compare.main([b, a]) == 1
    assert "EXTRA city objects in roundtrip: ['b2']" in capsys.readouterr().out
    assert compare.main([b, a, "--subset"]) == 0


def test_db_neutralises_the_importer_exporter_differences(tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    exported = (
        CREATION_DATE.replace("2026-01-01", "2026-11-07")
        + ENVELOPE.replace('srsName="EPSG:6697"', 'srsName="urn:ogc:def:crs:EPSG::6697" srsDimension="3"')
        # the generic attributes come back in database order
        + GENERIC_B
        + GENERIC_A
        + HEIGHT
        + DETAIL
        + ID_ATTRIBUTE
    )
    a = write(tmp_path, "a.gml", ORIGINAL)
    b = write(tmp_path, "b.gml", building("b1", exported))
    assert compare.main([a, b]) == 1
    assert "standard content differs for b1" in capsys.readouterr().out
    assert compare.main([a, b, "--db"]) == 0
    assert "objects with standard-content differences: 0" in capsys.readouterr().out


def test_ignore_creation_date_only(tmp_path: Path) -> None:
    a = write(tmp_path, "a.gml", ORIGINAL)
    b = write(tmp_path, "b.gml", ORIGINAL.replace("2026-01-01", "2026-11-07"))
    assert compare.main([a, b]) == 1
    assert compare.main([a, b, "--ignore-creation-date"]) == 0


GROUP_HEADER = HEADER.replace(
    "xmlns:xlink=", 'xmlns:grp="http://www.opengis.net/citygml/cityobjectgroup/2.0" xmlns:xlink='
)
RING_POS = (
    "      <uro:lod0MultiSurface><gml:MultiSurface><gml:surfaceMember><gml:Polygon><gml:exterior><gml:LinearRing>"
    "<gml:pos>1.0 2.0 0</gml:pos><gml:pos>3 4 0</gml:pos><gml:pos>1 2 0</gml:pos>"
    "</gml:LinearRing></gml:exterior></gml:Polygon></gml:surfaceMember></gml:MultiSurface></uro:lod0MultiSurface>\n"
)
RING_POS_LIST = (
    "      <uro:lod0MultiSurface><gml:MultiSurface><gml:surfaceMember><gml:Polygon><gml:exterior><gml:LinearRing>"
    "<gml:posList>1 2 0 3 4 0 1 2 0</gml:posList>"
    "</gml:LinearRing></gml:exterior></gml:Polygon></gml:surfaceMember></gml:MultiSurface></uro:lod0MultiSurface>\n"
)


def test_db_treats_a_run_of_pos_elements_as_a_pos_list(tmp_path: Path) -> None:
    a = write(tmp_path, "a.gml", building("b1", STANDARD + RING_POS))
    b = write(tmp_path, "b.gml", building("b1", STANDARD + RING_POS_LIST))
    assert compare.main([a, b]) == 1
    assert compare.main([a, b, "--db"]) == 0


def test_inline_group_members_are_compared_with_the_exported_top_level_objects(
    tmp_path: Path, capsys: pytest.CaptureFixture[str]
) -> None:
    inline = (
        '  <core:cityObjectMember>\n    <grp:CityObjectGroup gml:id="g1">\n      <grp:groupMember>\n'
        '        <bldg:Building gml:id="b1">\n' + DETAIL + "        </bldg:Building>\n"
        "      </grp:groupMember>\n    </grp:CityObjectGroup>\n  </core:cityObjectMember>\n"
    )
    exported = (
        building("b1", CREATION_DATE + DETAIL)
        + '  <core:cityObjectMember>\n    <grp:CityObjectGroup gml:id="g1">\n'
        + CREATION_DATE
        + '      <grp:groupMember xlink:href="#b1"/>\n    </grp:CityObjectGroup>\n  </core:cityObjectMember>\n'
    )
    a, b = tmp_path / "a.gml", tmp_path / "b.gml"
    a.write_text(GROUP_HEADER + inline + FOOTER, encoding="utf-8")
    b.write_text(GROUP_HEADER + exported + FOOTER, encoding="utf-8")
    assert compare.main([str(a), str(b), "--db"]) == 1
    out = capsys.readouterr().out
    assert "city objects compared: 2" in out and "objects with ADE differences: 0" in out
    assert "standard content differs for g1" in out, "the inline member versus the xlink is a standard difference"


def test_db_resolves_shared_geometries_and_array_properties(tmp_path: Path) -> None:
    ring = "<gml:LinearRing><gml:posList>1 2 0 3 4 0 1 2 0</gml:posList></gml:LinearRing>"
    inline = (
        '      <uro:lod0MultiSurface><gml:MultiSurface gml:id="ms1"><gml:surfaceMembers><gml:Polygon gml:id="p1">'
        f"<gml:exterior>{ring}</gml:exterior></gml:Polygon></gml:surfaceMembers></gml:MultiSurface>"
        "</uro:lod0MultiSurface>\n"
    )
    exported = (
        '      <uro:lod0MultiSurface><gml:MultiSurface gml:id="x"><gml:surfaceMember><gml:Polygon gml:id="y">'
        f"<gml:exterior>{ring}</gml:exterior></gml:Polygon></gml:surfaceMember></gml:MultiSurface>"
        "</uro:lod0MultiSurface>\n"
    )
    reference = '      <uro:lod0MultiSurface xlink:href="#ms1"/>\n'
    reference_exported = '      <uro:lod0MultiSurface xlink:href="#x"/>\n'
    # the original writes the geometry in b1 and refers to it from b2; the export inlines it in b2 first
    a = write(tmp_path, "a.gml", building("b1", STANDARD + inline), building("b2", STANDARD + reference))
    b = write(tmp_path, "b.gml", building("b1", STANDARD + reference_exported), building("b2", STANDARD + exported))
    assert compare.main([a, b]) == 1
    assert compare.main([a, b, "--db"]) == 0


def test_db_ignores_a_missing_hash_in_xlinks(tmp_path: Path) -> None:
    a = write(tmp_path, "a.gml", building("b1", STANDARD + '      <uro:buildingIDAttribute xlink:href="x1"/>\n'))
    b = write(tmp_path, "b.gml", building("b1", STANDARD + '      <uro:buildingIDAttribute xlink:href="#x1"/>\n'))
    assert compare.main([a, b]) == 1
    assert compare.main([a, b, "--db"]) == 0
