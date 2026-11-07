"""The importers of the data type tables and the feature tables."""

from __future__ import annotations

import os
from collections import OrderedDict

from ..errors import GeneratorError
from ..naming import uncap
from .common import GEOM_IMPORTS, PKG, indent, render_imports, wrap
from .fields import FieldWriter
from .tables import Table


class ImporterWriter(FieldWriter):
    def gen_feature_importer(self, tbl: Table) -> list[str]:
        """Importer of one feature table: inserts the row of a city object that the Importer/Exporter has created (urf
        style)."""
        self.current_importer = tbl.importer
        concrete = tbl.concrete
        var = uncap(concrete.model)
        columns, body, post, i = ["id"], "        ps.setLong(1, objectId);\n", "", 2
        imports = {
            f"{PKG}.importer.ImportManager",
            f"{PKG}.schema.ADETable",
            f"{PKG}.schema.SchemaMapper",
            "org.citydb.core.ade.importer.CityGMLImportHelper",
            "org.citydb.core.ade.importer.ForeignKeys",
            "org.citydb.core.database.schema.mapping.AbstractObjectType",
            "org.citydb.core.operation.importer.CityGMLImportException",
            f"{concrete.module.model_pkg}.{concrete.model}",
        }
        fields: list[str] = []
        inits: list[str] = []
        self.extra_imports = set()
        if tbl.has_objectclass:
            columns.append("objectclass_id")
            body += f"        ps.setInt({i}, objectType.getObjectClassId());\n"
            i += 1
        for c in tbl.parent_columns:
            columns.append(c)
            body += f'        if (foreignKeys.contains("{c}"))\n            ps.setLong({i}, foreignKeys.get("{c}"));\n        else\n            ps.setNull({i}, Types.NULL);\n'
            i += 1
        body += "\n"
        child_importers: OrderedDict[str, bool] = OrderedDict()
        if tbl.parent is not None:
            child_importers[tbl.parent.importer] = True
        needs: set[str] = set()
        ctx = (child_importers, needs, imports)
        cols, sets, nulls, posts, i = self.import_fields(tbl.primary_type, var, i, tbl, ctx)
        columns += cols
        body += "\n".join(sets)
        post += "".join(posts)
        for m in tbl.merged:
            if not m.fields:
                continue
            mvar = uncap(m.model)
            cols, sets, nulls, posts, i = self.import_fields(m, mvar, i, tbl, ctx)
            columns += cols
            imports.add(f"{m.module.model_pkg}.{m.model}")
            if m is concrete:
                body += ("\n" if sets else "") + "\n".join(sets)
                post += "".join(posts)
            else:
                body += (
                    f"\n        if ({var} instanceof {m.model}) {{\n            {m.model} {mvar} = ({m.model}) {var};\n"
                    + indent("\n".join(sets), 4)
                    + "        } else {\n"
                    + indent("".join(nulls), 4)
                    + "        }\n"
                )
                if posts:
                    post += f"        if ({var} instanceof {m.model}) {{\n" + indent("".join(posts), 4) + "        }\n"
        body = body.rstrip("\n") + "\n"
        for imp in child_importers:
            fields.append(f"    private final {imp} {uncap(imp)};\n")
            inits.append(f"        {uncap(imp)} = manager.getImporter({imp}.class);\n")
        if "joiner" in needs:
            fields.append("    private final AttributeValueJoiner valueJoiner;\n")
            inits.append("        valueJoiner = helper.getAttributeValueJoiner();\n")
            imports.add("org.citydb.core.operation.importer.util.AttributeValueJoiner")
        if "geometry" in needs:
            fields.append("    private final GeometryConverter geometryConverter;\n")
            inits.append("        geometryConverter = helper.getGeometryConverter();\n")
            imports |= {GEOM_IMPORTS[k] for k in ("GeometryObject", "GeometryConverter", "AbstractGeometry")}
        base_call = (
            f"        {uncap(tbl.parent.importer)}.doImport({var}, objectId, objectType, foreignKeys);\n\n"
            if tbl.parent is not None
            else ""
        )
        sql_cols = '" +\n                "'.join(wrap(columns))
        inits_block = ("\n" + "".join(inits)) if inits else ""
        conn_field = "    private final Connection connection;\n" if "geometry" in needs else ""
        conn_init = "        this.connection = connection;\n" if "geometry" in needs else ""
        imports.add("java.sql.*")
        imports |= self.extra_imports
        if "LocalDate" in body:
            imports.add("java.time.LocalDate")
        text = f"""{self.header}

package {PKG}.importer.{tbl.module.prefix};

{render_imports(imports)}

public class {tbl.importer} implements {tbl.module.importer_interface} {{
{conn_field}    private final CityGMLImportHelper helper;
    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;
{"".join(fields)}
    private int batchCounter;

    public {tbl.importer}(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {{
{conn_init}        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();

        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.{tbl.enum})) + " " +
                "({sql_cols}) " +
                "values ({", ".join("?" * len(columns))})");
{inits_block}    }}

    public void doImport({concrete.model} {var}, long objectId, AbstractObjectType<?> objectType, ForeignKeys foreignKeys) throws CityGMLImportException, SQLException {{
{base_call}{body}
        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(objectType);

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
        self.out(os.path.join(self.src, "importer", tbl.module.prefix, tbl.importer + ".java"), text)
        return columns

    def gen_importer(self, tbl: Table) -> list[str]:
        self.current_importer = tbl.importer
        dispatch = self.dispatch_style(tbl)
        concrete = tbl.concrete
        var = uncap(concrete.model)
        parent_style = self.parent_arg_style(tbl)
        root = tbl.parent is None
        columns, body, post, i = ["id"], "", "", 2
        imports = {
            f"{PKG}.importer.ImportManager",
            f"{PKG}.schema.ADETable",
            f"{PKG}.schema.SchemaMapper",
            "org.citydb.core.ade.importer.CityGMLImportHelper",
            "org.citydb.core.operation.importer.CityGMLImportException",
            f"{concrete.module.model_pkg}.{concrete.model}",
        }
        fields: list[str] = []
        inits: list[str] = []
        self.extra_imports = set()
        body += "        ps.setLong(1, objectId);\n"
        if tbl.has_objectclass:
            columns.append("objectclass_id")
            body += f"        ps.setLong({i}, objectMapper.getTypeClassId({var}.getClass()));\n"
            i += 1
            imports.add(f"{PKG}.schema.ObjectMapper")
        for c in tbl.parent_columns:
            columns.append(c)
            if parent_style == "single":
                body += f"        ps.setLong({i}, parentId);\n"
            else:
                body += f'        if ("{c}".equals(parentColumn))\n            ps.setLong({i}, parentId);\n        else\n            ps.setNull({i}, Types.NULL);\n'
            i += 1
        body += "\n"
        child_importers: OrderedDict[str, bool] = OrderedDict()
        needs: set[str] = set()
        ctx = (child_importers, needs, imports)

        cols, sets, nulls, posts, i = self.import_fields(tbl.primary_type, var, i, tbl, ctx)
        columns += cols
        body += "\n".join(sets)
        post += "".join(posts)
        for m in tbl.merged:
            if not m.fields:
                continue
            mvar = uncap(m.model)
            cols, sets, nulls, posts, i = self.import_fields(m, mvar, i, tbl, ctx)
            columns += cols
            imports.add(f"{m.module.model_pkg}.{m.model}")
            if m is concrete:
                body += ("\n" if sets else "") + "\n".join(sets)
                post += "".join(posts)
            else:
                body += (
                    f"\n        if ({var} instanceof {m.model}) {{\n            {m.model} {mvar} = ({m.model}) {var};\n"
                    + indent("\n".join(sets), 4)
                    + "        } else {\n"
                    + indent("".join(nulls), 4)
                    + "        }\n"
                )
                if posts:
                    post += f"        if ({var} instanceof {m.model}) {{\n" + indent("".join(posts), 4) + "        }\n"
        body = body.rstrip("\n") + "\n"
        # sub tables
        for s in tbl.sub_tables:
            if dispatch:
                args = "objectId"
                if parent_style and s.hierarchy_parent_columns:
                    args += ", parentId" + (", parentColumn" if parent_style == "multi" else "")
                post += f"        if ({var} instanceof {s.primary_type.model})\n            {self.ref_imp(s.importer)}.doImport(({s.primary_type.model}) {var}, {args});\n\n"
                child_importers[s.importer] = True
                imports.add(f"{s.primary_type.module.model_pkg}.{s.primary_type.model}")
        if not dispatch and not root:
            child_importers = OrderedDict([(tbl.root.importer, True), *child_importers.items()])
        lazy_methods = ""
        for imp in child_importers:
            if (tbl.importer, imp) in self.lazy_imp:
                fields.append(f"    private {imp} {uncap(imp)};\n")
                lazy_methods += self.lazy_accessor(imp, "getImporter", "CityGMLImportException")
            else:
                fields.append(f"    private final {imp} {uncap(imp)};\n")
                inits.append(f"        {uncap(imp)} = manager.getImporter({imp}.class);\n")
        if lazy_methods:
            fields.insert(0, "    private final ImportManager manager;\n")
        if "joiner" in needs:
            fields.append("    private final AttributeValueJoiner valueJoiner;\n")
            inits.append("        valueJoiner = helper.getAttributeValueJoiner();\n")
            imports.add("org.citydb.core.operation.importer.util.AttributeValueJoiner")
        if "geometry" in needs:
            fields.append("    private final GeometryConverter geometryConverter;\n")
            inits.append("        geometryConverter = helper.getGeometryConverter();\n")
            imports |= {GEOM_IMPORTS[k] for k in ("GeometryObject", "GeometryConverter", "AbstractGeometry")}

        # signature
        params = f"{concrete.model} {var}"
        if root:
            if parent_style == "single":
                params += ", long parentId"
            elif parent_style == "multi":
                params += ", long parentId, String parentColumn"
            if dispatch or tbl.sequence:
                sequence = tbl.sequence or ""
                head = (
                    f"    public long doImport({params}) throws CityGMLImportException, SQLException {{\n"
                    f"        long objectId = helper.getNextSequenceValue(schemaMapper.getSequenceName(ADESequence.{sequence[3:].upper()}));\n"
                )
                imports.add(f"{PKG}.schema.ADESequence")
            else:
                raise GeneratorError("root table without sequence: " + tbl.name)
            ret = "\n        return objectId;\n"
        elif dispatch:
            params += ", long objectId"
            if parent_style and tbl.hierarchy_parent_columns:
                params += ", long parentId" + (", String parentColumn" if parent_style == "multi" else "")
            head = f"    public void doImport({params}) throws CityGMLImportException, SQLException {{\n"
            ret = ""
        else:
            head = (
                f"    public long doImport({params}) throws CityGMLImportException, SQLException {{\n"
                f"        long objectId = {self.ref_imp(tbl.root.importer)}.doImport({var});\n"
            )
            ret = "\n        return objectId;\n"
        overload = ""
        if root and parent_style and any(t.used_single for t in tbl.all_tables()):
            overload = (
                f"    public long doImport({concrete.model} {var}) throws CityGMLImportException, SQLException {{\n"
                f"        return doImport({var}, 0" + (", null" if parent_style == "multi" else "") + ");\n    }\n\n"
            )

        om_field = "    private final ObjectMapper objectMapper;\n" if tbl.has_objectclass else ""
        om_init = "        this.objectMapper = manager.getObjectMapper();\n" if tbl.has_objectclass else ""
        sql_cols = '" +\n                "'.join(wrap(columns))
        inits_block = ("\n" + "".join(inits)) if inits else ""
        conn_field = "    private final Connection connection;\n" if "geometry" in needs else ""
        conn_init = "        this.connection = connection;\n" if "geometry" in needs else ""
        if lazy_methods:
            conn_init += "        this.manager = manager;\n"
        imports.add("java.sql.*")
        imports |= self.extra_imports
        if "LocalDate" in body:
            imports.add("java.time.LocalDate")
        text = f"""{self.header}

package {PKG}.importer.{tbl.module.prefix};

{render_imports(imports)}

public class {tbl.importer} implements {tbl.module.importer_interface} {{
{conn_field}    private final CityGMLImportHelper helper;
{om_field}    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;
{"".join(fields)}
    private int batchCounter;

    public {tbl.importer}(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {{
{conn_init}        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();
{om_init}
        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.{tbl.enum})) + " " +
                "({sql_cols}) " +
                "values ({", ".join("?" * len(columns))})");
{inits_block}    }}

{overload}{head}{body}
        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(schemaMapper.getTableName(ADETable.{tbl.enum}));

{post}{ret}    }}

{lazy_methods}    @Override
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
        text = text.replace("\n\n    }\n\n    @Override", "\n    }\n\n    @Override").replace(
            "\n\n    }\n\n    private", "\n    }\n\n    private"
        )
        text = text.replace(
            "        this.schemaMapper = manager.getSchemaMapper();\n\n\n",
            "        this.schemaMapper = manager.getSchemaMapper();\n\n",
        )
        self.out(os.path.join(self.src, "importer", tbl.module.prefix, tbl.importer + ".java"), text)
        return columns
