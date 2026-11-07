/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.importer.uro;

import org.citydb.ade.iur.importer.ImportManager;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.ade.iur.schema.SchemaMapper;
import org.citydb.core.ade.importer.CityGMLImportHelper;
import org.citydb.core.ade.importer.ForeignKeys;
import org.citydb.core.database.schema.mapping.AbstractObjectType;
import org.citydb.core.operation.importer.CityGMLImportException;
import org.citygml4j.ade.iur.model.uro.MiniFeature;
import org.citygml4j.ade.iur.model.uro.MiniPart;
import org.citygml4j.ade.iur.model.uro.MiniPartProperty;
import org.citygml4j.model.gml.geometry.aggregates.MultiSurfaceProperty;

import java.sql.*;

public class MiniFeatureImporter implements UrbanObjectModuleImporter {
    private final CityGMLImportHelper helper;
    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;
    private final DetailAttributeImporter detailAttributeImporter;

    private int batchCounter;

    public MiniFeatureImporter(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {
        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();

        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.MINIFEATURE)) + " " +
                "(id, label, lod1multisurface_id, detail_id) " +
                "values (?, ?, ?, ?)");

        detailAttributeImporter = manager.getImporter(DetailAttributeImporter.class);
    }

    public void doImport(MiniFeature miniFeature, long objectId, AbstractObjectType<?> objectType, ForeignKeys foreignKeys) throws CityGMLImportException, SQLException {
        ps.setLong(1, objectId);

        ps.setString(2, miniFeature.getLabel());

        long lod1MultiSurfaceId = 0;
        if (miniFeature.getLod1MultiSurface() != null) {
            MultiSurfaceProperty property = miniFeature.getLod1MultiSurface();
            if (property.isSetMultiSurface()) {
                lod1MultiSurfaceId = helper.importSurfaceGeometry(property.getMultiSurface(), objectId);
                property.unsetMultiSurface();
            } else {
                String href = property.getHref();
                if (href != null && !href.isEmpty())
                    helper.propagateSurfaceGeometryXlink(href, schemaMapper.getTableName(ADETable.MINIFEATURE), objectId, "lod1multisurface_id");
            }
        }

        if (lod1MultiSurfaceId != 0)
            ps.setLong(3, lod1MultiSurfaceId);
        else
            ps.setNull(3, Types.NULL);

        long detailId = 0;
        if (miniFeature.getDetail() != null && miniFeature.getDetail().isSetObject())
            detailId = detailAttributeImporter.doImport(miniFeature.getDetail().getObject());

        if (detailId != 0)
            ps.setLong(4, detailId);
        else
            ps.setNull(4, Types.NULL);

        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(objectType);

        for (MiniPartProperty property : miniFeature.getPart()) {
            MiniPart miniPart = property.getObject();
            if (miniPart != null) {
                helper.importObject(miniPart, ForeignKeys.create().with("minifeature_part_id", objectId));
                property.unsetObject();
            } else {
                String href = property.getHref();
                if (href != null && !href.isEmpty())
                    helper.propagateReverseObjectXlink(schemaMapper.getTableName(ADETable.MINIPART), href, objectId, "minifeature_part_id");
            }
        }
    }

    @Override
    public void executeBatch() throws CityGMLImportException, SQLException {
        if (batchCounter > 0) {
            ps.executeBatch();
            batchCounter = 0;
        }
    }

    @Override
    public void close() throws CityGMLImportException, SQLException {
        ps.close();
    }
}
