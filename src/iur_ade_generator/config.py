"""Configuration: the editions of the i-UR ADE, the external tools, the verification database and the workspace.

The defaults are overridden by ``iur-ade.toml`` in the repository root (or the file named by ``IUR_ADE_CONFIG``) and
then by environment variables ``IUR_ADE_<SECTION>_<KEY>`` (for example ``IUR_ADE_DATABASE_PASSWORD``);
``iur-ade.example.toml`` documents the keys.
"""

from __future__ import annotations

import dataclasses
import os
import tomllib
from collections.abc import Mapping
from dataclasses import dataclass, field, fields
from pathlib import Path
from typing import Any

from .errors import GeneratorError

REPO_ROOT = Path(__file__).resolve().parents[2]
CONFIG_FILE = "iur-ade.toml"
# the generated modules of every edition, in generation order (urf, urg and urt refer to uro types)
MODULES = ("uro", "urf", "urg", "urt")
ENV_PREFIX = "IUR_ADE_"


@dataclass(frozen=True)
class Edition:
    """One version of the i-UR ADE: a branch pair of the forks, an artifact version, a verification database and an
    Importer/Exporter extension folder."""

    version: str
    branch: str
    citygml4j_version: str
    citydb_version: str
    database: str
    extension_folder: str

    @property
    def nn(self) -> str:
        """The version without its dot, as used in file names (``iur31_all.gml``)."""
        return self.version.replace(".", "")

    @property
    def jaxb_package(self) -> str:
        return "jp.geospatial.iur._" + self.version.replace(".", "_")

    @property
    def jaxb_packages(self) -> tuple[str, ...]:
        """The packages ade-xjc generates for the edition, copied into the citygml4j fork."""
        return tuple(f"{self.jaxb_package}.{module}" for module in MODULES)

    def namespace(self, module: str) -> str:
        return f"https://www.geospatial.jp/iur/{module}/{self.version}"

    @property
    def fixture_name(self) -> str:
        return f"iur{self.nn}_all.gml"

    @property
    def extension_name(self) -> str:
        """The extension folder the citydb distribution installs to (``iur-ade-<citydb version>``)."""
        return f"iur-ade-{self.citydb_version}"


EDITIONS: dict[str, Edition] = {
    "2.0": Edition("2.0", "iur-2.0", "2.0.0", "2.2.0", "citydb_poc", "ade-extensions-iur20"),
    "3.0": Edition("3.0", "iur-3.0", "3.0.0", "3.0.0", "citydb_poc30", "ade-extensions-iur30"),
    "3.1": Edition("3.1", "iur-3.1", "3.1.0", "3.1.0", "citydb_poc31", "ade-extensions-iur31"),
    "3.2": Edition("3.2", "iur-3.2", "3.2.0", "3.2.0", "citydb_poc32", "ade-extensions-iur32"),
}


@dataclass(frozen=True)
class Tools:
    """Folders of the external tools; ``None`` until configured."""

    ade_xjc: Path | None = None
    """ade-xjc 2.10.0 (``ade-xjc.bat`` / ``ade-xjc``, ``lib/``, ``schemas/`` with the GML and CityGML schemas)."""
    impexp: Path | None = None
    """3DCityDB Importer/Exporter 5.5.0 with the ADE Manager plugin (``bin/``, ``lib/``, ``plugins/``)."""
    citydb_scripts: Path | None = None
    """``postgresql/SQLScripts`` of 3DCityDB 4.4.1 (``CREATE_DB.sql``)."""
    psql: str = "psql"
    """The psql executable."""

    def require(self, name: str) -> Path:
        value = getattr(self, name)
        if value is None:
            raise GeneratorError(f"tools.{name} is not configured ({CONFIG_FILE} or {ENV_PREFIX}TOOLS_{name.upper()})")
        if not isinstance(value, Path):
            raise GeneratorError(f"tools.{name} is not a path")
        if not value.exists():
            raise GeneratorError(f"tools.{name} does not exist: {value}")
        return value

    @property
    def citygml_schemas(self) -> Path:
        """The CityGML 2.0 schemas used for the XSD validation (shipped with ade-xjc)."""
        return self.require("ade_xjc") / "schemas" / "citygml" / "2.0.0"


@dataclass(frozen=True)
class Database:
    """The PostgreSQL server of the verification databases (one database per edition, see ``Edition.database``)."""

    host: str = "localhost"
    port: int = 5432
    user: str = "postgres"
    password: str = ""
    srid: int = 6697
    gml_srs_name: str = "urn:ogc:def:crs:EPSG::6697"


@dataclass(frozen=True)
class Workspace:
    """The forks and the output folder."""

    citygml4j: Path = field(default_factory=lambda: REPO_ROOT.parent / "iur-ade-citygml4j")
    citydb: Path = field(default_factory=lambda: REPO_ROOT.parent / "iur-ade-citydb")
    out: Path = field(default_factory=lambda: REPO_ROOT / "out")

    def require(self, name: str) -> Path:
        value: Path = getattr(self, name)
        if name != "out" and not (value / ".git").exists():
            raise GeneratorError(f"workspace.{name} is not a git repository: {value}")
        return value


@dataclass(frozen=True)
class Config:
    tools: Tools = field(default_factory=Tools)
    database: Database = field(default_factory=Database)
    workspace: Workspace = field(default_factory=Workspace)
    editions: dict[str, Edition] = field(default_factory=lambda: dict(EDITIONS))

    def edition(self, version: str) -> Edition:
        try:
            return self.editions[version]
        except KeyError:
            raise GeneratorError(f"unknown i-UR version {version!r}; known: {', '.join(self.editions)}") from None


def _coerce(value: Any, type_name: str, base: Path) -> Any:
    """Converts a TOML or environment value to the type of the dataclass field (paths relative to ``base``)."""
    if type_name in ("Path", "Path | None"):
        if value is None or value == "":
            return None
        path = Path(str(value)).expanduser()
        return path if path.is_absolute() else (base / path).resolve()
    if type_name == "int":
        try:
            return int(value)
        except TypeError, ValueError:
            raise GeneratorError(f"not an integer: {value!r}") from None
    return str(value)


def _section(cls: type[Any], values: Mapping[str, Any], env: Mapping[str, str], name: str, base: Path) -> Any:
    kwargs: dict[str, Any] = {}
    unknown = set(values) - {f.name for f in fields(cls)}
    if unknown:
        raise GeneratorError(f"unknown key(s) in [{name}]: {', '.join(sorted(unknown))}")
    for f in fields(cls):
        env_name = f"{ENV_PREFIX}{name.upper()}_{f.name.upper()}"
        if env_name in env:
            kwargs[f.name] = _coerce(env[env_name], str(f.type), Path.cwd())
        elif f.name in values:
            kwargs[f.name] = _coerce(values[f.name], str(f.type), base)
    return cls(**kwargs)


def _editions(values: Mapping[str, Any]) -> dict[str, Edition]:
    editions = dict(EDITIONS)
    for version, overrides in values.items():
        if not isinstance(overrides, Mapping):
            raise GeneratorError(f"[editions.{version}] must be a table")
        base = editions.get(version)
        if base is None:
            raise GeneratorError(f"unknown edition {version!r} in [editions]; known: {', '.join(editions)}")
        unknown = set(overrides) - {f.name for f in fields(Edition)} - {"version"}
        if unknown:
            raise GeneratorError(f"unknown key(s) in [editions.{version}]: {', '.join(sorted(unknown))}")
        editions[version] = dataclasses.replace(base, **{k: str(v) for k, v in overrides.items() if k != "version"})
    return editions


def load(path: Path | None = None, env: Mapping[str, str] | None = None) -> Config:
    """The configuration from the defaults, the TOML file and the environment."""
    env = os.environ if env is None else env
    if path is None:
        named = env.get(f"{ENV_PREFIX}CONFIG")
        path = Path(named) if named else REPO_ROOT / CONFIG_FILE
    values: dict[str, Any] = {}
    if path.exists():
        with path.open("rb") as f:
            try:
                values = tomllib.load(f)
            except tomllib.TOMLDecodeError as e:
                raise GeneratorError(f"{path}: {e}") from None
    unknown = set(values) - {"tools", "database", "workspace", "editions"}
    if unknown:
        raise GeneratorError(f"{path}: unknown section(s) {', '.join(sorted(unknown))}")
    base = path.parent.resolve()
    return Config(
        tools=_section(Tools, values.get("tools", {}), env, "tools", base),
        database=_section(Database, values.get("database", {}), env, "database", base),
        workspace=_section(Workspace, values.get("workspace", {}), env, "workspace", base),
        editions=_editions(values.get("editions", {})),
    )
