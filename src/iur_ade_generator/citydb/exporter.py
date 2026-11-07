"""The exporters of the data type tables (one per hierarchy root or per table) and the feature tables (urf style)."""

from __future__ import annotations

import os
import re
from collections import OrderedDict
from collections.abc import Callable

from ..errors import GeneratorError
from ..naming import cap, uncap, words
from ..spec import Type
from .common import GEOM_IMPORTS, PKG, indent, render_imports, required, wrap
from .join_tables import JoinTableWriter
from .tables import Table


class ExporterWriter(JoinTableWriter):
    def gen_feature_exporter(self, tbl: Table) -> bool:
        """Exporter of one feature table (urf style): addProjection()/doExport(.., prefix, rs) for use by subtype
        exporters, and a statement joining the ancestor tables for the concrete types of the table. Returns False when
        there is nothing to export."""
        self.current_exporter = tbl.exporter
        primary, concrete = tbl.primary_type, tbl.concrete
        if tbl.parent is None and not any(rt.fields for rt in tbl.row_types):
            return False
        var = uncap(primary.model)
        imports = {
            f"{PKG}.exporter.ExportManager",
            f"{PKG}.schema.ADETable",
            "org.citydb.core.ade.exporter.CityGMLExportHelper",
            "org.citydb.core.operation.exporter.CityGMLExportException",
            "org.citydb.sqlbuilder.schema.Table",
            "org.citydb.sqlbuilder.select.Select",
            f"{primary.module.model_pkg}.{primary.model}",
        }
        # projection of the table's own columns
        plain, geoms = [], []
        for rt in tbl.row_types:
            for f in rt.fields:
                p = f.mapped
                if (
                    f.is_feature_property
                    or f.kind == "cityObjectRef"
                    or (f.kind == "property" and (p.join_table is not None or p.require_join().to_role == "child"))
                ):
                    continue
                if f.kind in ("geometry", "complex"):
                    plain.append(required(p.ref_column, "refColumn"))
                    geoms.append(required(p.inline_column, "inlineColumn"))
                elif f.kind in ("point", "multiCurve", "multiPoint"):
                    geoms.append(required(p.inline_column, "inlineColumn"))
                elif f.kind == "multiSurface":
                    plain.append(required(p.ref_column, "refColumn"))
                elif f.kind in ("property", "inline", "address"):
                    plain.append(p.require_join().from_column)
                else:
                    plain.append(p.require_column())
                    if p.qualifier:
                        plain.append(p.qualifier)
        proj = [f'table.getColumn("{c}", prefix + "{c}")' for c in plain] + [
            f'helper.getGeometryColumn(table.getColumn("{c}"), prefix + "{c}")' for c in geoms
        ]
        projection = ("        select.addProjection(" + ",\n                ".join(proj) + ");\n\n") if proj else ""
        # row reader
        child_exporters: OrderedDict[str, bool] = OrderedDict()
        needs: set[str] = set()
        ctx = (child_exporters, needs, imports)
        # nested features first: polygons shared by a nested surface and a solid of the parent are then written
        # inline in the surface and referenced from the solid (the structure of the PLATEAU files)
        read = "".join(
            self.export_field(var, f, lambda c: c)[1] + "\n"
            for f in primary.fields
            if f.is_feature_property and f.mapped.join_table is None
        )
        read += self.export_fields(primary, var, lambda c: c, ctx, features_first=True)
        for m in tbl.merged:
            if not m.fields:
                continue
            mvar = uncap(m.model)
            code = self.export_fields(m, mvar, lambda c: c, ctx)
            read += (
                f"                if ({var} instanceof {m.model}) {{\n                    {m.model} {mvar} = ({m.model}) {var};\n\n"
                + indent(code.rstrip("\n") + "\n", 4)
                + "                }\n\n"
            )
            imports.add(f"{m.module.model_pkg}.{m.model}")
        read = re.sub(r'\brs\.get(\w+)\("(\w+)"\)', r'rs.get\1(prefix + "\2")', read)
        read = indent(read.rstrip("\n") + "\n", -8)
        if geoms:
            needs.add("helper")
        # statements
        ancestors = [self.table_of(a) for a in reversed(primary.ancestors())]  # root first
        fields, inits, stmts = "", "", ""
        for a in ancestors:
            fields += f"    private final {a.exporter} {uncap(a.exporter)};\n"
            inits += f"        {uncap(a.exporter)} = manager.getExporter({a.exporter}.class);\n"
        if tbl.exportable:
            fields += "    private final PreparedStatement ps;\n"
            decls = "        Table table = new Table(helper.getTableNameWithSchema(tableName));\n"
            joins = ""
            for a in ancestors:
                av = uncap(a.concrete.model)
                decls += f"        Table {av} = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.{a.enum})));\n"
                joins += f'\n                .addJoin(JoinFactory.inner({av}, "id", ComparisonName.EQUAL_TO, table.getColumn("id")))'
            if joins:
                imports |= {
                    "org.citydb.sqlbuilder.select.join.JoinFactory",
                    "org.citydb.sqlbuilder.select.operator.comparison.ComparisonName",
                }
            stmts += (
                decls
                + f'        Select select = new Select(){joins}\n                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));\n'
            )
            stmts += '        addProjection(select, table, "");\n'
            for a in ancestors:
                stmts += (
                    f'        {uncap(a.exporter)}.addProjection(select, {uncap(a.concrete.model)}, "{a.prefix}");\n'
                )
            stmts += "        ps = connection.prepareStatement(select.toString());\n"
            imports |= {
                "org.citydb.sqlbuilder.expression.PlaceHolder",
                "org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory",
                "org.citydb.core.database.schema.mapping.AbstractType",
                "org.citydb.core.query.filter.projection.ProjectionFilter",
                f"{concrete.module.model_pkg}.{concrete.model}",
            }
        # nested feature and join table statements
        feature_props = [
            f for rt in tbl.row_types for f in rt.fields if f.is_feature_property and f.mapped.join_table is None
        ]
        ref_props = [
            f
            for rt in tbl.row_types
            for f in rt.fields
            if f.kind == "cityObjectRef" or (f.kind == "property" and f.mapped.join_table is not None)
        ]
        jt_stmts, jt_fields, jt_closes, jt_imports = self.join_table_statements(ref_props)
        if feature_props or ref_props:
            stmts += "\n" if stmts else ""
            if feature_props and "Table cityObject" not in jt_stmts:
                stmts += "        Table cityObject = new Table(helper.getTableNameWithSchema(MappingConstants.CITYOBJECT));\n"
            stmts += jt_stmts
            fields += jt_fields
            imports |= jt_imports
            taken = {"table", "cityObject"} | {uncap(a.concrete.model) for a in ancestors}
            for f in feature_props:
                join = f.mapped.require_join()
                child = self.feature_tables[join.table]
                cv = uncap(child.primary_type.model.replace("Abstract", "", 1))
                name = f.model_name
                if cv in taken:
                    cv = name + "Table"
                stmts += (
                    f"        Table {cv} = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.{child.enum})));\n"
                    f'        Select {name}Select = new Select().addProjection({cv}.getColumn("id"), cityObject.getColumn("objectclass_id"), cityObject.getColumn("gmlid"))\n'
                    f'                .addJoin(JoinFactory.inner(cityObject, "id", ComparisonName.EQUAL_TO, {cv}.getColumn("id")))\n'
                    f'                .addSelection(ComparisonFactory.equalTo({cv}.getColumn("{join.to_column}"), new PlaceHolder<>()))\n'
                    f'                .addOrderBy(new OrderByToken({cv}.getColumn("id")));\n'
                    f"        ps{cap(name)} = connection.prepareStatement({name}Select.toString());\n"
                )
                fields += f"    private final PreparedStatement ps{cap(name)};\n"
            imports |= {
                "org.citydb.core.database.schema.mapping.MappingConstants",
                "org.citydb.sqlbuilder.select.OrderByToken",
                "org.citydb.sqlbuilder.select.join.JoinFactory",
                "org.citydb.sqlbuilder.select.operator.comparison.ComparisonName",
                "org.citydb.sqlbuilder.expression.PlaceHolder",
                "org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory",
            }
        for exp in child_exporters:
            fields += f"    private final {exp} {uncap(exp)};\n"
            inits += f"        {uncap(exp)} = manager.getExporter({exp}.class);\n"
        if "splitter" in needs:
            fields += "    private final AttributeValueSplitter valueSplitter;\n"
            inits += "        valueSplitter = helper.getAttributeValueSplitter();\n"
            imports |= {
                "org.citydb.core.operation.exporter.util.AttributeValueSplitter",
                "org.citydb.core.operation.exporter.util.SplitValue",
            }
        if "geometry" in needs:
            fields += "    private final SurfaceGeometryExporter surfaceGeometryExporter;\n    private final GMLConverter gmlConverter;\n"
            inits += "        surfaceGeometryExporter = helper.getSurfaceGeometryExporter();\n        gmlConverter = helper.getGMLConverter();\n"
            imports |= {
                GEOM_IMPORTS[k] for k in ("GeometryObject", "GMLConverter", "SurfaceGeometryExporter", "GeometrySetter")
            }
        # the hooks of core:_CityObject (uro 3.2 pointCloud): the Importer/Exporter calls them for its own feature types
        # only, so the top-level features rooted directly in core:_CityObject export them themselves
        hooks = ""
        if tbl.exportable and primary.root().core_base == "core:AbstractCityObjectType":
            for table, (inj, _) in self.injections.items():
                if inj.default_base == "AbstractCityObjectType":
                    hooks += (
                        f"\n        manager.exportGenericApplicationProperties(manager.getSchemaMapper().getTableName(ADETable.{table[3:].upper()}), "
                        f"{uncap(concrete.model)}, objectId, (FeatureType) objectType, projectionFilter);\n"
                    )
                    needs.add("manager")
                    imports.add("org.citydb.core.database.schema.mapping.FeatureType")
        helper_field = "    private final CityGMLExportHelper helper;\n" if needs & {"geometry", "helper"} else ""
        helper_init = "        this.helper = helper;\n" if helper_field else ""
        if "manager" in needs:
            helper_field += "    private final ExportManager manager;\n"
            helper_init += "        this.manager = manager;\n"
        table_name = (
            f"        String tableName = manager.getSchemaMapper().getTableName(ADETable.{tbl.enum});\n"
            if tbl.exportable
            else ""
        )
        methods = ""
        if tbl.exportable:
            cvar = uncap(concrete.model)
            chain = "".join(
                f'                {uncap(a.exporter)}.doExport({cvar}, objectId, "{a.prefix}", rs);\n'
                for a in ancestors
            )
            methods += (
                f"    public void doExport({concrete.model} {cvar}, long objectId, AbstractType<?> objectType, ProjectionFilter projectionFilter) throws CityGMLExportException, SQLException {{\n"
                f"        ps.setLong(1, objectId);\n\n        try (ResultSet rs = ps.executeQuery()) {{\n            if (rs.next()) {{\n"
                f'{chain}                doExport({cvar}, objectId, "", rs);\n            }}\n        }}\n{hooks}    }}\n\n'
            )
        methods += (
            f"    public Select addProjection(Select select, Table table, String prefix) {{\n{projection}        return select;\n    }}\n\n"
            f"    public void doExport({primary.model} {var}, long objectId, String prefix, ResultSet rs) throws CityGMLExportException, SQLException {{\n"
            f"{read}    }}\n"
        )
        closes = jt_closes + "".join(f"        ps{cap(f.model_name)}.close();\n" for f in feature_props)
        if tbl.exportable:
            closes = "        ps.close();\n" + closes
        text = f"""{self.header}

package {PKG}.exporter.{tbl.module.prefix};

{render_imports(imports)}

import java.sql.*;

public class {tbl.exporter} implements {tbl.module.exporter_interface} {{
{helper_field}{fields}
    public {tbl.exporter}(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {{
{helper_init}{table_name}{inits}
{stmts}    }}

{methods}
    @Override
    public void close() throws CityGMLExportException, SQLException {{
{closes}    }}
}}
"""
        text = re.sub(r"\n{3,}", "\n\n", text)
        text = text.replace("    }\n\n    @Override", "    }\n\n    @Override").replace("{\n\n    }\n}", "{\n    }\n}")
        self.out(os.path.join(self.src, "exporter", tbl.module.prefix, tbl.exporter + ".java"), text)
        return True

    def gen_exporter(self, tbl: Table) -> None:
        """One exporter per hierarchy root (dispatch style) or per table (otherwise)."""
        self.current_exporter = tbl.exporter
        dispatch = self.dispatch_style(tbl)
        if dispatch and tbl.parent is not None:
            return
        tables = tbl.all_tables() if dispatch else [tbl]
        used_single = any(t.used_single for t in tables)
        used_multi = any(t.used_multi for t in tables)
        concrete = tbl.concrete
        var = uncap(concrete.model)
        imports = {
            f"{PKG}.exporter.ExportManager",
            f"{PKG}.schema.ADETable",
            "org.citydb.core.ade.exporter.CityGMLExportHelper",
            "org.citydb.core.operation.exporter.CityGMLExportException",
            "org.citydb.sqlbuilder.expression.PlaceHolder",
            "org.citydb.sqlbuilder.schema.Table",
            "org.citydb.sqlbuilder.select.Select",
            "org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory",
            f"{concrete.module.model_pkg}.{concrete.model}",
        }
        # column aliases: duplicates across the joined tables get a table prefix
        seen: dict[str, set[str]] = {}
        for t in tables:
            for rt in t.row_types:
                for f in rt.fields:
                    p = f.mapped
                    join_col = (
                        p.join.from_column
                        if f.kind in ("property", "inline", "address")
                        and p.join is not None
                        and p.join.to_role == "parent"
                        else None
                    )
                    for c in (p.column, p.qualifier, p.ref_column, p.inline_column, join_col):
                        if c:
                            seen.setdefault(c, set()).add(t.name)
        if dispatch:
            for t in tables:
                seen.setdefault("id", set()).add(t.name)
        aliases: dict[tuple[str, str], str] = {}

        def alias_for(t: Table) -> Callable[[str], str]:
            def alias(c: str) -> str:
                if c and len(seen.get(c, ())) > 1 and t is not tbl:
                    a = "%s_%s" % (t.concrete.model.lower(), c)
                    aliases[(t.name, c)] = a
                    return a
                return c

            return alias

        # projections
        table_vars = {tbl.name: "table"}
        for t in tables[1:]:
            table_vars[t.name] = uncap(t.concrete.model)
        geom_lines: list[str] = []
        proj_by_table: OrderedDict[str, list[str]] = OrderedDict()
        alias_proj: list[str] = []
        child_exporters: OrderedDict[str, bool] = OrderedDict()
        needs: set[str] = set()
        for t in tables:
            tv = table_vars[t.name]
            proj_by_table[tv] = []
            cols = []
            if t is tbl and dispatch:
                cols.append("id")
                if tbl.has_objectclass:
                    cols.append("objectclass_id")
            elif dispatch and not tbl.has_objectclass:
                cols.append("id")
            plain: list[str] = []
            geoms: list[tuple[str, bool]] = []
            for rt in t.row_types:
                for f in rt.fields:
                    p = f.mapped
                    if f.kind in ("geometry", "complex"):
                        geoms += [
                            (required(p.ref_column, "refColumn"), False),
                            (required(p.inline_column, "inlineColumn"), True),
                        ]
                    elif f.kind in ("point", "multiCurve", "multiPoint"):
                        geoms.append((required(p.inline_column, "inlineColumn"), True))
                    elif f.kind == "multiSurface":
                        plain.append(required(p.ref_column, "refColumn"))
                    elif f.kind == "cityObjectRef" or (
                        f.kind == "property" and (p.join_table is not None or p.require_join().to_role == "child")
                    ):
                        continue
                    elif f.kind in ("property", "inline", "address"):
                        plain.append(p.require_join().from_column)
                    else:
                        plain.append(p.require_column())
                        if p.qualifier:
                            plain.append(p.qualifier)
            al = alias_for(t)
            for c in cols + plain:
                a = al(c)
                if a != c:
                    alias_proj.append(f'{tv}.getColumn("{c}", "{a}")')
                else:
                    proj_by_table[tv].append(c)
            for c, is_geom in geoms:
                a = al(c)
                if is_geom:
                    geom_lines.append(
                        f'helper.getGeometryColumn({tv}.getColumn("{c}"), "{a}")'
                        if a != c
                        else f'helper.getGeometryColumn({tv}.getColumn("{c}"))'
                    )
                elif a != c:
                    alias_proj.append(f'{tv}.getColumn("{c}", "{a}")')
                else:
                    proj_by_table[tv].append(c)
        proj_lines = proj_by_table["table"]
        if not proj_lines and not alias_proj and not geom_lines:
            proj_lines = ["id"]  # a table whose content is all in join tables: the statement needs a projection
        ctx = (child_exporters, needs, imports)

        def read_type(rt: Type, v: str) -> str:
            return self.export_fields(rt, v, alias_for(self.table_of(rt)), ctx)

        if dispatch:
            read = ""
            # instantiate
            if tbl.has_objectclass:
                read += (
                    f'                int objectClassId = rs.getInt("objectclass_id");\n                if (rs.wasNull())\n                    return null;\n\n'
                    f"                {concrete.model} {var} = objectMapper.createType(objectClassId, {concrete.model}.class);\n"
                    f'                if ({var} == null) {{\n                    helper.logOrThrowErrorMessage("Failed to instantiate {words(concrete.model)} (id: " + objectId + ").");\n'
                    f"                    return null;\n                }}\n\n"
                )
                imports.add(f"{PKG}.schema.ObjectMapper")
            else:
                conds = []
                for t in reversed(tables[1:]):
                    a = aliases.get((t.name, "id"), "id")
                    conds.append(f'rs.getLong("{a}") != 0 ? new {t.primary_type.model}()')
                read += (
                    f"                {concrete.model} {var} = " + " : ".join(conds) + f" : new {concrete.model}();\n\n"
                )
            for t in tables:
                for rt in t.row_types:
                    if not rt.fields:
                        continue
                    code = read_type(rt, uncap(rt.model) if rt is not concrete else var)
                    if not code.strip():
                        continue
                    if rt is concrete:
                        read += code
                    else:
                        v = uncap(rt.model)
                        read += (
                            f"                if ({var} instanceof {rt.model}) {{\n                    {rt.model} {v} = ({rt.model}) {var};\n\n"
                            + indent(code.rstrip("\n") + "\n", 4)
                            + "                }\n\n"
                        )
                        imports.add(f"{rt.module.model_pkg}.{rt.model}")
            read = read.rstrip("\n") + "\n"
        else:
            read = ""
            for rt in tbl.row_types:
                if rt is concrete:
                    read += read_type(rt, var)
                elif rt.fields:
                    v = uncap(rt.model)
                    code = read_type(rt, v)
                    read += (
                        f"                if ({var} instanceof {rt.model}) {{\n                    {rt.model} {v} = ({rt.model}) {var};\n\n"
                        + indent(code.rstrip("\n") + "\n", 4)
                        + "                }\n\n"
                    )
                    imports.add(f"{rt.module.model_pkg}.{rt.model}")
            read = read.rstrip("\n") + "\n"
            # base tables with fields (attribute style) are joined
            for base_table in [self.table_of(x) for x in tbl.primary_type.ancestors()]:
                if any(rt.fields for rt in base_table.row_types):
                    raise GeneratorError("attribute-style base table with fields: " + base_table.name)

        # statements
        parent_style = self.parent_arg_style(tbl)
        joins = ""
        for t in tables[1:]:
            tv = table_vars[t.name]
            joins += f'                .addJoin(JoinFactory.left({tv}, "id", ComparisonName.EQUAL_TO, table.getColumn("id")))\n'
        if joins:
            imports |= {
                "org.citydb.sqlbuilder.select.join.JoinFactory",
                "org.citydb.sqlbuilder.select.operator.comparison.ComparisonName",
            }
        table_decls = "        Table table = new Table(helper.getTableNameWithSchema(tableName));\n"
        for t in tables[1:]:
            table_decls += f"        Table {table_vars[t.name]} = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.{t.enum})));\n"
        projection = "\n                        ".join(wrap(proj_lines, quote=True))
        extra_proj = ""
        for tv, cols in proj_by_table.items():
            if tv != "table" and cols:
                extra_proj += (
                    f"\n                .addProjection({tv}.getColumns("
                    + "\n                        ".join(wrap(cols, quote=True))
                    + "))"
                )
        extra_proj += "".join(f"\n                .addProjection({a})" for a in alias_proj)
        geom_proj = "".join(f"\n                .addProjection({g})" for g in geom_lines)
        select_base = f"        Select select = new Select().addProjection(table.getColumns({projection})){extra_proj}{geom_proj}\n{joins}"
        stmts, fields, inits = "", "", ""
        methods = ""
        jt_props = [
            f
            for t in tables
            for rt in t.row_types
            for f in rt.fields
            if f.kind == "property" and f.mapped.join_table is not None
        ]
        jt_stmts, jt_fields, jt_closes, jt_imports = self.join_table_statements(jt_props)
        stmts += jt_stmts
        fields += jt_fields
        imports |= jt_imports
        use_single = used_single or (not used_multi)
        parent_cols = tbl.hierarchy_parent_columns
        if use_single:
            stmts += (
                select_base
                + '                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));\n        ps = connection.prepareStatement(select.toString());\n'
            )
            fields += "    private final PreparedStatement ps;\n"
        if used_multi:
            imports.add("org.citydb.sqlbuilder.select.OrderByToken")
            if parent_style == "multi":
                fields += "    private final Map<String, PreparedStatement> psByParent = new HashMap<>();\n"
                imports |= {"java.util.HashMap", "java.util.Map"}
                col_table = {}
                for t in tables:
                    for c in t.parent_columns:
                        col_table[c] = table_vars[t.name]
                stmts += "\n" if use_single else ""
                stmts += (
                    "        for (String parentColumn : Arrays.asList("
                    + ", ".join('"%s"' % c for c in parent_cols)
                    + ")) {\n"
                )
                stmts += indent(select_base.replace("Select select", "Select parentSelect"), 4)
                by_table: dict[str, list[str]] = {}
                for c in parent_cols:
                    by_table.setdefault(col_table[c], []).append(c)
                if len(by_table) == 1:
                    tv = next(iter(by_table))
                    stmts += f"                    .addSelection(ComparisonFactory.equalTo({tv}.getColumn(parentColumn), new PlaceHolder<>()))\n"
                else:
                    stmts = stmts.rstrip("\n") + "\n"
                    parts, items = [], list(by_table.items())
                    for idx, (tv, cols) in enumerate(items):
                        if idx == len(items) - 1:
                            parts.append("%s.getColumn(parentColumn)" % tv)
                        else:
                            test = " || ".join('"%s".equals(parentColumn)' % c for c in cols)
                            parts.append("%s ? %s.getColumn(parentColumn)" % (test, tv))
                    cond = " : ".join(parts)
                    stmts += (
                        f"                    .addSelection(ComparisonFactory.equalTo({cond}, new PlaceHolder<>()))\n"
                    )
                stmts += '                    .addOrderBy(new OrderByToken(table.getColumn("id")));\n            psByParent.put(parentColumn, connection.prepareStatement(parentSelect.toString()));\n        }\n'
                imports.add("java.util.Arrays")
            else:
                c = parent_cols[0]
                tv = next(table_vars[t.name] for t in tables if c in t.parent_columns)
                stmts += "\n" if use_single else ""
                stmts += select_base.replace("Select select", "Select parentSelect") if use_single else select_base
                sel = "parentSelect" if use_single else "select"
                stmts += f'                .addSelection(ComparisonFactory.equalTo({tv}.getColumn("{c}"), new PlaceHolder<>()))\n                .addOrderBy(new OrderByToken(table.getColumn("id")));\n        psByParent = connection.prepareStatement({sel}.toString());\n'
                fields += "    private final PreparedStatement psByParent;\n"
        # methods
        reader_name = "doExport"
        reader = ""
        if dispatch:
            reader = (
                f"    private {concrete.model} {reader_name}(long objectId, ResultSet rs) throws CityGMLExportException, SQLException {{\n"
                + indent(read, -8)
                + f"        return {var};\n    }}\n"
            )
            reader = reader.replace("\n" * 3, "\n\n")
            if use_single:
                methods += (
                    f"    public {concrete.model} doExport(long objectId) throws CityGMLExportException, SQLException {{\n        ps.setLong(1, objectId);\n\n"
                    f"        try (ResultSet rs = ps.executeQuery()) {{\n            return rs.next() ? {reader_name}(objectId, rs) : null;\n        }}\n    }}\n\n"
                )
            if used_multi:
                sig = "long parentId, String parentColumn" if parent_style == "multi" else "long parentId"
                psv = "psByParent.get(parentColumn)" if parent_style == "multi" else "psByParent"
                methods += (
                    f"    public List<{concrete.model}> doExport({sig}) throws CityGMLExportException, SQLException {{\n"
                    f"        PreparedStatement ps = {psv};\n        ps.setLong(1, parentId);\n\n        List<{concrete.model}> result = new ArrayList<>();\n"
                    f'        try (ResultSet rs = ps.executeQuery()) {{\n            while (rs.next()) {{\n                {concrete.model} {var} = {reader_name}(rs.getLong("id"), rs);\n'
                    f"                if ({var} != null)\n                    result.add({var});\n            }}\n        }}\n\n        return result;\n    }}\n\n"
                )
                imports |= {"java.util.ArrayList", "java.util.List"}
            methods += reader
        else:
            if use_single and used_multi:
                reader = (
                    f"    private void doExport({concrete.model} {var}, long objectId, ResultSet rs) throws CityGMLExportException, SQLException {{\n"
                    + indent(read, -8)
                    + "    }\n"
                )
                methods += (
                    f"    public void doExport({concrete.model} {var}, long objectId) throws CityGMLExportException, SQLException {{\n        ps.setLong(1, objectId);\n\n"
                    f"        try (ResultSet rs = ps.executeQuery()) {{\n            if (rs.next())\n                doExport({var}, objectId, rs);\n        }}\n    }}\n\n"
                )
            elif use_single:
                methods += (
                    f"    public void doExport({concrete.model} {var}, long objectId) throws CityGMLExportException, SQLException {{\n        ps.setLong(1, objectId);\n\n"
                    f"        try (ResultSet rs = ps.executeQuery()) {{\n            if (rs.next()) {{\n{read}            }}\n        }}\n    }}\n"
                )
            if used_multi:
                sig = "long parentId, String parentColumn" if parent_style == "multi" else "long parentId"
                psv = "psByParent.get(parentColumn)" if parent_style == "multi" else "psByParent"
                inner = f"                doExport({var}, objectId, rs);\n" if use_single else read
                id_line = '                long objectId = rs.getLong("id");\n' if use_single else ""
                methods += (
                    f"    public List<{concrete.model}> doExport({sig}) throws CityGMLExportException, SQLException {{\n"
                    f"        PreparedStatement ps = {psv};\n        ps.setLong(1, parentId);\n\n        List<{concrete.model}> result = new ArrayList<>();\n"
                    f"        try (ResultSet rs = ps.executeQuery()) {{\n            while (rs.next()) {{\n                {concrete.model} {var} = new {concrete.model}();\n{id_line}{inner}\n                result.add({var});\n            }}\n        }}\n\n        return result;\n    }}\n\n"
                )
                imports |= {"java.util.ArrayList", "java.util.List"}
                if use_single:
                    methods += reader
        if used_multi and not dispatch and (use_single or "objectId" in read):
            # the row id is needed by the 1:n reader (nested children, or the row reader shared with the 1:1 statement)
            old = "table.getColumns(" + projection + ")"
            new = "table.getColumns(" + "\n                        ".join(wrap(["id", *proj_lines], quote=True)) + ")"
            stmts = stmts.replace(old, new)
            if not use_single:
                methods = methods.replace(
                    f"                {concrete.model} {var} = new {concrete.model}();\n",
                    f'                {concrete.model} {var} = new {concrete.model}();\n                long objectId = rs.getLong("id");\n',
                )
        lazy_methods = ""
        for exp in child_exporters:
            if (tbl.exporter, exp) in self.lazy_exp:
                fields += f"    private {exp} {uncap(exp)};\n"
                lazy_methods += self.lazy_accessor(exp, "getExporter", "CityGMLExportException")
            else:
                fields += f"    private final {exp} {uncap(exp)};\n"
                inits += f"        {uncap(exp)} = manager.getExporter({exp}.class);\n"
        if lazy_methods:
            fields = "    private final ExportManager manager;\n" + fields
            inits = "        this.manager = manager;\n" + inits
        if "splitter" in needs:
            fields += "    private final AttributeValueSplitter valueSplitter;\n"
            inits += "        valueSplitter = helper.getAttributeValueSplitter();\n"
            imports |= {
                "org.citydb.core.operation.exporter.util.AttributeValueSplitter",
                "org.citydb.core.operation.exporter.util.SplitValue",
            }
        if "geometry" in needs:
            fields += "    private final SurfaceGeometryExporter surfaceGeometryExporter;\n    private final GMLConverter gmlConverter;\n"
            inits += "        surfaceGeometryExporter = helper.getSurfaceGeometryExporter();\n        gmlConverter = helper.getGMLConverter();\n"
            imports |= {
                GEOM_IMPORTS[k] for k in ("GeometryObject", "GMLConverter", "SurfaceGeometryExporter", "GeometrySetter")
            }
        helper_field = (
            "    private final CityGMLExportHelper helper;\n"
            if (dispatch and tbl.has_objectclass) or needs & {"geometry", "helper"}
            else ""
        )
        helper_init = "        this.helper = helper;\n" if helper_field else ""
        om_field = "    private final ObjectMapper objectMapper;\n" if dispatch and tbl.has_objectclass else ""
        om_init = "        this.objectMapper = manager.getObjectMapper();\n" if om_field else ""
        close_ps = "        ps.close();" if use_single else ""
        if used_multi and parent_style == "multi":
            close_parent = "        for (PreparedStatement ps : psByParent.values())\n            ps.close();"
        elif used_multi:
            close_parent = "        psByParent.close();"
        else:
            close_parent = ""
        text = f"""{self.header}

package {PKG}.exporter.{tbl.module.prefix};

{render_imports(imports)}

import java.sql.*;

public class {tbl.exporter} implements {tbl.module.exporter_interface} {{
{helper_field}{om_field}{fields}
    public {tbl.exporter}(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {{
{helper_init}{om_init}        String tableName = manager.getSchemaMapper().getTableName(ADETable.{tbl.enum});

{table_decls}{stmts}
{inits}    }}

{methods}
{lazy_methods}    @Override
    public void close() throws CityGMLExportException, SQLException {{
{close_ps}
{close_parent}{jt_closes}
    }}
}}
"""
        text = re.sub(r"\n{3,}", "\n\n", text)
        text = text.replace("    }\n\n    @Override", "    }\n\n    @Override")
        text = (
            text.replace("{\n\n        ps.close();", "{\n        ps.close();")
            .replace("{\n\n        psByParent", "{\n        psByParent")
            .replace("{\n\n        for (PreparedStatement", "{\n        for (PreparedStatement")
        )
        text = (
            text.replace("        ps.close();\n\n    }", "        ps.close();\n    }")
            .replace("            ps.close();\n\n    }", "            ps.close();\n    }")
            .replace("        psByParent.close();\n\n    }", "        psByParent.close();\n    }")
        )
        self.out(os.path.join(self.src, "exporter", tbl.module.prefix, tbl.exporter + ".java"), text)
