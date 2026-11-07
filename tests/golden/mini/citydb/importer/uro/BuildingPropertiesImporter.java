/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.importer.uro;

import org.citydb.ade.iur.importer.ImportManager;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.ade.iur.schema.SchemaMapper;
import org.citydb.core.ade.importer.ADEPropertyCollection;
import org.citydb.core.ade.importer.CityGMLImportHelper;
import org.citydb.core.database.schema.mapping.FeatureType;
import org.citydb.core.operation.importer.CityGMLImportException;
import org.citygml4j.ade.iur.model.uro.*;
import org.citygml4j.model.citygml.building.AbstractBuilding;

import java.sql.*;

public class BuildingPropertiesImporter implements UrbanObjectModuleImporter {
    private final CityGMLImportHelper helper;
    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;

    private final DetailAttributeImporter detailAttributeImporter;
    private final NoteAttributeImporter noteAttributeImporter;
    private final BuildingToNoteAttributeImporter buildingToNoteAttributeImporter;

    private int batchCounter;

    public BuildingPropertiesImporter(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {
        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();

        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.BUILDING)) + " " +
                "(id, minidetailattribute_id) " +
                "values (?, ?)");

        detailAttributeImporter = manager.getImporter(DetailAttributeImporter.class);
        noteAttributeImporter = manager.getImporter(NoteAttributeImporter.class);
        buildingToNoteAttributeImporter = manager.getImporter(BuildingToNoteAttributeImporter.class);
    }

    public void doImport(ADEPropertyCollection properties, AbstractBuilding parent, long parentId, FeatureType parentType) throws CityGMLImportException, SQLException {
        ps.setLong(1, parentId);

        long miniDetailAttributeId = 0;
        if (properties.contains(MiniDetailAttributePropertyElement.class)) {
            MiniDetailAttributePropertyElement property = properties.getFirst(MiniDetailAttributePropertyElement.class);
            if (property.isSetValue() && property.getValue().isSetObject()) {
                miniDetailAttributeId = detailAttributeImporter.doImport(property.getValue().getObject());
                property.setValue(null);
            }
        }

        if (miniDetailAttributeId != 0)
            ps.setLong(2, miniDetailAttributeId);
        else
            ps.setNull(2, Types.NULL);

        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(schemaMapper.getTableName(ADETable.BUILDING));

        if (properties.contains(MiniNoteAttributePropertyElement.class)) {
            for (MiniNoteAttributePropertyElement property : properties.getAll(MiniNoteAttributePropertyElement.class)) {
                if (property.isSetValue() && property.getValue().isSetObject()) {
                    long miniNoteAttributeId = noteAttributeImporter.doImport(property.getValue().getObject());
                    buildingToNoteAttributeImporter.doImport(miniNoteAttributeId, parentId);
                }
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
