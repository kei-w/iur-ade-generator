/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.importer.urf;

import org.citydb.ade.iur.importer.ImportManager;
import org.citydb.ade.iur.importer.uro.DetailAttributeImporter;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.ade.iur.schema.SchemaMapper;
import org.citydb.core.ade.importer.CityGMLImportHelper;
import org.citydb.core.ade.importer.ForeignKeys;
import org.citydb.core.database.schema.mapping.AbstractObjectType;
import org.citydb.core.operation.importer.CityGMLImportException;
import org.citygml4j.ade.iur.model.urf.MiniZone;
import org.citygml4j.ade.iur.model.urf.MiniZoneProperty;

import java.sql.*;

public class MiniZoneImporter implements UrbanFunctionModuleImporter {
    private final CityGMLImportHelper helper;
    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;
    private final AbstractMiniFunctionImporter abstractMiniFunctionImporter;
    private final MiniZoneToMiniZoneImporter miniZoneToMiniZoneImporter;
    private final DetailAttributeImporter detailAttributeImporter;

    private int batchCounter;

    public MiniZoneImporter(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {
        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();

        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.MINIZONE)) + " " +
                "(id, areainha, areainha_uom, detail_id) " +
                "values (?, ?, ?, ?)");

        abstractMiniFunctionImporter = manager.getImporter(AbstractMiniFunctionImporter.class);
        miniZoneToMiniZoneImporter = manager.getImporter(MiniZoneToMiniZoneImporter.class);
        detailAttributeImporter = manager.getImporter(DetailAttributeImporter.class);
    }

    public void doImport(MiniZone miniZone, long objectId, AbstractObjectType<?> objectType, ForeignKeys foreignKeys) throws CityGMLImportException, SQLException {
        abstractMiniFunctionImporter.doImport(miniZone, objectId, objectType, foreignKeys);

        ps.setLong(1, objectId);

        if (miniZone.getAreaInHa() != null && miniZone.getAreaInHa().isSetValue()) {
            ps.setDouble(2, miniZone.getAreaInHa().getValue());
            ps.setString(3, miniZone.getAreaInHa().getUom());
        } else {
            ps.setNull(2, Types.DOUBLE);
            ps.setNull(3, Types.VARCHAR);
        }

        long detailId = 0;
        if (miniZone.getDetail() != null && miniZone.getDetail().isSetObject())
            detailId = detailAttributeImporter.doImport(miniZone.getDetail().getObject());

        if (detailId != 0)
            ps.setLong(4, detailId);
        else
            ps.setNull(4, Types.NULL);

        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(objectType);

        for (MiniZoneProperty property : miniZone.getRelatedZone()) {
            MiniZone cityObject = property.getObject();
            if (cityObject != null) {
                long cityObjectId = helper.importObject(cityObject);
                property.unsetObject();
                miniZoneToMiniZoneImporter.doImport(cityObjectId, objectId);
            } else {
                String href = property.getHref();
                if (href != null && !href.isEmpty())
                    helper.propagateObjectXlink(schemaMapper.getTableName(ADETable.MINIZONE_TO_MINIZONE), objectId, "minizone_id", href, "minizone_id_2");
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
