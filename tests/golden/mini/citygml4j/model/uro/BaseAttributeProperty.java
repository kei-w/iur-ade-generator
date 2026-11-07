/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.uro;

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.model.gml.base.AssociationByRep;

public class BaseAttributeProperty extends AssociationByRep<AbstractBaseAttribute> implements ADEModelObject {

    public BaseAttributeProperty() {
        super();
    }

    public BaseAttributeProperty(AbstractBaseAttribute object) {
        super(object);
    }

    @Override
    public Class<AbstractBaseAttribute> getAssociableClass() {
        return AbstractBaseAttribute.class;
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new BaseAttributeProperty(), copyBuilder);
    }

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        BaseAttributeProperty copy = (target == null) ? new BaseAttributeProperty() : (BaseAttributeProperty) target;
        return super.copyTo(copy, copyBuilder);
    }
}
