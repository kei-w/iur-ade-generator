"""The importers and exporters of the hook tables (generic application properties injected into CityGML features)."""

from __future__ import annotations

import os
import re
from collections import OrderedDict
from collections.abc import Sequence

from ..naming import cap, uncap
from ..spec import Hook, MappingInjection
from .common import BASE_TARGETS, HOOK_TARGETS, PKG, SUBCLASS_OF, hook_class, ref, render_imports, wrap
from .exporter import ExporterWriter
from .tables import HookField


class HookWriter(ExporterWriter):
    @staticmethod
    def hook_parent(inj: MappingInjection, hooks: Sequence[Hook]) -> tuple[str, list[str]]:
        """(param class FQN, dispatch classes) for the injection."""
        base = BASE_TARGETS[inj.default_base]
        targets = OrderedDict((h.target, True) for h in hooks)
        tops: OrderedDict[str, bool] = OrderedDict()
        for tgt in targets:
            tops[SUBCLASS_OF.get(tgt, tgt)] = True
        if list(tops) == [base]:
            return HOOK_TARGETS[base][0], [HOOK_TARGETS[base][0]]
        return "org.citygml4j.model.citygml.core.AbstractCityObject", [HOOK_TARGETS[t][0] for t in tops]

    def hook_dispatch(self, inj: MappingInjection, hooks: Sequence[Hook]) -> tuple[str, list[str]]:
        _, classes = self.hook_parent(inj, hooks)
        return " || ".join("parent instanceof %s" % ref(c) for c in classes), classes

    def gen_hook_importer(self, inj: MappingInjection, hooks: Sequence[Hook]) -> tuple[str, list[str]]:
        name = hook_class(inj.default_base) + "PropertiesImporter"
        mod = hooks[0].module
        self.register_class(name, mod.prefix)
        parent_cls, _ = self.hook_parent(inj, hooks)
        imports = {
            f"{PKG}.importer.ImportManager",
            f"{PKG}.schema.ADETable",
            f"{PKG}.schema.SchemaMapper",
            "org.citydb.core.ade.importer.ADEPropertyCollection",
            "org.citydb.core.ade.importer.CityGMLImportHelper",
            "org.citydb.core.database.schema.mapping.FeatureType",
            "org.citydb.core.operation.importer.CityGMLImportException",
            f"{mod.model_pkg}.*",
            parent_cls,
        }
        columns, body, post, i = ["id"], "        ps.setLong(1, parentId);\n\n", "", 2
        importers: OrderedDict[str, bool] = OrderedDict()
        for h in hooks:
            if h.prop_type is None:
                if h.element == "fiscalYearOfPublication":
                    columns.append("fiscalyearofpublication")
                    body += (
                        "        FiscalYearOfPublicationProperty fiscalYearOfPublication = properties.getFirst(FiscalYearOfPublicationProperty.class);\n"
                        "        if (fiscalYearOfPublication != null && fiscalYearOfPublication.isSetValue())\n"
                        f"            ps.setDate({i}, Date.valueOf(LocalDate.of(fiscalYearOfPublication.getValue().getValue(), 1, 1)));\n        else\n            ps.setNull({i}, Types.DATE);\n\n"
                    )
                    i += 1
                    imports.add("java.time.LocalDate")
                else:
                    columns += ["language", "language_codespace"]
                    body += (
                        "        LanguageProperty language = properties.getFirst(LanguageProperty.class);\n        if (language != null && language.isSetValue()) {\n"
                        f"            ps.setString({i}, language.getValue().getValue());\n            ps.setString({i + 1}, language.getValue().getCodeSpace());\n"
                        f"        }} else {{\n            ps.setNull({i}, Types.VARCHAR);\n            ps.setNull({i + 1}, Types.VARCHAR);\n        }}\n\n"
                    )
                    i += 2
                continue
            target = h.nested
            mapping = h.mapped
            el = h.model_element
            v = h.element if h.element[0].islower() else uncap(h.element)
            if mapping.join_table is not None:
                imp = self.importer_for(target)
                jt_imp = self.join_importer(hook_class(inj.default_base), HookField(h))
                importers[imp] = True
                importers[jt_imp] = True
                post += (
                    f"        if (properties.contains({el}.class)) {{\n            for ({el} property : properties.getAll({el}.class)) {{\n"
                    f"                if (property.isSetValue() && property.getValue().isSetObject()) {{\n"
                    f"                    long {v}Id = {self.ref_imp(imp)}.doImport(property.getValue().getObject());\n"
                    f"                    {uncap(jt_imp)}.doImport({v}Id, parentId);\n                }}\n            }}\n        }}\n\n"
                )
                continue
            join = mapping.require_join()
            if join.to_role == "parent" and target.is_feature:
                # a feature (uro 3.2 pointCloud): imported by the Importer/Exporter, referenced by its id or by xlink
                col = join.from_column
                columns.append(col)
                body += (
                    f"        long {v}Id = 0;\n        if (properties.contains({el}.class)) {{\n            {el} property = properties.getFirst({el}.class);\n"
                    f"            if (property.isSetValue()) {{\n                {target.model} {v} = property.getValue().getObject();\n"
                    f"                if ({v} != null) {{\n                    {v}Id = helper.importObject({v});\n                    property.getValue().unsetObject();\n"
                    f"                }} else {{\n                    String href = property.getValue().getHref();\n                    if (href != null && !href.isEmpty())\n"
                    f'                        helper.propagateObjectXlink(schemaMapper.getTableName(ADETable.{inj.table[3:].upper()}), parentId, href, "{col}");\n'
                    f"                }}\n            }}\n        }}\n\n        if ({v}Id != 0)\n            ps.setLong({i}, {v}Id);\n        else\n            ps.setNull({i}, Types.NULL);\n\n"
                )
                i += 1
            elif join.to_role == "parent":
                imp = self.importer_for(target)
                importers[imp] = True
                col = join.from_column
                columns.append(col)
                body += (
                    f"        long {v}Id = 0;\n        if (properties.contains({el}.class)) {{\n            {el} property = properties.getFirst({el}.class);\n"
                    f"            if (property.isSetValue() && property.getValue().isSetObject()) {{\n                {v}Id = {self.ref_imp(imp)}.doImport(property.getValue().getObject());\n"
                    f"                property.setValue(null);\n            }}\n        }}\n\n        if ({v}Id != 0)\n            ps.setLong({i}, {v}Id);\n        else\n            ps.setNull({i}, Types.NULL);\n\n"
                )
                i += 1
            else:
                child = self.tables[join.table].root
                importers[child.importer] = True
                args = "parentId"
                if self.parent_arg_style(child) == "multi":
                    args += ', "%s"' % join.to_column
                post += (
                    f"        if (properties.contains({el}.class)) {{\n            for ({el} property : properties.getAll({el}.class)) {{\n"
                    f"                if (property.isSetValue() && property.getValue().isSetObject())\n                    {self.ref_imp(child.importer)}.doImport(property.getValue().getObject(), {args});\n"
                    f"            }}\n        }}\n\n"
                )
        fields = "".join(f"    private final {imp} {uncap(imp)};\n" for imp in importers)
        inits = "".join(f"        {uncap(imp)} = manager.getImporter({imp}.class);\n" for imp in importers)
        sql_cols = '" +\n                "'.join(wrap(columns))
        text = f"""{self.header}

package {PKG}.importer.{mod.prefix};

{render_imports(imports)}

import java.sql.*;

public class {name} implements {mod.importer_interface} {{
    private final CityGMLImportHelper helper;
    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;

{fields}
    private int batchCounter;

    public {name}(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {{
        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();

        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.{inj.table[3:].upper()})) + " " +
                "({sql_cols}) " +
                "values ({", ".join("?" * len(columns))})");

{inits}    }}

    public void doImport(ADEPropertyCollection properties, {ref(parent_cls)} parent, long parentId, FeatureType parentType) throws CityGMLImportException, SQLException {{
{body}        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(schemaMapper.getTableName(ADETable.{inj.table[3:].upper()}));

{post}    }}

    @Override
    public void executeBatch() throws CityGMLImportException, SQLException {{
        if (batchCounter > 0) {{
            ps.executeBatch();
            batchCounter = 0;
        }}
    }}

    @Override
    public void close() throws CityGMLImportException, SQLException {{
        ps.close();
    }}
}}
"""
        text = text.replace("\n\n    }\n\n    @Override", "\n    }\n\n    @Override")
        text = text.replace('                "values (?)");\n\n    }', '                "values (?)");\n    }')
        self.out(os.path.join(self.src, "importer", mod.prefix, name + ".java"), text)
        return name, columns

    def gen_hook_exporter(self, inj: MappingInjection, hooks: Sequence[Hook]) -> tuple[str, list[str]]:
        name = hook_class(inj.default_base) + "PropertiesExporter"
        mod = hooks[0].module
        self.register_class(name, mod.prefix)
        parent_cls, _ = self.hook_parent(inj, hooks)
        imports = {
            f"{PKG}.exporter.ExportManager",
            f"{PKG}.schema.ADETable",
            "org.citydb.core.ade.exporter.CityGMLExportHelper",
            "org.citydb.core.database.schema.mapping.FeatureType",
            "org.citydb.core.operation.exporter.CityGMLExportException",
            "org.citydb.core.query.filter.projection.ProjectionFilter",
            "org.citydb.sqlbuilder.expression.PlaceHolder",
            "org.citydb.sqlbuilder.schema.Table",
            "org.citydb.sqlbuilder.select.Select",
            "org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory",
            f"org.citygml4j.ade.iur.model.module.{mod.module_class}",
            f"{mod.model_pkg}.*",
            parent_cls,
        }
        columns: list[str] = []
        body = ""
        exporters: OrderedDict[str, bool] = OrderedDict()
        jt_hooks: list[HookField] = []
        feature_hooks: list[tuple[str, str]] = []
        for h in hooks:
            if h.prop_type is None:
                if h.element == "fiscalYearOfPublication":
                    columns.append("fiscalyearofpublication")
                    body += (
                        '                Date fiscalYearOfPublication = rs.getDate("fiscalyearofpublication");\n'
                        '                if (!rs.wasNull() && projectionFilter.containsProperty("fiscalYearOfPublication", module))\n'
                        f"                    parent.{HOOK_TARGETS[h.target][1]}(new FiscalYearOfPublicationProperty(Year.of(fiscalYearOfPublication.toLocalDate().getYear())));\n\n"
                    )
                    imports.add("java.time.Year")
                else:
                    columns += ["language", "language_codespace"]
                    body += (
                        '                String language = rs.getString("language");\n                if (!rs.wasNull() && projectionFilter.containsProperty("language", module)) {\n'
                        '                    Code code = new Code(language);\n                    code.setCodeSpace(rs.getString("language_codespace"));\n'
                        f"                    parent.{HOOK_TARGETS[h.target][1]}(new LanguageProperty(code));\n                }}\n\n"
                    )
                    imports.add("org.citygml4j.model.gml.basicTypes.Code")
                continue
            target = h.nested
            tbl = self.table_of(target)
            mapping = h.mapped
            el = h.model_element
            prop = h.property_type.model
            cls, adder = HOOK_TARGETS[h.target]
            if cls != parent_cls:
                imports.add(cls)
                add = f"(({ref(cls)}) parent).{adder}"
                guard = f"parent instanceof {ref(cls)} && "
            else:
                add = f"parent.{adder}"
                guard = ""
            v = h.element if h.element[0].islower() else uncap(h.element)
            if mapping.join_table is not None:
                jt_hooks.append(HookField(h))
                target_col = mapping.join_table.target_column
                if self.dispatch_style(tbl):
                    exp = tbl.root.exporter
                    exporters[exp] = True
                    root_model = tbl.root.primary_type.model
                    cast = f"({target.model}) " if root_model != target.model else ""
                    inst = f"instanceof {target.model}" if root_model != target.model else "!= null"
                    load = (
                        f'                            {root_model} {v} = {self.ref_exp(exp)}.doExport({v}Rs.getLong("{target_col}"));\n'
                        f"                            if ({v} {inst}) {{\n"
                        f"                                {el} property = new {el}(new {prop}({cast}{v}));\n                                {add}(property);\n                            }}\n"
                    )
                else:
                    exp = tbl.exporter
                    exporters[exp] = True
                    load = (
                        f"                            {target.model} {v} = new {target.model}();\n"
                        f'                            {self.ref_exp(exp)}.doExport({v}, {v}Rs.getLong("{target_col}"));\n\n'
                        f"                            {el} property = new {el}(new {prop}({v}));\n                            {add}(property);\n"
                    )
                body += (
                    f'                if ({guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                    f"                    ps{cap(h.element)}.setLong(1, parentId);\n                    try (ResultSet {v}Rs = ps{cap(h.element)}.executeQuery()) {{\n"
                    f"                        while ({v}Rs.next()) {{\n{load}                        }}\n                    }}\n                }}\n\n"
                )
                continue
            join = mapping.require_join()
            if join.to_role == "parent" and target.is_feature:
                col = join.from_column
                columns.append(col)
                feature_hooks.append((v, col))
                body += (
                    f'                long {v}Id = rs.getLong("{col}");\n                if ({v}Id != 0 && {guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                    f'                    int {v}ObjectClassId = rs.getInt("{col}_objectclass_id");\n'
                    f"                    AbstractObjectType<?> {v}Type = helper.getAbstractObjectType({v}ObjectClassId);\n"
                    f"                    {target.model} {v} = helper.createObject({v}Id, {v}ObjectClassId, {target.model}.class);\n"
                    f"                    if ({v} != null) {{\n                        manager.exportObject({v}, {v}Id, {v}Type, helper.getProjectionFilter({v}Type));\n"
                    f"                        {el} property = new {el}(new {prop}({v}));\n                        {add}(property);\n                    }}\n                }}\n\n"
                )
                imports |= {
                    "org.citydb.core.database.schema.mapping.AbstractObjectType",
                    "org.citydb.core.database.schema.mapping.MappingConstants",
                    "org.citydb.sqlbuilder.select.join.JoinFactory",
                    "org.citydb.sqlbuilder.select.operator.comparison.ComparisonName",
                }
            elif join.to_role == "parent":
                columns.append(join.from_column)
                if self.dispatch_style(tbl):
                    exp = tbl.root.exporter
                    exporters[exp] = True
                    root_model = tbl.root.primary_type.model
                    cast = f"({target.model}) " if root_model != target.model else ""
                    inst = f"instanceof {target.model}" if root_model != target.model else "!= null"
                    body += (
                        f'                long {v}Id = rs.getLong("{join.from_column}");\n                if ({v}Id != 0 && {guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                        f"                    {root_model} {v} = {self.ref_exp(exp)}.doExport({v}Id);\n                    if ({v} {inst}) {{\n"
                        f"                        {el} property = new {el}(new {prop}({cast}{v}));\n                        {add}(property);\n                    }}\n                }}\n\n"
                    )
                else:
                    exp = tbl.exporter
                    exporters[exp] = True
                    body += (
                        f'                long {v}Id = rs.getLong("{join.from_column}");\n                if ({v}Id != 0 && {guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                        f"                    {target.model} {v} = new {target.model}();\n                    {self.ref_exp(exp)}.doExport({v}, {v}Id);\n\n"
                        f"                    {el} property = new {el}(new {prop}({v}));\n                    {add}(property);\n                }}\n\n"
                    )
            else:
                child = self.tables[join.table].root
                exp = child.exporter
                exporters[exp] = True
                args = "parentId"
                if self.parent_arg_style(child) == "multi":
                    args += ', "%s"' % join.to_column
                root_model = child.primary_type.model
                if root_model != target.model:
                    body += (
                        f'                if ({guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                        f"                    for ({root_model} {v} : {self.ref_exp(exp)}.doExport({args})) {{\n                        if ({v} instanceof {target.model}) {{\n"
                        f"                            {el} property = new {el}(new {prop}(({target.model}) {v}));\n                            {add}(property);\n                        }}\n                    }}\n                }}\n\n"
                    )
                else:
                    body += (
                        f'                if ({guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                        f"                    for ({target.model} {v} : {self.ref_exp(exp)}.doExport({args})) {{\n"
                        f"                        {el} property = new {el}(new {prop}({v}));\n                        {add}(property);\n                    }}\n                }}\n\n"
                    )
        fields = "".join(f"    private final {exp} {uncap(exp)};\n" for exp in exporters)
        inits = "".join(f"        {uncap(exp)} = manager.getExporter({exp}.class);\n" for exp in exporters)
        jt_stmts, jt_fields, jt_closes, jt_imports = self.join_table_statements(jt_hooks)
        fields += jt_fields
        inits = jt_stmts + inits
        imports |= jt_imports
        projection = "\n                        ".join(wrap(columns, quote=True))
        if columns:
            # the object class of a referenced feature (pointCloud) comes from its cityobject row
            feature_tables = "".join(
                f"        Table {v}CityObject = new Table(helper.getTableNameWithSchema(MappingConstants.CITYOBJECT));\n"
                for v, _ in feature_hooks
            )
            feature_joins = "".join(
                f'\n                .addJoin(JoinFactory.left({v}CityObject, "id", ComparisonName.EQUAL_TO, table.getColumn("{c}")))'
                f'\n                .addProjection({v}CityObject.getColumn("objectclass_id", "{c}_objectclass_id"))'
                for v, c in feature_hooks
            )
            select = (
                f"        Table table = new Table(helper.getTableNameWithSchema(tableName));\n{feature_tables}        Select select = new Select().addProjection(table.getColumns({projection})){feature_joins}\n"
                f'                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));\n        ps = connection.prepareStatement(select.toString());\n'
            )
        else:
            # hook table without 1:1 columns: the parent row is enough
            select = (
                '        Table table = new Table(helper.getTableNameWithSchema(tableName));\n        Select select = new Select().addProjection(table.getColumn("id"))\n'
                '                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));\n        ps = connection.prepareStatement(select.toString());\n'
            )
        query = f"        ps.setLong(1, parentId);\n\n        try (ResultSet rs = ps.executeQuery()) {{\n            if (rs.next()) {{\n{body.rstrip()}\n            }}\n        }}\n"
        manager_fields = (
            "    private final CityGMLExportHelper helper;\n    private final ExportManager manager;\n"
            if feature_hooks
            else ""
        )
        manager_inits = "        this.helper = helper;\n        this.manager = manager;\n" if feature_hooks else ""
        text = f"""{self.header}

package {PKG}.exporter.{mod.prefix};

{render_imports(imports)}

import java.sql.*;

public class {name} implements {mod.exporter_interface} {{
{manager_fields}    private final PreparedStatement ps;
    private final String module;

{fields}
    public {name}(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {{
{manager_inits}        String tableName = manager.getSchemaMapper().getTableName(ADETable.{inj.table[3:].upper()});
        module = {mod.module_class}.{mod.version_const}.getNamespaceURI();

{select}
{inits}    }}

    public void doExport({ref(parent_cls)} parent, long parentId, FeatureType parentType, ProjectionFilter projectionFilter) throws CityGMLExportException, SQLException {{
{query}    }}

    @Override
    public void close() throws CityGMLExportException, SQLException {{
        ps.close();
{jt_closes}    }}
}}
"""
        text = re.sub(r"\n{3,}", "\n\n", text)
        text = text.replace(
            "        ps = connection.prepareStatement(select.toString());\n\n    }",
            "        ps = connection.prepareStatement(select.toString());\n    }",
        )
        self.out(os.path.join(self.src, "exporter", mod.prefix, name + ".java"), text)
        return name, columns
