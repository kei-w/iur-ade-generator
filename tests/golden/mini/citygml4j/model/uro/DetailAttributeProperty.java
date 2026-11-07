/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.uro;

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.model.gml.base.AssociationByRep;

public class DetailAttributeProperty extends AssociationByRep<DetailAttribute> implements ADEModelObject {

    public DetailAttributeProperty() {
        super();
    }

    public DetailAttributeProperty(DetailAttribute object) {
        super(object);
    }

    @Override
    public Class<DetailAttribute> getAssociableClass() {
        return DetailAttribute.class;
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new DetailAttributeProperty(), copyBuilder);
    }

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        DetailAttributeProperty copy = (target == null) ? new DetailAttributeProperty() : (DetailAttributeProperty) target;
        return super.copyTo(copy, copyBuilder);
    }
}
