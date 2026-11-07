"""Regenerate one edition of the i-UR ADE end to end and verify it with its generated fixture (``iur-ade regen``).

Steps, as the PoC script ``regen_edition.sh`` ran them:

0. the urf, urg and urt schemas of the edition into the citygml4j fork (the original as schema resource, a copy with
   relative imports of the GML/CityGML schemas for ade-xjc and the generators);
1. the JAXB classes with ade-xjc (all four packages from one run);
2. the schema mapping (uro patches, generated urf mapping) and the code of both forks, their builds and the
   Importer/Exporter extension folder;
3. the fixture, a fresh verification database, the fixture round trip and the XSD validation.
"""

from __future__ import annotations

import contextlib
import io
import logging
import re
import shutil
from collections.abc import Sequence
from pathlib import Path

from . import binding, compare, database, fixture
from . import config as config_modules
from .citydb import generator as citydb_generator
from .citygml4j import generator as citygml4j_generator
from .config import REPO_ROOT, Config, Edition
from .errors import GeneratorError
from .mapping import generate as mapping_generate
from .mapping import patch as mapping_patch
from .tools import ade_xjc, git, gradle, impexp

log = logging.getLogger(__name__)

MODULES = ",".join(config_modules.MODULES)
SCHEMA_FILES = {"urf": "urbanFunction.xsd", "urg": "statisticalGrid.xsd", "urt": "publicTransit.xsd"}
ROUNDTRIP = REPO_ROOT / "java" / "roundtrip"
FIXTURES = REPO_ROOT / "fixtures"
CITYGML_SCHEMAS = (
    "cityGMLBase",
    "building",
    "bridge",
    "tunnel",
    "landUse",
    "cityFurniture",
    "relief",
    "transportation",
    "vegetation",
    "waterBody",
    "cityObjectGroup",
)
# the schema copy for ade-xjc imports the GML/CityGML schemas shipped with ade-xjc (two folders up, see generate_jaxb)
RELATIVE_IMPORTS = {
    "http://schemas.opengis.net/gml/3.1.1/base/gml.xsd": "../../schemas/gml/3.1.1/base/gml.xsd",
    "http://schemas.opengis.net/citygml/2.0/cityGMLBase.xsd": "../../schemas/citygml/2.0.0/cityGMLBase.xsd",
    "http://schemas.opengis.net/citygml/cityobjectgroup/2.0/cityObjectGroup.xsd": (
        "../../schemas/citygml/2.0.0/cityObjectGroup.xsd"
    ),
}
GENERATED_STAMP = "// Generated:"


def module_schema(edition: Edition, prefix: str) -> Path:
    """The schema of a generated module (besides uro) of the edition in this repository."""
    path = REPO_ROOT / "schemas" / "iur" / prefix / edition.version / SCHEMA_FILES[prefix]
    if not path.exists():
        raise GeneratorError(f"no {prefix} schema for {edition.version}: {path}")
    return path


def update_schemas(edition: Edition, citygml4j: Path) -> None:
    """Step 0: the urf, urg and urt schemas of the edition in the citygml4j fork: the original as schema resource,
    a copy with relative imports of the GML/CityGML schemas for ade-xjc and the generators, and the namespaces of the
    wrapper schema ade-xjc compiles."""
    resource = citygml4j / "src" / "main" / "resources" / "org" / "citygml4j" / "ade" / "iur" / "schema"
    ade_xjc_resources = citygml4j / "resources" / "ade-xjc"
    wrapper = ade_xjc_resources / "UrbanRevitalizationADE.xsd"
    data = wrapper.read_bytes()
    for prefix, file in SCHEMA_FILES.items():
        source = module_schema(edition, prefix)
        shutil.copyfile(source, resource / file)
        text = source.read_bytes().decode("utf-8").replace("\r\n", "\n")
        for absolute, relative in RELATIVE_IMPORTS.items():
            text = text.replace(f'schemaLocation="{absolute}"', f'schemaLocation="{relative}"')
        text = text.replace(
            f'schemaLocation="../../uro/{edition.version}/urbanObject.xsd"', 'schemaLocation="urbanObject.xsd"'
        )
        (ade_xjc_resources / "schemas" / file).write_text(text, encoding="utf-8", newline="\n")
        data = re.sub(
            rb'namespace="[^"]*/%s/[0-9.]*" schemaLocation="schemas/%s"' % (prefix.encode(), file.encode()),
            f'namespace="{edition.namespace(prefix)}" schemaLocation="schemas/{file}"'.encode(),
            data,
        )
    if data != wrapper.read_bytes():
        wrapper.write_bytes(data)
    log.info("urf, urg and urt %s schemas copied into %s", edition.version, citygml4j.name)


def generate_jaxb(config: Config, edition: Edition, citygml4j: Path, out: Path) -> None:
    """Step 1: the JAXB classes of the four packages with ade-xjc, copied into ``src-gen`` with LF line endings."""
    binding.main([str(citygml4j)])
    work = out / "ade-xjc" / edition.version
    shutil.rmtree(work, ignore_errors=True)
    resources = citygml4j / "resources" / "ade-xjc"
    shutil.copytree(resources / "schemas", work / "schemas")
    # the schema copies of the fork import "../../schemas/..." (the layout of a subfolder of the ade-xjc
    # installation); the working folder is elsewhere, so the imports point at the installation by URI (ade-xjc loads
    # the GML/CityGML schemas from there itself, a second copy would define every type twice)
    schemas_uri = (config.tools.require("ade_xjc") / "schemas").as_uri()
    for xsd in work.glob("schemas/*.xsd"):
        text = xsd.read_text(encoding="utf-8")
        xsd.write_text(
            text.replace('schemaLocation="../../schemas/', f'schemaLocation="{schemas_uri}/'),
            encoding="utf-8",
            newline="",
        )
    for name in ("UrbanRevitalizationADE.xsd", "binding.xjb"):
        shutil.copyfile(resources / name, work / name)
    output = ade_xjc(config.tools, work, log_file=out / f"ade-xjc{edition.nn}.log")
    lines = [line for line in output.splitlines() if line.strip()]
    if lines:
        log.info("ade-xjc: %s", lines[-1])
    src_gen = citygml4j / "src-gen" / "main" / "java"
    for package in edition.jaxb_packages:
        parts = package.split(".")
        source, target = work / "src-gen" / Path(*parts), src_gen / Path(*parts)
        if not source.is_dir():
            raise GeneratorError(f"ade-xjc did not generate {package} (log: {out / f'ade-xjc{edition.nn}.log'})")
        target.mkdir(parents=True, exist_ok=True)
        for old in target.glob("*.java"):
            old.unlink()
        files = sorted(source.glob("*.java"))
        for f in files:
            (target / f.name).write_bytes(f.read_bytes().replace(b"\r\n", b"\n"))
        log.info("JAXB classes of %s: %d files", package, len(files))
    shutil.rmtree(src_gen / "jp" / "go", ignore_errors=True)  # the 1.4 packages of the hand-written modules
    restore_timestamp_only_changes(citygml4j)


def _code_lines(text: str) -> list[str]:
    """The code lines of a generated Java file, sorted: without the generation timestamp, the Javadoc and blank
    lines. ade-xjc lists the members of a substitution group (the Javadoc and the accessors of the property types) in
    an order that changes from run to run."""
    lines = (line.strip() for line in text.splitlines())
    return sorted(line for line in lines if line and not line.startswith(("*", "/**", GENERATED_STAMP)))


def restore_timestamp_only_changes(citygml4j: Path) -> None:
    """JAXB files that only differ from the committed ones by their generation timestamp or the order of their
    members are kept as committed."""
    tracked = set(git(citygml4j, "ls-files", "src-gen").split())
    restored = 0
    for rel in git(citygml4j, "diff", "--name-only", "src-gen").split():
        path = citygml4j / rel
        if rel not in tracked or not path.is_file():
            continue
        committed = git(citygml4j, "show", f"HEAD:{rel}")
        if _code_lines(committed) == _code_lines(path.read_text(encoding="utf-8")):
            git(citygml4j, "checkout", "-q", "--", rel)
            restored += 1
    if restored:
        log.info("JAXB files with a new timestamp or member order only: %d (kept as committed)", restored)


def regenerate_code(config: Config, edition: Edition, citygml4j: Path, citydb: Path, out: Path) -> None:
    """Step 2: the schema mapping and the code of both forks, built and published (the patches and the mapping
    generation of urf, urg and urt are idempotent and start from the committed mapping)."""
    version = edition.version
    git(citydb, "checkout", "-q", "--", "resources/database")
    mapping_patch.main([str(citydb), str(citygml4j), version, "uro"])
    citygml4j_generator.main([str(citygml4j), str(citydb), version, "all", MODULES])
    gradle(citygml4j, "publishToMavenLocal", log_file=out / f"citygml4j{edition.nn}_build.log")
    for prefix in SCHEMA_FILES:
        mapping_generate.main([str(citydb), str(citygml4j), version, prefix, "uro"])
    citydb_generator.main([str(citydb), str(citygml4j), version, "all", MODULES])
    gradle(citydb, "installDist", log_file=out / f"citydb{edition.nn}_build.log")
    jar = citydb / "build" / "install" / "iur-ade" / "lib" / f"iur-ade-citydb-{edition.citydb_version}.jar"
    if not jar.exists():
        raise GeneratorError(f"citydb build did not produce {jar}")


def install_extension(config: Config, edition: Edition, citydb: Path) -> Path:
    """Copies the citydb distribution into the Importer/Exporter extension folder of the edition."""
    extension = config.tools.require("impexp") / edition.extension_folder / edition.extension_name
    for sub in ("lib", "3dcitydb", "schema-mapping"):
        shutil.rmtree(extension / sub, ignore_errors=True)
    shutil.copytree(citydb / "build" / "install" / "iur-ade", extension, dirs_exist_ok=True)
    log.info("extension installed: %s", extension)
    return extension


def extension_dir(config: Config, edition: Edition) -> Path:
    extension = config.tools.require("impexp") / edition.extension_folder / edition.extension_name
    if not (extension / "schema-mapping").is_dir():
        raise GeneratorError(f"extension folder {extension} does not exist; run 'iur-ade regen {edition.version}'")
    return extension


def write_fixture(edition: Edition, citygml4j: Path, citydb: Path) -> Path:
    """Step 3: the fixture with every attribute of the modules."""
    FIXTURES.mkdir(exist_ok=True)
    path = FIXTURES / edition.fixture_name
    fixture.main([str(citygml4j), str(citydb), edition.version, "all", str(path), MODULES])
    return path


def compare_files(original: Path, roundtrip: Path, options: Sequence[str], report: Path | None) -> tuple[int, str]:
    """Runs the comparison and returns its exit code and summary line; the full output goes to ``report``."""
    buffer = io.StringIO()
    with contextlib.redirect_stdout(buffer):
        code = compare.main([str(original), str(roundtrip), *options])
    output = buffer.getvalue()
    if report is not None:
        report.parent.mkdir(parents=True, exist_ok=True)
        report.write_text(output, encoding="utf-8")
    lines = [line for line in output.splitlines() if line.strip()]
    return code, lines[-1] if lines else ""


def round_trip(config: Config, edition: Edition, extension: Path, fixture: Path, out: Path) -> tuple[int, Path]:
    """Imports the fixture into a fresh database, exports it and compares (``compare --db``)."""
    tools, db = config.tools, config.database
    database.recreate(config, edition.database, extension, out)
    nn = edition.nn
    impexp(
        tools,
        db,
        edition.database,
        edition.extension_folder,
        "import",
        "--creation-date=complement",
        str(fixture),
        log_file=out / f"fixture{nn}_import.log",
    )
    exported = out / f"fixture{nn}_db.gml"
    impexp(
        tools,
        db,
        edition.database,
        edition.extension_folder,
        "export",
        "-o",
        str(exported),
        log_file=out / f"fixture{nn}_export.log",
    )
    report = out / f"cmp_fixture{nn}.txt"
    code, summary = compare_files(fixture, exported, ["--db"], report)
    for line in report.read_text(encoding="utf-8").splitlines():
        if line.startswith("===") or line.startswith("city objects"):
            log.info("%s", line)
    if code != 0 and "objects with ADE differences: 0," in summary:
        # standard content the Importer/Exporter itself does not round-trip (nested building furniture)
        log.warning("standard content differs, ADE content does not (report: %s)", report)
        code = 0
    elif code != 0:
        log.error("fixture round trip differs (report: %s)", report)
    return code, exported


def validate(config: Config, citygml4j: Path, files: Sequence[Path], out: Path) -> bool:
    """XSD validation against the CityGML 2.0 schemas and the module schemas of the fork."""
    module_schemas = citygml4j / "resources" / "ade-xjc" / "schemas"
    schemas = [config.tools.citygml_schemas / f"{name}.xsd" for name in CITYGML_SCHEMAS]
    schemas += [module_schemas / name for name in ("urbanObject.xsd", *SCHEMA_FILES.values())]
    valid = True
    for f in files:
        args = " ".join(p.as_posix() for p in (f, *schemas))
        output = gradle(ROUNDTRIP, "validate", f"--args={args}", log_file=out / f"validate_{f.stem}.log")
        lines = [line for line in output.splitlines() if "VALID" in line or "ERROR" in line]
        for line in lines[:3]:
            log.info("%s", line)
        valid = valid and any(line.startswith("VALID") for line in lines)
    return valid


def checkout(config: Config, edition: Edition) -> tuple[Path, Path]:
    """Both forks on the branch of the edition."""
    citygml4j = config.workspace.require("citygml4j")
    citydb = config.workspace.require("citydb")
    git(citygml4j, "checkout", "-q", edition.branch)
    git(citydb, "checkout", "-q", edition.branch)
    return citygml4j, citydb


def regen(config: Config, version: str, *, skip_jaxb: bool = False, skip_db: bool = False) -> int:
    edition = config.edition(version)
    out = config.workspace.out
    out.mkdir(parents=True, exist_ok=True)
    log.info("== %s: branch %s", version, edition.branch)
    citygml4j, citydb = checkout(config, edition)
    update_schemas(edition, citygml4j)
    if skip_jaxb:
        log.info("JAXB classes: kept as committed (--skip-jaxb)")
    else:
        generate_jaxb(config, edition, citygml4j, out)
    regenerate_code(config, edition, citygml4j, citydb, out)
    extension = install_extension(config, edition, citydb)
    fixture = write_fixture(edition, citygml4j, citydb)
    if skip_db:
        log.info("== %s done (no database round trip, --skip-db)", version)
        return 0
    code, exported = round_trip(config, edition, extension, fixture, out)
    valid = validate(config, citygml4j, [fixture, exported], out)
    log.info("== %s done", version)
    return 0 if code == 0 and valid else 1
