/*
 * iur-ade-citygml4j - mini fixture of the iur-ade-generator tests
 * (the generators copy this license header into the generated files)
 */

package org.citygml4j.ade.iur.bind.urf;

import jp.geospatial.iur._9_9.urf.*;
import net.opengis.citygml._2.AbstractCityObjectType;
import org.citygml4j.ade.iur.bind.Marshaller;
import org.citygml4j.ade.iur.model.urf.*;
import org.citygml4j.builder.jaxb.marshal.citygml.ade.ADEMarshallerHelper;
import org.citygml4j.model.citygml.ade.binding.ADEMarshaller;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.model.gml.basicTypes.Code;
import org.citygml4j.util.mapper.TypeMapper;
import org.w3._1999.xlink.ActuateType;
import org.w3._1999.xlink.ShowType;
import org.w3._1999.xlink.TypeType;

import javax.xml.bind.JAXBElement;

public class UrbanFunctionMarshaller implements ADEMarshaller {
    private final Marshaller marshaller;
    private final ObjectFactory factory = new ObjectFactory();
    private ADEMarshallerHelper helper;
    private TypeMapper<JAXBElement<?>> elementMapper;
    private TypeMapper<Object> typeMapper;

    public UrbanFunctionMarshaller(Marshaller marshaller) {
        this.marshaller = marshaller;
    }

    private synchronized TypeMapper<JAXBElement<?>> getElementMapper() {
        if (elementMapper == null) {
            elementMapper = TypeMapper.<JAXBElement<?>>create()
                    .with(MiniZone.class, this::createMiniZone)
                    .with(MiniDistrict.class, this::createMiniDistrict);
        }

        return elementMapper;
    }

    private synchronized TypeMapper<Object> getTypeMapper() {
        if (typeMapper == null) {
            typeMapper = TypeMapper.create()
                    .with(MiniZone.class, this::marshalMiniZone)
                    .with(MiniZoneProperty.class, this::marshalMiniZoneProperty)
                    .with(MiniDistrict.class, this::marshalMiniDistrict)
                    .with(TargetProperty.class, this::marshalTargetProperty);
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

    private void marshalAbstractMiniFunction(AbstractMiniFunction src, _MiniFunctionType dest) {
        helper.getCore200Marshaller().marshalAbstractCityObject(src, dest);

        for (Code function : src.getFunction())
            dest.getFunction().add(helper.getGMLMarshaller().marshalCode(function));

        if (src.getValidFrom() != null)
            dest.setValidFrom(marshaller.toCalendar(src.getValidFrom()));

        if (src.getLod1MultiSurface() != null)
            dest.setLod1MultiSurface(helper.getGMLMarshaller().marshalMultiSurfaceProperty(src.getLod1MultiSurface()));

        for (TargetProperty target : src.getTarget())
            dest.getTarget().add(marshalTargetProperty(target));
    }

    private MiniZoneType marshalMiniZone(MiniZone src) {
        MiniZoneType dest = factory.createMiniZoneType();
        marshalAbstractMiniFunction(src, dest);

        if (src.getAreaInHa() != null)
            dest.setAreaInHa(helper.getGMLMarshaller().marshalMeasure(src.getAreaInHa()));

        for (MiniZoneProperty relatedZone : src.getRelatedZone())
            dest.getRelatedZone().add(marshalMiniZoneProperty(relatedZone));

        if (src.getDetail() != null)
            dest.setDetail((jp.geospatial.iur._9_9.uro.DetailAttributePropertyType) helper.getJAXBMarshaller().marshal(src.getDetail()));

        return dest;
    }

    private MiniZonePropertyType marshalMiniZoneProperty(MiniZoneProperty src) {
        MiniZonePropertyType dest = factory.createMiniZonePropertyType();

        if (src.isSetObject())
            dest.setMiniZone(marshalMiniZone(src.getObject()));

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

    private MiniDistrictType marshalMiniDistrict(MiniDistrict src) {
        MiniDistrictType dest = factory.createMiniDistrictType();
        marshalAbstractMiniFunction(src, dest);
        return dest;
    }

    private TargetPropertyType marshalTargetProperty(TargetProperty src) {
        TargetPropertyType dest = factory.createTargetPropertyType();

        if (src.getObject() != null) {
            JAXBElement<?> elem = helper.getJAXBMarshaller().marshalJAXBElement(src.getObject());
            if (elem != null && elem.getValue() instanceof AbstractCityObjectType)
                dest.set_CityObject((JAXBElement<? extends AbstractCityObjectType>) elem);
        }

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

    private JAXBElement<?> createMiniZone(MiniZone src) {
        return factory.createMiniZone(marshalMiniZone(src));
    }

    private JAXBElement<?> createMiniDistrict(MiniDistrict src) {
        return factory.createMiniDistrict(marshalMiniDistrict(src));
    }
}
