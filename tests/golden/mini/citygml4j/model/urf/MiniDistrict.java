/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.urf;

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.builder.copy.ObjectCopier;

public class MiniDistrict extends AbstractMiniFunction {
    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        MiniDistrict copy = target == null ? new MiniDistrict() : (MiniDistrict) target;
        super.copyTo(copy, copyBuilder);
        return ObjectCopier.copyTo(this, copy, copyBuilder);
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new MiniDistrict(), copyBuilder);
    }
}
