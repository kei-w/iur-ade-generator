/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.bind.urf;

import jp.geospatial.iur._9_9.urf.*;
import net.opengis.gml.CodeType;
import org.citygml4j.ade.iur.model.urf.*;
import org.citygml4j.builder.jaxb.unmarshal.citygml.ade.ADEUnmarshallerHelper;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.model.citygml.ade.binding.ADEUnmarshaller;
import org.citygml4j.model.citygml.core.AbstractCityObject;
import org.citygml4j.model.common.base.ModelObject;
import org.citygml4j.model.gml.xlink.XLinkActuate;
import org.citygml4j.model.gml.xlink.XLinkShow;
import org.citygml4j.model.gml.xlink.XLinkType;
import org.citygml4j.util.mapper.CheckedTypeMapper;
import org.citygml4j.xml.io.reader.MissingADESchemaException;

import javax.xml.bind.JAXBElement;

public class UrbanFunctionUnmarshaller implements ADEUnmarshaller {
    private ADEUnmarshallerHelper helper;
    private CheckedTypeMapper<ADEModelObject> typeMapper;

    private synchronized CheckedTypeMapper<ADEModelObject> getTypeMapper() {
        if (typeMapper == null) {
            typeMapper = CheckedTypeMapper.<ADEModelObject>create()
                    .with(MiniZoneType.class, this::unmarshalMiniZone)
                    .with(MiniZonePropertyType.class, this::unmarshalMiniZoneProperty)
                    .with(MiniDistrictType.class, this::unmarshalMiniDistrict)
                    .with(TargetPropertyType.class, this::unmarshalTargetProperty);
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

        }

        // all other types
        return unmarshal(value);
    }

    @Override
    public ADEModelObject unmarshal(Object src) throws MissingADESchemaException {
        CheckedTypeMapper<ADEModelObject> typeMapper = getTypeMapper();
        return typeMapper != null ? typeMapper.apply(src) : null;
    }

    private void unmarshalAbstractMiniFunction(_MiniFunctionType src, AbstractMiniFunction dest) throws MissingADESchemaException {
        helper.getCore200Unmarshaller().unmarshalAbstractCityObject(src, dest);

        if (src.isSetFunction()) {
            for (CodeType function : src.getFunction())
                dest.getFunction().add(helper.getGMLUnmarshaller().unmarshalCode(function));
        }

        if (src.isSetValidFrom())
            dest.setValidFrom(src.getValidFrom().toGregorianCalendar().toZonedDateTime().toLocalDate());

        if (src.isSetLod1MultiSurface())
            dest.setLod1MultiSurface(helper.getGMLUnmarshaller().unmarshalMultiSurfaceProperty(src.getLod1MultiSurface()));

        if (src.isSetTarget()) {
            for (TargetPropertyType target : src.getTarget())
                dest.getTarget().add(unmarshalTargetProperty(target));
        }
    }

    private MiniZone unmarshalMiniZone(MiniZoneType src) throws MissingADESchemaException {
        MiniZone dest = new MiniZone();
        unmarshalAbstractMiniFunction(src, dest);

        if (src.isSetAreaInHa())
            dest.setAreaInHa(helper.getGMLUnmarshaller().unmarshalMeasure(src.getAreaInHa()));

        if (src.isSetRelatedZone()) {
            for (MiniZonePropertyType relatedZone : src.getRelatedZone())
                dest.getRelatedZone().add(unmarshalMiniZoneProperty(relatedZone));
        }

        if (src.isSetDetail())
            dest.setDetail((org.citygml4j.ade.iur.model.uro.DetailAttributeProperty) helper.getJAXBUnmarshaller().unmarshal(src.getDetail()));

        return dest;
    }

    private MiniZoneProperty unmarshalMiniZoneProperty(MiniZonePropertyType src) throws MissingADESchemaException {
        MiniZoneProperty dest = new MiniZoneProperty();

        if (src.isSetMiniZone())
            dest.setObject(unmarshalMiniZone(src.getMiniZone()));

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

    private MiniDistrict unmarshalMiniDistrict(MiniDistrictType src) throws MissingADESchemaException {
        MiniDistrict dest = new MiniDistrict();
        unmarshalAbstractMiniFunction(src, dest);
        return dest;
    }

    private TargetProperty unmarshalTargetProperty(TargetPropertyType src) throws MissingADESchemaException {
        TargetProperty dest = new TargetProperty();

        if (src.isSet_CityObject()) {
            ModelObject object = helper.getJAXBUnmarshaller().unmarshal(src.get_CityObject());
            if (object instanceof AbstractCityObject)
                dest.setObject((AbstractCityObject) object);
        }

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
