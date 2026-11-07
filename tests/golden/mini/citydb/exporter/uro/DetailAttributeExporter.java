/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.exporter.uro;

import org.citydb.ade.iur.exporter.ExportManager;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.config.geometry.GeometryObject;
import org.citydb.core.ade.exporter.CityGMLExportHelper;
import org.citydb.core.operation.exporter.CityGMLExportException;
import org.citydb.core.operation.exporter.database.content.GMLConverter;
import org.citydb.core.operation.exporter.database.content.SurfaceGeometryExporter;
import org.citydb.core.operation.exporter.util.AttributeValueSplitter;
import org.citydb.core.operation.exporter.util.GeometrySetter;
import org.citydb.core.operation.exporter.util.SplitValue;
import org.citydb.sqlbuilder.expression.PlaceHolder;
import org.citydb.sqlbuilder.schema.Table;
import org.citydb.sqlbuilder.select.OrderByToken;
import org.citydb.sqlbuilder.select.Select;
import org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory;
import org.citygml4j.ade.iur.model.uro.AbstractBaseAttribute;
import org.citygml4j.ade.iur.model.uro.BaseAttributeProperty;
import org.citygml4j.ade.iur.model.uro.ColorValue;
import org.citygml4j.ade.iur.model.uro.DetailAttribute;
import org.citygml4j.ade.iur.model.uro.ExtraAttribute;
import org.citygml4j.ade.iur.model.uro.ExtraAttributeProperty;
import org.citygml4j.ade.iur.model.uro.NoteAttribute;
import org.citygml4j.ade.iur.model.uro.NoteAttributeProperty;
import org.citygml4j.model.gml.basicTypes.Code;
import org.citygml4j.model.gml.basicTypes.Measure;

import java.sql.*;

public class DetailAttributeExporter implements UrbanObjectModuleExporter {
    private final CityGMLExportHelper helper;
    private final PreparedStatement psNotes;
    private final PreparedStatement ps;
    private final ExtraAttributeExporter extraAttributeExporter;
    private final NoteAttributeExporter noteAttributeExporter;
    private final SubAttributeExporter subAttributeExporter;
    private final AttributeValueSplitter valueSplitter;
    private final SurfaceGeometryExporter surfaceGeometryExporter;
    private final GMLConverter gmlConverter;

    public DetailAttributeExporter(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {
        this.helper = helper;
        String tableName = manager.getSchemaMapper().getTableName(ADETable.DETAILATTRIBUTE);

        Table table = new Table(helper.getTableNameWithSchema(tableName));
        Table notess = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.DETAILATT_TO_NOTEATTRI)));
        Select notesSelect = new Select().addProjection(notess.getColumn("noteattribute_id"))
                .addSelection(ComparisonFactory.equalTo(notess.getColumn("detailattribute_id"), new PlaceHolder<>()))
                .addOrderBy(new OrderByToken(notess.getColumn("noteattribute_id")));
        psNotes = connection.prepareStatement(notesSelect.toString());
        Select select = new Select().addProjection(table.getColumns("name", "count", "area", "area_uom", "kind", "kind_codespace", "date_", "tags", "color", "grade",
                        "geometry_id", "extra_id", "base_id"))
                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));
        ps = connection.prepareStatement(select.toString());

        extraAttributeExporter = manager.getExporter(ExtraAttributeExporter.class);
        noteAttributeExporter = manager.getExporter(NoteAttributeExporter.class);
        subAttributeExporter = manager.getExporter(SubAttributeExporter.class);
        valueSplitter = helper.getAttributeValueSplitter();
        surfaceGeometryExporter = helper.getSurfaceGeometryExporter();
        gmlConverter = helper.getGMLConverter();
    }

    public void doExport(DetailAttribute detailAttribute, long objectId) throws CityGMLExportException, SQLException {
        ps.setLong(1, objectId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                detailAttribute.setName(rs.getString("name"));

                int count = rs.getInt("count");
                if (!rs.wasNull())
                    detailAttribute.setCount(count);

                double area = rs.getDouble("area");
                if (!rs.wasNull()) {
                    Measure measure = new Measure(area);
                    measure.setUom(rs.getString("area_uom"));
                    detailAttribute.setArea(measure);
                }

                String kind = rs.getString("kind");
                if (!rs.wasNull()) {
                    Code code = new Code(kind);
                    code.setCodeSpace(rs.getString("kind_codespace"));
                    detailAttribute.setKind(code);
                }

                Date date = rs.getDate("date_");
                if (!rs.wasNull())
                    detailAttribute.setDate(date.toLocalDate());

                for (SplitValue splitValue : valueSplitter.split(rs.getString("tags")))
                    detailAttribute.getTags().add(splitValue.result(0));

                String color = rs.getString("color");
                if (!rs.wasNull())
                    detailAttribute.setColor(ColorValue.fromValue(color));

                detailAttribute.setGrade(rs.getString("grade"));

                long geometryId = rs.getLong("geometry_id");
                if (!rs.wasNull())
                    surfaceGeometryExporter.addBatch(geometryId, detailAttribute::setGeometry);

                long extraId = rs.getLong("extra_id");
                if (extraId != 0) {
                    ExtraAttribute extra = new ExtraAttribute();
                    extraAttributeExporter.doExport(extra, extraId);
                    detailAttribute.setExtra(new ExtraAttributeProperty(extra));
                }

                psNotes.setLong(1, objectId);
                try (ResultSet notesRs = psNotes.executeQuery()) {
                    while (notesRs.next()) {
                        NoteAttribute notes = new NoteAttribute();
                        noteAttributeExporter.doExport(notes, notesRs.getLong("noteattribute_id"));
                        detailAttribute.getNotes().add(new NoteAttributeProperty(notes));
                    }
                }

                long baseId = rs.getLong("base_id");
                if (baseId != 0) {
                    AbstractBaseAttribute base = subAttributeExporter.doExport(baseId);
                    if (base != null)
                        detailAttribute.setBase(new BaseAttributeProperty(base));
                }
            }
        }
    }

    @Override
    public void close() throws CityGMLExportException, SQLException {
        ps.close();
        psNotes.close();

    }
}
