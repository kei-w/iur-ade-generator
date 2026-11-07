/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.uro;

import org.citygml4j.ade.iur.model.common.AbstractDataType;
import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.builder.copy.ObjectCopier;
import org.citygml4j.model.common.base.ModelObjects;
import org.citygml4j.model.common.child.ChildList;
import org.citygml4j.model.gml.basicTypes.Code;
import org.citygml4j.model.gml.basicTypes.Measure;
import org.citygml4j.model.gml.geometry.aggregates.MultiSurfaceProperty;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DetailAttribute extends AbstractDataType {
    private String name;
    private Integer count;
    private Measure area;
    private Code kind;
    private LocalDate date;
    private List<String> tags;
    private ColorValue color;
    private String grade;
    private MultiSurfaceProperty geometry;
    private ExtraAttributeProperty extra;
    private List<NoteAttributeProperty> notes;
    private BaseAttributeProperty base;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Measure getArea() {
        return area;
    }

    public void setArea(Measure area) {
        this.area = ModelObjects.setParent(area, this);
    }

    public Code getKind() {
        return kind;
    }

    public void setKind(Code kind) {
        this.kind = ModelObjects.setParent(kind, this);
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public List<String> getTags() {
        if (tags == null)
            tags = new ArrayList<>();

        return tags;
    }

    public void setTags(List<String> tags) {
        this.tags = tags;
    }

    public ColorValue getColor() {
        return color;
    }

    public void setColor(ColorValue color) {
        this.color = color;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public MultiSurfaceProperty getGeometry() {
        return geometry;
    }

    public void setGeometry(MultiSurfaceProperty geometry) {
        this.geometry = ModelObjects.setParent(geometry, this);
    }

    public ExtraAttributeProperty getExtra() {
        return extra;
    }

    public void setExtra(ExtraAttributeProperty extra) {
        this.extra = ModelObjects.setParent(extra, this);
    }

    public List<NoteAttributeProperty> getNotes() {
        if (notes == null)
            notes = new ChildList<>(this);

        return notes;
    }

    public void setNotes(List<NoteAttributeProperty> notes) {
        this.notes = ModelObjects.setParent(notes, this);
    }

    public BaseAttributeProperty getBase() {
        return base;
    }

    public void setBase(BaseAttributeProperty base) {
        this.base = ModelObjects.setParent(base, this);
    }

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        DetailAttribute copy = target == null ? new DetailAttribute() : (DetailAttribute) target;
        return ObjectCopier.copyTo(this, copy, copyBuilder);
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new DetailAttribute(), copyBuilder);
    }
}
