"""The table model of the citydb generator: the tables of the data and feature types, their hierarchies, parent
columns, usage and the import/export dependencies between them."""

from __future__ import annotations

import os
import re
from collections import OrderedDict
from collections.abc import Iterable, Mapping
from typing import Protocol

from ..errors import GeneratorError
from ..naming import cap, uncap
from ..spec import Field, Hook, MappingInjection, MappingProperty, Module, Spec, Type
from .common import PKG, render_imports, write


class JoinRef(Protocol):
    """A property stored in a join table, as a field of a type or a hook (``HookField``)."""

    @property
    def kind(self) -> str: ...

    @property
    def multi(self) -> bool: ...

    @property
    def is_feature_property(self) -> bool: ...

    @property
    def model_name(self) -> str: ...

    @property
    def nested(self) -> Type: ...

    @property
    def property_type(self) -> Type: ...

    @property
    def mapped(self) -> MappingProperty: ...


class HookField:
    """A hook property (injected into a CityGML feature) seen as a field by the join table helpers."""

    kind = "property"
    is_feature_property = False

    def __init__(self, h: Hook) -> None:
        self.hook = h
        self.mapped = h.mapped
        self.multi = h.multi
        self.model_name = h.element

    @property
    def property_type(self) -> Type:
        return self.hook.property_type

    @property
    def nested(self) -> Type:
        return self.hook.nested


class Table:
    def __init__(self, name: str, spec: Spec, module: Module, feature: bool) -> None:
        self.name = name
        self.enum = name[3:].upper()
        self.columns = spec.ddl_tables[name]
        self.primary: Type | None = None
        self.merged: list[Type] = []
        self.sub_tables: list[Table] = []
        self.parent: Table | None = None
        self.parent_columns: list[str] = []
        """Columns referencing an owner (1:n), from the mapping joins."""
        self.has_objectclass = "objectclass_id" in self.columns
        self.sequence = spec.table_sequence.get(name)
        self.used_single = False
        """Referenced through a 1:1 foreign key."""
        self.used_multi = False
        """Referenced through a parent column."""
        self.feature = feature
        """Table of an ADE feature type hierarchy (rows share the cityobject id)."""
        self.module = module
        """Module of the types stored in the table."""

    @property
    def primary_type(self) -> Type:
        if self.primary is None:
            raise GeneratorError(f"table {self.name} has no primary type")
        return self.primary

    @property
    def row_types(self) -> list[Type]:
        return [self.primary_type, *self.merged]

    @property
    def root(self) -> Table:
        t = self
        while t.parent:
            t = t.parent
        return t

    def all_tables(self) -> list[Table]:
        out = [self]
        for s in self.sub_tables:
            out.extend(s.all_tables())
        return out

    @property
    def hierarchy_parent_columns(self) -> list[str]:
        return [c for t in self.all_tables() for c in t.parent_columns]

    @property
    def concrete(self) -> Type:
        """Parameter type of the importer: the primary type, or its single concrete merged type when the primary is
        abstract."""
        primary = self.primary_type
        if primary.abstract and len(self.merged) == 1 and not self.sub_tables and not self.merged[0].subtypes:
            return self.merged[0]
        return primary

    @property
    def importer(self) -> str:
        return self.concrete.model + "Importer"

    @property
    def exporter(self) -> str:
        return self.concrete.model + "Exporter"

    @property
    def exportable(self) -> bool:
        """A feature table that holds rows of concrete types (abstract-only tables are read through their subtypes)."""
        return any(not rt.abstract for rt in self.row_types)

    @property
    def prefix(self) -> str:
        """Column alias prefix of this table's columns in the select of a subtype exporter (the urf style: "uf")."""
        return "".join(c for c in self.concrete.model if c.isupper()).lower() + "_"

    @property
    def depth(self) -> int:
        return len(self.primary_type.ancestors())

    def __repr__(self) -> str:
        return "Table(%s)" % self.name


class CitydbBase:
    """The state shared by the writers of the citydb generator and the table model."""

    spec: Spec
    repo: str
    cg4j: str
    """The citygml4j fork (the hand-written model classes of the modules that are not generated)."""
    modules: list[Module]
    hooks: list[Hook]
    special: list[Hook]
    features: list[Type]
    types: list[Type]
    type_names: set[str]
    src: str
    header: str
    tables: OrderedDict[str, Table]
    feature_tables: OrderedDict[str, Table]
    polymorphic_roots: set[str]
    injections: OrderedDict[str, tuple[MappingInjection, list[Hook]]]
    class_module: dict[str, str]
    """importer/exporter class -> module prefix (for cross-package imports)."""
    class_modules: dict[str, set[str]]
    """importer/exporter class -> every module prefix it exists in."""
    join_importer_tables: dict[str, str]
    ambiguous_models: set[str]
    """Model class names that exist in several modules: referred to qualified."""
    lazy_imp: set[tuple[str, str]]
    lazy_exp: set[tuple[str, str]]
    current_importer: str | None
    current_exporter: str | None
    extra_imports: set[str]
    """Imports collected while the fields of one class are written."""
    written: set[str]
    table_columns: dict[str, list[str]]
    feature_importers: list[tuple[Module, Type, str]]
    feature_exporters: list[tuple[Module, Type, str]]

    # --------------------------------------------------------------- tables
    def build_tables(self) -> None:
        for t in self.types + self.features:
            mt = t.mapping
            if mt is None:
                raise GeneratorError("no mapping for " + t.name)
            tables = self.feature_tables if t.is_feature else self.tables
            tbl = tables.get(mt.table)
            if tbl is None:
                tbl = tables[mt.table] = Table(mt.table, self.spec, t.module, t.is_feature)
            if t.base is not None and t.base.mapped.table == mt.table:
                tbl.merged.append(t)
            else:
                if tbl.primary is not None:
                    raise GeneratorError(f"{tbl} has two primary types: {tbl.primary} and {t}")
                tbl.primary = t
                if t.base is not None:
                    tbl.parent = tables[t.base.mapped.table]
                    tbl.parent.sub_tables.append(tbl)
        # polymorphic hierarchies: a property type targets a type that has subtypes
        for pt in self.spec.property_types(self.types + self.features):
            if pt.polymorphic and pt.prop_target is not None and not pt.prop_target.is_feature:
                self.polymorphic_roots.add(pt.prop_target.root().qname)
        # parent columns and usage
        for t in self.types + self.features:
            for f in t.fields:
                p = f.column = t.mapped.props.get(f.name)
                if p is None:
                    raise GeneratorError("no mapping property for %s.%s" % (t.name, f.name))
                if p.join_table is not None:
                    if f.kind == "property" and not f.is_feature_property:
                        self.note_usage(f.nested, p)
                    continue  # references through a join table (members, urf:target, data type lists)
                if f.is_feature_property:
                    join = p.require_join()
                    child = self.feature_tables[join.table]
                    if join.to_column not in child.parent_columns:
                        child.parent_columns.append(join.to_column)
                elif f.kind == "property":
                    self.note_usage(f.nested, p)
        for h in self.hooks:
            if not h.nested.is_feature:  # feature hooks (pointCloud) are imported by the Importer/Exporter
                self.note_usage(h.nested, h.mapped)

    def note_usage(self, target: Type, p: MappingProperty) -> None:
        if p.join_table is not None:
            self.tables[target.mapped.table].used_single = True
            return
        join = p.require_join()
        if join.to_role == "parent":
            self.tables[target.mapped.table].used_single = True
        else:
            tbl = self.tables[join.table]
            tbl.used_multi = True
            if join.to_column not in tbl.parent_columns:
                tbl.parent_columns.append(join.to_column)

    def build_injections(self) -> OrderedDict[str, tuple[MappingInjection, list[Hook]]]:
        out: OrderedDict[str, tuple[MappingInjection, list[Hook]]] = OrderedDict()
        for h in self.hooks + self.special:
            inj = h.injected
            out.setdefault(inj.table, (inj, []))[1].append(h)
        return out

    def table_of(self, t: Type) -> Table:
        return (self.feature_tables if t.is_feature else self.tables)[t.mapped.table]

    # ---------------------------------------------------- dependency cycles
    def importer_deps(self, tbl: Table) -> list[str]:
        deps = []
        for rt in tbl.row_types:
            for f in rt.fields:
                if f.kind == "property" and not f.is_feature_property:
                    target = f.nested
                    join = f.mapped.join
                    deps.append(
                        self.table_of(target).root.importer
                        if join is not None and join.to_role == "child"
                        else self.importer_for(target)
                    )
                elif f.kind == "inline":
                    deps.append(self.importer_for(f.nested))
        if self.dispatch_style(tbl):
            deps += [s.importer for s in tbl.sub_tables]
        elif tbl.parent is not None:
            deps.append(tbl.root.importer)
        return deps

    def exporter_deps(self, tbl: Table) -> list[str]:
        deps = []
        tables = tbl.all_tables() if self.dispatch_style(tbl) else [tbl]
        for t in tables:
            for rt in t.row_types:
                for f in rt.fields:
                    if f.kind == "property" and not f.is_feature_property:
                        tt = self.table_of(f.nested)
                        join = f.mapped.join
                        deps.append(
                            tt.root.exporter
                            if join is not None and join.to_role == "child"
                            else (tt.root.exporter if self.dispatch_style(tt) else tt.exporter)
                        )
                    elif f.kind == "inline":
                        deps.append(self.table_of(f.nested).exporter)
        return deps

    @staticmethod
    def cyclic_edges(graph: Mapping[str, Iterable[str]]) -> set[tuple[str, str]]:
        """Edges (u, v) where v can reach u again: these must be resolved lazily."""

        def reaches(a: str, b: str, seen: set[str]) -> bool:
            if a == b:
                return True
            for c in graph.get(a, ()):
                if c not in seen:
                    seen.add(c)
                    if reaches(c, b, seen):
                        return True
            return False

        return {(u, v) for u, vs in graph.items() for v in vs if reaches(v, u, set())}

    def compute_lazy(self) -> None:
        imp_graph, exp_graph = {}, {}
        for tbl in self.tables.values():
            imp_graph[tbl.importer] = self.importer_deps(tbl)
            if not (self.dispatch_style(tbl) and tbl.parent is not None):
                exp_graph[tbl.exporter] = self.exporter_deps(tbl)
        self.lazy_imp = self.cyclic_edges(imp_graph)
        self.lazy_exp = self.cyclic_edges(exp_graph)
        self.current_importer = self.current_exporter = None

    def ref_imp(self, imp: str) -> str:
        return uncap(imp) + ("()" if (self.current_importer, imp) in self.lazy_imp else "")

    def ref_exp(self, exp: str) -> str:
        return uncap(exp) + ("()" if (self.current_exporter, exp) in self.lazy_exp else "")

    @staticmethod
    def lazy_accessor(cls: str, manager_getter: str, exception: str) -> str:
        var = uncap(cls)
        return (
            f"    private {cls} {var}() throws {exception}, SQLException {{\n        if ({var} == null)\n"
            f"            {var} = manager.{manager_getter}({cls}.class);\n\n        return {var};\n    }}\n\n"
        )

    def dispatch_style(self, tbl: Table) -> bool:
        return tbl.root.primary_type.qname in self.polymorphic_roots

    def parent_arg_style(self, tbl: Table) -> str | None:
        """None, 'single' (one parent column, fixed) or 'multi' (parent column passed by name)."""
        cols = tbl.root.hierarchy_parent_columns
        if not cols:
            return None
        # a hierarchy used both through a FK and a parent column needs distinct doExport(long ...) signatures
        both = any(t.used_single for t in tbl.root.all_tables())
        return "single" if len(cols) == 1 and not both else "multi"

    def importer_for(self, target: Type) -> str:
        """Importer class to call for a 1:1 nested or hooked object of the given type."""
        tbl = self.table_of(target)
        if self.dispatch_style(tbl):
            return tbl.root.importer
        return tbl.importer

    def join_name(self, f: JoinRef) -> str:
        """Name of the join table statement of a field: its model name, prefixed with the owner type where the merged
        row types of a table hierarchy have fields of the same name (urt Frequency/StopTime trip -> frequencyTrip, stopTimeTrip)."""
        owner = f.owner if isinstance(f, Field) else None
        if owner is None:
            return f.model_name
        group = [rt for t in self.table_of(owner).root.all_tables() for rt in t.row_types if rt is not owner]
        others = [rt for rt in group if any(x.model_name == f.model_name for x in rt.fields)]
        return uncap(owner.model) + cap(f.model_name) if others else f.model_name

    def join_importer(self, owner: Table | str, f: JoinRef) -> str:
        """Importer of the join table of a reference to city objects (urf:target), to members (urf nested features) or
        to the rows of a multi-valued data type; owner is the owner table or the owner class name (hook tables)."""
        name = owner if isinstance(owner, str) else owner.concrete.model
        target = "CityObject" if f.kind == "cityObjectRef" else f.nested.model
        jt = f.mapped.require_join_table().table
        cls = name + "To" + target + "Importer"
        if cls in self.join_importer_tables and self.join_importer_tables[cls] != jt:
            cls = name + cap(f.model_name) + "To" + target + "Importer"
        self.join_importer_tables[cls] = jt
        return cls

    def register_class(self, name: str, prefix: str) -> None:
        """Record the module package of a generated importer/exporter class (a name may exist in several modules)."""
        self.class_module[name] = prefix
        self.class_modules.setdefault(name, set()).add(prefix)

    def out(self, path: str, text: str) -> None:
        """Write a generated class; importer/exporter classes of other modules get their imports added (a class of the
        own module or one that exists in several other modules is not imported: the code refers to it qualified)."""
        m = re.search(r"\n(package org\.citydb\.ade\.iur\.(importer|exporter)\.(\w+);)", text)
        if m:
            kind, prefix = m.group(2), m.group(3)
            classes = set(re.findall(r"\b(\w+(?:Importer|Exporter))\b", text))
            add = {
                f"{PKG}.{kind}.{self.class_module[c]}.{c}"
                for c in classes
                if c in self.class_modules
                and prefix not in self.class_modules[c]
                and len(self.class_modules[c]) == 1
                and c.endswith(kind.capitalize())
            }
            if add:
                existing = re.findall(r"^import ([\w.*]+);\n", text, re.M)
                all_imports = list(re.finditer(r"^import .*;\n", text, re.M))
                first, last = all_imports[0].start(), all_imports[-1].end()
                text = text[:first] + render_imports(set(existing) | add) + "\n" + text[last:]
        self.written.add(os.path.normcase(path))
        write(path, text)
