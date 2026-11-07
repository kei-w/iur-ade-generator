"""The file steps of iur-ade regen that need no external tool."""

from pathlib import Path

import pytest

from iur_ade_generator import config, regen
from iur_ade_generator.errors import GeneratorError

WRAPPER = (
    b'<?xml version="1.0" encoding="UTF-8"?>\r\n'
    b'<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">\r\n'
    b'  <xs:import namespace="http://www.kantei.go.jp/jp/singi/tiiki/toshisaisei/itoshisaisei/iur/urg/1.4" '
    b'schemaLocation="schemas/statisticalGrid.xsd"/>\r\n'
    b'  <xs:import namespace="https://www.geospatial.jp/iur/uro/3.1" schemaLocation="schemas/urbanObject.xsd"/>\r\n'
    b'  <xs:import namespace="http://www.kantei.go.jp/jp/singi/tiiki/toshisaisei/itoshisaisei/iur/urf/1.4" '
    b'schemaLocation="schemas/urbanFunction.xsd"/>\r\n'
    b'  <xs:import namespace="http://www.kantei.go.jp/jp/singi/tiiki/toshisaisei/itoshisaisei/iur/urt/1.4" '
    b'schemaLocation="schemas/publicTransit.xsd"/>\r\n'
    b"</xs:schema>\r\n"
)


def fake_fork(tmp_path: Path) -> Path:
    fork = tmp_path / "iur-ade-citygml4j"
    (fork / "src/main/resources/org/citygml4j/ade/iur/schema").mkdir(parents=True)
    (fork / "resources/ade-xjc/schemas").mkdir(parents=True)
    (fork / "resources/ade-xjc/UrbanRevitalizationADE.xsd").write_bytes(WRAPPER)
    return fork


def test_update_schemas_copies_the_schemas_and_rewrites_the_imports(tmp_path: Path) -> None:
    fork = fake_fork(tmp_path)
    edition = config.EDITIONS["3.1"]
    regen.update_schemas(edition, fork)

    for prefix, file in regen.SCHEMA_FILES.items():
        source = regen.module_schema(edition, prefix).read_bytes()
        resource = fork / "src/main/resources/org/citygml4j/ade/iur/schema" / file
        assert resource.read_bytes() == source, "the schema resource is the dataset schema byte for byte"
        copy = (fork / "resources/ade-xjc/schemas" / file).read_bytes()
        assert b"\r\n" not in copy
        assert b"schemas.opengis.net" not in copy and b"../../uro/" not in copy
    urf = (fork / "resources/ade-xjc/schemas/urbanFunction.xsd").read_bytes()
    assert b'schemaLocation="../../schemas/gml/3.1.1/base/gml.xsd"' in urf
    assert b'schemaLocation="../../schemas/citygml/2.0.0/cityGMLBase.xsd"' in urf
    assert b'schemaLocation="urbanObject.xsd"' in urf
    urg = (fork / "resources/ade-xjc/schemas/statisticalGrid.xsd").read_bytes()
    assert b'schemaLocation="../../schemas/citygml/2.0.0/cityObjectGroup.xsd"' in urg

    wrapper = (fork / "resources/ade-xjc/UrbanRevitalizationADE.xsd").read_bytes()
    for prefix, file in regen.SCHEMA_FILES.items():
        assert (
            f'namespace="https://www.geospatial.jp/iur/{prefix}/3.1" schemaLocation="schemas/{file}"'.encode()
            in wrapper
        )
    assert b"kantei" not in wrapper
    assert b"\r\n" in wrapper, "the line endings of the wrapper are kept"

    # idempotent
    regen.update_schemas(edition, fork)
    assert (fork / "resources/ade-xjc/UrbanRevitalizationADE.xsd").read_bytes() == wrapper


@pytest.mark.parametrize("version", ["2.0", "3.0", "3.1", "3.2"])
def test_every_edition_has_its_schemas(version: str) -> None:
    for prefix in regen.SCHEMA_FILES:
        assert regen.module_schema(config.EDITIONS[version], prefix).exists()


def test_a_missing_schema_is_reported() -> None:
    edition = config.Edition("9.9", "x", "9.9.0", "9.9.0", "db", "ext")
    with pytest.raises(GeneratorError, match="no urf schema"):
        regen.module_schema(edition, "urf")


def test_timestamp_javadoc_and_member_order_are_ignored_when_comparing_jaxb_files() -> None:
    a = (
        "// Generated: Sat Nov 07 17:59:35 JST 2026\npackage x;\n\n"
        "/**\n * {@link A}\n * {@link B}\n */\nclass P {\n    A getA() { return a; }\n\n    B getB() { return b; }\n}\n"
    )
    b = (
        "// Generated: Sat Nov 07 21:28:03 JST 2026\npackage x;\n\n"
        "/**\n * {@link B}\n * {@link A}\n */\nclass P {\n    B getB() { return b; }\n\n    A getA() { return a; }\n}\n"
    )
    assert regen._code_lines(a) == regen._code_lines(b)
    assert regen._code_lines(a) != regen._code_lines(b.replace("getB()", "getC()"))


def test_compare_files_writes_the_report(tmp_path: Path) -> None:
    gml = (
        '<core:CityModel xmlns:core="http://www.opengis.net/citygml/2.0" xmlns:gml="http://www.opengis.net/gml" '
        'xmlns:bldg="http://www.opengis.net/citygml/building/2.0"><core:cityObjectMember>'
        '<bldg:Building gml:id="b"><bldg:measuredHeight uom="m">%s</bldg:measuredHeight></bldg:Building>'
        "</core:cityObjectMember></core:CityModel>"
    )
    a, b = tmp_path / "a.gml", tmp_path / "b.gml"
    a.write_text(gml % "4.0", encoding="utf-8")
    b.write_text(gml % "5", encoding="utf-8")
    report = tmp_path / "report.txt"
    code, summary = regen.compare_files(a, b, [], report)
    assert code == 1
    assert summary.startswith("city objects compared: 1,")
    assert "standard content differs for b" in report.read_text(encoding="utf-8")
    b.write_text(gml % "4", encoding="utf-8")
    assert regen.compare_files(a, b, ["--db"], None)[0] == 0
