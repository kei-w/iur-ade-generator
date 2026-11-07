/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.bind.uro;

import jp.geospatial.iur._9_9.uro.*;
import org.citygml4j.ade.iur.model.uro.*;
import org.citygml4j.builder.jaxb.unmarshal.citygml.ade.ADEUnmarshallerHelper;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.model.citygml.ade.binding.ADEUnmarshaller;
import org.citygml4j.model.common.base.ModelObject;
import org.citygml4j.model.gml.xlink.XLinkActuate;
import org.citygml4j.model.gml.xlink.XLinkShow;
import org.citygml4j.model.gml.xlink.XLinkType;
import org.citygml4j.util.mapper.CheckedTypeMapper;
import org.citygml4j.xml.io.reader.MissingADESchemaException;

import javax.xml.bind.JAXBElement;

public class UrbanObjectUnmarshaller implements ADEUnmarshaller {
    private ADEUnmarshallerHelper helper;
    private CheckedTypeMapper<ADEModelObject> typeMapper;

    private synchronized CheckedTypeMapper<ADEModelObject> getTypeMapper() {
        if (typeMapper == null) {
            typeMapper = CheckedTypeMapper.<ADEModelObject>create()
                    .with(DetailAttributeType.class, this::unmarshalDetailAttribute)
                    .with(DetailAttributePropertyType.class, this::unmarshalDetailAttributeProperty)
                    .with(ExtraAttributeType.class, this::unmarshalExtraAttribute)
                    .with(ExtraAttributePropertyType.class, this::unmarshalExtraAttributeProperty)
                    .with(NoteAttributeType.class, this::unmarshalNoteAttribute)
                    .with(NoteAttributePropertyType.class, this::unmarshalNoteAttributeProperty)
                    .with(SubAttributeType.class, this::unmarshalSubAttribute)
                    .with(BaseAttributePropertyType.class, this::unmarshalBaseAttributeProperty)
                    .with(MiniFeatureType.class, this::unmarshalMiniFeature)
                    .with(MiniPartType.class, this::unmarshalMiniPart)
                    .with(MiniPartPropertyType.class, this::unmarshalMiniPartProperty);
        }

        return typeMapper;
    }

    @Override
    public void setADEUnmarshallerHelper(ADEUnmarshallerHelper helper) {
        this.helper = helper;
    }

    @Override
    public ADEModelObject unmarshal(JAXBElement<?> src) throws MissingADESchemaException {
        final Object value = src.getValue();

        // generic application properties
        switch (src.getName().getLocalPart()) {
            case "miniDetailAttribute":
                return new MiniDetailAttributePropertyElement(unmarshalDetailAttributeProperty((DetailAttributePropertyType) value));
            case "miniNoteAttribute":
                return new MiniNoteAttributePropertyElement(unmarshalNoteAttributeProperty((NoteAttributePropertyType) value));
        }

        // all other types
        return unmarshal(value);
    }

    @Override
    public ADEModelObject unmarshal(Object src) throws MissingADESchemaException {
        CheckedTypeMapper<ADEModelObject> typeMapper = getTypeMapper();
        return typeMapper != null ? typeMapper.apply(src) : null;
    }

    private DetailAttribute unmarshalDetailAttribute(DetailAttributeType src) throws MissingADESchemaException {
        DetailAttribute dest = new DetailAttribute();

        dest.setName(src.getName());

        if (src.isSetCount())
            dest.setCount(src.getCount().intValue());

        if (src.isSetArea())
            dest.setArea(helper.getGMLUnmarshaller().unmarshalMeasure(src.getArea()));

        if (src.isSetKind())
            dest.setKind(helper.getGMLUnmarshaller().unmarshalCode(src.getKind()));

        if (src.isSetDate())
            dest.setDate(src.getDate().toGregorianCalendar().toZonedDateTime().toLocalDate());

        if (src.isSetTags()) {
            for (String tags : src.getTags())
                dest.getTags().add(tags);
        }

        if (src.isSetColor())
            dest.setColor(org.citygml4j.ade.iur.model.uro.ColorValue.fromValue(src.getColor().value()));

        dest.setGrade(src.getGrade());

        if (src.isSetGeometry())
            dest.setGeometry(helper.getGMLUnmarshaller().unmarshalMultiSurfaceProperty(src.getGeometry()));

        if (src.isSetExtra())
            dest.setExtra(unmarshalExtraAttributeProperty(src.getExtra()));

        if (src.isSetNotes()) {
            for (NoteAttributePropertyType notes : src.getNotes())
                dest.getNotes().add(unmarshalNoteAttributeProperty(notes));
        }

        if (src.isSetBase())
            dest.setBase(unmarshalBaseAttributeProperty(src.getBase()));

        return dest;
    }

    private DetailAttributeProperty unmarshalDetailAttributeProperty(DetailAttributePropertyType src) throws MissingADESchemaException {
        DetailAttributeProperty dest = new DetailAttributeProperty();

        if (src.isSetDetailAttribute())
            dest.setObject(unmarshalDetailAttribute(src.getDetailAttribute()));

        return dest;
    }

    private ExtraAttribute unmarshalExtraAttribute(ExtraAttributeType src) throws MissingADESchemaException {
        ExtraAttribute dest = new ExtraAttribute();

        dest.setValue(src.getValue());

        return dest;
    }

    private ExtraAttributeProperty unmarshalExtraAttributeProperty(ExtraAttributePropertyType src) throws MissingADESchemaException {
        ExtraAttributeProperty dest = new ExtraAttributeProperty();

        if (src.isSetExtraAttribute())
            dest.setObject(unmarshalExtraAttribute(src.getExtraAttribute()));

        return dest;
    }

    private NoteAttribute unmarshalNoteAttribute(NoteAttributeType src) throws MissingADESchemaException {
        NoteAttribute dest = new NoteAttribute();

        dest.setText(src.getText());

        return dest;
    }

    private NoteAttributeProperty unmarshalNoteAttributeProperty(NoteAttributePropertyType src) throws MissingADESchemaException {
        NoteAttributeProperty dest = new NoteAttributeProperty();

        if (src.isSetNoteAttribute())
            dest.setObject(unmarshalNoteAttribute(src.getNoteAttribute()));

        return dest;
    }

    private void unmarshalAbstractBaseAttribute(AbstractBaseAttributeType src, AbstractBaseAttribute dest) throws MissingADESchemaException {
        dest.setBaseField(src.getBaseField());
    }

    private SubAttribute unmarshalSubAttribute(SubAttributeType src) throws MissingADESchemaException {
        SubAttribute dest = new SubAttribute();
        unmarshalAbstractBaseAttribute(src, dest);

        if (src.isSetSubField())
            dest.setSubField(src.getSubField().intValue());

        return dest;
    }

    private BaseAttributeProperty unmarshalBaseAttributeProperty(BaseAttributePropertyType src) throws MissingADESchemaException {
        BaseAttributeProperty dest = new BaseAttributeProperty();

        if (src.isSetBaseAttribute()) {
            ModelObject object = helper.getJAXBUnmarshaller().unmarshal(src.getBaseAttribute());
            if (object instanceof AbstractBaseAttribute)
                dest.setObject((AbstractBaseAttribute) object);
        }

        return dest;
    }

    private MiniFeature unmarshalMiniFeature(MiniFeatureType src) throws MissingADESchemaException {
        MiniFeature dest = new MiniFeature();
        helper.getCore200Unmarshaller().unmarshalAbstractCityObject(src, dest);

        dest.setLabel(src.getLabel());

        if (src.isSetLod1MultiSurface())
            dest.setLod1MultiSurface(helper.getGMLUnmarshaller().unmarshalMultiSurfaceProperty(src.getLod1MultiSurface()));

        if (src.isSetDetail())
            dest.setDetail(unmarshalDetailAttributeProperty(src.getDetail()));

        if (src.isSetPart()) {
            for (MiniPartPropertyType part : src.getPart())
                dest.getPart().add(unmarshalMiniPartProperty(part));
        }

        return dest;
    }

    private MiniPart unmarshalMiniPart(MiniPartType src) throws MissingADESchemaException {
        MiniPart dest = new MiniPart();
        helper.getCore200Unmarshaller().unmarshalAbstractCityObject(src, dest);

        dest.setPartName(src.getPartName());

        return dest;
    }

    private MiniPartProperty unmarshalMiniPartProperty(MiniPartPropertyType src) throws MissingADESchemaException {
        MiniPartProperty dest = new MiniPartProperty();

        if (src.isSetMiniPart())
            dest.setObject(unmarshalMiniPart(src.getMiniPart()));

        dest.setRemoteSchema(src.getRemoteSchema());

        if (src.isSetType())
            dest.setType(XLinkType.fromValue(src.getType().value()));

        dest.setHref(src.getHref());
        dest.setRole(src.getRole());
        dest.setArcrole(src.getArcrole());
        dest.setTitle(src.getTitle());

        if (src.isSetShow())
            dest.setShow(XLinkShow.fromValue(src.getShow().value()));

        if (src.isSetActuate())
            dest.setActuate(XLinkActuate.fromValue(src.getActuate().value()));

        return dest;
    }
}
