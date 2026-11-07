"""Integration tests: the generators reproduce the committed code of both forks (run with ``pytest -m integration``).

They need the forks next to this repository (``iur-ade.toml`` / ``IUR_ADE_WORKSPACE_*``) with clean working trees;
they switch the forks to the branch of every edition and run the generators without ade-xjc, the builds or a
database.
"""

from __future__ import annotations

import pytest

from iur_ade_generator import config, fixture, gen_citydb, regen
from iur_ade_generator.citygml4j import generator as citygml4j_generator
from iur_ade_generator.mapping import generate as mapping_generate
from iur_ade_generator.mapping import patch as mapping_patch
from iur_ade_generator.tools import git

pytestmark = pytest.mark.integration


@pytest.fixture(scope="module")
def cfg() -> config.Config:
    cfg = config.load()
    for name in ("citygml4j", "citydb"):
        repo = cfg.workspace.require(name)
        if git(repo, "status", "--short").strip():
            pytest.skip(f"{repo} has uncommitted changes")
    return cfg


@pytest.mark.parametrize("version", list(config.EDITIONS))
def test_the_generators_reproduce_the_committed_code(
    cfg: config.Config, version: str, tmp_path_factory: pytest.TempPathFactory
) -> None:
    edition = cfg.edition(version)
    citygml4j, citydb = regen.checkout(cfg, edition)
    g, d = str(citygml4j), str(citydb)
    try:
        regen.update_urf_schema(edition, citygml4j)
        mapping_patch.main([d, g, version, "uro"])
        citygml4j_generator.main([g, d, version, "all", regen.MODULES])
        mapping_generate.main([d, g, version, "urf", "uro"])
        gen_citydb.main([d, g, version, "all", regen.MODULES])
        path = tmp_path_factory.mktemp("fixture") / edition.fixture_name
        fixture.main([g, d, version, "all", str(path), regen.MODULES])
        assert git(citygml4j, "status", "--short") == ""
        assert git(citydb, "status", "--short") == ""
        committed = regen.FIXTURES / edition.fixture_name
        if committed.exists():
            assert path.read_bytes() == committed.read_bytes()
    finally:
        git(citygml4j, "checkout", "-q", "--", ".")
        git(citydb, "checkout", "-q", "--", ".")
