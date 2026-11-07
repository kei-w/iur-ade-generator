/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.bind.uro;

import jp.geospatial.iur._9_9.uro.*;
import org.citygml4j.ade.iur.bind.Marshaller;
import org.citygml4j.ade.iur.model.uro.*;
import org.citygml4j.builder.jaxb.marshal.citygml.ade.ADEMarshallerHelper;
import org.citygml4j.model.citygml.ade.binding.ADEMarshaller;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.util.mapper.TypeMapper;
import org.w3._1999.xlink.ActuateType;
import org.w3._1999.xlink.ShowType;
import org.w3._1999.xlink.TypeType;

import java.math.BigInteger;
import javax.xml.bind.JAXBElement;

public class UrbanObjectMarshaller implements ADEMarshaller {
    private final Marshaller marshaller;
    private final ObjectFactory factory = new ObjectFactory();
    private ADEMarshallerHelper helper;
    private TypeMapper<JAXBElement<?>> elementMapper;
    private TypeMapper<Object> typeMapper;

    public UrbanObjectMarshaller(Marshaller marshaller) {
        this.marshaller = marshaller;
    }

    private synchronized TypeMapper<JAXBElement<?>> getElementMapper() {
        if (elementMapper == null) {
            elementMapper = TypeMapper.<JAXBElement<?>>create()
                    .with(DetailAttribute.class, this::createDetailAttribute)
                    .with(ExtraAttribute.class, this::createExtraAttribute)
                    .with(NoteAttribute.class, this::createNoteAttribute)
                    .with(SubAttribute.class, this::createSubAttribute)
                    .with(MiniFeature.class, this::createMiniFeature)
                    .with(MiniPart.class, this::createMiniPart)
                    .with(MiniDetailAttributePropertyElement.class, this::createMiniDetailAttributePropertyElement)
                    .with(MiniNoteAttributePropertyElement.class, this::createMiniNoteAttributePropertyElement);
        }

        return elementMapper;
    }

    private synchronized TypeMapper<Object> getTypeMapper() {
        if (typeMapper == null) {
            typeMapper = TypeMapper.create()
                    .with(DetailAttribute.class, this::marshalDetailAttribute)
                    .with(DetailAttributeProperty.class, this::marshalDetailAttributeProperty)
                    .with(ExtraAttribute.class, this::marshalExtraAttribute)
                    .with(ExtraAttributeProperty.class, this::marshalExtraAttributeProperty)
                    .with(NoteAttribute.class, this::marshalNoteAttribute)
                    .with(NoteAttributeProperty.class, this::marshalNoteAttributeProperty)
                    .with(SubAttribute.class, this::marshalSubAttribute)
                    .with(BaseAttributeProperty.class, this::marshalBaseAttributeProperty)
                    .with(MiniFeature.class, this::marshalMiniFeature)
                    .with(MiniPart.class, this::marshalMiniPart)
                    .with(MiniPartProperty.class, this::marshalMiniPartProperty);
        }

        return typeMapper;
    }

    @Override
    public void setADEMarshallerHelper(ADEMarshallerHelper helper) {
        this.helper = helper;
    }

    @Override
    public JAXBElement<?> marshalJAXBElement(ADEModelObject src) {
        TypeMapper<JAXBElement<?>> elementMapper = getElementMapper();
        return elementMapper != null ? elementMapper.apply(src) : null;
    }

    @Override
    public Object marshal(ADEModelObject src) {
        TypeMapper<Object> typeMapper = getTypeMapper();
        return typeMapper != null ? typeMapper.apply(src) : null;
    }

    private DetailAttributeType marshalDetailAttribute(DetailAttribute src) {
        DetailAttributeType dest = factory.createDetailAttributeType();

        dest.setName(src.getName());

        if (src.getCount() != null)
            dest.setCount(BigInteger.valueOf(src.getCount()));

        if (src.getArea() != null)
            dest.setArea(helper.getGMLMarshaller().marshalMeasure(src.getArea()));

        if (src.getKind() != null)
            dest.setKind(helper.getGMLMarshaller().marshalCode(src.getKind()));

        if (src.getDate() != null)
            dest.setDate(marshaller.toCalendar(src.getDate()));

        for (String tags : src.getTags())
            dest.getTags().add(tags);

        if (src.getColor() != null)
            dest.setColor(jp.geospatial.iur._9_9.uro.ColorValue.fromValue(src.getColor().value()));

        dest.setGrade(src.getGrade());

        if (src.getGeometry() != null)
            dest.setGeometry(helper.getGMLMarshaller().marshalMultiSurfaceProperty(src.getGeometry()));

        if (src.getExtra() != null)
            dest.setExtra(marshalExtraAttributeProperty(src.getExtra()));

        for (NoteAttributeProperty notes : src.getNotes())
            dest.getNotes().add(marshalNoteAttributeProperty(notes));

        if (src.getBase() != null)
            dest.setBase(marshalBaseAttributeProperty(src.getBase()));

        return dest;
    }

    private DetailAttributePropertyType marshalDetailAttributeProperty(DetailAttributeProperty src) {
        DetailAttributePropertyType dest = factory.createDetailAttributePropertyType();

        if (src.isSetObject())
            dest.setDetailAttribute(marshalDetailAttribute(src.getObject()));

        return dest;
    }

    private ExtraAttributeType marshalExtraAttribute(ExtraAttribute src) {
        ExtraAttributeType dest = factory.createExtraAttributeType();

        dest.setValue(src.getValue());

        return dest;
    }

    private ExtraAttributePropertyType marshalExtraAttributeProperty(ExtraAttributeProperty src) {
        ExtraAttributePropertyType dest = factory.createExtraAttributePropertyType();

        if (src.isSetObject())
            dest.setExtraAttribute(marshalExtraAttribute(src.getObject()));

        return dest;
    }

    private NoteAttributeType marshalNoteAttribute(NoteAttribute src) {
        NoteAttributeType dest = factory.createNoteAttributeType();

        dest.setText(src.getText());

        return dest;
    }

    private NoteAttributePropertyType marshalNoteAttributeProperty(NoteAttributeProperty src) {
        NoteAttributePropertyType dest = factory.createNoteAttributePropertyType();

        if (src.isSetObject())
            dest.setNoteAttribute(marshalNoteAttribute(src.getObject()));

        return dest;
    }

    private void marshalAbstractBaseAttribute(AbstractBaseAttribute src, AbstractBaseAttributeType dest) {
        dest.setBaseField(src.getBaseField());
    }

    private SubAttributeType marshalSubAttribute(SubAttribute src) {
        SubAttributeType dest = factory.createSubAttributeType();
        marshalAbstractBaseAttribute(src, dest);

        if (src.getSubField() != null)
            dest.setSubField(BigInteger.valueOf(src.getSubField()));

        return dest;
    }

    private BaseAttributePropertyType marshalBaseAttributeProperty(BaseAttributeProperty src) {
        BaseAttributePropertyType dest = factory.createBaseAttributePropertyType();

        if (src.getObject() != null) {
            JAXBElement<?> elem = helper.getJAXBMarshaller().marshalJAXBElement(src.getObject());
            if (elem != null && elem.getValue() instanceof AbstractBaseAttributeType)
                dest.setBaseAttribute((JAXBElement<? extends AbstractBaseAttributeType>) elem);
        }

        return dest;
    }

    private MiniFeatureType marshalMiniFeature(MiniFeature src) {
        MiniFeatureType dest = factory.createMiniFeatureType();
        helper.getCore200Marshaller().marshalAbstractCityObject(src, dest);

        dest.setLabel(src.getLabel());

        if (src.getLod1MultiSurface() != null)
            dest.setLod1MultiSurface(helper.getGMLMarshaller().marshalMultiSurfaceProperty(src.getLod1MultiSurface()));

        if (src.getDetail() != null)
            dest.setDetail(marshalDetailAttributeProperty(src.getDetail()));

        for (MiniPartProperty part : src.getPart())
            dest.getPart().add(marshalMiniPartProperty(part));

        return dest;
    }

    private MiniPartType marshalMiniPart(MiniPart src) {
        MiniPartType dest = factory.createMiniPartType();
        helper.getCore200Marshaller().marshalAbstractCityObject(src, dest);

        dest.setPartName(src.getPartName());

        return dest;
    }

    private MiniPartPropertyType marshalMiniPartProperty(MiniPartProperty src) {
        MiniPartPropertyType dest = factory.createMiniPartPropertyType();

        if (src.isSetObject())
            dest.setMiniPart(marshalMiniPart(src.getObject()));

        dest.setRemoteSchema(src.getRemoteSchema());

        if (src.isSetType())
            dest.setType(TypeType.fromValue(src.getType().getValue()));

        dest.setHref(src.getHref());
        dest.setRole(src.getRole());
        dest.setArcrole(src.getArcrole());
        dest.setTitle(src.getTitle());

        if (src.isSetShow())
            dest.setShow(ShowType.fromValue(src.getShow().getValue()));

        if (src.isSetActuate())
            dest.setActuate(ActuateType.fromValue(src.getActuate().getValue()));

        return dest;
    }

    private JAXBElement<?> createDetailAttribute(DetailAttribute src) {
        return factory.createDetailAttribute(marshalDetailAttribute(src));
    }

    private JAXBElement<?> createExtraAttribute(ExtraAttribute src) {
        return factory.createExtraAttribute(marshalExtraAttribute(src));
    }

    private JAXBElement<?> createNoteAttribute(NoteAttribute src) {
        return factory.createNoteAttribute(marshalNoteAttribute(src));
    }

    private JAXBElement<?> createSubAttribute(SubAttribute src) {
        return factory.createSubAttribute(marshalSubAttribute(src));
    }

    private JAXBElement<?> createMiniFeature(MiniFeature src) {
        return factory.createMiniFeature(marshalMiniFeature(src));
    }

    private JAXBElement<?> createMiniPart(MiniPart src) {
        return factory.createMiniPart(marshalMiniPart(src));
    }

    private JAXBElement<?> createMiniDetailAttributePropertyElement(MiniDetailAttributePropertyElement src) {
        return factory.createMiniDetailAttribute(marshalDetailAttributeProperty(src.getValue()));
    }

    private JAXBElement<?> createMiniNoteAttributePropertyElement(MiniNoteAttributePropertyElement src) {
        return factory.createMiniNoteAttribute(marshalNoteAttributeProperty(src.getValue()));
    }
}
