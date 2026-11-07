/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.uro;

import org.citygml4j.ade.iur.model.common.AbstractDataType;
import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.builder.copy.ObjectCopier;

public abstract class AbstractBaseAttribute extends AbstractDataType {
    private String baseField;

    public String getBaseField() {
        return baseField;
    }

    public void setBaseField(String baseField) {
        this.baseField = baseField;
    }

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        if (target == null)
            throw new IllegalArgumentException("Target argument must not be null for abstract copyable classes.");

        AbstractBaseAttribute copy = (AbstractBaseAttribute) target;
        return ObjectCopier.copyTo(this, copy, AbstractBaseAttribute.class, copyBuilder);
    }
}
