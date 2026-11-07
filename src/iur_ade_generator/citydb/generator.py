"""Generate the importers, exporters and schema registrations of iur-ade-citydb from the ADE Manager mapping.

Usage: iur-ade gen-citydb <citydb repo> <citygml4j repo> <version> <preset: all|phaseA|phaseB|phaseC> [modules: uro,urf]
"""

from __future__ import annotations

import logging
import os
import sys
from collections import OrderedDict
from collections.abc import Sequence

from ..citygml4j.common import SPECIAL_HOOKS
from ..citygml4j.generator import load_spec, select_hooks
from ..spec import Hook, Spec
from .balloon import BalloonWriter
from .common import AMBIGUOUS, hook_class, read
from .importer import ImporterWriter
from .tables import HookField

log = logging.getLogger(__name__)


class Generator(BalloonWriter, ImporterWriter):
    """The citydb code of the modules of a specification."""

    def __init__(self, spec: Spec, repo: str, hooks: Sequence[Hook], features: bool = True) -> None:
        self.spec = spec
        self.repo = repo
        first_xsd = next(iter(spec.modules.values())).xsd_path
        self.cg4j = os.path.dirname(first_xsd.split(os.sep + "resources" + os.sep)[0] + os.sep)
        self.modules = list(spec.modules.values())
        self.hooks = [h for h in hooks if h.prop_type is not None]
        self.special = [h for h in hooks if h.prop_type is None and h.element in SPECIAL_HOOKS]
        self.features = spec.feature_types() if features else []
        self.types = spec.closure(self.hooks, self.features)
        self.type_names = {t.qname for t in self.types}
        self.src = os.path.join(repo, "src", "main", "java", "org", "citydb", "ade", "iur")
        header_src = read(os.path.join(self.src, "importer", "urt", "FeedInfoImporter.java"))
        self.header = header_src[: header_src.index("*/") + 2]
        self.tables = OrderedDict()
        self.feature_tables = OrderedDict()
        self.polymorphic_roots = set()
        self.extra_imports = set()
        self.written = set()
        self.table_columns = {}
        self.feature_importers = []
        self.feature_exporters = []
        self.build_tables()
        self.injections = self.build_injections()
        self.compute_lazy()
        self.class_module = {}
        self.class_modules = {}
        self.join_importer_tables = {}
        for tbl in list(self.tables.values()) + list(self.feature_tables.values()):
            self.register_class(tbl.importer, tbl.module.prefix)
            self.register_class(tbl.exporter, tbl.module.prefix)
        by_name: dict[str, set[str]] = {}
        for t in self.types + self.features:
            by_name.setdefault(t.model, set()).add(t.module.prefix)
        for prefix in ("urf", "urg", "urt"):
            d = self.model_dir(prefix)
            if prefix not in spec.modules and os.path.isdir(d):
                for fn in os.listdir(d):
                    by_name.setdefault(fn[:-5], set()).add(prefix)
        self.ambiguous_models = {n for n, mods in by_name.items() if len(mods) > 1} | AMBIGUOUS

    def clean_stale(self) -> None:
        """Remove importer and exporter files of the generated modules that were not written in this run."""
        for sub in ("importer", "exporter"):
            for m in self.modules:
                d = os.path.join(self.src, sub, m.prefix)
                for fn in os.listdir(d):
                    path = os.path.join(d, fn)
                    if (
                        fn.endswith(".java")
                        and not fn.endswith("Module%s.java" % sub.capitalize())
                        and os.path.normcase(path) not in self.written
                    ):
                        os.remove(path)
                        log.debug("removed stale %s %s", sub, fn)

    def run(self) -> str:
        """Generates everything; returns a summary line."""
        importers: list[str] = []
        exporters: list[str] = []
        join_importers: list[tuple[str, str]] = []
        for tbl in self.tables.values():
            self.table_columns[tbl.name] = self.gen_importer(tbl)
            importers.append(tbl.importer)
            for rt in tbl.row_types:
                for f in rt.fields:
                    if f.kind == "property" and f.mapped.join_table is not None:
                        jt = f.mapped.join_table.table
                        name = self.gen_join_importer(tbl, f, tbl.module)
                        importers.append(name)
                        join_importers.append((jt, name))
                        self.table_columns[jt] = list(self.spec.ddl_tables[jt])
            if self.dispatch_style(tbl) and tbl.parent is not None:
                continue
            if not self.dispatch_style(tbl) and not any(rt.fields for rt in tbl.row_types):
                continue  # attribute-style base table without columns of its own
            self.gen_exporter(tbl)
            exporters.append(tbl.exporter)
        # feature types: one importer per table, exporters for the tables with something to read (most specific first
        # in dispatch)
        for tbl in sorted(self.feature_tables.values(), key=lambda x: -x.depth):
            self.table_columns[tbl.name] = self.gen_feature_importer(tbl)
            importers.append(tbl.importer)
            for rt in tbl.row_types:
                for f in rt.fields:
                    if f.kind == "cityObjectRef" or (f.kind == "property" and f.mapped.join_table is not None):
                        jt = f.mapped.require_join_table().table
                        name = self.gen_join_importer(tbl, f, tbl.module)
                        importers.append(name)
                        join_importers.append((jt, name))
                        self.table_columns[jt] = list(self.spec.ddl_tables[jt])
            if tbl.exportable:
                self.feature_importers.append((tbl.module, tbl.concrete, tbl.importer))
            if self.gen_feature_exporter(tbl):
                exporters.append(tbl.exporter)
                if tbl.exportable:
                    self.feature_exporters.append((tbl.module, tbl.concrete, tbl.exporter))
        hook_importers: list[tuple[str, str]] = []
        hook_exporters: list[tuple[str, str]] = []
        for table, (inj, hooks) in self.injections.items():
            name, cols = self.gen_hook_importer(inj, hooks)
            self.table_columns[table] = cols
            hook_importers.append((table, name))
            for h in hooks:
                if h.mapping is not None and h.mapping.join_table is not None:
                    jt = h.mapping.join_table.table
                    jname = self.gen_join_importer(hook_class(inj.default_base), HookField(h), h.module)
                    importers.append(jname)
                    join_importers.append((jt, jname))
                    self.table_columns[jt] = list(self.spec.ddl_tables[jt])
            name, _ = self.gen_hook_exporter(inj, hooks)
            hook_exporters.append((table, name))
        for m in self.modules:
            if m.prefix != "uro":
                self.gen_balloon_handler(m)
        self.clean_stale()
        self.patch_ade_table(hook_importers + join_importers)
        self.patch_ade_sequence()
        self.patch_table_mapper()
        self.patch_object_mapper()
        self.patch_import_manager(importers, hook_importers)
        self.patch_export_manager(exporters, hook_exporters)
        self.fix_date_list_columns()
        self.patch_module_constants()
        return "tables: %d injections: %d" % (len(self.tables), len(self.injections))


def generate(repo: str, cg4j: str, version: str, preset: str, prefixes: Sequence[str] = ("uro",)) -> str:
    """Generates the citydb code of the edition; returns a summary line."""
    spec = load_spec(cg4j, repo, version, prefixes)
    return Generator(spec, repo, select_hooks(spec, preset)).run()


def main(argv: list[str] | None = None) -> None:
    argv = sys.argv[1:] if argv is None else list(argv)
    repo, cg4j, version, preset = argv[0:4]
    prefixes = argv[4].split(",") if len(argv) > 4 else ["uro"]
    log.info("%s", generate(repo, cg4j, version, preset, prefixes))
