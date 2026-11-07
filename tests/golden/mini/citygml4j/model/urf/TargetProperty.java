/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.urf;

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.model.citygml.core.AbstractCityObject;
import org.citygml4j.model.gml.feature.FeatureProperty;

public class TargetProperty extends FeatureProperty<AbstractCityObject> implements ADEModelObject {

    public TargetProperty() {
        super();
    }

    public TargetProperty(AbstractCityObject object) {
        super(object);
    }

    public TargetProperty(String href) {
        super(href);
    }

    @Override
    public Class<AbstractCityObject> getAssociableClass() {
        return AbstractCityObject.class;
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new TargetProperty(), copyBuilder);
    }

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        TargetProperty copy = (target == null) ? new TargetProperty() : (TargetProperty) target;
        return super.copyTo(copy, copyBuilder);
    }
}
