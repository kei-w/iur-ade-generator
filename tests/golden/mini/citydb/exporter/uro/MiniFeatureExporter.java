/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.exporter.uro;

import org.citydb.ade.iur.exporter.ExportManager;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.config.geometry.GeometryObject;
import org.citydb.core.ade.exporter.CityGMLExportHelper;
import org.citydb.core.database.schema.mapping.AbstractObjectType;
import org.citydb.core.database.schema.mapping.AbstractType;
import org.citydb.core.database.schema.mapping.MappingConstants;
import org.citydb.core.operation.exporter.CityGMLExportException;
import org.citydb.core.operation.exporter.database.content.GMLConverter;
import org.citydb.core.operation.exporter.database.content.SurfaceGeometryExporter;
import org.citydb.core.operation.exporter.util.GeometrySetter;
import org.citydb.core.query.filter.projection.ProjectionFilter;
import org.citydb.sqlbuilder.expression.PlaceHolder;
import org.citydb.sqlbuilder.schema.Table;
import org.citydb.sqlbuilder.select.OrderByToken;
import org.citydb.sqlbuilder.select.Select;
import org.citydb.sqlbuilder.select.join.JoinFactory;
import org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory;
import org.citydb.sqlbuilder.select.operator.comparison.ComparisonName;
import org.citygml4j.ade.iur.model.uro.DetailAttribute;
import org.citygml4j.ade.iur.model.uro.DetailAttributeProperty;
import org.citygml4j.ade.iur.model.uro.MiniFeature;
import org.citygml4j.ade.iur.model.uro.MiniPart;
import org.citygml4j.ade.iur.model.uro.MiniPartProperty;

import java.sql.*;

public class MiniFeatureExporter implements UrbanObjectModuleExporter {
    private final CityGMLExportHelper helper;
    private final ExportManager manager;
    private final PreparedStatement ps;
    private final PreparedStatement psPart;
    private final DetailAttributeExporter detailAttributeExporter;
    private final SurfaceGeometryExporter surfaceGeometryExporter;
    private final GMLConverter gmlConverter;

    public MiniFeatureExporter(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {
        this.helper = helper;
        this.manager = manager;
        String tableName = manager.getSchemaMapper().getTableName(ADETable.MINIFEATURE);
        detailAttributeExporter = manager.getExporter(DetailAttributeExporter.class);
        surfaceGeometryExporter = helper.getSurfaceGeometryExporter();
        gmlConverter = helper.getGMLConverter();

        Table table = new Table(helper.getTableNameWithSchema(tableName));
        Select select = new Select()
                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));
        addProjection(select, table, "");
        ps = connection.prepareStatement(select.toString());

        Table cityObject = new Table(helper.getTableNameWithSchema(MappingConstants.CITYOBJECT));
        Table miniPart = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.MINIPART)));
        Select partSelect = new Select().addProjection(miniPart.getColumn("id"), cityObject.getColumn("objectclass_id"), cityObject.getColumn("gmlid"))
                .addJoin(JoinFactory.inner(cityObject, "id", ComparisonName.EQUAL_TO, miniPart.getColumn("id")))
                .addSelection(ComparisonFactory.equalTo(miniPart.getColumn("minifeature_part_id"), new PlaceHolder<>()))
                .addOrderBy(new OrderByToken(miniPart.getColumn("id")));
        psPart = connection.prepareStatement(partSelect.toString());
    }

    public void doExport(MiniFeature miniFeature, long objectId, AbstractType<?> objectType, ProjectionFilter projectionFilter) throws CityGMLExportException, SQLException {
        ps.setLong(1, objectId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                doExport(miniFeature, objectId, "", rs);
            }
        }
    }

    public Select addProjection(Select select, Table table, String prefix) {
        select.addProjection(table.getColumn("label", prefix + "label"),
                table.getColumn("lod1multisurface_id", prefix + "lod1multisurface_id"),
                table.getColumn("detail_id", prefix + "detail_id"));

        return select;
    }

    public void doExport(MiniFeature miniFeature, long objectId, String prefix, ResultSet rs) throws CityGMLExportException, SQLException {
        psPart.setLong(1, objectId);
        try (ResultSet partRs = psPart.executeQuery()) {
            while (partRs.next()) {
                long miniPartId = partRs.getLong("id");
                AbstractObjectType<?> miniPartType = helper.getAbstractObjectType(partRs.getInt("objectclass_id"));
                MiniPart miniPart = helper.createObject(miniPartId, miniPartType.getObjectClassId(), MiniPart.class);
                if (miniPart != null) {
                    manager.exportObject(miniPart, miniPartId, miniPartType, helper.getProjectionFilter(miniPartType));
                    miniFeature.getPart().add(new MiniPartProperty(miniPart));
                }
            }
        }

        miniFeature.setLabel(rs.getString(prefix + "label"));

        long lod1MultiSurfaceId = rs.getLong(prefix + "lod1multisurface_id");
        if (!rs.wasNull())
            surfaceGeometryExporter.addBatch(lod1MultiSurfaceId, miniFeature::setLod1MultiSurface);

        long detailId = rs.getLong(prefix + "detail_id");
        if (detailId != 0) {
            DetailAttribute detail = new DetailAttribute();
            detailAttributeExporter.doExport(detail, detailId);
            miniFeature.setDetail(new DetailAttributeProperty(detail));
        }
    }

    @Override
    public void close() throws CityGMLExportException, SQLException {
        ps.close();
        psPart.close();
    }
}
