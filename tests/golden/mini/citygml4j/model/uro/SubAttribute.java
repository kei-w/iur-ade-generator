/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.uro;

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.builder.copy.ObjectCopier;

public class SubAttribute extends AbstractBaseAttribute {
    private Integer subField;

    public Integer getSubField() {
        return subField;
    }

    public void setSubField(Integer subField) {
        this.subField = subField;
    }

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        SubAttribute copy = target == null ? new SubAttribute() : (SubAttribute) target;
        super.copyTo(copy, copyBuilder);
        return ObjectCopier.copyTo(this, copy, copyBuilder);
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new SubAttribute(), copyBuilder);
    }
}
