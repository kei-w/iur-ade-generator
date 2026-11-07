"""Command line entry point: ``iur-ade <command> ...``.

The generator commands take the positional arguments of the modules (their docstrings); ``regen``, ``verify`` and
``recreate-db`` read the configuration (``iur-ade.toml``, see ``config``).
"""

from __future__ import annotations

import argparse
import logging
import sys
from collections.abc import Callable, Sequence
from pathlib import Path

from . import binding, compare, config, fixture, gen_citydb, update_changes_features, update_changes_urf
from .citygml4j import generator as citygml4j_generator
from .errors import GeneratorError
from .mapping import generate as mapping_generate
from .mapping import patch as mapping_patch

log = logging.getLogger(__name__)

# command -> (function taking the arguments, usage, description)
GENERATORS: dict[str, tuple[Callable[[list[str]], int | None], str, str]] = {
    "patch-binding": (
        binding.main,
        "<citygml4j repo>",
        "rename the JAXB properties of the feature types, the urf package and the lod-N elements in binding.xjb",
    ),
    "patch-mapping": (
        mapping_patch.main,
        "<citydb repo> <citygml4j repo> <version> [modules: uro,urf]",
        "apply the rules 1-7 to the schema mapping and DDL the ADE Manager generated (idempotent)",
    ),
    "gen-mapping": (
        mapping_generate.main,
        "<citydb repo> <citygml4j repo> <version> <module prefix> [modules the module depends on: uro]",
        "generate the schema mapping and DDL of a module the ADE Manager cannot transform (urf)",
    ),
    "gen-citygml4j": (
        citygml4j_generator.main,
        "<citygml4j repo> <citydb repo> <version> <preset: all|phaseA|phaseB|phaseC> [modules: uro,urf]",
        "generate the model classes, (un)marshallers, walkers and modules of iur-ade-citygml4j",
    ),
    "gen-citydb": (
        gen_citydb.main,
        "<citydb repo> <citygml4j repo> <version> <preset: all|phaseA|phaseB|phaseC> [modules: uro,urf]",
        "generate the importers, exporters, join table importers and registrations of iur-ade-citydb",
    ),
    "fixture": (
        fixture.main,
        "<citygml4j repo> <citydb repo> <version> <preset> <out.gml> [modules: uro,urf]",
        "write a CityGML file that uses every attribute of the modules",
    ),
    "compare": (
        compare.main,
        "<original.gml> <roundtrip.gml> [--ignore-creation-date] [--db] [--subset]",
        "compare the city objects of two CityGML files (exit code 1 on differences)",
    ),
    "changes-features": (
        update_changes_features.main,
        "<citygml4j repo> <citydb repo> <citygml4j version> <citydb version> <version>",
        "add the 'ADE feature types' section to both CHANGES.md files (idempotent)",
    ),
    "changes-urf": (
        update_changes_urf.main,
        "<citygml4j repo> <citydb repo> <citygml4j version> <citydb version> <version> <feature types> <data types>",
        "add the 'Urban Function module' section to both CHANGES.md files (idempotent)",
    ),
}


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="iur-ade",
        description="Code generators and verification harness of the i-UR ADE forks.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--config",
        type=Path,
        metavar="FILE",
        help=f"configuration file (default: {config.CONFIG_FILE} in the repository root)",
    )
    parser.add_argument("-v", "--verbose", action="store_true", help="log the commands that are run")
    commands = parser.add_subparsers(dest="command", metavar="<command>", required=True)

    regen = commands.add_parser(
        "regen",
        help="regenerate one edition end to end and round-trip its fixture",
        description="Regenerate one edition (urf schema, JAXB classes, schema mapping, code, "
        "builds, extension folder, fixture, verification database, round trip, "
        "XSD validation).",
    )
    regen.add_argument("version", help="i-UR version: " + ", ".join(config.EDITIONS))
    regen.add_argument("--skip-jaxb", action="store_true", help="keep the committed JAXB classes (no ade-xjc run)")
    regen.add_argument("--skip-db", action="store_true", help="stop after the fixture (no database round trip)")

    verify = commands.add_parser(
        "verify",
        help="round-trip CityGML files through citygml4j or the database",
        description="Round-trip the given files (folders recursively) through citygml4j "
        "with the ADE module, or with --db through a fresh verification "
        "database, and compare each file with the result.",
    )
    verify.add_argument("version", help="i-UR version of the files: " + ", ".join(config.EDITIONS))
    verify.add_argument("paths", nargs="+", type=Path, help="CityGML files or folders")
    verify.add_argument("--db", action="store_true", help="database round trip (needs the extension folder)")
    verify.add_argument("--database", metavar="NAME", help="database to recreate (default: the edition's)")
    verify.add_argument("--out", type=Path, metavar="DIR", help="output folder (default: out/verify<version>)")

    recreate = commands.add_parser(
        "recreate-db",
        help="recreate a verification database with the extension",
        description="Drop and recreate the verification database of the edition and register its extension folder.",
    )
    recreate.add_argument("version", help="i-UR version: " + ", ".join(config.EDITIONS))
    recreate.add_argument("--database", metavar="NAME", help="database name (default: the edition's)")

    for name, (_, usage, description) in GENERATORS.items():
        generator = commands.add_parser(
            name, help=description, description=f"{description}.", usage=f"iur-ade {name} {usage}"
        )
        generator.add_argument("args", nargs=argparse.REMAINDER, help=usage)
    return parser


def run_command(args: argparse.Namespace) -> int:
    if args.command in GENERATORS:
        function = GENERATORS[args.command][0]
        return function(list(args.args)) or 0
    cfg = config.load(args.config)
    if args.command == "regen":
        from . import regen

        return regen.regen(cfg, args.version, skip_jaxb=args.skip_jaxb, skip_db=args.skip_db)
    if args.command == "verify":
        from . import verify

        out = args.out or cfg.workspace.out / f"verify{args.version.replace('.', '')}"
        if args.db:
            return 1 if verify.verify_db(cfg, args.version, args.paths, out, args.database) else 0
        return 1 if verify.verify_files(cfg, args.version, args.paths, out) else 0
    if args.command == "recreate-db":
        from . import database, regen

        edition = cfg.edition(args.version)
        database.recreate(cfg, args.database or edition.database, regen.extension_dir(cfg, edition), cfg.workspace.out)
        return 0
    raise GeneratorError(f"unknown command {args.command!r}")


def main(argv: Sequence[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    logging.basicConfig(level=logging.DEBUG if args.verbose else logging.INFO, format="%(message)s", stream=sys.stdout)
    try:
        return run_command(args)
    except GeneratorError as e:
        print(f"iur-ade: {e}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
