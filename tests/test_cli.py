"""The iur-ade command: help, dispatch of the generator commands, error reporting."""

from pathlib import Path

import pytest

from iur_ade_generator import cli
from iur_ade_generator.errors import GeneratorError


def test_help_lists_the_commands(capsys: pytest.CaptureFixture[str]) -> None:
    with pytest.raises(SystemExit) as e:
        cli.main(["--help"])
    assert e.value.code == 0
    out = capsys.readouterr().out
    for name in ("regen", "verify", "recreate-db", "gen-citydb", "compare", "changes-urf"):
        assert name in out


def test_a_generator_command_gets_its_arguments(monkeypatch: pytest.MonkeyPatch) -> None:
    seen: list[list[str]] = []
    monkeypatch.setitem(cli.GENERATORS, "gen-citydb", (lambda args: seen.append(args), "<args>", "test"))
    assert cli.main(["gen-citydb", "citydb", "citygml4j", "3.1", "all", "uro,urf"]) == 0
    assert seen == [["citydb", "citygml4j", "3.1", "all", "uro,urf"]]


def test_compare_passes_its_options_through(monkeypatch: pytest.MonkeyPatch) -> None:
    seen: list[list[str]] = []

    def fake_compare(args: list[str]) -> int:
        seen.append(args)
        return 1

    monkeypatch.setitem(cli.GENERATORS, "compare", (fake_compare, "<args>", "test"))
    assert cli.main(["compare", "a.gml", "b.gml", "--db", "--subset"]) == 1
    assert seen == [["a.gml", "b.gml", "--db", "--subset"]]


def test_generator_errors_are_messages(monkeypatch: pytest.MonkeyPatch, capsys: pytest.CaptureFixture[str]) -> None:
    def fail(args: list[str]) -> None:
        raise GeneratorError("something is missing")

    monkeypatch.setitem(cli.GENERATORS, "fixture", (fail, "<args>", "test"))
    assert cli.main(["fixture", "x"]) == 1
    assert "iur-ade: something is missing" in capsys.readouterr().err


def test_regen_reports_a_missing_tool(tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    (tmp_path / "iur-ade.toml").write_text(
        f'[workspace]\ncitygml4j = "{tmp_path.as_posix()}/g"\ncitydb = "{tmp_path.as_posix()}/d"\n', encoding="utf-8"
    )
    assert cli.main(["--config", str(tmp_path / "iur-ade.toml"), "regen", "3.1"]) == 1
    assert "workspace.citygml4j is not a git repository" in capsys.readouterr().err


def test_unknown_version(tmp_path: Path, capsys: pytest.CaptureFixture[str]) -> None:
    assert cli.main(["--config", str(tmp_path / "none.toml"), "regen", "1.4"]) == 1
    assert "unknown i-UR version" in capsys.readouterr().err
