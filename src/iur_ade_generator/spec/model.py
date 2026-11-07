"""The specification model of the generated modules: types, fields, enumerations, hooks and modules.

The objects are created from the XSD (``spec.xsd``), completed with the JAXB accessors (``spec.jaxb``) and the schema
mapping (``spec.mapping``) by ``Spec`` and linked to each other; the optional attributes are ``None`` until that step.
"""

from __future__ import annotations

import re
from collections import OrderedDict
from dataclasses import dataclass, field
from typing import TYPE_CHECKING, NamedTuple

from ..errors import GeneratorError
from ..naming import model_field
from .mapping import MappingInjection, MappingProperty, MappingType

if TYPE_CHECKING:
    from .spec import Spec

SCALAR_KINDS = {
    "xs:string": "string",
    "xs:anyURI": "string",
    "xs:integer": "integer",
    "xs:int": "integer",
    "xs:nonNegativeInteger": "integer",
    "xs:double": "double",
    "xs:boolean": "boolean",
    "xs:date": "date",
    "xs:time": "time",
    "xs:gYear": "year",
    "xs:gYearMonth": "yearMonth",
    "gml:CodeType": "code",
    "gml:MeasureType": "measure",
    "gml:LengthType": "length",
    "gml:doubleList": "doubleList",
    "gml:GeometryPropertyType": "geometry",
    "gml:PointPropertyType": "point",
    "gml:GeometricComplexPropertyType": "complex",
    "core:AddressPropertyType": "address",
    "gml:StringOrRefType": "stringOrRef",
    "gml:MultiSurfacePropertyType": "multiSurface",
    "gml:MultiCurvePropertyType": "multiCurve",
    "gml:MultiPointPropertyType": "multiPoint",
    "gml:DirectPositionType": "directPosition",
}
# field kinds that hold a type of the modules
TYPE_KINDS = ("property", "inline", "enum", "cityObjectRef")
# field kinds whose value is a child object of the model (ModelObjects.setParent)
CHILD_KINDS = (
    "code",
    "measure",
    "length",
    "property",
    "inline",
    "geometry",
    "point",
    "complex",
    "address",
    "stringOrRef",
    "multiSurface",
    "multiCurve",
    "multiPoint",
    "directPosition",
    "cityObjectRef",
)
MODEL_TYPES = {
    "string": "String",
    "integer": "Integer",
    "double": "Double",
    "boolean": "Boolean",
    "date": "LocalDate",
    "time": "LocalTime",
    "year": "Year",
    "yearMonth": "YearMonth",
    "code": "Code",
    "measure": "Measure",
    "length": "Length",
    "doubleList": "List<Double>",
    "geometry": "GeometryProperty<? extends AbstractGeometry>",
    "point": "PointProperty",
    "complex": "GeometricComplexProperty",
    "address": "AddressProperty",
    "stringOrRef": "StringOrRef",
    "multiSurface": "MultiSurfaceProperty",
    "multiCurve": "MultiCurveProperty",
    "multiPoint": "MultiPointProperty",
    "directPosition": "DirectPosition",
}

# model class names that would clash with a JAXB class of the same simple name are renamed here;
# the leading underscore of the abstract feature types follows the citygml4j "Abstract" convention
MODEL_RENAMES = {
    "ControlPointTypeType": "ControlPointParameter",
    "_BoundarySurfaceType": "AbstractBoundarySurface",
    "_BoundarySurfacePropertyType": "AbstractBoundarySurfaceProperty",
    # the urf root keeps its 1.4/3.1 name (and table ur_urbanfunction) where the schema declares it with an
    # underscore (3.2): the hand-written balloon and vis exporter classes refer to it
    "_UrbanFunctionType": "UrbanFunction",
    "_UrbanFunctionPropertyType": "UrbanFunctionProperty",
}


class FeatureBase(NamedTuple):
    """The citygml4j model class, the JAXB class and the marshaller accessors of a CityGML (or GML) base type."""

    model: str
    jaxb: str
    marshal: str
    unmarshal: str


# CityGML (and GML) base types of the ADE feature types
FEATURE_BASES = {
    "core:AbstractCityObjectType": FeatureBase(
        "org.citygml4j.model.citygml.core.AbstractCityObject",
        "net.opengis.citygml._2.AbstractCityObjectType",
        "getCore200Marshaller().marshalAbstractCityObject",
        "getCore200Unmarshaller().unmarshalAbstractCityObject",
    ),
    "bldg:AbstractBuildingType": FeatureBase(
        "org.citygml4j.model.citygml.building.AbstractBuilding",
        "net.opengis.citygml.building._2.AbstractBuildingType",
        "getBuilding200Marshaller().marshalAbstractBuilding",
        "getBuilding200Unmarshaller().unmarshalAbstractBuilding",
    ),
    "tran:TransportationComplexType": FeatureBase(
        "org.citygml4j.model.citygml.transportation.TransportationComplex",
        "net.opengis.citygml.transportation._2.TransportationComplexType",
        "getTransportation200Marshaller().marshalTransportationComplex",
        "getTransportation200Unmarshaller().unmarshalTransportationComplex",
    ),
    "frn:CityFurnitureType": FeatureBase(
        "org.citygml4j.model.citygml.cityfurniture.CityFurniture",
        "net.opengis.citygml.cityfurniture._2.CityFurnitureType",
        "getCityFurniture200Marshaller().marshalCityFurniture",
        "getCityFurniture200Unmarshaller().unmarshalCityFurniture",
    ),
    "luse:LandUseType": FeatureBase(
        "org.citygml4j.model.citygml.landuse.LandUse",
        "net.opengis.citygml.landuse._2.LandUseType",
        "getLandUse200Marshaller().marshalLandUse",
        "getLandUse200Unmarshaller().unmarshalLandUse",
    ),
    "gml:AbstractFeatureType": FeatureBase(
        "org.citygml4j.model.gml.feature.AbstractFeature",
        "net.opengis.gml.AbstractFeatureType",
        "getGMLMarshaller().marshalAbstractFeature",
        "getGMLUnmarshaller().unmarshalAbstractFeature",
    ),
}
# base types whose citygml4j class is abstract: the ADE class implements the visitor methods and the ADE walkers
# visit it
ABSTRACT_FEATURE_BASES = {"core:AbstractCityObjectType", "bldg:AbstractBuildingType", "gml:AbstractFeatureType"}
# modules whose nested feature types are city object members as well: every i-UR urban function feature is written as a
# cityObjectMember in the PLATEAU datasets (e.g. urf:SpecialUrbanRenaissanceDistrict, which urf:UrbanRenewalProject also
# nests), the statistical grids are members and the public transit features are group members referring to each other
# by xlink, whereas the nested uro features (boundary surfaces, construction installations) never are
MEMBER_FEATURE_MODULES = {"urf", "urg", "urt"}

# the i-UR modules: XSD prefix -> Java name used by the citygml4j and citydb class names
MODULE_NAMES = {"uro": "UrbanObject", "urf": "UrbanFunction", "urg": "StatisticalGrid", "urt": "PublicTransit"}
XSD_FILES = {
    "uro": "urbanObject.xsd",
    "urf": "urbanFunction.xsd",
    "urg": "statisticalGrid.xsd",
    "urt": "publicTransit.xsd",
}


def split_ref(qref: str) -> tuple[str, str]:
    """("uro", "FooType") for "uro:FooType"; ("", name) without prefix."""
    prefix, _, name = qref.rpartition(":")
    return prefix, name


@dataclass
class JaxbProperty:
    """An accessor pair of a generated JAXB class."""

    getter: str
    """e.g. ``getBranchID`` / ``isIsTollRoad``."""
    setter: str | None
    """``setBranchID``; ``None`` for lists."""
    java_type: str
    is_list: bool
    is_jaxb_element: bool
    primitive: bool

    @property
    def prop(self) -> str:
        return self.getter[3:] if self.getter.startswith("get") else self.getter[2:]

    @property
    def is_set(self) -> str:
        return "isSet" + self.prop


@dataclass
class Enum:
    """An XSD simple type restricted by an enumeration."""

    name: str
    values: list[str]
    module: Module

    @property
    def model(self) -> str:
        """The model enum class (referenced qualified in the bind code)."""
        return self.name[0].upper() + self.name[1:]

    @property
    def jaxb(self) -> str:
        """The JAXB enum class (ade-xjc capitalises the simple type name)."""
        return self.model

    @property
    def qname(self) -> str:
        return self.module.prefix + ":" + self.name


@dataclass
class Field:
    """An element of a complex type."""

    name: str
    xsd_type: str
    required: bool
    multi: bool
    kind: str = "unsupported"
    """A scalar kind of ``SCALAR_KINDS``, ``property``, ``inline``, ``enum``, ``cityObjectRef`` or ``unsupported``."""
    target: Type | None = None
    """The property type (``property``, ``cityObjectRef``) or the inline type (``inline``)."""
    enum: Enum | None = None
    jaxb: JaxbProperty | None = None
    column: MappingProperty | None = None
    """The mapping property (set by the citydb generator)."""
    enum_values: list[str] | None = None
    """The allowed values of a string field restricted by an enumeration."""
    owner: Type | None = None

    @property
    def model_name(self) -> str:
        """The name of the model accessor."""
        return model_field(self.name, self.owner.name if self.owner is not None and self.owner.is_feature else None)

    @property
    def property_type(self) -> Type:
        """The property type of a ``property`` or ``cityObjectRef`` field, or the inline type of an ``inline`` field."""
        if self.target is None:
            raise GeneratorError(f"field {self} has no target type")
        return self.target

    @property
    def nested(self) -> Type:
        """The type the field holds: the target of the property type (``property``), the inline type (``inline``)."""
        if self.kind == "inline":
            return self.property_type
        target = self.property_type.prop_target
        if target is None:
            raise GeneratorError(f"field {self} has no nested type")
        return target

    @property
    def enum_type(self) -> Enum:
        if self.enum is None:
            raise GeneratorError(f"field {self} is no enumeration")
        return self.enum

    @property
    def jaxb_property(self) -> JaxbProperty:
        if self.jaxb is None:
            raise GeneratorError(f"field {self} has no JAXB property")
        return self.jaxb

    @property
    def mapped(self) -> MappingProperty:
        if self.column is None:
            raise GeneratorError(f"field {self} has no mapping property")
        return self.column

    @property
    def model_type(self) -> str:
        """Java type of the field in the citygml4j model."""
        if self.kind == "enum":
            t = self.enum_type.model
        elif self.kind in TYPE_KINDS:
            t = self.property_type.model
        else:
            t = MODEL_TYPES[self.kind]
        return f"List<{t}>" if self.multi else t

    @property
    def is_child(self) -> bool:
        """Whether the model stores the value as a child object (ModelObjects.setParent)."""
        return self.kind in CHILD_KINDS

    @property
    def is_feature_property(self) -> bool:
        """A property whose target is an ADE feature type (modelled as a FeatureProperty)."""
        return self.kind == "property" and self.nested.is_feature

    @property
    def is_member_reference(self) -> bool:
        """A feature property whose (concrete) targets are city object members: written as an xlink to the member."""
        if not self.is_feature_property:
            return False
        t = self.nested
        return any(x.top_level for x in [t, *t.descendants()])

    @property
    def foreign(self) -> bool:
        """The target belongs to another module than the declaring type."""
        if self.kind not in TYPE_KINDS or self.owner is None:
            return False
        module = self.enum_type.module if self.kind == "enum" else self.property_type.module
        return module is not self.owner.module

    @property
    def lod(self) -> int | None:
        """LoD number of a lodNGeometry / lodNMultiSurface ... field, else None."""
        m = re.match(r"lod(\d)", self.name)
        return int(m.group(1)) if m else None

    def __repr__(self) -> str:
        return "Field({}:{}{})".format(self.name, self.kind, "[]" if self.multi else "")


@dataclass(eq=False)
class Type:
    """An XSD complex type of a module: a data type, a feature type or a property type."""

    name: str
    module: Module
    base_name: str | None = None
    """The XSD base type (``uro:FooType`` or a CityGML type) before linking."""
    base: Type | None = None
    """The base type within the modules."""
    core_base: str | None = None
    """The CityGML/GML base type of a feature type hierarchy root, e.g. ``core:AbstractCityObjectType``."""
    abstract: bool = False
    fields: list[Field] = field(default_factory=list)
    dropped: list[Field] = field(default_factory=list)
    """Fields that cannot be generated (unsupported XSD types)."""
    subtypes: list[Type] = field(default_factory=list)
    element: str | None = None
    """The global element declared with this type."""
    choice: bool = False
    choice_groups: list[list[str]] = field(default_factory=list)
    """Element names of every ``<choice>``; the fixture writes the first alternative only."""
    prop_target_ref: str | None = None
    """For property types: the referenced element before linking."""
    prop_target: Type | None = None
    """For property types: the target type (``None`` for a CityGML target, see ``foreign_target``)."""
    foreign_target: str | None = None
    """For property types referencing a CityGML element, e.g. ``core:_CityObject``."""
    polymorphic: bool = False
    """For property types: JAXB uses JAXBElement for the content."""
    mapping: MappingType | None = None

    @property
    def is_property(self) -> bool:
        return self.name.endswith("PropertyType")

    @property
    def qname(self) -> str:
        return self.module.prefix + ":" + self.name

    @property
    def spec(self) -> Spec:
        return self.module.require_spec()

    @property
    def is_feature(self) -> bool:
        """Whether this is an ADE feature type (derived from a CityGML or GML feature type)."""
        return self.root().core_base in FEATURE_BASES

    @property
    def feature_base(self) -> FeatureBase:
        """FEATURE_BASES entry of the hierarchy root."""
        core_base = self.root().core_base
        if core_base is None or core_base not in FEATURE_BASES:
            raise GeneratorError(f"{self.qname} is no feature type")
        return FEATURE_BASES[core_base]

    @property
    def top_level(self) -> bool:
        """A concrete city object type that is not nested in another ADE feature (the ADE Manager misses some)."""
        return (
            self.is_feature
            and not self.abstract
            and self.root().core_base != "gml:AbstractFeatureType"
            and (
                self.module.prefix in MEMBER_FEATURE_MODULES
                or not any(a.qname in self.spec.nested_features for a in [self, *self.ancestors()])
            )
        )

    @property
    def model(self) -> str:
        """The citygml4j model class."""
        if self.name in MODEL_RENAMES:
            return MODEL_RENAMES[self.name]
        name = self.name[:-4] if self.name.endswith("Type") else self.name
        if name.startswith("_"):
            # the leading underscore of the abstract types (_UrbanFunctionType, _BoundarySurfaceType) follows the
            # citygml4j "Abstract" convention
            name = name[1:]
            return name if name.startswith("Abstract") else "Abstract" + name
        return name

    @property
    def mapping_path(self) -> str:
        """The ``path`` of the type in the schema mapping (the ADE Manager keeps the XSD name without ``Type``)."""
        return self.name[:-4] if self.name in MODEL_RENAMES or self.name.startswith("_") else self.model

    @property
    def jaxb(self) -> str:
        return self.name

    @property
    def mapped(self) -> MappingType:
        if self.mapping is None:
            raise GeneratorError(f"no mapping for {self.name}")
        return self.mapping

    @property
    def target(self) -> Type:
        """The target type of a property type."""
        if self.prop_target is None:
            raise GeneratorError(f"property type {self.qname} has no target type")
        return self.prop_target

    @property
    def element_name(self) -> str:
        if self.element is None:
            raise GeneratorError(f"{self.qname} has no element")
        return self.element

    def ancestors(self) -> list[Type]:
        t, out = self.base, []
        while t is not None:
            out.append(t)
            t = t.base
        return out

    def all_fields(self) -> list[Field]:
        out: list[Field] = []
        for t in reversed(self.ancestors()):
            out.extend(t.fields)
        out.extend(self.fields)
        return out

    def descendants(self) -> list[Type]:
        out = []
        for s in self.subtypes:
            out.append(s)
            out.extend(s.descendants())
        return out

    def root(self) -> Type:
        t = self
        while t.base is not None:
            t = t.base
        return t

    def __repr__(self) -> str:
        return f"Type({self.qname})"


@dataclass(eq=False)
class Hook:
    """A generic application property element hooked into a CityGML feature type."""

    element: str
    """e.g. ``bldgDisasterRiskAttribute``."""
    target: str
    """e.g. ``AbstractBuilding``."""
    module: Module
    prefix: str | None = None
    """The prefix of the substitution group, e.g. ``bldg``."""
    xsd_type: str | None = None
    prop_type: Type | None = None
    """The property type (``None`` for the simple hooks fiscalYearOfPublication and language)."""
    injection: MappingInjection | None = None
    mapping: MappingProperty | None = None

    @property
    def multi(self) -> bool:
        return self.mapping is None or self.mapping.max_occurs != "1"

    @property
    def model_element(self) -> str:
        return self.element[0].upper() + self.element[1:] + "PropertyElement"

    @property
    def property_type(self) -> Type:
        if self.prop_type is None:
            raise GeneratorError(f"hook {self.element} has no property type")
        return self.prop_type

    @property
    def nested(self) -> Type:
        """The type the hook holds."""
        return self.property_type.target

    @property
    def mapped(self) -> MappingProperty:
        if self.mapping is None:
            raise GeneratorError(f"hook {self.element} is not mapped")
        return self.mapping

    @property
    def injected(self) -> MappingInjection:
        if self.injection is None:
            raise GeneratorError(f"hook {self.element} is not injected")
        return self.injection

    def __repr__(self) -> str:
        return f"Hook({self.element} -> {self.target})"


class Module:
    """One i-UR module: its XSD, JAXB package and the names of the generated Java artifacts."""

    def __init__(self, prefix: str, xsd_path: str, jaxb_pkg: str, jaxb_dir: str, namespace: str) -> None:
        self.prefix = prefix
        self.xsd_path = xsd_path
        self.jaxb_pkg = jaxb_pkg
        self.jaxb_dir = jaxb_dir
        self.namespace = namespace
        self.java_name = MODULE_NAMES[prefix]
        self.spec: Spec | None = None
        self.types: OrderedDict[str, Type] = OrderedDict()
        self.enums: OrderedDict[str, Enum] = OrderedDict()
        self.elements: OrderedDict[str, str] = OrderedDict()
        """element name -> type name."""
        self.hooks: list[Hook] = []
        self.factory: dict[str, str] = {}
        """element name -> ObjectFactory method name."""
        self.jaxb_classes: set[str] = set()
        self.mapping_types: OrderedDict[str, MappingType] = OrderedDict()
        self.schema_id: str | None = None
        self.version = self.namespace.rstrip("/").rsplit("/", 1)[1]  # e.g. "3.1"

    def require_spec(self) -> Spec:
        if self.spec is None:
            raise GeneratorError(f"module {self.prefix} is not part of a specification")
        return self.spec

    @property
    def version_const(self) -> str:
        return "v" + self.version.replace(".", "_")

    @property
    def schema_url(self) -> str:
        return (
            self.namespace.replace(f"/iur/{self.prefix}/", f"/iur/schemas/{self.prefix}/")
            + "/"
            + XSD_FILES[self.prefix]
        )

    @property
    def model_pkg(self) -> str:
        return "org.citygml4j.ade.iur.model." + self.prefix

    @property
    def module_class(self) -> str:
        return self.java_name + "Module"

    @property
    def marshaller(self) -> str:
        return self.java_name + "Marshaller"

    @property
    def unmarshaller(self) -> str:
        return self.java_name + "Unmarshaller"

    @property
    def importer_interface(self) -> str:
        return self.java_name + "ModuleImporter"

    @property
    def exporter_interface(self) -> str:
        return self.java_name + "ModuleExporter"

    def __repr__(self) -> str:
        return f"Module({self.prefix} {self.version})"
