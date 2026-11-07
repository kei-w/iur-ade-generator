/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.uro;

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.model.citygml.ade.binding.ADEGenericApplicationProperty;

public class MiniDetailAttributePropertyElement extends ADEGenericApplicationProperty<DetailAttributeProperty> {

    public MiniDetailAttributePropertyElement() {
        super();
    }

    public MiniDetailAttributePropertyElement(DetailAttributeProperty value) {
        super(value);
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new MiniDetailAttributePropertyElement(), copyBuilder);
    }
}
