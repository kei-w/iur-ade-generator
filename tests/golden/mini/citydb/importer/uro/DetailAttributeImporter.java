/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.importer.uro;

import org.citydb.ade.iur.importer.ImportManager;
import org.citydb.ade.iur.schema.ADESequence;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.ade.iur.schema.SchemaMapper;
import org.citydb.core.ade.importer.CityGMLImportHelper;
import org.citydb.core.operation.importer.CityGMLImportException;
import org.citydb.core.operation.importer.util.AttributeValueJoiner;
import org.citygml4j.ade.iur.model.uro.DetailAttribute;
import org.citygml4j.ade.iur.model.uro.NoteAttributeProperty;
import org.citygml4j.model.gml.geometry.aggregates.MultiSurfaceProperty;

import java.sql.*;

public class DetailAttributeImporter implements UrbanObjectModuleImporter {
    private final CityGMLImportHelper helper;
    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;
    private final ExtraAttributeImporter extraAttributeImporter;
    private final DetailAttributeToNoteAttributeImporter detailAttributeToNoteAttributeImporter;
    private final NoteAttributeImporter noteAttributeImporter;
    private final SubAttributeImporter subAttributeImporter;
    private final AttributeValueJoiner valueJoiner;

    private int batchCounter;

    public DetailAttributeImporter(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {
        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();

        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.DETAILATTRIBUTE)) + " " +
                "(id, name, count, area, area_uom, kind, kind_codespace, date_, tags, color, grade, geometry_id," +
                "extra_id, base_id) " +
                "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");

        extraAttributeImporter = manager.getImporter(ExtraAttributeImporter.class);
        detailAttributeToNoteAttributeImporter = manager.getImporter(DetailAttributeToNoteAttributeImporter.class);
        noteAttributeImporter = manager.getImporter(NoteAttributeImporter.class);
        subAttributeImporter = manager.getImporter(SubAttributeImporter.class);
        valueJoiner = helper.getAttributeValueJoiner();
    }

    public long doImport(DetailAttribute detailAttribute) throws CityGMLImportException, SQLException {
        long objectId = helper.getNextSequenceValue(schemaMapper.getSequenceName(ADESequence.DETAILATTRIBUTE_SEQ));
        ps.setLong(1, objectId);

        ps.setString(2, detailAttribute.getName());

        if (detailAttribute.getCount() != null)
            ps.setInt(3, detailAttribute.getCount());
        else
            ps.setNull(3, Types.INTEGER);

        if (detailAttribute.getArea() != null && detailAttribute.getArea().isSetValue()) {
            ps.setDouble(4, detailAttribute.getArea().getValue());
            ps.setString(5, detailAttribute.getArea().getUom());
        } else {
            ps.setNull(4, Types.DOUBLE);
            ps.setNull(5, Types.VARCHAR);
        }

        if (detailAttribute.getKind() != null && detailAttribute.getKind().isSetValue()) {
            ps.setString(6, detailAttribute.getKind().getValue());
            ps.setString(7, detailAttribute.getKind().getCodeSpace());
        } else {
            ps.setNull(6, Types.VARCHAR);
            ps.setNull(7, Types.VARCHAR);
        }

        if (detailAttribute.getDate() != null)
            ps.setDate(8, Date.valueOf(detailAttribute.getDate()));
        else
            ps.setNull(8, Types.DATE);

        if (!detailAttribute.getTags().isEmpty())
            ps.setString(9, valueJoiner.join(detailAttribute.getTags()));
        else
            ps.setNull(9, Types.VARCHAR);

        if (detailAttribute.getColor() != null)
            ps.setString(10, detailAttribute.getColor().value());
        else
            ps.setNull(10, Types.VARCHAR);

        ps.setString(11, detailAttribute.getGrade());

        long geometryId = 0;
        if (detailAttribute.getGeometry() != null) {
            MultiSurfaceProperty property = detailAttribute.getGeometry();
            if (property.isSetMultiSurface()) {
                geometryId = helper.importSurfaceGeometry(property.getMultiSurface(), objectId);
                property.unsetMultiSurface();
            } else {
                String href = property.getHref();
                if (href != null && !href.isEmpty())
                    helper.propagateSurfaceGeometryXlink(href, schemaMapper.getTableName(ADETable.DETAILATTRIBUTE), objectId, "geometry_id");
            }
        }

        if (geometryId != 0)
            ps.setLong(12, geometryId);
        else
            ps.setNull(12, Types.NULL);

        long extraId = 0;
        if (detailAttribute.getExtra() != null && detailAttribute.getExtra().isSetObject())
            extraId = extraAttributeImporter.doImport(detailAttribute.getExtra().getObject());

        if (extraId != 0)
            ps.setLong(13, extraId);
        else
            ps.setNull(13, Types.NULL);

        long baseId = 0;
        if (detailAttribute.getBase() != null && detailAttribute.getBase().isSetObject())
            baseId = subAttributeImporter.doImport(detailAttribute.getBase().getObject());

        if (baseId != 0)
            ps.setLong(14, baseId);
        else
            ps.setNull(14, Types.NULL);

        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(schemaMapper.getTableName(ADETable.DETAILATTRIBUTE));

        for (NoteAttributeProperty property : detailAttribute.getNotes()) {
            if (property.isSetObject()) {
                long notesId = noteAttributeImporter.doImport(property.getObject());
                detailAttributeToNoteAttributeImporter.doImport(notesId, objectId);
            }
        }

        return objectId;
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
