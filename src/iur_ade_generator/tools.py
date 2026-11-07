"""Subprocess wrappers for the external tools: git, Gradle, ade-xjc, the Importer/Exporter and psql.

Every call logs its command, writes the complete output to a log file when one is given and raises
``GeneratorError`` with the last lines of the output when the tool fails.
"""

from __future__ import annotations

import logging
import os
import subprocess
import sys
from collections.abc import Mapping, Sequence
from pathlib import Path

from .config import Database, Tools
from .errors import GeneratorError

log = logging.getLogger(__name__)

IS_WINDOWS = sys.platform == "win32"


def run(
    cmd: Sequence[str | Path],
    *,
    cwd: Path | None = None,
    env: Mapping[str, str] | None = None,
    log_file: Path | None = None,
    check: bool = True,
) -> str:
    """Runs ``cmd`` and returns its combined output (stdout and stderr)."""
    args = [str(c) for c in cmd]
    log.debug("run: %s (cwd %s)", " ".join(args), cwd or Path.cwd())
    full_env = {**os.environ, **env} if env else None
    try:
        result = subprocess.run(
            args,
            cwd=cwd,
            env=full_env,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            encoding="utf-8",
            errors="replace",
            check=False,
        )
    except OSError as e:
        raise GeneratorError(f"cannot run {args[0]}: {e}") from None
    output = result.stdout or ""
    if log_file is not None:
        log_file.parent.mkdir(parents=True, exist_ok=True)
        log_file.write_text(output, encoding="utf-8")
    if check and result.returncode != 0:
        tail = "\n".join(output.rstrip().splitlines()[-15:])
        where = f" (log: {log_file})" if log_file else ""
        raise GeneratorError(f"{Path(args[0]).name} failed with exit code {result.returncode}{where}\n{tail}")
    return output


def script(folder: Path, name: str) -> Path:
    """The start script ``name`` of a tool folder: ``name.bat`` on Windows, ``name`` elsewhere."""
    return folder / (f"{name}.bat" if IS_WINDOWS else name)


def git(repo: Path, *args: str, check: bool = True) -> str:
    return run(["git", "-C", repo, *args], check=check)


def gradle(project: Path, *args: str, log_file: Path | None = None, properties: Mapping[str, str] | None = None) -> str:
    """Runs the Gradle wrapper of ``project`` quietly."""
    props = [f"-P{k}={v}" for k, v in (properties or {}).items()]
    return run([script(project, "gradlew"), "-q", *props, *args], cwd=project, log_file=log_file)


def ade_xjc(tools: Tools, work_dir: Path, log_file: Path | None = None) -> str:
    """Runs ade-xjc in ``work_dir`` (``UrbanRevitalizationADE.xsd``, ``binding.xjb``, ``schemas/``) into ``src-gen``.

    The Javadoc of the generated classes follows the JVM locale, so it is forced to English."""
    ade_xjc_home = tools.require("ade_xjc")
    options = os.environ.get("JAVA_TOOL_OPTIONS", "")
    env = {"JAVA_TOOL_OPTIONS": f"{options} -Duser.language=en -Duser.country=US".strip()}
    cmd: list[str | Path] = [
        script(ade_xjc_home, "ade-xjc"),
        "-Xnamespace-prefix",
        "-clean",
        "-output",
        "src-gen",
        "-binding",
        "binding.xjb",
        "UrbanRevitalizationADE.xsd",
    ]
    return run(cmd, cwd=work_dir, env=env, log_file=log_file)


def impexp(
    tools: Tools,
    database: Database,
    name: str,
    extension_folder: str,
    operation: str,
    *args: str,
    log_file: Path | None = None,
) -> str:
    """Runs the Importer/Exporter command line (``import`` or ``export``) against the database ``name``."""
    home = tools.require("impexp")
    cmd: list[str | Path] = [
        script(home / "bin", "impexp"),
        operation,
        "-H",
        database.host,
        "-P",
        str(database.port),
        "-d",
        name,
        "-u",
        database.user,
        f"-p={database.password}",
        f"--ade-extensions={extension_folder}",
        *args,
    ]
    # the Importer/Exporter reports failures in its log and may still exit with 0
    output = run(cmd, cwd=home, log_file=log_file, check=False)
    if any(word in output.lower() for word in ("aborted", "fatal")):
        tail = "\n".join(line for line in output.splitlines() if "caused by" in line.lower() or "error" in line.lower())
        raise GeneratorError(f"impexp {operation} failed (log: {log_file})\n{tail[-2000:]}")
    return output


def psql(tools: Tools, database: Database, name: str, *args: str, cwd: Path | None = None, quiet: bool = True) -> str:
    """Runs psql against the database ``name`` with the configured credentials."""
    cmd = [
        tools.psql,
        "-h",
        database.host,
        "-p",
        str(database.port),
        "-U",
        database.user,
        "-d",
        name,
        "-v",
        "ON_ERROR_STOP=1",
        *(["-q"] if quiet else []),
        *args,
    ]
    return run(cmd, cwd=cwd, env={"PGPASSWORD": database.password})
