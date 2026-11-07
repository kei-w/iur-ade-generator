/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.uro;

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.model.gml.feature.FeatureProperty;

public class MiniPartProperty extends FeatureProperty<MiniPart> implements ADEModelObject {

    public MiniPartProperty() {
        super();
    }

    public MiniPartProperty(MiniPart object) {
        super(object);
    }

    public MiniPartProperty(String href) {
        super(href);
    }

    @Override
    public Class<MiniPart> getAssociableClass() {
        return MiniPart.class;
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new MiniPartProperty(), copyBuilder);
    }

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        MiniPartProperty copy = (target == null) ? new MiniPartProperty() : (MiniPartProperty) target;
        return super.copyTo(copy, copyBuilder);
    }
}
