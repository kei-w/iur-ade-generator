"""Specification model for the i-UR ADE code generators (uro, urf).

Combines three sources into one model:
  * the XSD of every generated module (types, fields, generic application property hooks),
  * the ade-xjc generated JAXB classes (exact accessor names and types),
  * the ADE Manager schema mapping (tables, columns, joins).
Types are kept per module (the XSD prefix: uro, urf) and referenced by their qualified name across modules.
"""
import os
import re
import sys
import xml.etree.ElementTree as ET
from collections import OrderedDict

XS = "{http://www.w3.org/2001/XMLSchema}"

SCALAR_KINDS = {
    "xs:string": "string", "xs:anyURI": "string", "xs:integer": "integer", "xs:int": "integer",
    "xs:nonNegativeInteger": "integer",
    "xs:double": "double", "xs:boolean": "boolean", "xs:date": "date", "xs:gYear": "year",
    "xs:gYearMonth": "yearMonth", "gml:CodeType": "code", "gml:MeasureType": "measure",
    "gml:LengthType": "length", "gml:doubleList": "doubleList", "gml:GeometryPropertyType": "geometry",
    "gml:PointPropertyType": "point", "gml:GeometricComplexPropertyType": "complex",
    "core:AddressPropertyType": "address", "gml:StringOrRefType": "stringOrRef",
    "gml:MultiSurfacePropertyType": "multiSurface", "gml:MultiCurvePropertyType": "multiCurve",
    "gml:MultiPointPropertyType": "multiPoint", "gml:DirectPositionType": "directPosition",
}

# model class names that would clash with a JAXB class of the same simple name are renamed here;
# the leading underscore of the abstract feature types follows the citygml4j "Abstract" convention
MODEL_RENAMES = {"ControlPointTypeType": "ControlPointParameter", "_BoundarySurfaceType": "AbstractBoundarySurface",
                 "_BoundarySurfacePropertyType": "AbstractBoundarySurfaceProperty",
                 # the urf root keeps its 1.4/3.1 name (and table ur_urbanfunction) where the schema declares it with an
                 # underscore (3.2): the hand-written balloon and vis exporter classes refer to it
                 "_UrbanFunctionType": "UrbanFunction", "_UrbanFunctionPropertyType": "UrbanFunctionProperty"}

# CityGML (and GML) base types of the ADE feature types -> citygml4j model class, JAXB class, marshaller accessor
FEATURE_BASES = {
    "core:AbstractCityObjectType": ("org.citygml4j.model.citygml.core.AbstractCityObject", "net.opengis.citygml._2.AbstractCityObjectType",
                                    "getCore200Marshaller().marshalAbstractCityObject", "getCore200Unmarshaller().unmarshalAbstractCityObject"),
    "bldg:AbstractBuildingType": ("org.citygml4j.model.citygml.building.AbstractBuilding", "net.opengis.citygml.building._2.AbstractBuildingType",
                                  "getBuilding200Marshaller().marshalAbstractBuilding", "getBuilding200Unmarshaller().unmarshalAbstractBuilding"),
    "tran:TransportationComplexType": ("org.citygml4j.model.citygml.transportation.TransportationComplex",
                                       "net.opengis.citygml.transportation._2.TransportationComplexType",
                                       "getTransportation200Marshaller().marshalTransportationComplex",
                                       "getTransportation200Unmarshaller().unmarshalTransportationComplex"),
    "frn:CityFurnitureType": ("org.citygml4j.model.citygml.cityfurniture.CityFurniture", "net.opengis.citygml.cityfurniture._2.CityFurnitureType",
                              "getCityFurniture200Marshaller().marshalCityFurniture", "getCityFurniture200Unmarshaller().unmarshalCityFurniture"),
    "luse:LandUseType": ("org.citygml4j.model.citygml.landuse.LandUse", "net.opengis.citygml.landuse._2.LandUseType",
                         "getLandUse200Marshaller().marshalLandUse", "getLandUse200Unmarshaller().unmarshalLandUse"),
    "gml:AbstractFeatureType": ("org.citygml4j.model.gml.feature.AbstractFeature", "net.opengis.gml.AbstractFeatureType",
                                "getGMLMarshaller().marshalAbstractFeature", "getGMLUnmarshaller().unmarshalAbstractFeature"),
}
# base types whose citygml4j class is abstract: the ADE class implements the visitor methods and the ADE walkers visit it
ABSTRACT_FEATURE_BASES = {"core:AbstractCityObjectType", "bldg:AbstractBuildingType", "gml:AbstractFeatureType"}
# fields of feature types whose accessor would clash with one inherited from the base class; the JAXB property is renamed
# alike in binding.xjb (otherwise ade-xjc binds the whole content model as a generic "rest" list)
FEATURE_FIELD_NAMES = {"id": "identifier", "boundedBy": "boundedBySurface", "location": "locationDescription"}
# modules whose nested feature types are city object members as well: every i-UR urban function feature is written as a
# cityObjectMember in the PLATEAU datasets (e.g. urf:SpecialUrbanRenaissanceDistrict, which urf:UrbanRenewalProject also
# nests), whereas the nested uro features (boundary surfaces, construction installations) never are
MEMBER_FEATURE_MODULES = {"urf"}

# the i-UR modules: XSD prefix -> Java name used by the citygml4j and citydb class names
MODULE_NAMES = {"uro": "UrbanObject", "urf": "UrbanFunction", "urg": "StatisticalGrid", "urt": "PublicTransit"}
XSD_FILES = {"uro": "urbanObject.xsd", "urf": "urbanFunction.xsd", "urg": "statisticalGrid.xsd", "urt": "publicTransit.xsd"}


def local(tag):
    return tag.split("}")[-1]


def norm(name):
    return re.sub(r"[^a-z0-9]", "", name.lower())


def cap(s):
    return s[0].upper() + s[1:]


def uncap(s):
    return s[0].lower() + s[1:]


def java_name(name):
    """Java identifier of an XSD element name: "lod-1MultiSurface" -> "lodMinus1MultiSurface"."""
    return re.sub(r"[^A-Za-z0-9_]", "", re.sub(r"^lod-(\d)", r"lodMinus\1", name))


def split_ref(qref):
    """("uro", "FooType") for "uro:FooType"; ("", name) without prefix."""
    return tuple(qref.split(":", 1)) if ":" in qref else ("", qref)


class Field:
    def __init__(self, name, xsd_type, min_occurs, max_occurs):
        self.name = name
        self.xsd_type = xsd_type
        self.required = min_occurs != "0"
        self.multi = max_occurs != "1"
        self.kind = None          # scalar kind, "property", "inline", "enum", "cityObjectRef"
        self.target = None        # Type for property/inline/cityObjectRef, Enum for enum
        self.jaxb = None          # JaxbProperty
        self.column = None        # mapping info (dict)
        self.enum_values = None   # allowed values of a string field restricted by an enumeration
        self.owner = None         # declaring Type

    @property
    def model_type(self):
        """Java type of the field in the citygml4j model."""
        base = {
            "string": "String", "integer": "Integer", "double": "Double", "boolean": "Boolean",
            "date": "LocalDate", "year": "Year", "yearMonth": "YearMonth", "code": "Code",
            "measure": "Measure", "length": "Length", "doubleList": "List<Double>",
            "geometry": "GeometryProperty<? extends AbstractGeometry>", "point": "PointProperty",
            "complex": "GeometricComplexProperty", "address": "AddressProperty", "stringOrRef": "StringOrRef",
            "multiSurface": "MultiSurfaceProperty", "multiCurve": "MultiCurveProperty", "multiPoint": "MultiPointProperty",
            "directPosition": "DirectPosition",
        }
        if self.kind in ("property", "inline", "enum", "cityObjectRef"):
            t = self.target.model
        else:
            t = base[self.kind]
        return "List<%s>" % t if self.multi else t

    @property
    def is_child(self):
        """Whether the model stores the value as a child object (ModelObjects.setParent)."""
        return self.kind in ("code", "measure", "length", "property", "inline", "geometry", "point", "complex", "address", "stringOrRef",
                             "multiSurface", "multiCurve", "multiPoint", "directPosition", "cityObjectRef")

    @property
    def is_feature_property(self):
        """A property whose target is an ADE feature type (modelled as a FeatureProperty)."""
        return self.kind == "property" and self.target.prop_target.is_feature

    @property
    def is_member_reference(self):
        """A feature property whose (concrete) targets are city object members: written as an xlink to the member."""
        t = self.target.prop_target if self.is_feature_property else None
        return t is not None and any(x.top_level for x in [t] + t.descendants())

    @property
    def foreign(self):
        """The target belongs to another module than the declaring type."""
        return self.kind in ("property", "inline", "enum", "cityObjectRef") and self.target.module is not self.owner.module

    @property
    def lod(self):
        """LoD number of a lodNGeometry / lodNMultiSurface ... field, else None."""
        m = re.match(r"lod(\d)", self.name)
        return int(m.group(1)) if m else None

    def __repr__(self):
        return "Field(%s:%s%s)" % (self.name, self.kind, "[]" if self.multi else "")


class Enum:
    def __init__(self, name, values, module):
        self.name = name              # XSD simpleType name
        self.model = cap(name)        # model enum class (referenced qualified in bind code)
        self.jaxb = cap(name)         # JAXB enum class (ade-xjc capitalises the simple type name)
        self.values = values
        self.module = module

    @property
    def qname(self):
        return self.module.prefix + ":" + self.name


class Type:
    def __init__(self, name, module):
        self.name = name              # XSD complexType name
        self.module = module
        self.base = None
        self.abstract = False
        self.fields = []
        self.subtypes = []
        self.element = None           # global element declared with this type
        self.is_property = name.endswith("PropertyType")
        self.prop_target = None       # for property types: the target Type (None for a CityGML target, see foreign_target)
        self.foreign_target = None    # for property types referencing a CityGML element, e.g. "core:_CityObject"
        self.polymorphic = False      # for property types: JAXB uses JAXBElement for the content
        self.mapping = None           # MappingType
        self.choice = False
        self.core_base = None         # CityGML/GML base type of a feature type hierarchy, e.g. "core:AbstractCityObjectType"
        self.spec = module.spec

    @property
    def qname(self):
        return self.module.prefix + ":" + self.name

    @property
    def is_feature(self):
        """Whether this is an ADE feature type (derived from a CityGML or GML feature type)."""
        return self.root().core_base in FEATURE_BASES

    @property
    def feature_base(self):
        """FEATURE_BASES entry of the hierarchy root."""
        return FEATURE_BASES[self.root().core_base]

    @property
    def top_level(self):
        """A concrete city object type that is not nested in another ADE feature (the ADE Manager misses some)."""
        return (self.is_feature and not self.abstract and self.root().core_base != "gml:AbstractFeatureType"
                and (self.module.prefix in MEMBER_FEATURE_MODULES
                     or not any(a.qname in self.spec.nested_features for a in [self] + self.ancestors())))

    @property
    def model(self):
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
    def mapping_path(self):
        return self.name[:-4] if self.name in MODEL_RENAMES or self.name.startswith("_") else self.model

    @property
    def jaxb(self):
        return self.name

    def ancestors(self):
        t, out = self.base, []
        while t is not None:
            out.append(t)
            t = t.base
        return out

    def all_fields(self):
        out = []
        for t in reversed(self.ancestors()):
            out.extend(t.fields)
        out.extend(self.fields)
        return out

    def descendants(self):
        out = []
        for s in self.subtypes:
            out.append(s)
            out.extend(s.descendants())
        return out

    def root(self):
        t = self
        while t.base is not None:
            t = t.base
        return t

    def __repr__(self):
        return "Type(%s)" % self.qname


class Hook:
    """A generic application property element hooked into a CityGML feature type."""

    def __init__(self, element, target, prop_type, module):
        self.element = element        # e.g. "bldgDisasterRiskAttribute"
        self.target = target          # e.g. "AbstractBuilding"
        self.prefix = None            # e.g. "bldg"
        self.prop_type = prop_type    # property Type (or None for simple hooks)
        self.module = module
        self.xsd_type = None
        self.injection = None         # MappingInjection
        self.mapping = None           # mapping property info (dict)

    @property
    def multi(self):
        return self.mapping is None or self.mapping.get("maxOccurs") != "1"

    @property
    def model_element(self):
        return cap(self.element) + "PropertyElement"

    def __repr__(self):
        return "Hook(%s -> %s)" % (self.element, self.target)


class JaxbProperty:
    def __init__(self, getter, setter, java_type, is_list, is_jaxb_element, primitive):
        self.getter = getter          # e.g. "getBranchID" / "isIsTollRoad"
        self.setter = setter          # e.g. "setBranchID" (None for lists)
        self.java_type = java_type
        self.is_list = is_list
        self.is_jaxb_element = is_jaxb_element
        self.primitive = primitive

    @property
    def prop(self):
        return self.getter[3:] if self.getter.startswith("get") else self.getter[2:]

    @property
    def is_set(self):
        return "isSet" + self.prop


class MappingType:
    def __init__(self, el):
        self.id = el.get("id")
        self.table = el.get("table")
        self.object_class_id = int(el.get("objectClassId"))
        self.path = el.get("path")
        self.abstract = el.get("abstract") == "true"
        self.top_level = el.get("topLevel") == "true"
        self.base_id = None
        self.base_join = None
        self.props = OrderedDict()    # path -> dict
        for c in el:
            tag = local(c.tag)
            if tag == "extension":
                self.base_id = c.get("base")
                j = c.find("{*}join")
                if j is not None:
                    self.base_join = (j.get("table"), j.get("fromColumn"), j.get("toColumn"), j.get("toRole"))
            else:
                p = parse_property(c)
                if p is not None:
                    self.props[p["path"]] = p


def parse_property(c):
    tag = local(c.tag)
    p = {"tag": tag, "path": c.get("path"), "maxOccurs": c.get("maxOccurs"), "minOccurs": c.get("minOccurs"),
         "schema": c.get("schema")}
    if tag == "attribute":
        p["column"] = c.get("column")
        p["type"] = c.get("type")
    elif tag == "complexAttribute":
        for a in c:
            if local(a.tag) == "attribute":
                if a.get("path") == ".":
                    p["column"] = a.get("column")
                    p["type"] = a.get("type")
                else:
                    p["qualifier"] = a.get("column")
    elif tag in ("complexProperty", "featureProperty"):
        p["refType"] = c.get("refType") or c.get("target")
        j = c.find("{*}join")
        if j is not None:
            p["join"] = (j.get("table"), j.get("fromColumn"), j.get("toColumn"), j.get("toRole"))
            p["condition"] = j.find("{*}condition") is not None
        jt = c.find("{*}joinTable")
        if jt is not None:
            j, inv = jt.find("{*}join"), jt.find("{*}inverseJoin")
            p["joinTable"] = (jt.get("table"), j.get("fromColumn"), inv.get("fromColumn"))
        t = c.find("{*}type")
        if t is not None:
            p["inline"] = {local(a.tag): None for a in t}
            p["inlineProps"] = [parse_property(a) for a in t]
    elif tag == "geometryProperty":
        p["refColumn"] = c.get("refColumn")
        p["inlineColumn"] = c.get("inlineColumn")
        p["geometryType"] = c.get("type")
    else:
        return None
    return p


class MappingInjection:
    def __init__(self, el):
        self.table = el.get("table")
        self.default_base = el.get("defaultBase")
        self.props = OrderedDict()
        for c in el:
            if local(c.tag) == "join":
                continue
            p = parse_property(c)
            if p is not None:
                self.props[p["path"]] = p


class Module:
    """One i-UR module: its XSD, JAXB package and the names of the generated Java artifacts."""

    def __init__(self, prefix, xsd_path, jaxb_pkg, jaxb_dir):
        self.prefix = prefix
        self.xsd_path = xsd_path
        self.jaxb_pkg = jaxb_pkg
        self.jaxb_dir = jaxb_dir
        self.java_name = MODULE_NAMES[prefix]
        self.spec = None
        self.types = OrderedDict()
        self.enums = OrderedDict()
        self.elements = OrderedDict()     # element name -> type name
        self.hooks = []
        self.factory = {}                 # element name -> ObjectFactory method name
        self.jaxb_classes = set()
        self.mapping_types = OrderedDict()
        self.schema_id = None
        self.namespace = ET.parse(xsd_path).getroot().get("targetNamespace")
        self.version = self.namespace.rstrip("/").rsplit("/", 1)[1]           # e.g. "3.1"

    @property
    def version_const(self):
        return "v" + self.version.replace(".", "_")

    @property
    def schema_url(self):
        return self.namespace.replace("/iur/%s/" % self.prefix, "/iur/schemas/%s/" % self.prefix) + "/" + XSD_FILES[self.prefix]

    @property
    def model_pkg(self):
        return "org.citygml4j.ade.iur.model." + self.prefix

    @property
    def module_class(self):
        return self.java_name + "Module"

    @property
    def marshaller(self):
        return self.java_name + "Marshaller"

    @property
    def unmarshaller(self):
        return self.java_name + "Unmarshaller"

    @property
    def importer_interface(self):
        return self.java_name + "ModuleImporter"

    @property
    def exporter_interface(self):
        return self.java_name + "ModuleExporter"

    def __repr__(self):
        return "Module(%s %s)" % (self.prefix, self.version)


class Spec:
    def __init__(self, modules, mapping_path, ddl_path):
        self.modules = OrderedDict((m.prefix, m) for m in modules)
        for m in modules:
            m.spec = self
        self.injections = []
        self.ddl_tables = OrderedDict()   # table -> [columns]
        self.table_sequence = {}          # table -> sequence used as default of its id column
        self.sequences = []
        for m in modules:
            self._parse_xsd(m)
            self._parse_jaxb(m)
        self._parse_mapping(mapping_path)
        self._parse_ddl(ddl_path)
        self._link()

    # ---------------------------------------------------------------- views
    @property
    def types(self):
        """All types of all modules by qualified name."""
        return OrderedDict((t.qname, t) for m in self.modules.values() for t in m.types.values())

    @property
    def hooks(self):
        return [h for m in self.modules.values() for h in m.hooks]

    def resolve(self, qref):
        """Type or Enum for a qualified XSD type reference, None for references outside the generated modules."""
        prefix, name = split_ref(qref)
        m = self.modules.get(prefix)
        if m is None:
            return None
        return m.types.get(name) or m.enums.get(name)

    # ------------------------------------------------------------------ XSD
    def _parse_xsd(self, m):
        root = ET.parse(m.xsd_path).getroot()
        for st in root.findall(XS + "simpleType"):
            values = list(OrderedDict.fromkeys(e.get("value") for e in st.iter(XS + "enumeration")))
            if values:
                m.enums[st.get("name")] = Enum(st.get("name"), values, m)
        for ct in root.findall(XS + "complexType"):
            t = Type(ct.get("name"), m)
            t.abstract = ct.get("abstract") == "true"
            for ext in ct.iter(XS + "extension"):
                t.base = ext.get("base")
                break
            t.choice_groups = []

            def collect(container, in_choice):
                names = []
                for e in container:
                    tag = local(e.tag)
                    if tag == "element":
                        if e.get("name"):
                            t.fields.append(Field(e.get("name"), e.get("type"), "0" if in_choice else e.get("minOccurs", "1"), e.get("maxOccurs", "1")))
                            names.append(e.get("name"))
                        elif e.get("ref") and t.is_property:
                            t.prop_target = e.get("ref")
                    elif tag in ("sequence", "choice"):
                        inner = collect(e, in_choice or tag == "choice")
                        if tag == "choice":
                            t.choice_groups.append(inner)
                        names.extend(inner)
                return names

            top = next((c for c in ct.iter() if local(c.tag) in ("sequence", "choice")), None)
            if top is not None:
                t.choice = local(top.tag) == "choice"
                names = collect(top, t.choice)
                if t.choice:
                    t.choice_groups.append(names)
            m.types[t.name] = t
        for e in root.findall(XS + "element"):
            name, tname, sg = e.get("name"), e.get("type"), e.get("substitutionGroup") or ""
            if tname and split_ref(tname)[0] == m.prefix:
                m.elements[name] = split_ref(tname)[1]
                if e.get("abstract") == "true" and split_ref(tname)[1] in m.types:
                    m.types[split_ref(tname)[1]].abstract = True       # abstract element: never instantiated
            if "_GenericApplicationPropertyOf" in sg:
                h = Hook(name, sg.split("_GenericApplicationPropertyOf")[1], None, m)
                h.prefix = sg.split(":")[0]
                h.xsd_type = tname
                m.hooks.append(h)

    # ----------------------------------------------------------------- JAXB
    def _parse_jaxb(self, m):
        for fn in os.listdir(m.jaxb_dir):
            if fn.endswith(".java"):
                m.jaxb_classes.add(fn[:-5])
        src = open(os.path.join(m.jaxb_dir, "ObjectFactory.java"), encoding="utf-8").read()
        for mm in re.finditer(r'@XmlElementDecl\(namespace = "[^"]*", name = "([^"]+)"[^)]*\)\s*public JAXBElement<[^>]+> (create\w+)\(', src):
            m.factory[mm.group(1)] = mm.group(2)

    def jaxb_properties(self, t):
        """Parse accessors of the generated JAXB class of a type: normalized property name -> JaxbProperty."""
        src = open(os.path.join(t.module.jaxb_dir, t.name + ".java"), encoding="utf-8").read()
        props = {}
        for m in re.finditer(r"public ([\w.<>?, ]+?) ((?:get|is)[A-Z_]\w*)\(\)", src):
            jtype, getter = m.group(1), m.group(2)
            if getter.startswith("isSet"):
                continue
            prop = getter[3:] if getter.startswith("get") else getter[2:]
            props[norm(prop)] = JaxbProperty(getter, None, jtype, jtype.startswith("List<"),
                                             jtype.startswith("JAXBElement<"), jtype in ("double", "boolean", "int", "long"))
        for m in re.finditer(r"public void (set[A-Z_]\w*)\(([\w.<>?, ]+?) value\)", src):
            prop = m.group(1)[3:]
            if norm(prop) in props:
                props[norm(prop)].setter = m.group(1)
        return props

    # -------------------------------------------------------------- mapping
    def _parse_mapping(self, path):
        root = ET.parse(path).getroot()
        # the schema ids of the module namespaces (the ADE Manager numbers the i-UR schemas ur_0.. in its own order)
        by_id = {}
        for sch in root.iter():
            if local(sch.tag) == "schema":
                for ns in sch:
                    if local(ns.tag) == "namespace":
                        for m in self.modules.values():
                            if (ns.text or "").rstrip("/") == m.namespace.rstrip("/"):
                                m.schema_id = sch.get("id")
                                by_id[m.schema_id] = m
        for m in self.modules.values():
            if m.schema_id is None:
                # no ADE Manager mapping of this module yet: the citygml4j side can still be generated
                print("warning: %s schema (%s) not found in %s" % (m.prefix, m.namespace, path), file=sys.stderr)
        for el in root.iter():
            tag = local(el.tag)
            if tag in ("complexType", "featureType") and el.get("schema") in by_id:
                mt = MappingType(el)
                by_id[el.get("schema")].mapping_types[mt.path] = mt
            elif tag == "propertyInjection":
                self.injections.append(MappingInjection(el))

    def _parse_ddl(self, path):
        ddl = open(path, encoding="utf-8").read()
        for m in re.finditer(r"^CREATE TABLE (\w+)\n\((.*?)\n\);", ddl, re.S | re.M):
            cols = []
            for l in m.group(2).splitlines():
                l = l.strip()
                if l and not l.startswith("PRIMARY"):
                    cols.append(l.split()[0])
                    seq = re.search(r"nextval\('(\w+)'", l)
                    if seq:
                        self.table_sequence[m.group(1)] = seq.group(1)
            self.ddl_tables[m.group(1)] = cols
        self.sequences = re.findall(r"^CREATE SEQUENCE (\w+)$", ddl, re.M)

    # ----------------------------------------------------------------- link
    def _link(self):
        for t in self.types.values():
            base = self.resolve(t.base) if t.base else None
            if base is not None:
                t.base = base
                base.subtypes.append(t)
            else:
                t.core_base = t.base
                t.base = None
            if t.is_property and t.prop_target:
                prefix, el = split_ref(t.prop_target)
                m = self.modules.get(prefix)
                if m is not None and el in m.elements:
                    t.prop_target = m.types[m.elements[el]]
                else:
                    t.foreign_target = t.prop_target       # e.g. core:_CityObject
                    t.prop_target = None
                props = self.jaxb_properties(t)
                jp = props.get(norm(el))
                t.polymorphic = jp is not None and jp.is_jaxb_element
        for m in self.modules.values():
            for el, tname in m.elements.items():
                t = m.types[tname]
                if not t.is_property and t.element is None:
                    t.element = el
        for t in self.types.values():
            if t.is_property:
                continue
            props = self.jaxb_properties(t)
            for f in t.fields:
                f.owner = t
                xt = f.xsd_type
                target = self.resolve(xt)
                if xt in SCALAR_KINDS:
                    f.kind = SCALAR_KINDS[xt]
                elif isinstance(target, Enum):
                    f.kind, f.target = "enum", target
                elif isinstance(target, Type) and target.is_property:
                    f.kind, f.target = ("property" if target.prop_target is not None else "cityObjectRef"), target
                    if target.prop_target is None and target.foreign_target != "core:_CityObject":
                        f.kind = "unsupported"
                elif isinstance(target, Type):
                    f.kind, f.target = "inline", target
                else:
                    f.kind = "unsupported"
                key = norm("clazz" if f.name == "class" else java_name(f.name))
                if t.is_feature and f.name in FEATURE_FIELD_NAMES:
                    key = norm(FEATURE_FIELD_NAMES[f.name])
                f.jaxb = props.get(key)
                if f.kind == "enum" and f.jaxb is not None and f.jaxb.java_type in ("String", "List<String>"):
                    # ade-xjc binds enumerations with values that are no Java identifiers as plain strings
                    f.enum_values = f.target.values
                    f.kind, f.target = "string", None
                if f.kind == "inline" and f.target is t:
                    f.kind = "unsupported"          # a type nested in itself (uro 2.0/3.0 ControlPoint.parameter)
            t.dropped = [f for f in t.fields if f.kind == "unsupported"]
            t.fields = [f for f in t.fields if f.kind != "unsupported"]
            t.mapping = t.module.mapping_types.get(t.mapping_path)
        for h in self.hooks:
            if h.xsd_type:
                target = self.resolve(h.xsd_type)
                if isinstance(target, Type):
                    h.prop_type = target
            for inj in self.injections:
                if h.element in inj.props and inj.props[h.element].get("schema") == h.module.schema_id:
                    h.injection = inj
                    h.mapping = inj.props[h.element]
        all_mapping_types = [mt for m in self.modules.values() for mt in m.mapping_types.values()]
        for mt in all_mapping_types:
            mt.base = next((x for x in all_mapping_types if x.id == mt.base_id), None) if mt.base_id else None
        # feature types (with their subtypes) that are reachable through a feature property or a feature-typed hook:
        # they are nested in other features and not exported as city object members
        self.nested_features = set()
        for t in self.types.values():
            if not t.is_property:
                for f in t.fields:
                    if f.kind == "property" and f.target.prop_target.is_feature:
                        self.nested_features.add(f.target.prop_target.qname)
        for h in self.hooks:
            if h.prop_type is not None and h.prop_type.prop_target is not None and h.prop_type.prop_target.is_feature:
                self.nested_features.add(h.prop_type.prop_target.qname)

    # -------------------------------------------------------------- helpers
    def feature_types(self, module=None):
        """The ADE feature types (ancestors first), of one module or of all."""
        out = OrderedDict()
        for t in self.types.values():
            if t.is_property or not t.is_feature or (module is not None and t.module is not module):
                continue
            for a in reversed(t.ancestors()):
                out.setdefault(a.qname, a)
            out[t.qname] = t
        return list(out.values())

    def closure(self, hooks, features=()):
        """All non-property data types reachable from the given hooks and feature types (including subtypes and nested types)."""
        out = OrderedDict()

        def add(t):
            if t.qname in out or t.is_feature:
                return
            out[t.qname] = t
            for s in t.subtypes:
                add(s)
            for f in t.all_fields():
                if f.kind == "property":
                    add(f.target.prop_target)
                elif f.kind == "inline":
                    add(f.target)

        for h in hooks:
            if h.prop_type is not None:
                add(h.prop_type.prop_target)
        for t in features:
            for f in t.fields:
                if f.kind == "property":
                    add(f.target.prop_target)
                elif f.kind == "inline":
                    add(f.target)
        # abstract base types of the reachable types (their own fields are inherited)
        for t in list(out.values()):
            for a in t.ancestors():
                out.setdefault(a.qname, a)
        ordered = OrderedDict()
        for t in out.values():
            for a in reversed(t.ancestors()):
                ordered.setdefault(a.qname, a)
            ordered[t.qname] = t
        return list(ordered.values())

    def property_types(self, types, hooks=None):
        """Property types used by the given types or hooks (city object references included)."""
        names = {t.qname for t in types}
        out = OrderedDict()
        for h in self.hooks if hooks is None else hooks:
            if h.prop_type is not None and h.prop_type.prop_target is not None and h.prop_type.prop_target.qname in names:
                out[h.prop_type.qname] = h.prop_type
        for t in types:
            for f in t.fields:
                if f.kind in ("property", "cityObjectRef"):
                    out[f.target.qname] = f.target
        return list(out.values())


def modules_for(cg4j_repo, prefixes, version):
    """Module objects of the given prefixes for one edition (XSDs under resources/ade-xjc/schemas, JAXB under src-gen)."""
    out = []
    for prefix in prefixes:
        pkg = "jp.geospatial.iur._%s.%s" % (version.replace(".", "_"), prefix)
        out.append(Module(prefix, os.path.join(cg4j_repo, "resources", "ade-xjc", "schemas", XSD_FILES[prefix]), pkg,
                          os.path.join(cg4j_repo, "src-gen", "main", "java", *pkg.split("."))))
    return out
