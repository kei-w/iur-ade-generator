/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.exporter.urf;

import org.citydb.ade.iur.exporter.ExportManager;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.config.geometry.GeometryObject;
import org.citydb.core.ade.exporter.CityGMLExportHelper;
import org.citydb.core.database.schema.mapping.AbstractType;
import org.citydb.core.database.schema.mapping.MappingConstants;
import org.citydb.core.operation.exporter.CityGMLExportException;
import org.citydb.core.operation.exporter.database.content.GMLConverter;
import org.citydb.core.operation.exporter.database.content.SurfaceGeometryExporter;
import org.citydb.core.operation.exporter.util.AttributeValueSplitter;
import org.citydb.core.operation.exporter.util.GeometrySetter;
import org.citydb.core.operation.exporter.util.SplitValue;
import org.citydb.core.query.filter.projection.ProjectionFilter;
import org.citydb.sqlbuilder.expression.PlaceHolder;
import org.citydb.sqlbuilder.schema.Table;
import org.citydb.sqlbuilder.select.OrderByToken;
import org.citydb.sqlbuilder.select.Select;
import org.citydb.sqlbuilder.select.join.JoinFactory;
import org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory;
import org.citydb.sqlbuilder.select.operator.comparison.ComparisonName;
import org.citygml4j.ade.iur.model.urf.AbstractMiniFunction;
import org.citygml4j.ade.iur.model.urf.TargetProperty;
import org.citygml4j.model.gml.basicTypes.Code;

import java.sql.*;

public class AbstractMiniFunctionExporter implements UrbanFunctionModuleExporter {
    private final CityGMLExportHelper helper;
    private final PreparedStatement ps;
    private final PreparedStatement psTarget;
    private final AttributeValueSplitter valueSplitter;
    private final SurfaceGeometryExporter surfaceGeometryExporter;
    private final GMLConverter gmlConverter;

    public AbstractMiniFunctionExporter(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {
        this.helper = helper;
        String tableName = manager.getSchemaMapper().getTableName(ADETable.ABSTRACTMINIFUNCTION);
        valueSplitter = helper.getAttributeValueSplitter();
        surfaceGeometryExporter = helper.getSurfaceGeometryExporter();
        gmlConverter = helper.getGMLConverter();

        Table table = new Table(helper.getTableNameWithSchema(tableName));
        Select select = new Select()
                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));
        addProjection(select, table, "");
        ps = connection.prepareStatement(select.toString());

        Table cityObject = new Table(helper.getTableNameWithSchema(MappingConstants.CITYOBJECT));
        Table targets = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.ABSTRACTM_TO_CITYOBJEC)));
        Select targetSelect = new Select().addProjection(cityObject.getColumn("gmlid"))
                .addJoin(JoinFactory.inner(cityObject, "id", ComparisonName.EQUAL_TO, targets.getColumn("cityobject_id")))
                .addSelection(ComparisonFactory.equalTo(targets.getColumn("abstractminifunction_id"), new PlaceHolder<>()))
                .addOrderBy(new OrderByToken(cityObject.getColumn("id")));
        psTarget = connection.prepareStatement(targetSelect.toString());
    }

    public void doExport(AbstractMiniFunction abstractMiniFunction, long objectId, AbstractType<?> objectType, ProjectionFilter projectionFilter) throws CityGMLExportException, SQLException {
        ps.setLong(1, objectId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                doExport(abstractMiniFunction, objectId, "", rs);
            }
        }
    }

    public Select addProjection(Select select, Table table, String prefix) {
        select.addProjection(table.getColumn("function", prefix + "function"),
                table.getColumn("function_codespace", prefix + "function_codespace"),
                table.getColumn("validfrom", prefix + "validfrom"),
                table.getColumn("lod1multisurface_id", prefix + "lod1multisurface_id"));

        return select;
    }

    public void doExport(AbstractMiniFunction abstractMiniFunction, long objectId, String prefix, ResultSet rs) throws CityGMLExportException, SQLException {
        for (SplitValue splitValue : valueSplitter.split(rs.getString(prefix + "function"), rs.getString(prefix + "function_codespace"))) {
            Code code = new Code(splitValue.result(0));
            code.setCodeSpace(splitValue.result(1));
            abstractMiniFunction.getFunction().add(code);
        }

        Date validFrom = rs.getDate(prefix + "validfrom");
        if (!rs.wasNull())
            abstractMiniFunction.setValidFrom(validFrom.toLocalDate());

        long lod1MultiSurfaceId = rs.getLong(prefix + "lod1multisurface_id");
        if (!rs.wasNull())
            surfaceGeometryExporter.addBatch(lod1MultiSurfaceId, abstractMiniFunction::setLod1MultiSurface);

        psTarget.setLong(1, objectId);
        try (ResultSet targetRs = psTarget.executeQuery()) {
            while (targetRs.next()) {
                TargetProperty targetProperty = new TargetProperty();
                targetProperty.setHref("#" + targetRs.getString("gmlid"));
                abstractMiniFunction.getTarget().add(targetProperty);
            }
        }
    }

    @Override
    public void close() throws CityGMLExportException, SQLException {
        ps.close();
        psTarget.close();
    }
}
