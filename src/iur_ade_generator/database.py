"""Verification databases: a fresh 3DCityDB 4.4.1 with an i-UR ADE extension registered (``iur-ade recreate-db``)."""

from __future__ import annotations

import logging
from pathlib import Path

from .config import REPO_ROOT, Config
from .errors import GeneratorError
from .tools import gradle, psql

log = logging.getLogger(__name__)

ADE_TRANSFORM = REPO_ROOT / "java" / "ade-transform"


def table_count(config: Config, name: str, where: str = "") -> int:
    sql = f"select count(*) from information_schema.tables where table_schema = 'citydb'{where}"
    return int(psql(config.tools, config.database, name, "-t", "-A", "-c", sql).strip())


def recreate(config: Config, name: str, extension_dir: Path, out: Path) -> None:
    """Drops and recreates the database ``name`` (PostGIS, 3DCityDB with the configured SRID) and registers the
    extension folder ``extension_dir`` (``<impexp>/ade-extensions-*/iur-ade-<version>``) in it."""
    tools, db = config.tools, config.database
    scripts = tools.require("citydb_scripts")
    if not (scripts / "CREATE_DB.sql").exists():
        raise GeneratorError(f"tools.citydb_scripts has no CREATE_DB.sql: {scripts}")
    if not (extension_dir / "schema-mapping").is_dir():
        raise GeneratorError(f"not an extension folder (no schema-mapping/): {extension_dir}")
    log.info("database %s: recreating", name)
    psql(tools, db, "postgres", "-c", f"DROP DATABASE IF EXISTS {name};", "-c", f"CREATE DATABASE {name};")
    psql(
        tools,
        db,
        name,
        "-c",
        "CREATE EXTENSION IF NOT EXISTS postgis;",
        "-c",
        "CREATE EXTENSION IF NOT EXISTS postgis_raster;",
    )
    psql(
        tools,
        db,
        name,
        "-v",
        f"srsno={db.srid}",
        "-v",
        f"gmlsrsname={db.gml_srs_name}",
        "-f",
        "CREATE_DB.sql",
        cwd=scripts,
    )
    core = table_count(config, name)
    register(config, name, extension_dir, out)
    ade = table_count(config, name, " and table_name like 'ur\\_%'")
    log.info("database %s: %d core tables, %d ADE tables", name, core, ade)


def register(config: Config, name: str, extension_dir: Path, out: Path) -> None:
    """Registers the extension through the ADE Manager (``java/ade-transform``, task ``register``)."""
    tools, db = config.tools, config.database
    args = f"{extension_dir.as_posix()} {db.host} {db.port} {name} {db.user} {db.password}"
    log_file = out / f"register_{name}.log"
    output = gradle(
        ADE_TRANSFORM,
        f"-DdeleteScript={(out / f'delete_{name}.sql').as_posix()}",
        "register",
        f"--args={args}",
        log_file=log_file,
        properties={"impexpHome": tools.require("impexp").as_posix()},
    )
    if "registerADE: true" not in output:
        raise GeneratorError(f"registration of {extension_dir} in {name} failed (log: {log_file})")
    log.info("extension registered in %s (delete functions: %s)", name, out / f"delete_{name}.sql")
