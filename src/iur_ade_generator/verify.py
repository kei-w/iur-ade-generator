"""Round trips of CityGML files through the generated code (``iur-ade verify``).

Without ``--db`` every file is read and written again by citygml4j with the ADE module (``java/roundtrip``) and
compared with its source. With ``--db`` the files are imported into a fresh verification database, everything is
exported and each file is compared with the export (``compare --db --subset``).
"""

from __future__ import annotations

import logging
import re
from collections.abc import Sequence
from pathlib import Path

from . import database
from .config import Config
from .errors import GeneratorError
from .regen import ROUNDTRIP, checkout, compare_files, extension_dir
from .tools import gradle, impexp

log = logging.getLogger(__name__)

CLEAN = re.compile(r"objects with ADE differences: 0, .*different order: 0, .*standard-content differences: 0")
CLEAN_DB = re.compile(r"objects with ADE differences: 0, .*different order: 0")
NO_ADE_DIFFERENCE = re.compile(r"objects with ADE differences: 0,")


def gml_files(paths: Sequence[Path]) -> list[Path]:
    """The ``.gml`` files of the given files and folders (folders recursively), sorted."""
    files: list[Path] = []
    for p in paths:
        if p.is_dir():
            files.extend(sorted(p.rglob("*.gml")))
        elif p.is_file():
            files.append(p)
        else:
            raise GeneratorError(f"not a file or folder: {p}")
    if not files:
        raise GeneratorError("no .gml files found")
    return [f.resolve() for f in files]


def verify_files(config: Config, version: str, paths: Sequence[Path], out: Path) -> int:
    """citygml4j round trip of every file; returns the number of failed or different files."""
    edition = config.edition(version)
    checkout(config, edition)
    files = gml_files(paths)
    out.mkdir(parents=True, exist_ok=True)
    bad = 0
    for f in files:
        roundtrip = out / f"{f.stem}.rt.gml"
        roundtrip.unlink(missing_ok=True)
        try:
            gradle(ROUNDTRIP, "run", f"--args={f.as_posix()} {roundtrip.as_posix()}", log_file=out / f"{f.stem}.log")
        except GeneratorError as e:
            bad += 1
            log.info("FAIL %s: %s", f.stem, str(e).splitlines()[-1][:160])
            continue
        if not roundtrip.exists() or roundtrip.stat().st_size == 0:
            bad += 1
            log.info("FAIL (no output) %s (log: %s)", f.stem, out / f"{f.stem}.log")
            continue
        _, summary = compare_files(f, roundtrip, [], out / f"{f.stem}.cmp.txt")
        if CLEAN.search(summary):
            log.info("ok   %s: %s", f.stem, summary)
        else:
            bad += 1
            log.info("DIFF %s: %s", f.stem, summary)
    log.info("files: %d, failed or different: %d", len(files), bad)
    return bad


def verify_db(config: Config, version: str, paths: Sequence[Path], out: Path, name: str | None = None) -> int:
    """Database round trip of every file; returns the number of failed or different files."""
    edition = config.edition(version)
    checkout(config, edition)
    files = gml_files(paths)
    out.mkdir(parents=True, exist_ok=True)
    name = name or edition.database
    tools, db = config.tools, config.database
    database.recreate(config, name, extension_dir(config, edition), out)
    imported: list[Path] = []
    for f in files:
        try:
            impexp(
                tools,
                db,
                name,
                edition.extension_folder,
                "import",
                "--creation-date=complement",
                "--no-appearance",
                str(f),
                log_file=out / f"{f.stem}.import.log",
            )
            imported.append(f)
        except GeneratorError as e:
            log.info("FAIL (import) %s: %s", f.stem, str(e).splitlines()[-1][:200])
    exported = out / "all_db.gml"
    impexp(
        tools,
        db,
        name,
        edition.extension_folder,
        "export",
        "--no-appearance",
        "-o",
        str(exported),
        log_file=out / "all.export.log",
    )
    bad = len(files) - len(imported)
    for f in imported:
        _, summary = compare_files(f, exported, ["--db", "--subset"], out / f"{f.stem}.cmp.txt")
        if CLEAN_DB.search(summary):
            log.info("ok   %s: %s", f.stem, summary)
        elif NO_ADE_DIFFERENCE.search(summary):
            log.info("ok   %s (generic property order only): %s", f.stem, summary)
        else:
            bad += 1
            log.info("DIFF %s: %s", f.stem, summary)
    log.info("files: %d, failed or different: %d", len(files), bad)
    return bad
