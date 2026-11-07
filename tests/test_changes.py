"""The CHANGES.md sections of both forks (iur-ade changes-features / changes-urf)."""

from __future__ import annotations

from pathlib import Path

import pytest

from iur_ade_generator import changes
from iur_ade_generator.errors import GeneratorError

CHANGES = """# Changes

### 3.1.0 - 2026-11-07

##### Changes
* The i-UR 3.1 Urban Object module.

##### Known limitations
* Something old.

### 1.4.0 - 2020-01-01

##### Changes
* The hand-written 1.4 modules.
"""


def forks(tmp_path: Path) -> tuple[Path, Path]:
    g, d = tmp_path / "citygml4j", tmp_path / "citydb"
    for repo in (g, d):
        repo.mkdir()
        (repo / "CHANGES.md").write_text(CHANGES, encoding="utf-8")
    return g, d


def test_feature_sections_are_added_once(tmp_path: Path) -> None:
    g, d = forks(tmp_path)
    changes.update_features(g, d, "3.1.0", "3.1.0", "3.1")
    text = (g / "CHANGES.md").read_text(encoding="utf-8")
    assert text.count("##### Changes (ADE feature types, 2026-11-07)") == 1
    assert text.count("##### Known limitations") == 1, "the previous limitations are replaced"
    assert "* Something old." not in text and "`urf`, `urg` and `urt` remain at 1.4." in text
    assert "### 1.4.0 - 2020-01-01\n\n##### Changes\n* The hand-written 1.4 modules.\n" in text
    assert "#### Changes (ADE feature types, 2026-11-07)" in (d / "CHANGES.md").read_text(encoding="utf-8")
    changes.update_features(g, d, "3.1.0", "3.1.0", "3.1")
    assert (g / "CHANGES.md").read_text(encoding="utf-8") == text, "idempotent"


def test_urf_section_follows_the_feature_section(tmp_path: Path) -> None:
    g, d = forks(tmp_path)
    changes.update_features(g, d, "3.1.0", "3.1.0", "3.2")
    changes.update_urf(g, d, "3.1.0", "3.1.0", "3.2", "132", "29")
    text = (g / "CHANGES.md").read_text(encoding="utf-8")
    assert (
        text.index("Changes (ADE feature types")
        < text.index("Changes (Urban Function module")
        < text.index("Known limitations")
    )
    assert text.count("Known limitations") == 1
    assert "`PointCloudPropertyElement`" in text and "132 feature types and 29 data types" in text
    db = (d / "CHANGES.md").read_text(encoding="utf-8")
    assert "`impexp delete` leaves" in db and "`ur_cityobject_2`" in db
    before = db
    changes.update_urf(g, d, "3.1.0", "3.1.0", "3.2", "132", "29")
    assert (d / "CHANGES.md").read_text(encoding="utf-8") == before


def test_a_missing_version_section_is_reported(tmp_path: Path) -> None:
    g, d = forks(tmp_path)
    with pytest.raises(GeneratorError, match="no section"):
        changes.update_features(g, d, "9.9.0", "9.9.0", "3.1")
