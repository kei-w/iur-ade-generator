/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.importer.urf;

import org.citydb.ade.iur.importer.ImportManager;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.ade.iur.schema.SchemaMapper;
import org.citydb.core.ade.importer.CityGMLImportHelper;
import org.citydb.core.ade.importer.ForeignKeys;
import org.citydb.core.database.schema.mapping.AbstractObjectType;
import org.citydb.core.operation.importer.CityGMLImportException;
import org.citydb.core.operation.importer.util.AttributeValueJoiner;
import org.citygml4j.ade.iur.model.urf.AbstractMiniFunction;
import org.citygml4j.ade.iur.model.urf.TargetProperty;
import org.citygml4j.model.citygml.core.AbstractCityObject;
import org.citygml4j.model.gml.basicTypes.Code;
import org.citygml4j.model.gml.geometry.aggregates.MultiSurfaceProperty;

import java.sql.*;

public class AbstractMiniFunctionImporter implements UrbanFunctionModuleImporter {
    private final CityGMLImportHelper helper;
    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;
    private final AbstractMiniFunctionToCityObjectImporter abstractMiniFunctionToCityObjectImporter;
    private final AttributeValueJoiner valueJoiner;

    private int batchCounter;

    public AbstractMiniFunctionImporter(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {
        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();

        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.ABSTRACTMINIFUNCTION)) + " " +
                "(id, objectclass_id, function, function_codespace, validfrom, lod1multisurface_id) " +
                "values (?, ?, ?, ?, ?, ?)");

        abstractMiniFunctionToCityObjectImporter = manager.getImporter(AbstractMiniFunctionToCityObjectImporter.class);
        valueJoiner = helper.getAttributeValueJoiner();
    }

    public void doImport(AbstractMiniFunction abstractMiniFunction, long objectId, AbstractObjectType<?> objectType, ForeignKeys foreignKeys) throws CityGMLImportException, SQLException {
        ps.setLong(1, objectId);
        ps.setInt(2, objectType.getObjectClassId());

        if (!abstractMiniFunction.getFunction().isEmpty()) {
            valueJoiner.join(abstractMiniFunction.getFunction(), Code::getValue, Code::getCodeSpace);
            ps.setString(3, valueJoiner.result(0));
            ps.setString(4, valueJoiner.result(1));
        } else {
            ps.setNull(3, Types.VARCHAR);
            ps.setNull(4, Types.VARCHAR);
        }

        if (abstractMiniFunction.getValidFrom() != null)
            ps.setDate(5, Date.valueOf(abstractMiniFunction.getValidFrom()));
        else
            ps.setNull(5, Types.DATE);

        long lod1MultiSurfaceId = 0;
        if (abstractMiniFunction.getLod1MultiSurface() != null) {
            MultiSurfaceProperty property = abstractMiniFunction.getLod1MultiSurface();
            if (property.isSetMultiSurface()) {
                lod1MultiSurfaceId = helper.importSurfaceGeometry(property.getMultiSurface(), objectId);
                property.unsetMultiSurface();
            } else {
                String href = property.getHref();
                if (href != null && !href.isEmpty())
                    helper.propagateSurfaceGeometryXlink(href, schemaMapper.getTableName(ADETable.ABSTRACTMINIFUNCTION), objectId, "lod1multisurface_id");
            }
        }

        if (lod1MultiSurfaceId != 0)
            ps.setLong(6, lod1MultiSurfaceId);
        else
            ps.setNull(6, Types.NULL);

        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(objectType);

        for (TargetProperty property : abstractMiniFunction.getTarget()) {
            AbstractCityObject cityObject = property.getObject();
            if (cityObject != null) {
                long cityObjectId = helper.importObject(cityObject);
                property.unsetObject();
                abstractMiniFunctionToCityObjectImporter.doImport(cityObjectId, objectId);
            } else {
                String href = property.getHref();
                if (href != null && !href.isEmpty())
                    helper.propagateObjectXlink(schemaMapper.getTableName(ADETable.ABSTRACTM_TO_CITYOBJEC), objectId, "abstractminifunction_id", href, "cityobject_id");
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
