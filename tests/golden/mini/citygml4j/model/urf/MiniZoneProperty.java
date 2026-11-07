/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.urf;

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.model.gml.feature.FeatureProperty;

public class MiniZoneProperty extends FeatureProperty<MiniZone> implements ADEModelObject {

    public MiniZoneProperty() {
        super();
    }

    public MiniZoneProperty(MiniZone object) {
        super(object);
    }

    public MiniZoneProperty(String href) {
        super(href);
    }

    @Override
    public Class<MiniZone> getAssociableClass() {
        return MiniZone.class;
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new MiniZoneProperty(), copyBuilder);
    }

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        MiniZoneProperty copy = (target == null) ? new MiniZoneProperty() : (MiniZoneProperty) target;
        return super.copyTo(copy, copyBuilder);
    }
}
