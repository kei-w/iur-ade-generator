/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.model.uro;

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.model.gml.base.AssociationByRep;

public class NoteAttributeProperty extends AssociationByRep<NoteAttribute> implements ADEModelObject {

    public NoteAttributeProperty() {
        super();
    }

    public NoteAttributeProperty(NoteAttribute object) {
        super(object);
    }

    @Override
    public Class<NoteAttribute> getAssociableClass() {
        return NoteAttribute.class;
    }

    @Override
    public Object copy(CopyBuilder copyBuilder) {
        return copyTo(new NoteAttributeProperty(), copyBuilder);
    }

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {
        NoteAttributeProperty copy = (target == null) ? new NoteAttributeProperty() : (NoteAttributeProperty) target;
        return super.copyTo(copy, copyBuilder);
    }
}
