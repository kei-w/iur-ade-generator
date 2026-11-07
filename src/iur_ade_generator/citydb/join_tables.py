"""Join tables: their importers and the prepared statements that read their rows."""

from __future__ import annotations

import os
from collections.abc import Iterable

from ..naming import cap, uncap
from ..spec import Module
from ..templates import render
from .common import PKG
from .fields import FieldWriter
from .tables import JoinRef, Table


class JoinTableWriter(FieldWriter):
    def gen_join_importer(self, owner: Table | str, f: JoinRef, module: Module) -> str:
        """Importer of a join table (city object references, member references, multi-valued data types)."""
        name = self.join_importer(owner, f)
        self.register_class(name, module.prefix)
        jt = f.mapped.require_join_table()
        enum = jt.table[3:].upper()
        owner_var = uncap(owner if isinstance(owner, str) else owner.concrete.model)
        target_id = "cityObjectId" if f.kind == "cityObjectRef" else uncap(f.nested.model) + "Id"
        if target_id == owner_var + "Id":  # self reference (urt Route/parentRoute)
            target_id = f.model_name + "Id"
        text = render(
            "citydb/join_importer.java.j2",
            header=self.header,
            pkg=PKG,
            prefix=module.prefix,
            name=name,
            interface=module.importer_interface,
            enum=enum,
            target_column=jt.target_column,
            owner_column=jt.owner_column,
            target_id=target_id,
            owner_var=owner_var,
        )
        self.out(os.path.join(self.src, "importer", module.prefix, name + ".java"), text)
        return name

    def join_table_statements(self, fields_with_jt: Iterable[JoinRef]) -> tuple[str, str, str, set[str]]:
        """(statements, fields, closes, imports) of the prepared statements that read the rows of the join tables of
        the given properties: the gml:ids of referenced city objects, or the ids of the rows of a data type."""
        stmts, fields, closes = "", "", ""
        imports: set[str] = set()
        need_cityobject = False
        for f in fields_with_jt:
            jt = f.mapped.require_join_table()
            name = self.join_name(f)
            var = name + "s" if name != "table" else "joinTable"
            stmts += f"        Table {var} = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.{jt.table[3:].upper()})));\n"
            if f.kind == "cityObjectRef" or f.is_feature_property:
                need_cityobject = True
                stmts += (
                    f'        Select {name}Select = new Select().addProjection(cityObject.getColumn("gmlid"))\n'
                    f'                .addJoin(JoinFactory.inner(cityObject, "id", ComparisonName.EQUAL_TO, {var}.getColumn("{jt.target_column}")))\n'
                    f'                .addSelection(ComparisonFactory.equalTo({var}.getColumn("{jt.owner_column}"), new PlaceHolder<>()))\n'
                    f'                .addOrderBy(new OrderByToken(cityObject.getColumn("id")));\n'
                )
                imports |= {
                    "org.citydb.sqlbuilder.select.join.JoinFactory",
                    "org.citydb.sqlbuilder.select.operator.comparison.ComparisonName",
                }
            else:
                stmts += (
                    f'        Select {name}Select = new Select().addProjection({var}.getColumn("{jt.target_column}"))\n'
                    f'                .addSelection(ComparisonFactory.equalTo({var}.getColumn("{jt.owner_column}"), new PlaceHolder<>()))\n'
                    f'                .addOrderBy(new OrderByToken({var}.getColumn("{jt.target_column}")));\n'
                )
            stmts += f"        ps{cap(name)} = connection.prepareStatement({name}Select.toString());\n"
            fields += f"    private final PreparedStatement ps{cap(name)};\n"
            closes += f"        ps{cap(name)}.close();\n"
        if need_cityobject:
            stmts = (
                "        Table cityObject = new Table(helper.getTableNameWithSchema(MappingConstants.CITYOBJECT));\n"
                + stmts
            )
            imports.add("org.citydb.core.database.schema.mapping.MappingConstants")
        if stmts:
            imports |= {
                "org.citydb.sqlbuilder.select.OrderByToken",
                "org.citydb.sqlbuilder.expression.PlaceHolder",
                "org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory",
                "org.citydb.sqlbuilder.schema.Table",
                "org.citydb.sqlbuilder.select.Select",
            }
        return stmts, fields, closes, imports
