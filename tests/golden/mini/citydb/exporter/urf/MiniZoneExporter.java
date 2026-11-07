/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.exporter.urf;

import org.citydb.ade.iur.exporter.ExportManager;
import org.citydb.ade.iur.exporter.uro.DetailAttributeExporter;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.core.ade.exporter.CityGMLExportHelper;
import org.citydb.core.database.schema.mapping.AbstractType;
import org.citydb.core.database.schema.mapping.MappingConstants;
import org.citydb.core.operation.exporter.CityGMLExportException;
import org.citydb.core.operation.exporter.util.AttributeValueSplitter;
import org.citydb.core.operation.exporter.util.SplitValue;
import org.citydb.core.query.filter.projection.ProjectionFilter;
import org.citydb.sqlbuilder.expression.PlaceHolder;
import org.citydb.sqlbuilder.schema.Table;
import org.citydb.sqlbuilder.select.OrderByToken;
import org.citydb.sqlbuilder.select.Select;
import org.citydb.sqlbuilder.select.join.JoinFactory;
import org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory;
import org.citydb.sqlbuilder.select.operator.comparison.ComparisonName;
import org.citygml4j.ade.iur.model.urf.MiniZone;
import org.citygml4j.ade.iur.model.urf.MiniZoneProperty;
import org.citygml4j.ade.iur.model.uro.DetailAttribute;
import org.citygml4j.ade.iur.model.uro.DetailAttributeProperty;
import org.citygml4j.model.gml.basicTypes.Measure;

import java.sql.*;

public class MiniZoneExporter implements UrbanFunctionModuleExporter {
    private final AbstractMiniFunctionExporter abstractMiniFunctionExporter;
    private final PreparedStatement ps;
    private final PreparedStatement psRelatedZone;
    private final DetailAttributeExporter detailAttributeExporter;
    private final AttributeValueSplitter valueSplitter;

    public MiniZoneExporter(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {
        String tableName = manager.getSchemaMapper().getTableName(ADETable.MINIZONE);
        abstractMiniFunctionExporter = manager.getExporter(AbstractMiniFunctionExporter.class);
        detailAttributeExporter = manager.getExporter(DetailAttributeExporter.class);
        valueSplitter = helper.getAttributeValueSplitter();

        Table table = new Table(helper.getTableNameWithSchema(tableName));
        Table abstractMiniFunction = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.ABSTRACTMINIFUNCTION)));
        Select select = new Select()
                .addJoin(JoinFactory.inner(abstractMiniFunction, "id", ComparisonName.EQUAL_TO, table.getColumn("id")))
                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));
        addProjection(select, table, "");
        abstractMiniFunctionExporter.addProjection(select, abstractMiniFunction, "amf_");
        ps = connection.prepareStatement(select.toString());

        Table cityObject = new Table(helper.getTableNameWithSchema(MappingConstants.CITYOBJECT));
        Table relatedZones = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.MINIZONE_TO_MINIZONE)));
        Select relatedZoneSelect = new Select().addProjection(cityObject.getColumn("gmlid"))
                .addJoin(JoinFactory.inner(cityObject, "id", ComparisonName.EQUAL_TO, relatedZones.getColumn("minizone_id_2")))
                .addSelection(ComparisonFactory.equalTo(relatedZones.getColumn("minizone_id"), new PlaceHolder<>()))
                .addOrderBy(new OrderByToken(cityObject.getColumn("id")));
        psRelatedZone = connection.prepareStatement(relatedZoneSelect.toString());
    }

    public void doExport(MiniZone miniZone, long objectId, AbstractType<?> objectType, ProjectionFilter projectionFilter) throws CityGMLExportException, SQLException {
        ps.setLong(1, objectId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                abstractMiniFunctionExporter.doExport(miniZone, objectId, "amf_", rs);
                doExport(miniZone, objectId, "", rs);
            }
        }
    }

    public Select addProjection(Select select, Table table, String prefix) {
        select.addProjection(table.getColumn("areainha", prefix + "areainha"),
                table.getColumn("areainha_uom", prefix + "areainha_uom"),
                table.getColumn("detail_id", prefix + "detail_id"));

        return select;
    }

    public void doExport(MiniZone miniZone, long objectId, String prefix, ResultSet rs) throws CityGMLExportException, SQLException {
        double areaInHa = rs.getDouble(prefix + "areainha");
        if (!rs.wasNull()) {
            Measure measure = new Measure(areaInHa);
            measure.setUom(rs.getString(prefix + "areainha_uom"));
            miniZone.setAreaInHa(measure);
        }

        psRelatedZone.setLong(1, objectId);
        try (ResultSet relatedZoneRs = psRelatedZone.executeQuery()) {
            while (relatedZoneRs.next()) {
                MiniZoneProperty relatedZoneProperty = new MiniZoneProperty();
                relatedZoneProperty.setHref("#" + relatedZoneRs.getString("gmlid"));
                miniZone.getRelatedZone().add(relatedZoneProperty);
            }
        }

        long detailId = rs.getLong(prefix + "detail_id");
        if (detailId != 0) {
            DetailAttribute detail = new DetailAttribute();
            detailAttributeExporter.doExport(detail, detailId);
            miniZone.setDetail(new DetailAttributeProperty(detail));
        }
    }

    @Override
    public void close() throws CityGMLExportException, SQLException {
        ps.close();
        psRelatedZone.close();
    }
}
