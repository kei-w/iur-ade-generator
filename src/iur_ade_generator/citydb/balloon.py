"""The balloon handler of a feature module (the SQL of the KML/COLLADA/glTF exporter's balloons)."""

from __future__ import annotations

import os

from ..spec import Module
from .common import write
from .registry import RegistryWriter

BALLOON_TEMPLATE = """{header}

package org.citydb.ade.iur.balloon;

import org.citydb.ade.iur.schema.ADETable;
import org.citydb.ade.iur.schema.SchemaMapper;
import org.citydb.core.ade.visExporter.ADEBalloonHandler;

public class {name} implements ADEBalloonHandler {{
    private final SchemaMapper schemaMapper;

    public {name}(BalloonManager manager) {{
        this.schemaMapper = manager.getSchemaMapper();
    }}

    @Override
    public String getSqlStatement(String table,
                                  String tableShortId,
                                  String aggregateColumnsClause,
                                  int lod,
                                  String schemaName) {{
        String sqlStatement = null;

{branches}
        return sqlStatement;
    }}
}}
"""


class BalloonWriter(RegistryWriter):
    def gen_balloon_handler(self, module: Module) -> None:
        """Balloon SQL of a feature module: the feature tables by city object id, their direct child tables by parent."""
        feature_tables = [t for t in self.feature_tables.values() if t.module is module]
        cond = "\n                || ".join(
            f"schemaMapper.getTableName(ADETable.{t.enum}).equalsIgnoreCase(table)" for t in feature_tables
        )
        branches = (
            f'        if ({cond}) {{\n            sqlStatement = "SELECT " + aggregateColumnsClause +\n'
            f'                    " FROM " + schemaName + "." + table + " " + tableShortId +\n'
            f'                    " WHERE " + tableShortId + ".id = ?";\n        }}'
        )
        done: set[str] = set()
        for ft in feature_tables:
            for rt in ft.row_types:
                for f in rt.fields:
                    p = f.mapped
                    if f.kind not in ("property", "cityObjectRef") or p.join_table is not None or f.is_feature_property:
                        continue
                    child = self.table_of(f.nested)
                    if child.name in done:
                        continue
                    done.add(child.name)
                    join = p.require_join()
                    if join.to_role == "parent":
                        branches += (
                            f" else if (schemaMapper.getTableName(ADETable.{child.enum}).equalsIgnoreCase(table)) {{\n"
                            f'            sqlStatement = "SELECT " + aggregateColumnsClause +\n'
                            f'                    " FROM " + schemaName + "." + table + " " + tableShortId + ", " + schemaName + "." + schemaMapper.getTableName(ADETable.{ft.enum}) + " p" +\n'
                            f'                    " WHERE " + tableShortId + ".id = p.{join.from_column}" +\n'
                            f'                    " AND p.id = ?";\n        }}'
                        )
                    else:
                        branches += (
                            f" else if (schemaMapper.getTableName(ADETable.{child.enum}).equalsIgnoreCase(table)) {{\n"
                            f'            sqlStatement = "SELECT " + aggregateColumnsClause +\n'
                            f'                    " FROM " + schemaName + "." + table + " " + tableShortId +\n'
                            f'                    " WHERE " + tableShortId + ".{join.to_column} = ?";\n        }}'
                        )
        name = module.java_name + "BalloonHandler"
        write(
            os.path.join(self.src, "balloon", name + ".java"),
            BALLOON_TEMPLATE.format(header=self.header, name=name, branches=branches + "\n"),
        )
