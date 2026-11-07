/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.uro;

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.model.gml.base.AssociationByRep;

public class ExtraAttributeProperty extends AssociationByRep<ExtraAttribute> implements ADEModelObject {

    public ExtraAttributeProperty() {
        super();
    }

    public ExtraAttributeProperty(ExtraAttribute object) {
        super(object);
    }

    @Override
    public Class<ExtraAttribute> getAssociableClass() {
        return ExtraAttribute.class;
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new ExtraAttributeProperty(), copyBuilder);
    }

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        ExtraAttributeProperty copy = (target == null) ? new ExtraAttributeProperty() : (ExtraAttributeProperty) target;
        return super.copyTo(copy, copyBuilder);
    }
}
