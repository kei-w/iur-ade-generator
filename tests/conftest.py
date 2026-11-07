"""Shared fixtures: the mini modules (a small uro/urf pair with JAXB stubs and an ADE Manager style mapping) and the
golden file comparison (``pytest --update-golden`` rewrites the golden files)."""

from __future__ import annotations

import difflib
import shutil
from pathlib import Path

import pytest

DATA = Path(__file__).parent / "data"
GOLDEN = Path(__file__).parent / "golden"
MINI = DATA / "mini"
MINI_GOLDEN = GOLDEN / "mini"
VERSION = "9.9"


def pytest_addoption(parser: pytest.Parser) -> None:
    parser.addoption("--update-golden", action="store_true", help="rewrite the golden files from the generated output")


@pytest.fixture
def update_golden(request: pytest.FixtureRequest) -> bool:
    return bool(request.config.getoption("--update-golden"))


@pytest.fixture
def mini(tmp_path: Path) -> Path:
    """A writable copy of the mini forks (``citygml4j/`` and ``citydb/``)."""
    target = tmp_path / "mini"
    shutil.copytree(MINI, target)
    return target


def golden_resources(citydb: Path) -> None:
    """Replaces the citydb resources of a mini copy by the golden ones (the patched mapping with the urf module)."""
    shutil.rmtree(citydb / "resources")
    shutil.copytree(MINI_GOLDEN / "resources", citydb / "resources")


def assert_golden(actual: Path, golden: Path, update: bool) -> None:
    """Compares every file below ``actual`` with the file of the same relative path below ``golden``."""
    files = sorted(p.relative_to(actual) for p in actual.rglob("*") if p.is_file() and p.name != ".gitkeep")
    if update:
        shutil.rmtree(golden, ignore_errors=True)
        for rel in files:
            (golden / rel).parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(actual / rel, golden / rel)
        return
    expected = sorted(p.relative_to(golden) for p in golden.rglob("*") if p.is_file())
    assert files == expected, f"generated files differ from the golden set: {sorted(set(files) ^ set(expected))}"
    for rel in files:
        a = (actual / rel).read_text(encoding="utf-8")
        g = (golden / rel).read_text(encoding="utf-8")
        if a != g:
            diff = "".join(
                difflib.unified_diff(g.splitlines(True), a.splitlines(True), f"golden/{rel}", f"generated/{rel}")
            )
            pytest.fail(f"{rel} differs from the golden file (pytest --update-golden rewrites it):\n{diff[:4000]}")
