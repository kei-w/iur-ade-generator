/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.urf;

import org.citygml4j.ade.iur.model.uro.DetailAttributeProperty;
import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.builder.copy.ObjectCopier;
import org.citygml4j.model.common.base.ModelObjects;
import org.citygml4j.model.common.child.ChildList;
import org.citygml4j.model.gml.basicTypes.Measure;

import java.util.List;

public class MiniZone extends AbstractMiniFunction {
    private Measure areaInHa;
    private List<MiniZoneProperty> relatedZone;
    private DetailAttributeProperty detail;

    public Measure getAreaInHa() {
        return areaInHa;
    }

    public void setAreaInHa(Measure areaInHa) {
        this.areaInHa = ModelObjects.setParent(areaInHa, this);
    }

    public List<MiniZoneProperty> getRelatedZone() {
        if (relatedZone == null)
            relatedZone = new ChildList<>(this);

        return relatedZone;
    }

    public void setRelatedZone(List<MiniZoneProperty> relatedZone) {
        this.relatedZone = ModelObjects.setParent(relatedZone, this);
    }

    public DetailAttributeProperty getDetail() {
        return detail;
    }

    public void setDetail(DetailAttributeProperty detail) {
        this.detail = ModelObjects.setParent(detail, this);
    }

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        MiniZone copy = target == null ? new MiniZone() : (MiniZone) target;
        super.copyTo(copy, copyBuilder);
        return ObjectCopier.copyTo(this, copy, copyBuilder);
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new MiniZone(), copyBuilder);
    }
}
