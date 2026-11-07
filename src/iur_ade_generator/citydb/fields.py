"""The import and export code of one field: the prepared statement parameters and the result set reads."""

from __future__ import annotations

from collections import OrderedDict
from collections.abc import Callable

from ..errors import GeneratorError
from ..naming import cap, uncap
from ..spec import Field, Type
from .common import NULL_GEOMETRY, required, safe_var
from .tables import CitydbBase, Table

Alias = Callable[[str], str]
# (child importers/exporters, needs, imports) collected while the fields of one class are written
Context = tuple[OrderedDict[str, bool], set[str], set[str]]
ImportCode = tuple[list[str], str, str, str]
"""(columns, set code, null code, post code) of a field."""

LIST_KINDS = ("code", "string", "date", "integer", "double", "year", "yearMonth", "enum", "measure", "length")
NULL_GEOMETRY_PARAM = "ps.setNull(%d, " + NULL_GEOMETRY.replace("\n                    ", "\n                ") + ");\n"


def set_or_null(i: int, name: str) -> str:
    return (
        f"        if ({name}Id != 0)\n            ps.setLong({i}, {name}Id);\n        else\n"
        f"            ps.setNull({i}, Types.NULL);\n"
    )


class FieldWriter(CitydbBase):
    # ----------------------------------------------------------- field code
    def import_field(self, var: str, f: Field, i: int, tbl: Table) -> ImportCode:
        """Returns (columns, set_code, null_code, post_code) for a field; i is the first parameter index."""
        g = "%s.get%s()" % (var, cap(f.model_name))
        p = f.mapped
        k = f.kind
        if k == "property" and p.join_table is not None and not f.is_feature_property:
            # multi-valued data types: the rows are imported on their own and linked through the join table
            target = f.nested
            imp = self.importer_for(target)
            jt_imp = uncap(self.join_importer(tbl, f))
            name = f.model_name
            self.extra_imports.add(f"{f.property_type.module.model_pkg}.{f.property_type.model}")
            body = (
                f"            if (property.isSetObject()) {{\n"
                f"                long {name}Id = {self.ref_imp(imp)}.doImport(property.getObject());\n"
                f"                {jt_imp}.doImport({name}Id, objectId);\n            }}\n"
            )
            if f.multi:
                return [], "", "", f"        for ({f.property_type.model} property : {g}) {{\n{body}        }}\n"
            return (
                [],
                "",
                "",
                f"        if ({g} != null) {{\n            {f.property_type.model} property = {g};\n{body}        }}\n",
            )
        if k == "cityObjectRef" or (f.is_member_reference and p.join_table is not None):
            # references to other city objects (members): rows of a join table, xlinks resolved by the Importer/Exporter
            jt = p.require_join_table()
            imp = uncap(self.join_importer(tbl, f))
            cls = "AbstractCityObject" if k == "cityObjectRef" else f.nested.model
            self.extra_imports |= {
                f"{f.property_type.module.model_pkg}.{f.property_type.model}",
                "org.citygml4j.model.citygml.core.AbstractCityObject"
                if k == "cityObjectRef"
                else f"{f.nested.module.model_pkg}.{cls}",
            }
            body = (
                f"            {cls} cityObject = property.getObject();\n"
                f"            if (cityObject != null) {{\n                long cityObjectId = helper.importObject(cityObject);\n"
                f"                property.unsetObject();\n                {imp}.doImport(cityObjectId, objectId);\n            }} else {{\n"
                f"                String href = property.getHref();\n                if (href != null && !href.isEmpty())\n"
                f'                    helper.propagateObjectXlink(schemaMapper.getTableName(ADETable.{jt.table[3:].upper()}), objectId, "{jt.owner_column}", href, "{jt.target_column}");\n'
                f"            }}\n"
            )
            if f.multi:
                return [], "", "", f"        for ({f.property_type.model} property : {g}) {{\n{body}        }}\n"
            return (
                [],
                "",
                "",
                f"        if ({g} != null) {{\n            {f.property_type.model} property = {g};\n{body}        }}\n",
            )
        if f.is_feature_property:
            # nested ADE features are imported through the Importer/Exporter with the parent id as foreign key
            join = p.require_join()
            child = self.feature_tables[join.table]
            target = f.nested
            column = join.to_column
            cvar = uncap(target.model.replace("Abstract", "", 1))
            self.extra_imports |= {
                f"{f.property_type.module.model_pkg}.{f.property_type.model}",
                f"{target.module.model_pkg}.{target.model}",
                "org.citydb.core.ade.importer.ForeignKeys",
            }
            if f.multi:
                return (
                    [],
                    "",
                    "",
                    (
                        f"        for ({f.property_type.model} property : {g}) {{\n            {target.model} {cvar} = property.getObject();\n"
                        f"            if ({cvar} != null) {{\n"
                        f'                helper.importObject({cvar}, ForeignKeys.create().with("{column}", objectId));\n'
                        f"                property.unsetObject();\n            }} else {{\n"
                        f"                String href = property.getHref();\n                if (href != null && !href.isEmpty())\n"
                        f'                    helper.propagateReverseObjectXlink(schemaMapper.getTableName(ADETable.{child.enum}), href, objectId, "{column}");\n'
                        f"            }}\n        }}\n"
                    ),
                )
            return (
                [],
                "",
                "",
                (
                    f"        if ({g} != null) {{\n            {target.model} {cvar} = {g}.getObject();\n"
                    f"            if ({cvar} != null) {{\n"
                    f'                helper.importObject({cvar}, ForeignKeys.create().with("{column}", objectId));\n'
                    f"                {g}.unsetObject();\n            }} else {{\n"
                    f"                String href = {g}.getHref();\n                if (href != null && !href.isEmpty())\n"
                    f'                    helper.propagateReverseObjectXlink(schemaMapper.getTableName(ADETable.{child.enum}), href, objectId, "{column}");\n'
                    f"            }}\n        }}\n"
                ),
            )
        if k == "multiSurface":
            col = required(p.ref_column, "refColumn")
            name = f.model_name
            set_code = (
                f"        long {name}Id = 0;\n        if ({g} != null) {{\n            MultiSurfaceProperty property = {g};\n"
                f"            if (property.isSetMultiSurface()) {{\n"
                f"                {name}Id = helper.importSurfaceGeometry(property.getMultiSurface(), objectId);\n"
                f"                property.unsetMultiSurface();\n            }} else {{\n"
                f"                String href = property.getHref();\n                if (href != null && !href.isEmpty())\n"
                f'                    helper.propagateSurfaceGeometryXlink(href, schemaMapper.getTableName(ADETable.{tbl.enum}), objectId, "{col}");\n'
                f"            }}\n        }}\n\n" + set_or_null(i, name)
            )
            self.extra_imports.add("org.citygml4j.model.gml.geometry.aggregates.MultiSurfaceProperty")
            return [col], set_code, f"        ps.setNull({i}, Types.NULL);\n", ""
        if k in ("multiCurve", "multiPoint"):
            col = required(p.inline_column, "inlineColumn")
            name = safe_var(f.model_name, var)
            cls = cap(k)
            set_code = (
                f"        GeometryObject {name} = null;\n        if ({g} != null) {{\n"
                f"            {name} = geometryConverter.get{cls}({g});\n            {g}.unset{cls}();\n        }}\n\n"
                f"        if ({name} != null)\n            ps.setObject({i}, helper.getDatabaseAdapter().getGeometryConverter().getDatabaseObject({name}, connection));\n        else\n"
                f"            ps.setNull({i}, {NULL_GEOMETRY});\n"
            )
            null_code = "        " + NULL_GEOMETRY_PARAM % i
            return [col], set_code, null_code, ""
        if k == "directPosition":
            col = p.require_column()
            return (
                [col],
                f'        if ({g} != null && {g}.isSetValue())\n            ps.setString({i}, valueJoiner.join(" ", {g}.getValue()));\n'
                f"        else\n            ps.setNull({i}, Types.VARCHAR);\n",
                f"        ps.setNull({i}, Types.VARCHAR);\n",
                "",
            )
        if k == "property" and p.tag == "complexProperty" and p.require_join().to_role == "child":
            # 1:n child objects imported after the row
            child = self.table_of(f.nested).root
            args = "objectId"
            if self.parent_arg_style(child) == "multi":
                args += ', "%s"' % p.require_join().to_column
            post = (
                f"        for ({f.property_type.model} property : {g}) {{\n            if (property.isSetObject())\n"
                f"                {self.ref_imp(child.importer)}.doImport(property.getObject(), {args});\n        }}\n"
            )
            self.extra_imports.add(f"{f.property_type.module.model_pkg}.{f.property_type.model}")
            return [], "", "", post
        if k == "property":
            col = p.require_join().from_column
            imp = self.importer_for(f.nested)
            name = f.model_name
            set_code = (
                f"        long {name}Id = 0;\n        if ({g} != null && {g}.isSetObject())\n"
                f"            {name}Id = {self.ref_imp(imp)}.doImport({g}.getObject());\n\n" + set_or_null(i, name)
            )
            return [col], set_code, f"        ps.setNull({i}, Types.NULL);\n", ""
        if k == "inline":
            col = p.require_join().from_column
            imp = self.importer_for(f.nested)
            name = f.model_name
            set_code = (
                f"        long {name}Id = 0;\n        if ({g} != null)\n            {name}Id = {self.ref_imp(imp)}.doImport({g});\n\n"
                + set_or_null(i, name)
            )
            return [col], set_code, f"        ps.setNull({i}, Types.NULL);\n", ""
        if k == "address":
            col = p.require_join().from_column
            name = f.model_name
            set_code = (
                f"        long {name}Id = 0;\n        if ({g} != null && {g}.isSetAddress())\n            {name}Id = helper.importObject({g}.getAddress());\n\n"
                + set_or_null(i, name)
            )
            return [col], set_code, f"        ps.setNull({i}, Types.NULL);\n", ""
        if k in ("geometry", "complex"):
            ref_col, inline_col = required(p.ref_column, "refColumn"), required(p.inline_column, "inlineColumn")
            name = f.model_name
            owner = "objectId" if tbl.feature else "0"
            set_code = (
                f"        long {name}Id = 0;\n        Object {name}Geometry = null;\n"
                f"        if ({g} != null && {g}.isSetGeometry()) {{\n"
                f"            AbstractGeometry geometry = {g}.getGeometry();\n"
                f"            if (helper.isSurfaceGeometry(geometry))\n                {name}Id = helper.importSurfaceGeometry(geometry, {owner});\n"
                f"            else if (helper.isPointOrLineGeometry(geometry)) {{\n"
                f"                GeometryObject geometryObject = geometryConverter.getPointOrCurveGeometry(geometry);\n"
                f"                if (geometryObject != null)\n"
                f"                    {name}Geometry = helper.getDatabaseAdapter().getGeometryConverter().getDatabaseObject(geometryObject, connection);\n"
                f"            }}\n        }}\n\n" + set_or_null(i, name) + "\n"
                f"        if ({name}Geometry != null)\n            ps.setObject({i + 1}, {name}Geometry);\n        else\n"
                f"            ps.setNull({i + 1}, {NULL_GEOMETRY});\n"
            )
            null_code = f"        ps.setNull({i}, Types.NULL);\n        " + NULL_GEOMETRY_PARAM % (i + 1)
            return [ref_col, inline_col], set_code, null_code, ""
        if k == "point":
            col = required(p.inline_column, "inlineColumn")
            name = safe_var(f.model_name, var)
            set_code = (
                f"        GeometryObject {name} = null;\n        if ({g} != null)\n            {name} = geometryConverter.getPoint({g});\n\n"
                f"        if ({name} != null)\n            ps.setObject({i}, helper.getDatabaseAdapter().getGeometryConverter().getDatabaseObject({name}, connection));\n        else\n"
                f"            ps.setNull({i}, {NULL_GEOMETRY});\n"
            )
            null_code = "        " + NULL_GEOMETRY_PARAM % i
            return [col], set_code, null_code, ""
        col = p.require_column()
        q = p.qualifier
        if f.multi:
            if k == "code":
                return (
                    [col, required(q, "qualifier")],
                    f"        if (!{g}.isEmpty()) {{\n            valueJoiner.join({g}, Code::getValue, Code::getCodeSpace);\n"
                    f"            ps.setString({i}, valueJoiner.result(0));\n            ps.setString({i + 1}, valueJoiner.result(1));\n"
                    f"        }} else {{\n            ps.setNull({i}, Types.VARCHAR);\n            ps.setNull({i + 1}, Types.VARCHAR);\n        }}\n",
                    f"        ps.setNull({i}, Types.VARCHAR);\n        ps.setNull({i + 1}, Types.VARCHAR);\n",
                    "",
                )
            if k in ("string", "date", "integer", "double", "year", "yearMonth", "enum"):
                return (
                    [col],
                    f"        if (!{g}.isEmpty())\n            ps.setString({i}, valueJoiner.join({g}));\n        else\n            ps.setNull({i}, Types.VARCHAR);\n",
                    f"        ps.setNull({i}, Types.VARCHAR);\n",
                    "",
                )
            if k in ("measure", "length"):
                # lists of measures: the values and the units joined in the two columns of the measure
                cls = "Measure" if k == "measure" else "Length"
                return (
                    [col, required(q, "qualifier")],
                    f"        if (!{g}.isEmpty()) {{\n            valueJoiner.join({g}, {uncap(cls)} -> String.valueOf({uncap(cls)}.getValue()), {cls}::getUom);\n"
                    f"            ps.setString({i}, valueJoiner.result(0));\n            ps.setString({i + 1}, valueJoiner.result(1));\n"
                    f"        }} else {{\n            ps.setNull({i}, Types.VARCHAR);\n            ps.setNull({i + 1}, Types.VARCHAR);\n        }}\n",
                    f"        ps.setNull({i}, Types.VARCHAR);\n        ps.setNull({i + 1}, Types.VARCHAR);\n",
                    "",
                )
            raise GeneratorError("list of %s (%s) is not supported" % (k, f.name))
        if k == "string":
            return [col], f"        ps.setString({i}, {g});\n", f"        ps.setNull({i}, Types.VARCHAR);\n", ""
        if k == "stringOrRef":
            return (
                [col],
                f"        if ({g} != null && {g}.isSetValue())\n            ps.setString({i}, {g}.getValue());\n        else\n            ps.setNull({i}, Types.VARCHAR);\n",
                f"        ps.setNull({i}, Types.VARCHAR);\n",
                "",
            )
        if k == "enum":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setString({i}, {g}.value());\n        else\n            ps.setNull({i}, Types.VARCHAR);\n",
                f"        ps.setNull({i}, Types.VARCHAR);\n",
                "",
            )
        if k == "doubleList":
            return (
                [col],
                f"        if (!{g}.isEmpty())\n            ps.setString({i}, valueJoiner.join({g}));\n        else\n            ps.setNull({i}, Types.VARCHAR);\n",
                f"        ps.setNull({i}, Types.VARCHAR);\n",
                "",
            )
        if k == "integer":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setInt({i}, {g});\n        else\n            ps.setNull({i}, Types.INTEGER);\n",
                f"        ps.setNull({i}, Types.INTEGER);\n",
                "",
            )
        if k == "double":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setDouble({i}, {g});\n        else\n            ps.setNull({i}, Types.DOUBLE);\n",
                f"        ps.setNull({i}, Types.DOUBLE);\n",
                "",
            )
        if k == "boolean":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setInt({i}, {g} ? 1 : 0);\n        else\n            ps.setNull({i}, Types.INTEGER);\n",
                f"        ps.setNull({i}, Types.INTEGER);\n",
                "",
            )
        if k == "date":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setDate({i}, Date.valueOf({g}));\n        else\n            ps.setNull({i}, Types.DATE);\n",
                f"        ps.setNull({i}, Types.DATE);\n",
                "",
            )
        if k == "time":
            # a time of day in a timestamp column, on the epoch day (the Importer/Exporter has no time type)
            return (
                [col],
                f"        if ({g} != null)\n            ps.setTimestamp({i}, Timestamp.valueOf(LocalDateTime.of(LocalDate.ofEpochDay(0), {g})));\n"
                f"        else\n            ps.setNull({i}, Types.TIMESTAMP_WITH_TIMEZONE);\n",
                f"        ps.setNull({i}, Types.TIMESTAMP_WITH_TIMEZONE);\n",
                "",
            )
        if k == "year":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setDate({i}, Date.valueOf(LocalDate.of({g}.getValue(), 1, 1)));\n        else\n            ps.setNull({i}, Types.DATE);\n",
                f"        ps.setNull({i}, Types.DATE);\n",
                "",
            )
        if k == "yearMonth":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setDate({i}, Date.valueOf({g}.atDay(1)));\n        else\n            ps.setNull({i}, Types.DATE);\n",
                f"        ps.setNull({i}, Types.DATE);\n",
                "",
            )
        if k == "code":
            return (
                [col, required(q, "qualifier")],
                f"        if ({g} != null && {g}.isSetValue()) {{\n            ps.setString({i}, {g}.getValue());\n            ps.setString({i + 1}, {g}.getCodeSpace());\n"
                f"        }} else {{\n            ps.setNull({i}, Types.VARCHAR);\n            ps.setNull({i + 1}, Types.VARCHAR);\n        }}\n",
                f"        ps.setNull({i}, Types.VARCHAR);\n        ps.setNull({i + 1}, Types.VARCHAR);\n",
                "",
            )
        if k in ("measure", "length"):
            return (
                [col, required(q, "qualifier")],
                f"        if ({g} != null && {g}.isSetValue()) {{\n            ps.setDouble({i}, {g}.getValue());\n            ps.setString({i + 1}, {g}.getUom());\n"
                f"        }} else {{\n            ps.setNull({i}, Types.DOUBLE);\n            ps.setNull({i + 1}, Types.VARCHAR);\n        }}\n",
                f"        ps.setNull({i}, Types.DOUBLE);\n        ps.setNull({i + 1}, Types.VARCHAR);\n",
                "",
            )
        raise GeneratorError(f"cannot import a field of kind {k}")

    def export_field(self, var: str, f: Field, alias: Alias) -> tuple[list[str], str]:
        """Returns (columns, code) for reading a field of the given object variable; alias maps column -> result set
        label."""
        p = f.mapped
        k = f.kind
        if k == "property" and p.join_table is not None and not f.is_feature_property:
            target = f.nested
            tbl = self.table_of(target)
            name = safe_var(f.model_name, var)
            ps = "ps" + cap(self.join_name(f))
            setter, getter = "%s.set%s" % (var, cap(f.model_name)), "%s.get%s" % (var, cap(f.model_name))
            prop_model = f.property_type.model
            target_col = p.require_join_table().target_column
            if self.dispatch_style(tbl):
                exp = tbl.root.exporter
                root_model = tbl.root.primary_type.model
                test = f"{name} instanceof {target.model}" if root_model != target.model else f"{name} != null"
                cast = f"({target.model}) " if root_model != target.model else ""
                add = (
                    f"{getter}().add(new {prop_model}({cast}{name}))"
                    if f.multi
                    else f"{setter}(new {prop_model}({cast}{name}))"
                )
                load = (
                    f'                        {root_model} {name} = {self.ref_exp(exp)}.doExport({name}Rs.getLong("{target_col}"));\n'
                    f"                        if ({test})\n                            {add};\n"
                )
            else:
                exp = tbl.exporter
                add = f"{getter}().add(new {prop_model}({name}))" if f.multi else f"{setter}(new {prop_model}({name}))"
                load = (
                    f"                        {target.model} {name} = new {target.model}();\n"
                    f'                        {self.ref_exp(exp)}.doExport({name}, {name}Rs.getLong("{target_col}"));\n'
                    f"                        {add};\n"
                )
            return [], (
                f"                {ps}.setLong(1, objectId);\n                try (ResultSet {name}Rs = {ps}.executeQuery()) {{\n"
                f"                    while ({name}Rs.next()) {{\n{load}                    }}\n                }}\n"
            )
        if k == "cityObjectRef" or (f.is_member_reference and p.join_table is not None):
            name = f.model_name
            ps = "ps" + cap(self.join_name(f))
            prop_model = f.property_type.model
            add = f"{var}.get{cap(name)}().add({name}Property)" if f.multi else f"{var}.set{cap(name)}({name}Property)"
            return [], (
                f"                {ps}.setLong(1, objectId);\n                try (ResultSet {name}Rs = {ps}.executeQuery()) {{\n"
                f"                    while ({name}Rs.next()) {{\n"
                f"                        {prop_model} {name}Property = new {prop_model}();\n"
                f'                        {name}Property.setHref("#" + {name}Rs.getString("gmlid"));\n'
                f"                        {add};\n                    }}\n                }}\n"
            )
        setter = "%s.set%s" % (var, cap(f.model_name))
        getter = "%s.get%s" % (var, cap(f.model_name))
        name = safe_var(f.model_name, var)
        if f.is_feature_property:
            # nested ADE features: their ids are queried per parent, the objects are created by the Importer/Exporter
            target = f.nested
            prop_model = f.property_type.model
            cvar = uncap(target.model.replace("Abstract", "", 1))
            ps = "ps" + cap(name)
            add = f"{getter}().add(new {prop_model}({cvar}))" if f.multi else f"{setter}(new {prop_model}({cvar}))"
            # the Importer/Exporter creates nested ADE objects as stubs: their ADE content is exported here
            return [], (
                f"                {ps}.setLong(1, objectId);\n                try (ResultSet {name}Rs = {ps}.executeQuery()) {{\n"
                f"                    while ({name}Rs.next()) {{\n"
                f'                        long {cvar}Id = {name}Rs.getLong("id");\n'
                f'                        AbstractObjectType<?> {cvar}Type = helper.getAbstractObjectType({name}Rs.getInt("objectclass_id"));\n'
                f"                        {target.model} {cvar} = helper.createObject({cvar}Id, {cvar}Type.getObjectClassId(), {target.model}.class);\n"
                f"                        if ({cvar} != null) {{\n"
                f"                            manager.exportObject({cvar}, {cvar}Id, {cvar}Type, helper.getProjectionFilter({cvar}Type));\n"
                f"                            {add};\n                        }}\n"
                f"                    }}\n                }}\n"
            )
        if k == "multiSurface":
            col = alias(required(p.ref_column, "refColumn"))
            return [col], (
                f'                long {name}Id = rs.getLong("{col}");\n                if (!rs.wasNull())\n'
                f"                    surfaceGeometryExporter.addBatch({name}Id, {var}::set{cap(f.model_name)});\n"
            )
        if k in ("multiCurve", "multiPoint"):
            col = alias(required(p.inline_column, "inlineColumn"))
            cls = cap(k)
            return [col], (
                f'                Object {name}Object = rs.getObject("{col}");\n                if (!rs.wasNull()) {{\n'
                f"                    GeometryObject {name} = helper.getDatabaseAdapter().getGeometryConverter().get{cls}({name}Object);\n"
                f"                    if ({name} != null)\n                        {setter}(gmlConverter.get{cls}Property({name}));\n                }}\n"
            )
        if k == "directPosition":
            col = alias(p.require_column())
            return [col], (
                f'                String {name} = rs.getString("{col}");\n                if (!rs.wasNull()) {{\n'
                f"                    DirectPosition directPosition = new DirectPosition();\n"
                f'                    directPosition.setValue(valueSplitter.splitDoubleList(Pattern.compile(" "), {name}));\n'
                f"                    {setter}(directPosition);\n                }}\n"
            )
        if k == "property" and p.tag == "complexProperty" and p.require_join().to_role == "child":
            child = self.table_of(f.nested).root
            exp = child.exporter
            args = "objectId"
            if self.parent_arg_style(child) == "multi":
                args += ', "%s"' % p.require_join().to_column
            return [], (
                f"                for ({child.primary_type.model} {name} : {self.ref_exp(exp)}.doExport({args}))\n"
                f"                    {getter}().add(new {f.property_type.model}({name}));\n"
            )
        if k == "property":
            col = alias(p.require_join().from_column)
            target = f.nested
            tbl = self.table_of(target)
            prop_model = f.property_type.model
            if self.dispatch_style(tbl):
                exp = tbl.root.exporter
                root_model = tbl.root.primary_type.model
                test = f"{name} instanceof {target.model}" if root_model != target.model else f"{name} != null"
                cast = f"({target.model}) " if root_model != target.model else ""
                return [col], (
                    f'                long {name}Id = rs.getLong("{col}");\n                if ({name}Id != 0) {{\n'
                    f"                    {root_model} {name} = {self.ref_exp(exp)}.doExport({name}Id);\n"
                    f"                    if ({test})\n                        {setter}(new {prop_model}({cast}{name}));\n                }}\n"
                )
            exp = tbl.exporter
            return [col], (
                f'                long {name}Id = rs.getLong("{col}");\n                if ({name}Id != 0) {{\n'
                f"                    {target.model} {name} = new {target.model}();\n                    {self.ref_exp(exp)}.doExport({name}, {name}Id);\n"
                f"                    {setter}(new {prop_model}({name}));\n                }}\n"
            )
        if k == "inline":
            col = alias(p.require_join().from_column)
            tbl = self.table_of(f.nested)
            exp = tbl.exporter
            inline_model = f.property_type.model
            return [col], (
                f'                long {name}Id = rs.getLong("{col}");\n                if ({name}Id != 0) {{\n'
                f"                    {inline_model} {name} = new {inline_model}();\n                    {self.ref_exp(exp)}.doExport({name}, {name}Id);\n"
                f"                    {setter}({name});\n                }}\n"
            )
        if k == "address":
            col = alias(p.require_join().from_column)
            return [col], (
                f'                long {name}Id = rs.getLong("{col}");\n                if ({name}Id != 0) {{\n'
                f"                    Address {name} = helper.createObject({name}Id, Util.getObjectClassId(Address.class), Address.class);\n"
                f"                    if ({name} != null)\n                        {setter}(new AddressProperty({name}));\n                }}\n"
            )
        if k in ("geometry", "complex"):
            ref_col = alias(required(p.ref_column, "refColumn"))
            inline_col = alias(required(p.inline_column, "inlineColumn"))
            conv = "getPointOrCurveComplexProperty" if k == "complex" else "getPointOrCurveGeometryProperty"
            code = (
                f'                long {name}Id = rs.getLong("{ref_col}");\n                if ({name}Id != 0)\n'
                f"                    surfaceGeometryExporter.addBatch({name}Id, (GeometrySetter.AbstractGeometry) geometry -> {setter}(geometry));\n"
                f'                else {{\n                    Object {name}Object = rs.getObject("{inline_col}");\n'
                f"                    if (!rs.wasNull()) {{\n"
                f"                        GeometryObject {name} = helper.getDatabaseAdapter().getGeometryConverter().getGeometry({name}Object);\n"
                f"                        if ({name} != null)\n                            {setter}(gmlConverter.{conv}({name}));\n"
                f"                    }}\n                }}\n"
            )
            if k == "complex":
                code = code.replace(
                    f"(GeometrySetter.AbstractGeometry) geometry -> {setter}(geometry)",
                    f"(GeometrySetter.AbstractGeometry) geometry -> {{\n                        if (geometry.getGeometry() instanceof GeometricComplex)\n"
                    f"                            {setter}(new GeometricComplexProperty((GeometricComplex) geometry.getGeometry()));\n                    }}",
                )
            return [ref_col, inline_col], code
        if k == "point":
            col = alias(required(p.inline_column, "inlineColumn"))
            return [col], (
                f'                Object {name}Object = rs.getObject("{col}");\n                if (!rs.wasNull()) {{\n'
                f"                    GeometryObject {name} = helper.getDatabaseAdapter().getGeometryConverter().getPoint({name}Object);\n"
                f"                    if ({name} != null)\n                        {setter}(gmlConverter.getPointProperty({name}));\n                }}\n"
            )
        col = alias(p.require_column())
        q = alias(p.qualifier) if p.qualifier else ""
        if f.multi:
            if k == "code":
                return [col, q], (
                    f'                for (SplitValue splitValue : valueSplitter.split(rs.getString("{col}"), rs.getString("{q}"))) {{\n'
                    f"                    Code code = new Code(splitValue.result(0));\n                    code.setCodeSpace(splitValue.result(1));\n"
                    f"                    {getter}().add(code);\n                }}\n"
                )
            if k in ("measure", "length"):
                cls = "Measure" if k == "measure" else "Length"
                return [col, q], (
                    f'                for (SplitValue splitValue : valueSplitter.split(rs.getString("{col}"), rs.getString("{q}"))) {{\n'
                    f"                    {cls} {uncap(cls)} = new {cls}(splitValue.asDouble(0));\n                    {uncap(cls)}.setUom(splitValue.result(1));\n"
                    f"                    {getter}().add({uncap(cls)});\n                }}\n"
                )
            conv = {
                "string": "splitValue.result(0)",
                "date": "LocalDate.parse(splitValue.result(0))",
                "integer": "splitValue.asInteger(0)",
                "double": "splitValue.asDouble(0)",
                "year": "Year.parse(splitValue.result(0))",
                "yearMonth": "YearMonth.parse(splitValue.result(0))",
                "enum": "%s.fromValue(splitValue.result(0))" % (f.enum_type.model if k == "enum" else ""),
            }[k]
            return [col], (
                f'                for (SplitValue splitValue : valueSplitter.split(rs.getString("{col}")))\n'
                f"                    {getter}().add({conv});\n"
            )
        if k == "string":
            return [col], f'                {setter}(rs.getString("{col}"));\n'
        if k == "stringOrRef":
            return (
                [col],
                f'                String {name} = rs.getString("{col}");\n                if (!rs.wasNull())\n                    {setter}(new StringOrRef({name}));\n',
            )
        if k == "enum":
            return (
                [col],
                f'                String {name} = rs.getString("{col}");\n                if (!rs.wasNull())\n                    {setter}({f.enum_type.model}.fromValue({name}));\n',
            )
        if k == "doubleList":
            return [col], (
                f'                for (SplitValue splitValue : valueSplitter.split(rs.getString("{col}")))\n'
                f"                    {getter}().add(splitValue.asDouble(0));\n"
            )
        if k == "integer":
            return (
                [col],
                f'                int {name} = rs.getInt("{col}");\n                if (!rs.wasNull())\n                    {setter}({name});\n',
            )
        if k == "double":
            return (
                [col],
                f'                double {name} = rs.getDouble("{col}");\n                if (!rs.wasNull())\n                    {setter}({name});\n',
            )
        if k == "boolean":
            return (
                [col],
                f'                boolean {name} = rs.getBoolean("{col}");\n                if (!rs.wasNull())\n                    {setter}({name});\n',
            )
        if k == "date":
            return (
                [col],
                f'                Date {name} = rs.getDate("{col}");\n                if (!rs.wasNull())\n                    {setter}({name}.toLocalDate());\n',
            )
        if k == "time":
            return (
                [col],
                f'                Time {name} = rs.getTime("{col}");\n                if (!rs.wasNull())\n                    {setter}({name}.toLocalTime());\n',
            )
        if k == "year":
            return (
                [col],
                f'                Date {name} = rs.getDate("{col}");\n                if (!rs.wasNull())\n                    {setter}(Year.of({name}.toLocalDate().getYear()));\n',
            )
        if k == "yearMonth":
            return (
                [col],
                f'                Date {name} = rs.getDate("{col}");\n                if (!rs.wasNull())\n                    {setter}(YearMonth.from({name}.toLocalDate()));\n',
            )
        if k == "code":
            return [col, q], (
                f'                String {name} = rs.getString("{col}");\n                if (!rs.wasNull()) {{\n                    Code code = new Code({name});\n'
                f'                    code.setCodeSpace(rs.getString("{q}"));\n                    {setter}(code);\n                }}\n'
            )
        if k in ("measure", "length"):
            cls = "Measure" if k == "measure" else "Length"
            return [col, q], (
                f'                double {name} = rs.getDouble("{col}");\n                if (!rs.wasNull()) {{\n                    {cls} {uncap(cls)} = new {cls}({name});\n'
                f'                    {uncap(cls)}.setUom(rs.getString("{q}"));\n                    {setter}({uncap(cls)});\n                }}\n'
            )
        raise GeneratorError(f"cannot export a field of kind {k}")

    # -------------------------------------------------------------- importer
    def import_fields(
        self, t: Type, v: str, i: int, tbl: Table, ctx: Context
    ) -> tuple[list[str], list[str], list[str], list[str], int]:
        """Import code of the fields of type t read from variable v; returns (columns, sets, nulls, posts, next index)."""
        child_importers, needs, imports = ctx
        sets: list[str] = []
        nulls: list[str] = []
        posts: list[str] = []
        cols: list[str] = []
        for f in t.fields:
            c, s, n, p = self.import_field(v, f, i, tbl)
            i += len(c)
            cols += c
            if s:
                sets.append(s)
            if n:
                nulls.append(n)
            if p:
                posts.append(p)
            if f.kind == "cityObjectRef" or (f.kind == "property" and f.mapped.join_table is not None):
                child_importers[self.join_importer(tbl, f)] = True
                if f.kind == "property" and not f.is_feature_property:
                    child_importers[self.importer_for(f.nested)] = True
                continue
            if f.is_feature_property:
                continue
            if f.kind == "property":
                target = f.nested
                child = self.table_of(target).root if f.mapped.require_join().to_role == "child" else None
                imp = child.importer if child else self.importer_for(target)
                child_importers[imp] = True
            if f.kind == "inline":
                child_importers[self.importer_for(f.nested)] = True
            if f.kind in ("geometry", "complex", "point", "multiCurve", "multiPoint"):
                needs.add("geometry")
            if (f.multi and f.kind in LIST_KINDS) or f.kind in ("doubleList", "directPosition"):
                needs.add("joiner")
            if f.multi and f.kind == "code":
                imports.add("org.citygml4j.model.gml.basicTypes.Code")
            if f.multi and f.kind == "measure":
                imports.add("org.citygml4j.model.gml.basicTypes.Measure")
            if f.multi and f.kind == "length":
                imports.add("org.citygml4j.model.gml.measures.Length")
            if f.kind == "year":
                imports.add("java.time.LocalDate")
            if f.kind == "time":
                imports |= {"java.time.LocalDate", "java.time.LocalDateTime"}
        return cols, sets, nulls, posts, i

    # -------------------------------------------------------------- exporter
    def export_fields(self, rt: Type, v: str, alias: Alias, ctx: Context, features_first: bool = False) -> str:
        """Export code reading the fields of type rt into variable v (collects child exporters, needs and imports in
        ctx); with features_first the code of the feature properties is left out (the caller has emitted it before)."""
        child_exporters, needs, imports = ctx
        code = ""
        for f in rt.fields:
            _, s = self.export_field(v, f, alias)
            prop = f.property_type if f.kind in ("property", "inline", "cityObjectRef") else None
            if f.is_feature_property and f.mapped.join_table is None:
                needs |= {"helper", "manager"}
                imports |= {
                    f"{f.nested.module.model_pkg}.{f.nested.model}",
                    f"{f.property_type.module.model_pkg}.{f.property_type.model}",
                    "org.citydb.core.database.schema.mapping.AbstractObjectType",
                }
                if not features_first:
                    code += s + "\n"
                continue
            code += s + "\n"
            if prop is not None and (
                f.kind == "cityObjectRef" or (f.is_feature_property and f.mapped.join_table is not None)
            ):
                imports.add(f"{prop.module.model_pkg}.{prop.model}")
            if f.kind == "property" and f.mapped.join_table is not None and not f.is_feature_property:
                target = f.nested
                tt = self.table_of(target)
                child_exporters[tt.root.exporter if self.dispatch_style(tt) else tt.exporter] = True
                imports.add(f"{target.module.model_pkg}.{target.model}")
                imports.add(f"{f.property_type.module.model_pkg}.{f.property_type.model}")
                if self.dispatch_style(tt):
                    imports.add(f"{tt.root.primary_type.module.model_pkg}.{tt.root.primary_type.model}")
            if f.kind == "property" and f.mapped.join_table is None:
                target = f.nested
                tt = self.table_of(target)
                child = tt.root if f.mapped.require_join().to_role == "child" else None
                child_exporters[
                    child.exporter if child else (tt.root.exporter if self.dispatch_style(tt) else tt.exporter)
                ] = True
                imports.add(f"{target.module.model_pkg}.{target.model}")
                imports.add(f"{f.property_type.module.model_pkg}.{f.property_type.model}")
                if child:
                    imports.add(f"{child.primary_type.module.model_pkg}.{child.primary_type.model}")
                elif self.dispatch_style(tt):
                    imports.add(f"{tt.root.primary_type.module.model_pkg}.{tt.root.primary_type.model}")
            if f.kind == "inline":
                child_exporters[self.table_of(f.nested).exporter] = True
                imports.add(f"{f.property_type.module.model_pkg}.{f.property_type.model}")
            if f.kind == "address":
                needs.add("helper")
                imports.update(
                    {
                        "org.citygml4j.model.citygml.core.Address",
                        "org.citygml4j.model.citygml.core.AddressProperty",
                        "org.citydb.core.util.Util",
                    }
                )
            if f.kind in ("geometry", "complex", "point", "multiSurface", "multiCurve", "multiPoint"):
                needs.add("geometry")
                if f.kind == "complex":
                    imports.add("org.citygml4j.model.gml.geometry.complexes.GeometricComplex")
                    imports.add("org.citygml4j.model.gml.geometry.complexes.GeometricComplexProperty")
            if f.multi or f.kind in ("doubleList", "directPosition"):
                needs.add("splitter")
            if f.kind == "directPosition":
                imports |= {"org.citygml4j.model.gml.geometry.primitives.DirectPosition", "java.util.regex.Pattern"}
            if f.kind == "code":
                imports.add("org.citygml4j.model.gml.basicTypes.Code")
            if f.kind == "stringOrRef":
                imports.add("org.citygml4j.model.gml.base.StringOrRef")
            if f.kind == "enum":
                imports.add(f"{f.enum_type.module.model_pkg}.{f.enum_type.model}")
            if f.kind == "measure":
                imports.add("org.citygml4j.model.gml.basicTypes.Measure")
            if f.kind == "length":
                imports.add("org.citygml4j.model.gml.measures.Length")
            if f.kind == "year":
                imports.add("java.time.Year")
            if f.kind == "yearMonth":
                imports.add("java.time.YearMonth")
            if f.multi and f.kind == "date":
                imports.add("java.time.LocalDate")
        return code
