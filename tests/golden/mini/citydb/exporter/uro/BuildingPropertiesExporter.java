/*
 * iur-ade-citydb - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citydb.ade.iur.exporter.uro;

import org.citydb.ade.iur.exporter.ExportManager;
import org.citydb.ade.iur.schema.ADETable;
import org.citydb.core.ade.exporter.CityGMLExportHelper;
import org.citydb.core.database.schema.mapping.FeatureType;
import org.citydb.core.operation.exporter.CityGMLExportException;
import org.citydb.core.query.filter.projection.ProjectionFilter;
import org.citydb.sqlbuilder.expression.PlaceHolder;
import org.citydb.sqlbuilder.schema.Table;
import org.citydb.sqlbuilder.select.OrderByToken;
import org.citydb.sqlbuilder.select.Select;
import org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory;
import org.citygml4j.ade.iur.model.module.UrbanObjectModule;
import org.citygml4j.ade.iur.model.uro.*;
import org.citygml4j.model.citygml.building.AbstractBuilding;

import java.sql.*;

public class BuildingPropertiesExporter implements UrbanObjectModuleExporter {
    private final PreparedStatement ps;
    private final String module;

    private final DetailAttributeExporter detailAttributeExporter;
    private final NoteAttributeExporter noteAttributeExporter;
    private final PreparedStatement psMiniNoteAttribute;

    public BuildingPropertiesExporter(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {
        String tableName = manager.getSchemaMapper().getTableName(ADETable.BUILDING);
        module = UrbanObjectModule.v9_9.getNamespaceURI();

        Table table = new Table(helper.getTableNameWithSchema(tableName));
        Select select = new Select().addProjection(table.getColumns("minidetailattribute_id"))
                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));
        ps = connection.prepareStatement(select.toString());

        Table miniNoteAttributes = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.BUILDING_TO_NOTEATTRI)));
        Select miniNoteAttributeSelect = new Select().addProjection(miniNoteAttributes.getColumn("noteattribute_id"))
                .addSelection(ComparisonFactory.equalTo(miniNoteAttributes.getColumn("building_id"), new PlaceHolder<>()))
                .addOrderBy(new OrderByToken(miniNoteAttributes.getColumn("noteattribute_id")));
        psMiniNoteAttribute = connection.prepareStatement(miniNoteAttributeSelect.toString());
        detailAttributeExporter = manager.getExporter(DetailAttributeExporter.class);
        noteAttributeExporter = manager.getExporter(NoteAttributeExporter.class);
    }

    public void doExport(AbstractBuilding parent, long parentId, FeatureType parentType, ProjectionFilter projectionFilter) throws CityGMLExportException, SQLException {
        ps.setLong(1, parentId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                long miniDetailAttributeId = rs.getLong("minidetailattribute_id");
                if (miniDetailAttributeId != 0 && projectionFilter.containsProperty("miniDetailAttribute", module)) {
                    DetailAttribute miniDetailAttribute = new DetailAttribute();
                    detailAttributeExporter.doExport(miniDetailAttribute, miniDetailAttributeId);

                    MiniDetailAttributePropertyElement property = new MiniDetailAttributePropertyElement(new DetailAttributeProperty(miniDetailAttribute));
                    parent.addGenericApplicationPropertyOfAbstractBuilding(property);
                }

                if (projectionFilter.containsProperty("miniNoteAttribute", module)) {
                    psMiniNoteAttribute.setLong(1, parentId);
                    try (ResultSet miniNoteAttributeRs = psMiniNoteAttribute.executeQuery()) {
                        while (miniNoteAttributeRs.next()) {
                            NoteAttribute miniNoteAttribute = new NoteAttribute();
                            noteAttributeExporter.doExport(miniNoteAttribute, miniNoteAttributeRs.getLong("noteattribute_id"));

                            MiniNoteAttributePropertyElement property = new MiniNoteAttributePropertyElement(new NoteAttributeProperty(miniNoteAttribute));
                            parent.addGenericApplicationPropertyOfAbstractBuilding(property);
                        }
                    }
                }
            }
        }
    }

    @Override
    public void close() throws CityGMLExportException, SQLException {
        ps.close();
        psMiniNoteAttribute.close();
    }
}
