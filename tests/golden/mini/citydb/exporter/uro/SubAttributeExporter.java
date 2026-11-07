/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.exporter.uro;

import org.citydb.ade.iur.exporter.ExportManager;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.ade.iur.schema.ObjectMapper;
import org.citydb.core.ade.exporter.CityGMLExportHelper;
import org.citydb.core.operation.exporter.CityGMLExportException;
import org.citydb.sqlbuilder.expression.PlaceHolder;
import org.citydb.sqlbuilder.schema.Table;
import org.citydb.sqlbuilder.select.Select;
import org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory;
import org.citygml4j.ade.iur.model.uro.AbstractBaseAttribute;
import org.citygml4j.ade.iur.model.uro.SubAttribute;

import java.sql.*;

public class SubAttributeExporter implements UrbanObjectModuleExporter {
    private final CityGMLExportHelper helper;
    private final ObjectMapper objectMapper;
    private final PreparedStatement ps;

    public SubAttributeExporter(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {
        this.helper = helper;
        this.objectMapper = manager.getObjectMapper();
        String tableName = manager.getSchemaMapper().getTableName(ADETable.BASEATTRIBUTE);

        Table table = new Table(helper.getTableNameWithSchema(tableName));
        Select select = new Select().addProjection(table.getColumns("id", "objectclass_id", "basefield", "subfield"))
                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));
        ps = connection.prepareStatement(select.toString());

    }

    public SubAttribute doExport(long objectId) throws CityGMLExportException, SQLException {
        ps.setLong(1, objectId);

        try (ResultSet rs = ps.executeQuery()) {
            return rs.next() ? doExport(objectId, rs) : null;
        }
    }

    private SubAttribute doExport(long objectId, ResultSet rs) throws CityGMLExportException, SQLException {
        int objectClassId = rs.getInt("objectclass_id");
        if (rs.wasNull())
            return null;

        SubAttribute subAttribute = objectMapper.createType(objectClassId, SubAttribute.class);
        if (subAttribute == null) {
            helper.logOrThrowErrorMessage("Failed to instantiate sub attribute (id: " + objectId + ").");
            return null;
        }

        if (subAttribute instanceof AbstractBaseAttribute) {
            AbstractBaseAttribute abstractBaseAttribute = (AbstractBaseAttribute) subAttribute;

            abstractBaseAttribute.setBaseField(rs.getString("basefield"));
        }

        int subField = rs.getInt("subfield");
        if (!rs.wasNull())
            subAttribute.setSubField(subField);
        return subAttribute;
    }

    @Override
    public void close() throws CityGMLExportException, SQLException {
        ps.close();
    }
}
