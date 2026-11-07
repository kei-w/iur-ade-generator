"""Configuration: defaults, iur-ade.toml and environment overrides, editions."""

from pathlib import Path

import pytest

from iur_ade_generator import config
from iur_ade_generator.errors import GeneratorError


def test_defaults_without_a_file(tmp_path: Path) -> None:
    cfg = config.load(tmp_path / "missing.toml", env={})
    assert cfg.tools.ade_xjc is None
    assert cfg.tools.psql == "psql"
    assert cfg.database.port == 5432
    assert cfg.workspace.citygml4j == config.REPO_ROOT.parent / "iur-ade-citygml4j"
    assert cfg.workspace.out == config.REPO_ROOT / "out"
    assert set(cfg.editions) == {"2.0", "3.0", "3.1", "3.2"}


def test_file_values_and_relative_paths(tmp_path: Path) -> None:
    (tmp_path / "tools").mkdir()
    (tmp_path / "iur-ade.toml").write_text(
        '[tools]\nade_xjc = "tools"\npsql = "C:/pg/psql.exe"\n'
        '[database]\nport = 35432\npassword = "secret"\n'
        '[workspace]\nout = "results"\n'
        '[editions."3.1"]\ndatabase = "citydb_iur31"\n',
        encoding="utf-8",
    )
    cfg = config.load(tmp_path / "iur-ade.toml", env={})
    assert cfg.tools.ade_xjc == (tmp_path / "tools").resolve()
    assert cfg.tools.psql == "C:/pg/psql.exe"
    assert cfg.database.port == 35432 and cfg.database.password == "secret"
    assert cfg.workspace.out == (tmp_path / "results").resolve()
    assert cfg.edition("3.1").database == "citydb_iur31"
    assert cfg.edition("3.1").branch == "iur-3.1"
    assert cfg.edition("3.2").database == "citydb_poc32"


def test_environment_overrides_the_file(tmp_path: Path) -> None:
    (tmp_path / "iur-ade.toml").write_text('[database]\npassword = "file"\nport = 1\n', encoding="utf-8")
    env = {"IUR_ADE_DATABASE_PASSWORD": "env", "IUR_ADE_TOOLS_IMPEXP": str(tmp_path)}
    cfg = config.load(tmp_path / "iur-ade.toml", env=env)
    assert cfg.database.password == "env"
    assert cfg.database.port == 1
    assert cfg.tools.impexp == tmp_path.resolve()


def test_the_config_file_is_taken_from_the_environment(tmp_path: Path) -> None:
    (tmp_path / "custom.toml").write_text('[database]\nuser = "me"\n', encoding="utf-8")
    cfg = config.load(env={"IUR_ADE_CONFIG": str(tmp_path / "custom.toml")})
    assert cfg.database.user == "me"


@pytest.mark.parametrize(
    "text",
    [
        "[tools]\nbogus = 1\n",
        "[typo]\nx = 1\n",
        '[editions."9.9"]\ndatabase = "x"\n',
        '[editions."3.1"]\nbogus = "x"\n',
        '[database]\nport = "many"\n',
        "not toml",
    ],
)
def test_invalid_files_are_reported(tmp_path: Path, text: str) -> None:
    (tmp_path / "iur-ade.toml").write_text(text, encoding="utf-8")
    with pytest.raises(GeneratorError):
        config.load(tmp_path / "iur-ade.toml", env={})


def test_unknown_edition() -> None:
    with pytest.raises(GeneratorError, match="unknown i-UR version"):
        config.Config().edition("1.4")


def test_required_tools(tmp_path: Path) -> None:
    with pytest.raises(GeneratorError, match=r"tools\.ade_xjc is not configured"):
        config.Tools().require("ade_xjc")
    with pytest.raises(GeneratorError, match="does not exist"):
        config.Tools(ade_xjc=tmp_path / "nowhere").require("ade_xjc")
    assert config.Tools(ade_xjc=tmp_path).citygml_schemas == tmp_path / "schemas" / "citygml" / "2.0.0"


def test_edition_names() -> None:
    edition = config.EDITIONS["3.1"]
    assert edition.nn == "31"
    assert edition.jaxb_package == "jp.geospatial.iur._3_1"
    assert edition.jaxb_packages == (
        "jp.geospatial.iur._3_1.uro",
        "jp.geospatial.iur._3_1.urf",
        "jp.geospatial.iur._3_1.urg",
        "jp.geospatial.iur._3_1.urt",
    )
    assert edition.namespace("urf") == "https://www.geospatial.jp/iur/urf/3.1"
    assert edition.fixture_name == "iur31_all.gml"
    assert edition.extension_name == "iur-ade-3.1.0"
    assert config.EDITIONS["2.0"].extension_name == "iur-ade-2.2.0"
