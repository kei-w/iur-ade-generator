/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.exporter.uro;

import org.citydb.ade.iur.exporter.ExportManager;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.core.ade.exporter.CityGMLExportHelper;
import org.citydb.core.database.schema.mapping.AbstractType;
import org.citydb.core.operation.exporter.CityGMLExportException;
import org.citydb.core.query.filter.projection.ProjectionFilter;
import org.citydb.sqlbuilder.expression.PlaceHolder;
import org.citydb.sqlbuilder.schema.Table;
import org.citydb.sqlbuilder.select.Select;
import org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory;
import org.citygml4j.ade.iur.model.uro.MiniPart;

import java.sql.*;

public class MiniPartExporter implements UrbanObjectModuleExporter {
    private final PreparedStatement ps;

    public MiniPartExporter(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {
        String tableName = manager.getSchemaMapper().getTableName(ADETable.MINIPART);

        Table table = new Table(helper.getTableNameWithSchema(tableName));
        Select select = new Select()
                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));
        addProjection(select, table, "");
        ps = connection.prepareStatement(select.toString());
    }

    public void doExport(MiniPart miniPart, long objectId, AbstractType<?> objectType, ProjectionFilter projectionFilter) throws CityGMLExportException, SQLException {
        ps.setLong(1, objectId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                doExport(miniPart, objectId, "", rs);
            }
        }
    }

    public Select addProjection(Select select, Table table, String prefix) {
        select.addProjection(table.getColumn("partname", prefix + "partname"));

        return select;
    }

    public void doExport(MiniPart miniPart, long objectId, String prefix, ResultSet rs) throws CityGMLExportException, SQLException {
        miniPart.setPartName(rs.getString(prefix + "partname"));
    }

    @Override
    public void close() throws CityGMLExportException, SQLException {
        ps.close();
    }
}
