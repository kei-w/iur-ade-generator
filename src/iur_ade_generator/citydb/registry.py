"""The registrations of the generated classes in the hand-written schema and manager classes of the citydb fork."""

from __future__ import annotations

import logging
import os
import re
from collections import OrderedDict
from collections.abc import Iterable, Sequence

from ..errors import GeneratorError
from ..naming import words
from ..spec import Module, Type
from .common import BASE_TARGETS, MODULE_PREFIXES, PKG, hook_class, read, ref, simple, write, write_raw
from .hooks import HookWriter

log = logging.getLogger(__name__)

SPECIAL_HOOK_CLASSES = {"fiscalYearOfPublication": "FiscalYearOfPublicationProperty", "language": "LanguageProperty"}
# the citydb resources whose date columns of multi-valued fields become strings: (file, column type, string type)
DATE_LIST_COLUMNS = [
    ("resources/database/3dcitydb/postgreSQL/CREATE_ADE_DB.sql", "TIMESTAMP WITH TIME ZONE", "VARCHAR(1000)"),
    ("resources/database/3dcitydb/postgreSQL/CREATE_ADE_DB.sql", "DATE", "VARCHAR(1000)"),
    ("resources/database/3dcitydb/oracle/CREATE_ADE_DB.sql", "TIMESTAMP", "VARCHAR2(1000)"),
    ("resources/database/3dcitydb/oracle/CREATE_ADE_DB.sql", "DATE", "VARCHAR2(1000)"),
]


class RegistryWriter(HookWriter):
    def model_dir(self, prefix: str) -> str:
        """The hand-written model classes of a module in the citygml4j fork."""
        return os.path.join(self.cg4j, "src", "main", "java", "org", "citygml4j", "ade", "iur", "model", prefix)

    def model_ref(self, t: Type) -> str:
        """Reference to a model class from the managers (which import every module package): qualified when
        ambiguous."""
        return f"{t.module.model_pkg}.{t.model}" if t.model in self.ambiguous_models else t.model

    @property
    def ambiguous_classes(self) -> set[str]:
        """Importer/exporter class names that exist in more than one module package."""
        out = set()
        for n in self.class_module:
            kind = "importer" if n.endswith("Importer") else "exporter"
            if sum(1 for d in MODULE_PREFIXES if os.path.exists(os.path.join(self.src, kind, d, n + ".java"))) > 1:
                out.add(n)
        return out

    def hand_written_model(self, cls: str) -> str | None:
        """The hand-written module (not generated in this run) whose model package holds the class, if any."""
        for d in ("urf", "urg", "urt", "uro"):
            if d not in self.spec.modules and os.path.exists(os.path.join(self.model_dir(d), cls + ".java")):
                return d
        return None

    def _importer_exists(self, entry: str) -> str | None:
        """Whether the importer class of a hand-written ADETable entry still exists (outside the generated modules)."""
        name = entry.replace(".class", "").split(".")[-1]
        for d in ("urf", "urg", "urt", "uro"):
            if d not in self.spec.modules and os.path.exists(os.path.join(self.src, "importer", d, name + ".java")):
                return d
        return None

    # ---------------------------------------------------------------- schema
    def hook_module(self, table: str, importer: str) -> str:
        """Module of the importer of an injection table (the hook importers of all modules share their class name,
        CityObjectGroupPropertiesImporter) or of a join table."""
        if table in self.injections:
            return self.injections[table][1][0].module.prefix
        return self.class_module[importer]

    def patch_ade_table(self, hook_importers: Sequence[tuple[str, str]]) -> None:
        p = os.path.join(self.src, "schema", "ADETable.java")
        s = read(p)
        entries = dict(re.findall(r"^    ([A-Z_0-9]+)\((.*)\)[,;]\n", s, re.M))
        new = {}
        by_table = {
            tbl.name: (tbl.importer, tbl.module.prefix)
            for tbl in list(self.tables.values()) + list(self.feature_tables.values())
        }
        by_table.update({t: (n, self.hook_module(t, n)) for t, n in hook_importers})
        ambiguous = {
            n
            for n in self.class_module
            if sum(1 for d in MODULE_PREFIXES if os.path.exists(os.path.join(self.src, "importer", d, n + ".java"))) > 1
        }
        for table in self.spec.ddl_tables:
            k = table[3:].upper()
            if table in by_table:
                n, prefix = by_table[table]
                new[k] = (f"{PKG}.importer.{prefix}.{n}" if n in ambiguous else n) + ".class"
            elif k in entries and entries[k] != "null" and self._importer_exists(entries[k]):
                n = entries[k].replace(".class", "").split(".")[-1]
                new[k] = (f"{PKG}.importer.{self._importer_exists(entries[k])}.{n}" if n in ambiguous else n) + ".class"
            else:
                new[k] = "null"
        names = sorted(new)
        block = "".join("    %s(%s)%s\n" % (n, new[n], "," if i < len(names) - 1 else ";") for i, n in enumerate(names))
        a = s.index("public enum ADETable {\n") + len("public enum ADETable {\n")
        b = s.index("\n    private final Class<? extends ADEImporter> importerClass;")
        write(p, s[:a] + block + s[b:])

    def patch_ade_sequence(self) -> None:
        p = os.path.join(self.src, "schema", "ADESequence.java")
        s = read(p)
        seqs = sorted(q[3:].upper() for q in self.spec.sequences)
        block = "".join("    %s%s\n" % (q, "," if i < len(seqs) - 1 else "") for i, q in enumerate(seqs))
        a = s.index("public enum ADESequence {\n") + len("public enum ADESequence {\n")
        b = s.index("}", a)
        write(p, s[:a] + block + s[b:])

    def patch_table_mapper(self) -> None:
        p = os.path.join(self.src, "schema", "ADETableMapper.java")
        s = read(p)
        pat = re.compile(
            r"            put\(schemaMapper\.getTableName\(ADETable\.([A-Z_0-9]+)\)\.toUpperCase\(\), new LinkedHashSet<String>\(\) \{\{\n((?:                add\(\"[A-Z_0-9]+\"\);\n)+)            \}\}\);\n"
        )
        blocks = OrderedDict(
            (m.group(1), m.group(0)) for m in pat.finditer(s) if "ur_" + m.group(1).lower() in self.spec.ddl_tables
        )
        for table in self.table_columns:
            k = table[3:].upper()
            cols = self.spec.ddl_tables[table]
            blocks[k] = (
                "            put(schemaMapper.getTableName(ADETable.%s).toUpperCase(), new LinkedHashSet<String>() {{\n"
                % k
                + "".join('                add("%s");\n' % c.upper() for c in cols)
                + "            }});\n"
            )
        matches = list(pat.finditer(s))
        if not matches:
            raise GeneratorError(f"no table blocks found in {p}")
        first, last = matches[0].start(), matches[-1].end()
        write(p, s[:first] + "".join(blocks[k] for k in sorted(blocks)) + s[last:])

    def patch_object_mapper(self) -> None:
        p = os.path.join(self.src, "schema", "ObjectMapper.java")
        s = read(p)
        # feature types (object class ids)
        a = s.index("        for (AbstractObjectType<?> type : schemaMapping.getAbstractObjectTypes()) {")
        b = s.index("            switch (type.getPath()) {", a) + len("            switch (type.getPath()) {\n")
        c = s.index("            }\n        }\n", b)
        body = s[b:c]
        simple_case = re.compile(
            r'                case "(\w+)":\n                    objectClassIds\.put\(([\w.]+)\.class, objectClassId\);\n                    break;\n'
        )
        concrete = [t for t in self.features if not t.abstract]
        paths = {t.mapped.path for t in concrete}
        # cases of the generated paths and of the model classes of the generated modules are rewritten
        guarded = re.compile(
            r'                case "(\w+)":\n((?:                    if .*\n                        objectClassIds\.put\(([\w.]+)\.class, objectClassId\);\n|                    else if .*\n                        objectClassIds\.put\(([\w.]+)\.class, objectClassId\);\n)+)                    break;\n'
        )
        others: dict[str, list[tuple[str, str]]] = {}
        """path -> [(module class constant, class)] of hand-written cases that share a path with a generated one."""
        for m in list(guarded.finditer(body))[::-1]:
            if m.group(1) in paths:
                kept = [
                    (mm.group(1), mm.group(2))
                    for mm in re.finditer(
                        r"matchesNamespaceURI\((\w+\.v\d_\d)\.getNamespaceURI\(\)\)\)\n\s*objectClassIds\.put\(([\w.]+)\.class",
                        m.group(2),
                    )
                    if not any(mm.group(1).startswith(x.module_class + ".") for x in self.modules)
                ]
                others[m.group(1)] = kept
                body = body[: m.start()] + body[m.end() :]
        for m in list(simple_case.finditer(body))[::-1]:
            cls = m.group(2).split(".")[-1]
            if m.group(1) in paths or not self.hand_written_model(cls):
                body = body[: m.start()] + body[m.end() :]
        body = body.rstrip("\n") + "\n"
        for path in sorted(paths):
            mine = [t for t in concrete if t.mapped.path == path]
            branches = [
                (f"{t.module.module_class}.{t.module.version_const}", self.model_ref(t)) for t in mine
            ] + others.get(path, [])
            if len(branches) == 1:
                body += f'                case "{path}":\n                    objectClassIds.put({branches[0][1]}.class, objectClassId);\n                    break;\n'
            else:
                body += f'                case "{path}":\n'
                for i, (const, cls) in enumerate(branches):
                    body += (
                        f"                    {'if' if i == 0 else 'else if'} (type.getSchema().matchesNamespaceURI({const}.getNamespaceURI()))\n"
                        f"                        objectClassIds.put({cls}.class, objectClassId);\n"
                    )
                body += "                    break;\n"
        s = s[:b] + body + s[c:]
        s = self._patch_imports(s, {f"org.citygml4j.ade.iur.model.module.{m.module_class}" for m in self.modules})
        # data types (type class ids)
        a = s.index("        for (ComplexType type : schemaMapping.getComplexTypes()) {")
        b = s.index("            switch (type.getPath()) {", a) + len("            switch (type.getPath()) {\n")
        c = s.index("            }\n        }\n    }", b)
        body = s[b:c]
        cases = re.findall(
            r'                case "(\w+)":\n                    typeClassIds\.put\((\w+)\.class, typeClassId\);\n                    break;\n',
            body,
        )
        gen_paths = {t.mapped.path for t in self.types}
        kept = [
            (path, cls)
            for path, cls in cases
            if path not in gen_paths
            and not any(os.path.exists(os.path.join(self.model_dir(x.prefix), cls + ".java")) for x in self.modules)
        ]
        # a path shared by two modules (urf and urg 2.0 NumberOfHouseholds) is told apart by the schema namespace
        by_path: dict[str, list[tuple[str | None, str]]] = {}
        for path, cls in kept:
            by_path.setdefault(path, []).append((None, cls))
        for t in self.types:
            by_path.setdefault(t.mapped.path, []).append(
                (f"{t.module.module_class}.{t.module.version_const}", self.model_ref(t))
            )
        block = ""
        for path, alternatives in by_path.items():
            block += f'                case "{path}":\n'
            if len(alternatives) == 1:
                block += f"                    typeClassIds.put({alternatives[0][1]}.class, typeClassId);\n"
            else:
                for i, (module_const, model) in enumerate(alternatives):
                    if module_const is None:
                        raise GeneratorError(f"data type path {path} is shared with a hand-written module")
                    block += (
                        f"                    {'if' if i == 0 else 'else if'} (type.getSchema().matchesNamespaceURI({module_const}.getNamespaceURI()))\n"
                        f"                        typeClassIds.put({model}.class, typeClassId);\n"
                    )
            block += "                    break;\n"
        write(p, s[:b] + block + s[c:])

    # -------------------------------------------------------------- managers
    def patch_object_dispatch(self, s: str, method: str, entries: Sequence[tuple[Module, Type, str]], call: str) -> str:
        """Rewrite importObject()/exportObject(): one branch per module (hand-written modules keep their branch), each
        an if-else chain by model class (most specific first)."""
        a = s.index(f"    public void {method}(")
        start = s.index("{\n", a) + 2
        end = s.index("\n    }\n", a)
        body = s[start:end]
        pat = re.compile(
            r"(?:        if| else if) \((\w+Module)\.(v\d_\d)\.getModelPackageName\(\)\.equals\(object\.getClass\(\)\.getPackage\(\)\.getName\(\)\)\) \{\n(.*?)\n        \}",
            re.S,
        )
        blocks = OrderedDict((m.group(1), (m.group(2), m.group(3))) for m in pat.finditer(body))
        ambiguous = self.ambiguous_classes
        for mod in self.modules:
            lines = []
            for i, (_, t, cls) in enumerate(e for e in entries if e[0] is mod):
                q = f"{PKG}.{method[:6]}er.{mod.prefix}.{cls}" if cls in ambiguous else cls
                lines.append(
                    f"            {'if' if i == 0 else 'else if'} (object instanceof {self.model_ref(t)})\n"
                    f"                {call.format(cls=q, model=self.model_ref(t))}\n"
                )
            if lines:
                blocks[mod.module_class] = (mod.version_const, "".join(lines).rstrip("\n"))
            else:
                blocks.pop(mod.module_class, None)
        out = ""
        for i, (cls, (ver, text)) in enumerate(blocks.items()):
            out += (
                ("        if" if i == 0 else " else if")
                + f" ({cls}.{ver}.getModelPackageName().equals(object.getClass().getPackage().getName())) {{\n{text}\n        }}"
            )
        return s[:start] + out + s[end:]

    def patch_import_manager(self, importers: Sequence[str], hook_importers: Sequence[tuple[str, str]]) -> None:
        p = os.path.join(self.src, "importer", "ImportManager.java")
        s = read(p)
        # ADE feature types
        s = self.patch_object_dispatch(
            s,
            "importObject",
            self.feature_importers,
            "getImporter({cls}.class).doImport(({model}) object, objectId, objectType, foreignKeys);",
        )
        s = self._patch_imports(
            s,
            {f"org.citygml4j.ade.iur.model.module.{m.module_class}" for m, _, _ in self.feature_importers}
            | {
                f"{t.module.model_pkg}.{t.model}"
                for _, t, _ in self.feature_importers
                if t.model not in self.ambiguous_models
            },
        )
        s = self._hand_written_imports(s, "importer")
        # generic application properties
        a = s.index("    public void importGenericApplicationProperties(")
        b = s.index("    @Override\n    public void executeBatch(")
        lines = [
            "    public void importGenericApplicationProperties(ADEPropertyCollection properties, AbstractFeature parent, long parentId, FeatureType parentType) throws CityGMLImportException, SQLException {\n"
        ]
        imports: set[str] = set()
        for _, (inj, hooks) in self.injections.items():
            name = hook_class(inj.default_base) + "PropertiesImporter"
            cond, classes = self.hook_dispatch(inj, hooks)
            param_cls, _ = self.hook_parent(inj, hooks)
            imports |= set(classes) | {param_cls}
            kw = "if"  # independent checks: a Road also carries the TransportationComplex hook table
            if BASE_TARGETS[inj.default_base] == "CityObjectGroup":
                group_injections = [
                    (i, h) for i, h in self.injections.values() if BASE_TARGETS[i.default_base] == "CityObjectGroup"
                ]
                if inj is not group_injections[0][0]:
                    continue  # one block for every injection of the city object groups
                block = f"        {kw} (parent instanceof CityObjectGroup) {{\n"
                for group_inj, group_hooks in group_injections:
                    importer = f"{PKG}.importer.{group_hooks[0].module.prefix}.{hook_class(group_inj.default_base)}PropertiesImporter"
                    classes_of = ",\n                    ".join(
                        "%s.%s.class"
                        % (
                            h.module.model_pkg,
                            SPECIAL_HOOK_CLASSES[h.element] if h.prop_type is None else h.model_element,
                        )
                        for h in group_hooks
                    )
                    block += (
                        f"            if (properties.containsOneOf({classes_of})) {{\n"
                        f"                getImporter({importer}.class).doImport(properties, (CityObjectGroup) parent, parentId, parentType);\n"
                        "            }\n"
                    )
                lines.append(block + "        }\n")
            elif inj.default_base == "AbstractCityObjectType":
                classes_of = ", ".join(
                    "%s.%s.class" % (h.module.model_pkg, h.model_element) for h in hooks if h.prop_type is not None
                )
                lines.append(
                    f"        {kw} ({cond} && properties.containsOneOf({classes_of}))\n            getImporter({name}.class).doImport(properties, ({ref(param_cls)}) parent, parentId, parentType);\n"
                )
            else:
                lines.append(
                    f"        {kw} ({cond})\n            getImporter({name}.class).doImport(properties, ({ref(param_cls)}) parent, parentId, parentType);\n"
                )
        lines.append("    }\n\n")
        s = s[:a] + "".join(lines) + s[b:]
        s = self.patch_factories(s, "importer", [n for _, n in hook_importers] + list(importers))
        s = self._patch_imports(s, imports)
        write(p, s)

    def patch_factories(self, s: str, kind: str, names: Iterable[str]) -> str:
        """Rewrite the getImporter()/getExporter() factory section of every generated module."""
        ambiguous = self.ambiguous_classes
        for mod in self.modules:
            marker = "                // %s module\n" % words(mod.java_name)
            a = s.index(marker) + len(marker)
            b = min(x for x in (s.find("\n            } else if (", a), s.find("\n            }\n", a)) if x >= 0) + 1
            fact = ""
            for i, n in enumerate(x for x in dict.fromkeys(names) if mod.prefix in self.class_modules.get(x, ())):
                q = f"{PKG}.{kind}.{mod.prefix}.{n}" if n in ambiguous else n
                fact += f"                {'if' if i == 0 else 'else if'} (type == {q}.class)\n                    {kind} = new {q}(connection, helper, this);\n"
            s = s[:a] + fact + s[b:]
        return s

    def patch_export_manager(self, exporters: Sequence[str], hook_exporters: Sequence[tuple[str, str]]) -> None:
        p = os.path.join(self.src, "exporter", "ExportManager.java")
        s = read(p)
        s = self.patch_object_dispatch(
            s,
            "exportObject",
            self.feature_exporters,
            "getExporter({cls}.class).doExport(({model}) object, objectId, objectType, projectionFilter);",
        )
        s = self._patch_imports(
            s,
            {f"org.citygml4j.ade.iur.model.module.{m.module_class}" for m, _, _ in self.feature_exporters}
            | {
                f"{t.module.model_pkg}.{t.model}"
                for _, t, _ in self.feature_exporters
                if t.model not in self.ambiguous_models
            },
        )
        s = self._hand_written_imports(s, "exporter")
        a = s.index("    public void exportGenericApplicationProperties(")
        b = s.index("    @Override\n    public void close()")
        lines = [
            "    public void exportGenericApplicationProperties(String adeHookTable, AbstractFeature parent, long parentId, FeatureType parentType, ProjectionFilter projectionFilter) throws CityGMLExportException, SQLException {\n"
        ]
        imports: set[str] = set()
        for table, (inj, hooks) in self.injections.items():
            name = hook_class(inj.default_base) + "PropertiesExporter"
            cond, classes = self.hook_dispatch(inj, hooks)
            param_cls, _ = self.hook_parent(inj, hooks)
            imports |= set(classes) | {param_cls}
            kw = "if"
            enum = table[3:].upper()
            if BASE_TARGETS[inj.default_base] == "CityObjectGroup":
                group_injections = [
                    (t, i, h)
                    for t, (i, h) in self.injections.items()
                    if BASE_TARGETS[i.default_base] == "CityObjectGroup"
                ]
                if inj is not group_injections[0][1]:
                    continue  # one block for every injection of the city object groups
                block = f"        {kw} (parent instanceof CityObjectGroup) {{\n"
                for i, (group_table, group_inj, group_hooks) in enumerate(group_injections):
                    exporter = f"{PKG}.exporter.{group_hooks[0].module.prefix}.{hook_class(group_inj.default_base)}PropertiesExporter"
                    block += (
                        f"            {'if' if i == 0 else 'else if'} (adeHookTable.equals(schemaMapper.getTableName(ADETable.{group_table[3:].upper()})))\n"
                        f"                getExporter({exporter}.class).doExport((CityObjectGroup) parent, parentId, parentType, projectionFilter);\n"
                    )
                lines.append(block + "        }\n")
            else:
                c = f"({cond})" if " || " in cond else cond
                lines.append(
                    f"        {kw} (adeHookTable.equals(schemaMapper.getTableName(ADETable.{enum})) && {c})\n"
                    f"            getExporter({name}.class).doExport(({ref(param_cls)}) parent, parentId, parentType, projectionFilter);\n"
                )
        lines.append("    }\n\n")
        s = s[:a] + "".join(lines) + s[b:]
        s = self.patch_factories(s, "exporter", [n for _, n in hook_exporters] + list(exporters))
        s = self._patch_imports(s, imports)
        write(p, s)

    def patch_module_constants(self) -> None:
        """Hand-written classes refer to the module constants of the generated versions (urg/urt exporters name the
        urban function module)."""
        for sub in ("importer", "exporter", "schema", "balloon", ""):
            d = os.path.join(self.src, sub)
            for root, _, files in os.walk(d):
                for fn in files:
                    path = os.path.join(root, fn)
                    if not fn.endswith(".java") or os.path.normcase(path) in self.written:
                        continue
                    text = read(path)
                    new = text
                    for m in self.modules:
                        new = re.sub(r"\b%s\.v\d_\d\b" % m.module_class, f"{m.module_class}.{m.version_const}", new)
                    if new != text:
                        write(path, new)

    def _hand_written_imports(self, s: str, kind: str) -> str:
        """Explicit imports of the hand-written modules' classes whose simple names a generated module also uses
        (urg LandPrice vs urf 3.x LandPrice): the hand-written branches keep their simple names."""
        found: dict[str, list[str]] = {}
        ambiguous = self.ambiguous_classes
        for d in ("urf", "urg", "urt", "uro"):
            if d in self.spec.modules:
                continue
            kind_dir = os.path.join(self.src, kind, d)
            for n in ambiguous:
                if os.path.exists(os.path.join(kind_dir, n + ".java")):
                    found.setdefault(n, []).append(f"{PKG}.{kind}.{d}.{n}")
            for n in self.ambiguous_models:
                if os.path.exists(os.path.join(self.model_dir(d), n + ".java")):
                    found.setdefault(n, []).append(f"org.citygml4j.ade.iur.model.{d}.{n}")
        add = {v[0] for v in found.values() if len(v) == 1}
        for v in found.values():  # a name of several hand-written modules cannot be imported by its simple name
            if len(v) > 1:
                for c in v:
                    s = s.replace("import %s;\n" % c, "")
        existing = set(re.findall(r"^import ([\w.]+);", s, re.M))
        added = sorted(c for c in add if c not in existing)
        if not added:
            return s
        last = list(re.finditer(r"^import org\.citygml4j\.[\w.]+;\n", s, re.M))[-1]
        return s[: last.end()] + "".join("import %s;\n" % c for c in added) + s[last.end() :]

    def _patch_imports(self, s: str, classes: Iterable[str]) -> str:
        # imports of classes of the generated modules that no longer exist (renamed in a previous run) are dropped
        for m in re.finditer(
            r"^import (org\.citygml4j\.ade\.iur\.model|org\.citydb\.ade\.iur\.(?:importer|exporter))\.(\w+)\.(\w+);\n",
            s,
            re.M,
        ):
            pkg, prefix, cls = m.groups()
            if prefix not in self.spec.modules:
                continue
            if pkg.startswith("org.citygml4j"):
                path = os.path.join(self.model_dir(prefix), cls + ".java")
            else:
                path = os.path.join(self.src, pkg.split(".")[-1], prefix, cls + ".java")
            if not os.path.exists(path):
                s = s.replace(m.group(0), "")
        existing = set(re.findall(r"^import ([\w.]+);", s, re.M))
        add = sorted(c for c in classes if c not in existing and simple(c) not in self.ambiguous_models)
        if not add:
            return s
        # insert after the last org.citygml4j import
        last = list(re.finditer(r"^import org\.citygml4j\.[\w.]+;\n", s, re.M))[-1]
        return s[: last.end()] + "".join("import %s;\n" % c for c in add) + s[last.end() :]

    def fix_date_list_columns(self) -> None:
        """Multi-valued date fields are stored as joined strings: adjust DDL and mapping column types."""
        changes = [
            f.mapped.require_column()
            for t in self.types
            for f in t.fields
            if f.multi and f.kind in ("date", "year", "yearMonth")
        ]
        if not changes:
            return
        for rel, old, new in DATE_LIST_COLUMNS:
            p = os.path.join(self.repo, rel)
            s = read(p)
            for c in changes:
                s = re.sub(r"^(    %s) %s,$" % (c, re.escape(old)), r"\1 %s," % new, s, flags=re.M)
            write_raw(p, s)
        p = os.path.join(self.repo, "resources/database/schema-mapping/schema-mapping.xml")
        s = read(p)
        for c in changes:
            s = re.sub(r'column="%s" type="(timestamp|date)"' % c, 'column="%s" type="string"' % c, s)
        write_raw(p, s)
        log.info("schema columns changed to strings: %s", changes)
