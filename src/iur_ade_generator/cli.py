"""Command line entry point: ``iur-ade <command> <arguments...>``.

Every command runs the generator module of the same purpose with the positional arguments the module took as a script
in the PoC workspace (the usage line of each module's docstring). The commands get proper options and a shared
configuration when the modules are split (task 13, sections 3 and 4).
"""

from __future__ import annotations

import runpy
import sys
from collections.abc import Sequence

PACKAGE = "iur_ade_generator"

# command -> (module, arguments, one-line description)
COMMANDS: dict[str, tuple[str, str, str]] = {
    "patch-binding": (
        "patch_binding",
        "<citygml4j repo>",
        "rename the JAXB properties of the feature types, the urf package and the lod-N elements in binding.xjb",
    ),
    "patch-mapping": (
        "patch_mapping",
        "<citydb repo> <citygml4j repo> <version> [modules: uro,urf]",
        "apply the rules 1-7 to the schema mapping and DDL the ADE Manager generated (idempotent)",
    ),
    "gen-mapping": (
        "gen_mapping",
        "<citydb repo> <citygml4j repo> <version> <module prefix> [modules the module depends on: uro]",
        "generate the schema mapping and DDL of a module the ADE Manager cannot transform (urf)",
    ),
    "gen-citygml4j": (
        "gen_citygml4j",
        "<citygml4j repo> <citydb repo> <version> <preset: all|phaseA|phaseB|phaseC> [modules: uro,urf]",
        "generate the model classes, (un)marshallers, walkers and modules of iur-ade-citygml4j",
    ),
    "gen-citydb": (
        "gen_citydb",
        "<citydb repo> <citygml4j repo> <version> <preset: all|phaseA|phaseB|phaseC> [modules: uro,urf]",
        "generate the importers, exporters, join table importers and registrations of iur-ade-citydb",
    ),
    "fixture": (
        "gen_fixture",
        "<citygml4j repo> <citydb repo> <version> <preset> <out.gml> [modules: uro,urf]",
        "write a CityGML file that uses every attribute of the modules",
    ),
    "compare": (
        "compare",
        "<original.gml> <roundtrip.gml> [--ignore-creation-date] [--db] [--subset]",
        "compare the city objects of two CityGML files (exit code 1 on differences)",
    ),
    "changes-features": (
        "update_changes_features",
        "<citygml4j repo> <citydb repo> <citygml4j version> <citydb version> <version>",
        "add the 'ADE feature types' section to both CHANGES.md files (idempotent)",
    ),
    "changes-urf": (
        "update_changes_urf",
        "<citygml4j repo> <citydb repo> <citygml4j version> <citydb version> <version> <feature types> <data types>",
        "add the 'Urban Function module' section to both CHANGES.md files (idempotent)",
    ),
}


def usage() -> str:
    width = max(len(name) for name in COMMANDS)
    lines = ["usage: iur-ade <command> <arguments...>", "", "commands:"]
    for name, (_, arguments, description) in COMMANDS.items():
        lines.append(f"  {name:<{width}}  {description}")
        lines.append(f"  {'':<{width}}  iur-ade {name} {arguments}")
    return "\n".join(lines)


def main(argv: Sequence[str] | None = None) -> int:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args or args[0] in ("-h", "--help"):
        print(usage())
        return 0
    command = COMMANDS.get(args[0])
    if command is None:
        print(f"iur-ade: unknown command {args[0]!r}\n\n{usage()}", file=sys.stderr)
        return 2
    module = command[0]
    # the modules read sys.argv like the scripts they were
    sys.argv = [f"iur-ade {args[0]}", *args[1:]]
    try:
        runpy.run_module(f"{PACKAGE}.{module}", run_name="__main__", alter_sys=True)
    except SystemExit as e:
        code = e.code
        return code if isinstance(code, int) else (0 if code is None else 1)
    return 0


if __name__ == "__main__":
    sys.exit(main())
