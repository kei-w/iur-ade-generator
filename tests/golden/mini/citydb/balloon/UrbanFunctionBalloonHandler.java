/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.balloon;

import org.citydb.ade.iur.schema.ADETable;
import org.citydb.ade.iur.schema.SchemaMapper;
import org.citydb.core.ade.visExporter.ADEBalloonHandler;

public class UrbanFunctionBalloonHandler implements ADEBalloonHandler {
    private final SchemaMapper schemaMapper;

    public UrbanFunctionBalloonHandler(BalloonManager manager) {
        this.schemaMapper = manager.getSchemaMapper();
    }

    @Override
    public String getSqlStatement(String table,
                                  String tableShortId,
                                  String aggregateColumnsClause,
                                  int lod,
                                  String schemaName) {
        String sqlStatement = null;

        if (schemaMapper.getTableName(ADETable.ABSTRACTMINIFUNCTION).equalsIgnoreCase(table)
                || schemaMapper.getTableName(ADETable.MINIZONE).equalsIgnoreCase(table)) {
            sqlStatement = "SELECT " + aggregateColumnsClause +
                    " FROM " + schemaName + "." + table + " " + tableShortId +
                    " WHERE " + tableShortId + ".id = ?";
        } else if (schemaMapper.getTableName(ADETable.DETAILATTRIBUTE).equalsIgnoreCase(table)) {
            sqlStatement = "SELECT " + aggregateColumnsClause +
                    " FROM " + schemaName + "." + table + " " + tableShortId + ", " + schemaName + "." + schemaMapper.getTableName(ADETable.MINIZONE) + " p" +
                    " WHERE " + tableShortId + ".id = p.detail_id" +
                    " AND p.id = ?";
        }

        return sqlStatement;
    }
}
