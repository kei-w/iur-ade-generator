"""Generate the uro model classes and the JAXB (un)marshallers of iur-ade-citygml4j from the XSD.

Usage: gen_citygml4j.py <citygml4j repo> <citydb repo> <version> <preset: all|phaseA|phaseB|phaseC> [modules: uro,urf]

The generated code follows the style of the hand-written iur-ade classes (see gen_uro_model notes in poc/README).
"""

import os
import re
import sys
from collections import OrderedDict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from . import urospec
from .urospec import cap, uncap

JAVA_KEYWORDS = {
    "class",
    "default",
    "package",
    "new",
    "public",
    "private",
    "static",
    "final",
    "import",
    "switch",
    "case",
}
MODEL_FIELD_NAMES = {"class": "classifier"}
FEATURE_FIELD_NAMES = urospec.FEATURE_FIELD_NAMES
VISITORS = ("FeatureVisitor", "FeatureFunctor", "GMLVisitor", "GMLFunctor")

# simple hooks that are not uro property types; their model classes are kept as-is
SPECIAL_HOOKS = {"fiscalYearOfPublication": "FiscalYearOfPublicationProperty", "language": "LanguageProperty"}

IMPORTS = {
    "Code": "org.citygml4j.model.gml.basicTypes.Code",
    "Measure": "org.citygml4j.model.gml.basicTypes.Measure",
    "Length": "org.citygml4j.model.gml.measures.Length",
    "GeometryProperty": "org.citygml4j.model.gml.geometry.GeometryProperty",
    "AbstractGeometry": "org.citygml4j.model.gml.geometry.AbstractGeometry",
    "PointProperty": "org.citygml4j.model.gml.geometry.primitives.PointProperty",
    "GeometricComplexProperty": "org.citygml4j.model.gml.geometry.complexes.GeometricComplexProperty",
    "AddressProperty": "org.citygml4j.model.citygml.core.AddressProperty",
    "LocalDate": "java.time.LocalDate",
    "Year": "java.time.Year",
    "YearMonth": "java.time.YearMonth",
    "List": "java.util.List",
    "ArrayList": "java.util.ArrayList",
    "BigInteger": "java.math.BigInteger",
    "CodeType": "net.opengis.gml.CodeType",
    "MeasureType": "net.opengis.gml.MeasureType",
    "LengthType": "net.opengis.gml.LengthType",
    "XMLGregorianCalendar": "javax.xml.datatype.XMLGregorianCalendar",
    "ModelObject": "org.citygml4j.model.common.base.ModelObject",
    "StringOrRef": "org.citygml4j.model.gml.base.StringOrRef",
    "MultiSurfaceProperty": "org.citygml4j.model.gml.geometry.aggregates.MultiSurfaceProperty",
    "MultiCurveProperty": "org.citygml4j.model.gml.geometry.aggregates.MultiCurveProperty",
    "MultiPointProperty": "org.citygml4j.model.gml.geometry.aggregates.MultiPointProperty",
    "DirectPosition": "org.citygml4j.model.gml.geometry.primitives.DirectPosition",
    "LodRepresentation": "org.citygml4j.model.citygml.core.LodRepresentation",
    "BoundingShape": "org.citygml4j.model.gml.feature.BoundingShape",
    "BoundingBoxOptions": "org.citygml4j.util.bbox.BoundingBoxOptions",
    "SimpleBoundingBoxCalculator": "org.citygml4j.util.bbox.SimpleBoundingBoxCalculator",
    "FeatureVisitor": "org.citygml4j.model.common.visitor.FeatureVisitor",
    "FeatureFunctor": "org.citygml4j.model.common.visitor.FeatureFunctor",
    "GMLVisitor": "org.citygml4j.model.common.visitor.GMLVisitor",
    "GMLFunctor": "org.citygml4j.model.common.visitor.GMLFunctor",
    "ADEModelObject": "org.citygml4j.model.citygml.ade.binding.ADEModelObject",
    "TypeType": "org.w3._1999.xlink.TypeType",
    "ShowType": "org.w3._1999.xlink.ShowType",
    "ActuateType": "org.w3._1999.xlink.ActuateType",
    "XLinkType": "org.citygml4j.model.gml.xlink.XLinkType",
    "XLinkShow": "org.citygml4j.model.gml.xlink.XLinkShow",
    "XLinkActuate": "org.citygml4j.model.gml.xlink.XLinkActuate",
}


def model_field(f):
    name = urospec.java_name(f.name)
    if f.owner is not None and f.owner.is_feature and name in FEATURE_FIELD_NAMES:
        return FEATURE_FIELD_NAMES[name]
    return MODEL_FIELD_NAMES.get(name, name + "Value" if name in JAVA_KEYWORDS else name)


def write(path, text):
    d, name = os.path.split(path)
    os.makedirs(d, exist_ok=True)
    # case-insensitive file systems keep the old name of a file whose class name changed its case
    for existing in os.listdir(d):
        if existing != name and existing.lower() == name.lower():
            os.remove(os.path.join(d, existing))
    with open(path, "w", encoding="utf-8", newline="\n") as fp:
        fp.write(text)


def render_imports(imports):
    java = sorted(i for i in imports if not i.startswith("java"))
    jdk = sorted(i for i in imports if i.startswith("java"))
    out = "\n".join("import %s;" % i for i in java)
    if jdk:
        out += ("\n\n" if out else "") + "\n".join("import %s;" % i for i in jdk)
    return out


def infer_imports(body, extra=()):
    imports = set(extra)
    for token, imp in IMPORTS.items():
        if re.search(r"\b%s\b" % token, body):
            imports.add(imp)
    return imports


class Generator:
    def __init__(self, spec, repo, hooks, features=True):
        self.spec = spec
        self.repo = repo
        self.modules = list(spec.modules.values())
        self.hooks = [h for h in hooks if h.prop_type is not None]
        self.special = [h for h in hooks if h.prop_type is None and h.element in SPECIAL_HOOKS]
        self.features = spec.feature_types() if features else []
        self.feature_hooks = []  # feature-typed hooks (uro 3.2 pointCloud), not supported yet
        self.types = spec.closure(self.hooks, self.features)
        self.items = self._order()
        self.enums = OrderedDict()
        for t in self.types + self.features:
            for f in t.fields:
                if f.kind == "enum":
                    self.enums[f.target.qname] = f.target
                if f.jaxb is None:
                    raise ValueError("cannot generate %s.%s (%s)" % (t.name, f.name, f.xsd_type))
            for f in t.dropped:
                print("dropped unsupported field %s.%s (%s)" % (t.model, f.name, f.xsd_type), file=sys.stderr)
        self.src = os.path.join(repo, "src", "main", "java", "org", "citygml4j", "ade", "iur")
        header_src = open(
            os.path.join(self.src, "model", "uro", "FiscalYearOfPublicationProperty.java"), encoding="utf-8"
        ).read()
        self.header = header_src[: header_src.index("*/") + 2]
        self.written = set()

    def model_dir(self, module):
        return os.path.join(self.src, "model", module.prefix)

    def bind_dir(self, module):
        return os.path.join(self.src, "bind", module.prefix)

    def out(self, path, text):
        self.written.add(os.path.normcase(path))
        write(path, text)

    def model_ref(self, t, module):
        """Simple name of a model class, fully qualified when it belongs to another module."""
        return t.model if t.module is module else f"{t.module.model_pkg}.{t.model}"

    def _order(self):
        """Types and property types in the order used for mapper registrations and methods."""
        items, done = [], set()
        prop_of = {}
        refs = []
        for p in self.spec.property_types(self.types + self.features):
            if p.prop_target is not None:
                prop_of[p.prop_target.qname] = p
            else:
                refs.append(p)  # city object references (urf:target)

        def visit(t):
            if t.qname in done:
                return
            done.add(t.qname)
            items.append(t)
            for s in t.subtypes:
                visit(s)
            if t.qname in prop_of:
                items.append(prop_of[t.qname])
            for f in t.fields:
                if f.kind == "property":
                    visit(f.target.prop_target)
                elif f.kind == "inline":
                    visit(f.target)

        for h in self.hooks:
            visit(h.prop_type.prop_target)
        for t in self.features:
            if t.base is None:
                visit(t)
        return items + refs

    # ------------------------------------------------------------------ model
    def gen_model(self):
        for t in self.types:
            self.gen_data_type(t)
        for t in self.features:
            self.gen_feature_type(t)
        for p in self.spec.property_types(self.types + self.features):
            if p.prop_target is None:
                self.gen_feature_property_type(
                    p, "AbstractCityObject", "org.citygml4j.model.citygml.core.AbstractCityObject"
                )
            elif p.prop_target.is_feature:
                self.gen_feature_property_type(p, p.prop_target.model)
            else:
                self.gen_property_type(p)
        for h in self.hooks:
            self.gen_property_element(h)
        for e in self.enums.values():
            self.gen_enum(e)

    def accessors(self, t, imports):
        """Field declarations and accessor methods of a model class."""
        fields, methods = [], []
        for f in t.fields:
            fname, ftype = model_field(f), f.model_type
            if f.foreign:
                imports.add(f"{f.target.module.model_pkg}.{f.target.model}")
            fields.append("    private %s %s;\n" % (ftype, fname))
            getter, setter = "get" + cap(fname), "set" + cap(fname)
            if f.multi:
                if f.is_child:
                    imports.add("org.citygml4j.model.common.base.ModelObjects")
                    imports.add("org.citygml4j.model.common.child.ChildList")
                    methods.append(f"""    public {ftype} {getter}() {{
        if ({fname} == null)
            {fname} = new ChildList<>(this);

        return {fname};
    }}

    public void {setter}({ftype} {fname}) {{
        this.{fname} = ModelObjects.setParent({fname}, this);
    }}
""")
                else:
                    imports.add(IMPORTS["ArrayList"])
                    methods.append(f"""    public {ftype} {getter}() {{
        if ({fname} == null)
            {fname} = new ArrayList<>();

        return {fname};
    }}

    public void {setter}({ftype} {fname}) {{
        this.{fname} = {fname};
    }}
""")
            elif f.is_child:
                imports.add("org.citygml4j.model.common.base.ModelObjects")
                methods.append(f"""    public {ftype} {getter}() {{
        return {fname};
    }}

    public void {setter}({ftype} {fname}) {{
        this.{fname} = ModelObjects.setParent({fname}, this);
    }}
""")
            else:
                methods.append(f"""    public {ftype} {getter}() {{
        return {fname};
    }}

    public void {setter}({ftype} {fname}) {{
        this.{fname} = {fname};
    }}
""")
        return fields, methods

    @staticmethod
    def copy_methods(t, super_copy):
        name = t.model
        if t.abstract:
            return f"""    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {{
        if (target == null)
            throw new IllegalArgumentException("Target argument must not be null for abstract copyable classes.");

        {name} copy = ({name}) target;
{super_copy}        return ObjectCopier.copyTo(this, copy, {name}.class, copyBuilder);
    }}
"""
        copier = (
            f"ObjectCopier.copyTo(this, copy, {name}.class, copyBuilder)"
            if t.subtypes
            else "ObjectCopier.copyTo(this, copy, copyBuilder)"
        )
        return f"""    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {{
        {name} copy = target == null ? new {name}() : ({name}) target;
{super_copy}        return {copier};
    }}

    @Override
    public Object copy(CopyBuilder copyBuilder) {{
        return copyTo(new {name}(), copyBuilder);
    }}
"""

    def gen_feature_type(self, t):
        """An ADE feature class: a subclass of the citygml4j class of its CityGML base type."""
        name = t.model
        core_model, _, _, _ = t.feature_base
        root = t.base is None
        base = t.base.model if not root else core_model.rsplit(".", 1)[1]
        imports = {"org.citygml4j.builder.copy.CopyBuilder", "org.citygml4j.builder.copy.ObjectCopier"}
        if root:
            imports |= {core_model, IMPORTS["ADEModelObject"]}
        fields, methods = self.accessors(t, imports)
        lods = [
            f
            for f in t.fields
            if f.lod is not None and f.kind in ("geometry", "multiSurface", "multiCurve", "multiPoint")
        ]
        visitable = root and t.core_base in urospec.ABSTRACT_FEATURE_BASES
        if visitable:
            methods.append("""    @Override
    public BoundingShape calcBoundedBy(BoundingBoxOptions options) {
        return SimpleBoundingBoxCalculator.calcBoundedBy(this, options);
    }
""")
            imports |= {IMPORTS[k] for k in ("BoundingShape", "BoundingBoxOptions", "SimpleBoundingBoxCalculator")}
        if lods:
            lines = "".join(f"        lodRepresentation.addRepresentation({f.lod}, {model_field(f)});\n" for f in lods)
            methods.append(f"""    @Override
    public LodRepresentation getLodRepresentation() {{
        LodRepresentation lodRepresentation = {"new LodRepresentation()" if root else "super.getLodRepresentation()"};
{lines}
        return lodRepresentation;
    }}
""")
            imports.add(IMPORTS["LodRepresentation"])
        parts = []
        if fields:
            parts.append("".join(fields))
        parts.extend(methods)
        parts.append(self.copy_methods(t, "        super.copyTo(copy, copyBuilder);\n"))
        if visitable:
            parts.append("""    @Override
    public void accept(FeatureVisitor visitor) {
        visitor.visit(this);
    }

    @Override
    public <T> T accept(FeatureFunctor<T> visitor) {
        return visitor.apply(this);
    }

    @Override
    public void accept(GMLVisitor visitor) {
        visitor.visit(this);
    }

    @Override
    public <T> T accept(GMLFunctor<T> visitor) {
        return visitor.apply(this);
    }
""")
            imports |= {IMPORTS[k] for k in VISITORS}
        body = "\n".join(parts)
        imports |= infer_imports("".join(fields))
        self.out(
            os.path.join(self.model_dir(t.module), name + ".java"),
            f"""{self.header}

package {t.module.model_pkg};

{render_imports(imports)}

public {"abstract " if t.abstract else ""}class {name} extends {base}{" implements ADEModelObject" if root else ""} {{
{body}}}
""",
        )

    def gen_feature_property_type(self, p, target, target_import=None):
        name = p.model
        imports = [
            "org.citygml4j.builder.copy.CopyBuilder",
            "org.citygml4j.model.citygml.ade.binding.ADEModelObject",
            "org.citygml4j.model.gml.feature.FeatureProperty",
        ] + ([target_import] if target_import else [])
        self.out(
            os.path.join(self.model_dir(p.module), name + ".java"),
            f"""{self.header}

package {p.module.model_pkg};

{render_imports(imports)}

public class {name} extends FeatureProperty<{target}> implements ADEModelObject {{

    public {name}() {{
        super();
    }}

    public {name}({target} object) {{
        super(object);
    }}

    public {name}(String href) {{
        super(href);
    }}

    @Override
    public Class<{target}> getAssociableClass() {{
        return {target}.class;
    }}

    @Override
    public Object copy(CopyBuilder copyBuilder) {{
        return copyTo(new {name}(), copyBuilder);
    }}

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {{
        {name} copy = (target == null) ? new {name}() : ({name}) target;
        return super.copyTo(copy, copyBuilder);
    }}
}}
""",
        )

    def gen_data_type(self, t):
        name = t.model
        base = t.base.model if t.base else "AbstractDataType"
        imports = {"org.citygml4j.builder.copy.CopyBuilder", "org.citygml4j.builder.copy.ObjectCopier"}
        if not t.base:
            imports.add("org.citygml4j.ade.iur.model.common.AbstractDataType")
        fields, methods = self.accessors(t, imports)
        parts = []
        if fields:
            parts.append("".join(fields))
        parts.extend(methods)
        parts.append(self.copy_methods(t, "        super.copyTo(copy, copyBuilder);\n" if t.base else ""))
        body = "\n".join(parts)
        imports |= infer_imports("".join(fields))
        if t.base is not None and t.base.module is not t.module:
            imports.add(f"{t.base.module.model_pkg}.{t.base.model}")
        self.out(
            os.path.join(self.model_dir(t.module), name + ".java"),
            f"""{self.header}

package {t.module.model_pkg};

{render_imports(imports)}

public {"abstract " if t.abstract else ""}class {name} extends {base} {{
{body}}}
""",
        )

    def gen_property_type(self, p):
        name, target = p.model, p.prop_target.model
        self.out(
            os.path.join(self.model_dir(p.module), name + ".java"),
            f"""{self.header}

package {p.module.model_pkg};

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.model.citygml.ade.binding.ADEModelObject;
import org.citygml4j.model.gml.base.AssociationByRep;

public class {name} extends AssociationByRep<{target}> implements ADEModelObject {{

    public {name}() {{
        super();
    }}

    public {name}({target} object) {{
        super(object);
    }}

    @Override
    public Class<{target}> getAssociableClass() {{
        return {target}.class;
    }}

    @Override
    public Object copy(CopyBuilder copyBuilder) {{
        return copyTo(new {name}(), copyBuilder);
    }}

    @Override
    public Object copyTo(Object target, CopyBuilder copyBuilder) {{
        {name} copy = (target == null) ? new {name}() : ({name}) target;
        return super.copyTo(copy, copyBuilder);
    }}
}}
""",
        )

    def gen_property_element(self, h):
        name, value = h.model_element, h.prop_type.model
        self.out(
            os.path.join(self.model_dir(h.module), name + ".java"),
            f"""{self.header}

package {h.module.model_pkg};

import org.citygml4j.builder.copy.CopyBuilder;
import org.citygml4j.model.citygml.ade.binding.ADEGenericApplicationProperty;

public class {name} extends ADEGenericApplicationProperty<{value}> {{

    public {name}() {{
        super();
    }}

    public {name}({value} value) {{
        super(value);
    }}

    @Override
    public Object copy(CopyBuilder copyBuilder) {{
        return copyTo(new {name}(), copyBuilder);
    }}
}}
""",
        )

    def gen_enum(self, e):
        consts = ",\n".join(
            '    %s("%s")' % (re.sub(r"^(?=[0-9])", "_", re.sub(r"[^A-Za-z0-9_]", "_", v).upper()), v) for v in e.values
        )
        self.out(
            os.path.join(self.model_dir(e.module), e.model + ".java"),
            f"""{self.header}

package {e.module.model_pkg};

public enum {e.model} {{
{consts};

    private final String value;

    {e.model}(String value) {{
        this.value = value;
    }}

    public String value() {{
        return value;
    }}

    public static {e.model} fromValue(String value) {{
        for ({e.model} v : {e.model}.values()) {{
            if (v.value.equals(value))
                return v;
        }}

        return null;
    }}

    @Override
    public String toString() {{
        return value;
    }}
}}
""",
        )

    # ------------------------------------------------------------- marshaller
    def jaxb_enum(self, e):
        return e.module.jaxb_pkg + "." + e.jaxb

    @staticmethod
    def jaxb_fqn(t):
        return f"{t.module.jaxb_pkg}.{t.jaxb}"

    def clashing_models(self, module):
        """Model class names of a module that are also JAXB class names (urf 3.x UrbanDevelopmentProjectTypeType ->
        UrbanDevelopmentProjectType, ThreeDimensionalExtent): the bind code imports them explicitly and refers to the
        JAXB classes by their qualified names."""
        items = [i for i in self.items if i.module is module]
        return {i.model for i in items} & {i.jaxb for i in items}

    def jaxb_ref(self, t):
        return self.jaxb_fqn(t) if t.jaxb in self.clashing_models(t.module) else t.jaxb

    def marshal_field(self, f):
        g = "src.get%s()" % cap(model_field(f))
        j = f.jaxb
        setter = "dest.%s" % j.setter if j.setter else None
        adder = "dest.%s().add" % j.getter
        k = f.kind
        if f.multi:
            var = model_field(f)
            elem = f.model_type[5:-1]
            conv = {
                "string": var,
                "code": "helper.getGMLMarshaller().marshalCode(%s)" % var,
                "measure": "helper.getGMLMarshaller().marshalMeasure(%s)" % var,
                "length": "helper.getGMLMarshaller().marshalLength(%s)" % var,
                "date": "marshaller.toCalendar(%s)" % var,
                "year": "marshaller.toCalendar(%s)" % var,
                "yearMonth": "marshaller.toCalendar(%s)" % var,
                "integer": "BigInteger.valueOf(%s)" % var,
                "double": var,
                "boolean": var,
                "enum": "%s.fromValue(%s.value())" % (self.jaxb_enum(f.target) if f.kind == "enum" else "", var),
                "property": "marshal%s(%s)" % (f.target.model if f.target else "", var),
                "inline": "marshal%s(%s)" % (f.target.model if f.target else "", var),
                "cityObjectRef": "marshal%s(%s)" % (f.target.model if f.target else "", var),
            }[k]
            if k in ("property", "inline") and f.foreign:
                # a type of another module: through the JAXB marshaller, which dispatches to that module
                conv = "(%s) helper.getJAXBMarshaller().marshal(%s)" % (self.jaxb_fqn(f.target), var)
                elem = f"{f.target.module.model_pkg}.{f.target.model}"
            return f"        for ({elem} {var} : {g})\n            {adder}({conv});\n"
        if k == "string":
            return f"        {setter}({g});\n"
        if k == "integer":
            if j.java_type == "BigInteger":
                return f"        if ({g} != null)\n            {setter}(BigInteger.valueOf({g}));\n"
            return f"        {setter}({g});\n"
        if k in ("double", "boolean"):
            if j.primitive:
                return f"        if ({g} != null)\n            {setter}({g});\n"
            return f"        {setter}({g});\n"
        if k in ("date", "year", "yearMonth"):
            return f"        if ({g} != null)\n            {setter}(marshaller.toCalendar({g}));\n"
        if k in ("code", "measure", "length"):
            m = {"code": "marshalCode", "measure": "marshalMeasure", "length": "marshalLength"}[k]
            return f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().{m}({g}));\n"
        if k == "enum":
            return (
                f"        if ({g} != null)\n            {setter}({self.jaxb_enum(f.target)}.fromValue({g}.value()));\n"
            )
        if k == "doubleList":
            var = model_field(f)
            return f"        for (Double {var} : {g})\n            dest.{j.getter}().add({var});\n"
        if k in ("property", "inline") and f.foreign:
            return f"        if ({g} != null)\n            {setter}(({self.jaxb_fqn(f.target)}) helper.getJAXBMarshaller().marshal({g}));\n"
        if k in ("property", "inline", "cityObjectRef"):
            return f"        if ({g} != null)\n            {setter}(marshal{f.target.model}({g}));\n"
        if k == "geometry":
            return f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().marshalGeometryProperty({g}));\n"
        if k == "point":
            return f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().marshalPointProperty({g}));\n"
        if k == "complex":
            return f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().marshalGeometricComplexProperty({g}));\n"
        if k == "address":
            return f"        if ({g} != null)\n            {setter}(helper.getCore200Marshaller().marshalAddressProperty({g}));\n"
        if k == "stringOrRef":
            return (
                f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().marshalStringOrRef({g}));\n"
            )
        if k in ("multiSurface", "multiCurve", "multiPoint"):
            return f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().marshal{cap(k)}Property({g}));\n"
        if k == "directPosition":
            return f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().marshalDirectPosition({g}));\n"
        raise ValueError(k)

    def unmarshal_field(self, f):
        s = "dest.set%s" % cap(model_field(f))
        adder = "dest.get%s().add" % cap(model_field(f))
        j = f.jaxb
        g = "src.%s()" % j.getter
        k = f.kind
        if f.multi:
            var = model_field(f)
            jelem = j.java_type[5:-1]
            conv = {
                "string": var,
                "code": "helper.getGMLUnmarshaller().unmarshalCode(%s)" % var,
                "measure": "helper.getGMLUnmarshaller().unmarshalMeasure(%s)" % var,
                "length": "helper.getGMLUnmarshaller().unmarshalLength(%s)" % var,
                "date": "%s.toGregorianCalendar().toZonedDateTime().toLocalDate()" % var,
                "year": "Year.of(%s.getYear())" % var,
                "yearMonth": "YearMonth.of(%s.getYear(), %s.getMonth())" % (var, var),
                "integer": "%s.intValue()" % var,
                "double": var,
                "boolean": var,
                "enum": "%s.%s.fromValue(%s.value())"
                % (
                    f.target.module.model_pkg if f.kind == "enum" else "",
                    f.target.model if f.kind == "enum" else "",
                    var,
                ),
                "property": "unmarshal%s(%s)" % (f.target.model if f.target else "", var),
                "inline": "unmarshal%s(%s)" % (f.target.model if f.target else "", var),
                "cityObjectRef": "unmarshal%s(%s)" % (f.target.model if f.target else "", var),
            }[k]
            if k in ("property", "inline") and f.foreign:
                conv = "(%s.%s) helper.getJAXBUnmarshaller().unmarshal(%s)" % (
                    f.target.module.model_pkg,
                    f.target.model,
                    var,
                )
                jelem = self.jaxb_fqn(f.target)
            return f"        if (src.{j.is_set}()) {{\n            for ({jelem} {var} : {g})\n                {adder}({conv});\n        }}\n"
        if k == "string":
            return f"        {s}({g});\n"
        if k == "integer":
            if j.java_type == "BigInteger":
                return f"        if (src.{j.is_set}())\n            {s}({g}.intValue());\n"
            return f"        {s}({g});\n"
        if k in ("double", "boolean"):
            if j.primitive:
                return f"        if (src.{j.is_set}())\n            {s}({g});\n"
            return f"        {s}({g});\n"
        if k == "date":
            return f"        if (src.{j.is_set}())\n            {s}({g}.toGregorianCalendar().toZonedDateTime().toLocalDate());\n"
        if k == "year":
            return (
                f"        if (src.{j.is_set}()) {{\n            LocalDate date = {g}.toGregorianCalendar().toZonedDateTime().toLocalDate();\n"
                f"            {s}(Year.of(date.getYear()));\n        }}\n"
            )
        if k == "yearMonth":
            return (
                f"        if (src.{j.is_set}()) {{\n            LocalDate date = {g}.toGregorianCalendar().toZonedDateTime().toLocalDate();\n"
                f"            {s}(YearMonth.of(date.getYear(), date.getMonthValue()));\n        }}\n"
            )
        if k in ("code", "measure", "length"):
            m = {"code": "unmarshalCode", "measure": "unmarshalMeasure", "length": "unmarshalLength"}[k]
            return f"        if (src.{j.is_set}())\n            {s}(helper.getGMLUnmarshaller().{m}({g}));\n"
        if k == "enum":
            return f"        if (src.{j.is_set}())\n            {s}({f.target.module.model_pkg}.{f.target.model}.fromValue({g}.value()));\n"
        if k == "doubleList":
            var = model_field(f)
            return f"        if (src.{j.is_set}()) {{\n            for (Double {var} : {g})\n                {adder}({var});\n        }}\n"
        if k in ("property", "inline") and f.foreign:
            return (
                f"        if (src.{j.is_set}())\n            {s}(({f.target.module.model_pkg}.{f.target.model}) "
                f"helper.getJAXBUnmarshaller().unmarshal({g}));\n"
            )
        if k in ("property", "inline", "cityObjectRef"):
            return f"        if (src.{j.is_set}())\n            {s}(unmarshal{f.target.model}({g}));\n"
        if k == "geometry":
            return f"        if (src.{j.is_set}())\n            {s}(helper.getGMLUnmarshaller().unmarshalGeometryProperty({g}));\n"
        if k == "point":
            return f"        if (src.{j.is_set}())\n            {s}(helper.getGMLUnmarshaller().unmarshalPointProperty({g}));\n"
        if k == "complex":
            return f"        if (src.{j.is_set}())\n            {s}(helper.getGMLUnmarshaller().unmarshalGeometricComplexProperty({g}));\n"
        if k == "address":
            return f"        if (src.{j.is_set}())\n            {s}(helper.getCore200Unmarshaller().unmarshalAddressProperty({g}));\n"
        if k == "stringOrRef":
            return f"        if (src.{j.is_set}())\n            {s}(helper.getGMLUnmarshaller().unmarshalStringOrRef({g}));\n"
        if k in ("multiSurface", "multiCurve", "multiPoint"):
            return f"        if (src.{j.is_set}())\n            {s}(helper.getGMLUnmarshaller().unmarshal{cap(k)}Property({g}));\n"
        if k == "directPosition":
            return f"        if (src.{j.is_set}())\n            {s}(helper.getGMLUnmarshaller().unmarshalDirectPosition({g}));\n"
        raise ValueError(k)

    @staticmethod
    def join(parts):
        """Join statements; consecutive one-line statements stay together, others are separated by a blank line."""
        out, prev_single = "", False
        for p in parts:
            if not p:
                continue
            single = p.count("\n") == 1
            if out:
                out += "" if (single and prev_single) else "\n"
            out += p
            prev_single = single
        return out

    @staticmethod
    def method_body(head, base_call, fields, tail):
        """head line(s), optional base call, blank line, fields, blank line, tail."""
        body = head + base_call
        if fields:
            body += "\n" + fields + "\n"
        return body + tail

    def marshal_type_methods(self, t):
        name, jt = t.model, self.jaxb_ref(t)
        fields = self.join(self.marshal_field(f) for f in t.fields)
        out = []
        if t.is_feature:
            # feature types always delegate to their base: the citygml4j marshaller of the CityGML base type at the root
            base_call = (
                f"        marshal{t.base.model}(src, dest);\n"
                if t.base
                else f"        helper.{t.feature_base[2]}(src, dest);\n"
            )
            with_dest = t.abstract or t.subtypes
        else:
            base_call = f"        marshal{t.base.model}(src, dest);\n" if t.base and t.base.all_fields() else ""
            with_dest = (t.abstract or t.subtypes) and t.all_fields()
        if with_dest:
            body = self.join([base_call, fields])
            out.append(f"    private void marshal{name}({name} src, {jt} dest) {{\n{body}    }}\n")
        if not t.abstract:
            head = f"    private {jt} marshal{name}({name} src) {{\n        {jt} dest = factory.create{t.jaxb}();\n"
            if with_dest:
                base_call, fields = f"        marshal{name}(src, dest);\n", ""
            out.append(self.method_body(head, base_call, fields, "        return dest;\n    }\n"))
        return out

    def marshal_property_method(self, p):
        name, jt, target = p.model, self.jaxb_ref(p), p.prop_target
        if target is None:  # city object reference (core:_CityObject)
            jp = self.spec.jaxb_properties(p)[urospec.norm(urospec.split_ref(p.foreign_target)[1])]
            target_jaxb, feature = "AbstractCityObjectType", True
        else:
            jp = self.spec.jaxb_properties(p)[urospec.norm(target.element)]
            target_jaxb, feature = self.jaxb_ref(target), target.is_feature
        if p.polymorphic:
            body = (
                f"        if (src.getObject() != null) {{\n"
                f"            JAXBElement<?> elem = helper.getJAXBMarshaller().marshalJAXBElement(src.getObject());\n"
                f"            if (elem != null && elem.getValue() instanceof {target_jaxb})\n"
                f"                dest.{jp.setter}((JAXBElement<? extends {target_jaxb}>) elem);\n        }}\n"
            )
        else:
            body = f"        if (src.isSetObject())\n            dest.{jp.setter}(marshal{target.model}(src.getObject()));\n"
        if feature:
            body += """
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
"""
        return f"    private {jt} marshal{name}({name} src) {{\n        {jt} dest = factory.create{p.jaxb}();\n\n{body}\n        return dest;\n    }}\n"

    def unmarshal_type_methods(self, t):
        name, jt = t.model, self.jaxb_ref(t)
        fields = self.join(self.unmarshal_field(f) for f in t.fields)
        out = []
        if t.is_feature:
            base_call = (
                f"        unmarshal{t.base.model}(src, dest);\n"
                if t.base
                else f"        helper.{t.feature_base[3]}(src, dest);\n"
            )
            with_dest = t.abstract or t.subtypes
        else:
            base_call = f"        unmarshal{t.base.model}(src, dest);\n" if t.base and t.base.all_fields() else ""
            with_dest = (t.abstract or t.subtypes) and t.all_fields()
        if with_dest:
            body = self.join([base_call, fields])
            out.append(
                f"    private void unmarshal{name}({jt} src, {name} dest) throws MissingADESchemaException {{\n{body}    }}\n"
            )
        if not t.abstract:
            head = f"    private {name} unmarshal{name}({jt} src) throws MissingADESchemaException {{\n        {name} dest = new {name}();\n"
            if with_dest:
                base_call, fields = f"        unmarshal{name}(src, dest);\n", ""
            out.append(self.method_body(head, base_call, fields, "        return dest;\n    }\n"))
        return out

    def unmarshal_property_method(self, p):
        name, jt, target = p.model, self.jaxb_ref(p), p.prop_target
        if target is None:  # city object reference (core:_CityObject)
            jp = self.spec.jaxb_properties(p)[urospec.norm(urospec.split_ref(p.foreign_target)[1])]
            target_model, feature = "AbstractCityObject", True
        else:
            jp = self.spec.jaxb_properties(p)[urospec.norm(target.element)]
            target_model, feature = target.model, target.is_feature
        if p.polymorphic:
            body = (
                f"        if (src.{jp.is_set}()) {{\n"
                f"            ModelObject object = helper.getJAXBUnmarshaller().unmarshal(src.{jp.getter}());\n"
                f"            if (object instanceof {target_model})\n"
                f"                dest.setObject(({target_model}) object);\n        }}\n"
            )
        else:
            body = f"        if (src.{jp.is_set}())\n            dest.setObject(unmarshal{target.model}(src.{jp.getter}()));\n"
        if feature:
            body += """
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
"""
        return f"    private {name} unmarshal{name}({jt} src) throws MissingADESchemaException {{\n        {name} dest = new {name}();\n\n{body}\n        return dest;\n    }}\n"

    def gen_marshaller(self, module):
        element_entries, type_entries, methods, creates = [], [], [], []
        for item in [i for i in self.items if i.module is module]:
            if item.is_property:
                type_entries.append(f"                    .with({item.model}.class, this::marshal{item.model})")
                methods.append(self.marshal_property_method(item))
            else:
                if not item.abstract:
                    type_entries.append(f"                    .with({item.model}.class, this::marshal{item.model})")
                if not item.abstract and item.element:
                    element_entries.append(f"                    .with({item.model}.class, this::create{item.model})")
                    creates.append(
                        f"    private JAXBElement<?> create{item.model}({item.model} src) {{\n"
                        f"        return factory.{module.factory[item.element]}(marshal{item.model}(src));\n    }}\n"
                    )
                methods.extend(self.marshal_type_methods(item))
        for h in [x for x in self.hooks if x.module is module]:
            el = h.model_element
            element_entries.append(f"                    .with({el}.class, this::create{el})")
            creates.append(
                f"    private JAXBElement<?> create{el}({el} src) {{\n"
                f"        return factory.{module.factory[h.element]}(marshal{h.prop_type.model}(src.getValue()));\n    }}\n"
            )
        for h in [x for x in self.special if x.module is module]:
            cls = SPECIAL_HOOKS[h.element]
            element_entries.append(f"                    .with({cls}.class, this::create{cls})")
            if h.element == "fiscalYearOfPublication":
                creates.append(
                    f"    private JAXBElement<?> create{cls}({cls} src) {{\n        return factory.{module.factory[h.element]}(marshaller.toCalendar(src.getValue()));\n    }}\n"
                )
            else:
                creates.append(
                    f"    private JAXBElement<?> create{cls}({cls} src) {{\n        return factory.{module.factory[h.element]}(helper.getGMLMarshaller().marshalCode(src.getValue()));\n    }}\n"
                )

        body = "\n".join(methods + creates)
        imports = {
            "org.citygml4j.ade.iur.bind.Marshaller",
            module.model_pkg + ".*",
            module.jaxb_pkg + ".*",
            "org.citygml4j.builder.jaxb.marshal.citygml.ade.ADEMarshallerHelper",
            "org.citygml4j.model.citygml.ade.binding.ADEMarshaller",
            "org.citygml4j.model.citygml.ade.binding.ADEModelObject",
            "org.citygml4j.util.mapper.TypeMapper",
            "javax.xml.bind.JAXBElement",
        }
        imports |= {
            IMPORTS[k]
            for k in (
                "Code",
                "Measure",
                "Length",
                "LocalDate",
                "Year",
                "YearMonth",
                "BigInteger",
                "TypeType",
                "ShowType",
                "ActuateType",
            )
            if re.search(r"\b%s\b" % k, body)
        }
        if "AbstractCityObjectType" in body:
            imports.add("net.opengis.citygml._2.AbstractCityObjectType")
        imports |= {module.model_pkg + "." + m for m in self.clashing_models(module)}
        text = f"""{self.header}

package org.citygml4j.ade.iur.bind.{module.prefix};

{render_imports(imports)}

public class {module.marshaller} implements ADEMarshaller {{
    private final Marshaller marshaller;
    private final ObjectFactory factory = new ObjectFactory();
    private ADEMarshallerHelper helper;
    private TypeMapper<JAXBElement<?>> elementMapper;
    private TypeMapper<Object> typeMapper;

    public {module.marshaller}(Marshaller marshaller) {{
        this.marshaller = marshaller;
    }}

    private synchronized TypeMapper<JAXBElement<?>> getElementMapper() {{
        if (elementMapper == null) {{
            elementMapper = TypeMapper.<JAXBElement<?>>create()
{chr(10).join(element_entries)};
        }}

        return elementMapper;
    }}

    private synchronized TypeMapper<Object> getTypeMapper() {{
        if (typeMapper == null) {{
            typeMapper = TypeMapper.create()
{chr(10).join(type_entries)};
        }}

        return typeMapper;
    }}

    @Override
    public void setADEMarshallerHelper(ADEMarshallerHelper helper) {{
        this.helper = helper;
    }}

    @Override
    public JAXBElement<?> marshalJAXBElement(ADEModelObject src) {{
        TypeMapper<JAXBElement<?>> elementMapper = getElementMapper();
        return elementMapper != null ? elementMapper.apply(src) : null;
    }}

    @Override
    public Object marshal(ADEModelObject src) {{
        TypeMapper<Object> typeMapper = getTypeMapper();
        return typeMapper != null ? typeMapper.apply(src) : null;
    }}

{body}}}
"""
        self.out(os.path.join(self.bind_dir(module), module.marshaller + ".java"), text)

    def gen_unmarshaller(self, module):
        type_entries, cases, methods = [], [], []
        for item in [i for i in self.items if i.module is module]:
            if item.is_property:
                type_entries.append(
                    f"                    .with({self.jaxb_ref(item)}.class, this::unmarshal{item.model})"
                )
                methods.append(self.unmarshal_property_method(item))
            else:
                if not item.abstract:
                    type_entries.append(
                        f"                    .with({self.jaxb_ref(item)}.class, this::unmarshal{item.model})"
                    )
                methods.extend(self.unmarshal_type_methods(item))
        for h in [x for x in self.hooks if x.module is module]:
            p = h.prop_type
            cases.append(
                f'            case "{h.element}":\n                return new {h.model_element}(unmarshal{p.model}(({self.jaxb_ref(p)}) value));'
            )
        for h in [x for x in self.special if x.module is module]:
            if h.element == "fiscalYearOfPublication":
                cases.append(
                    '            case "fiscalYearOfPublication":\n'
                    "                LocalDate fiscalYearOfPublication = ((XMLGregorianCalendar) value).toGregorianCalendar().toZonedDateTime().toLocalDate();\n"
                    "                return new FiscalYearOfPublicationProperty(Year.of(fiscalYearOfPublication.getYear()));"
                )
            else:
                cases.append(
                    '            case "language":\n                return new LanguageProperty(helper.getGMLUnmarshaller().unmarshalCode((CodeType) value));'
                )

        body = "\n".join(methods)
        imports = {
            module.model_pkg + ".*",
            module.jaxb_pkg + ".*",
            "org.citygml4j.builder.jaxb.unmarshal.citygml.ade.ADEUnmarshallerHelper",
            "org.citygml4j.model.citygml.ade.binding.ADEModelObject",
            "org.citygml4j.model.citygml.ade.binding.ADEUnmarshaller",
            "org.citygml4j.util.mapper.CheckedTypeMapper",
            "org.citygml4j.xml.io.reader.MissingADESchemaException",
            "javax.xml.bind.JAXBElement",
        }
        all_text = body + "\n".join(cases)
        imports |= {
            IMPORTS[k]
            for k in (
                "CodeType",
                "MeasureType",
                "LengthType",
                "BigInteger",
                "LocalDate",
                "Year",
                "YearMonth",
                "XMLGregorianCalendar",
                "ModelObject",
                "XLinkType",
                "XLinkShow",
                "XLinkActuate",
            )
            if re.search(r"\b%s\b" % k, all_text)
        }
        if "AbstractCityObject)" in body or "instanceof AbstractCityObject" in body:
            imports.add("org.citygml4j.model.citygml.core.AbstractCityObject")
        imports |= {module.model_pkg + "." + m for m in self.clashing_models(module)}
        text = f"""{self.header}

package org.citygml4j.ade.iur.bind.{module.prefix};

{render_imports(imports)}

public class {module.unmarshaller} implements ADEUnmarshaller {{
    private ADEUnmarshallerHelper helper;
    private CheckedTypeMapper<ADEModelObject> typeMapper;

    private synchronized CheckedTypeMapper<ADEModelObject> getTypeMapper() {{
        if (typeMapper == null) {{
            typeMapper = CheckedTypeMapper.<ADEModelObject>create()
{chr(10).join(type_entries)};
        }}

        return typeMapper;
    }}

    @Override
    public void setADEUnmarshallerHelper(ADEUnmarshallerHelper helper) {{
        this.helper = helper;
    }}

    @Override
    public ADEModelObject unmarshal(JAXBElement<?> src) throws MissingADESchemaException {{
        final Object value = src.getValue();

        // generic application properties
        switch (src.getName().getLocalPart()) {{
{chr(10).join(cases)}
        }}

        // all other types
        return unmarshal(value);
    }}

    @Override
    public ADEModelObject unmarshal(Object src) throws MissingADESchemaException {{
        CheckedTypeMapper<ADEModelObject> typeMapper = getTypeMapper();
        return typeMapper != null ? typeMapper.apply(src) : null;
    }}

{body}}}
"""
        self.out(os.path.join(self.bind_dir(module), module.unmarshaller + ".java"), text)

    # ---------------------------------------------------------------- walkers
    def walker_methods(self, t, function):
        """visit()/apply() methods of the ADE walkers for a feature type rooted in an abstract citygml4j class."""
        var = uncap(t.model)
        core = t.feature_base[0].rsplit(".", 1)[1]
        if t.base is not None:
            if function:
                return (
                    f"    public T apply({t.model} {var}) {{\n        return apply(({t.base.model}) {var});\n    }}\n"
                )
            return f"    public void visit({t.model} {var}) {{\n        visit(({t.base.model}) {var});\n    }}\n"
        steps = []
        for f in t.fields:
            g = f"{var}.get{cap(model_field(f))}()"
            if f.is_feature_property:
                if f.multi:
                    steps.append(
                        (
                            "loop",
                            f"for ({f.target.model} property : new ArrayList<>({g}))",
                            "(FeatureProperty<?>) property",
                        )
                    )
                else:
                    steps.append(("if", f"if ({g} != null)", f"(FeatureProperty<?>) {g}"))
            elif (
                f.kind in ("geometry", "multiSurface", "multiCurve", "multiPoint", "point", "complex")
                and self.walker_geometry
            ):
                steps.append(("if", f"if ({g} != null)", g))
        if function:
            body = f"        T object = walker.apply(({core}) {var});\n        if (object != null)\n            return object;\n"
            for kind, head, arg in steps:
                if kind == "loop":
                    body += f"\n        {head} {{\n            object = walker.apply({arg});\n            if (object != null)\n                return object;\n        }}\n"
                else:
                    body += f"\n        {head} {{\n            object = walker.apply({arg});\n            if (object != null)\n                return object;\n        }}\n"
            return f"    public T apply({t.model} {var}) {{\n{body}\n        return null;\n    }}\n"
        body = f"        walker.visit(({core}) {var});\n"
        for kind, head, arg in steps:
            body += f"\n        {head}\n            walker.visit({arg});\n"
        return f"    public void visit({t.model} {var}) {{\n{body}    }}\n"

    def patch_walkers(self, stale_classes=()):
        """Append the visit()/apply() methods of the ADE feature types to the four hand-written walkers; hand-written
        methods of classes that are generated now (or no longer exist) are removed first."""
        marker = "    // uro feature types (generated)\n"
        walkable = [t for t in self.features if t.root().core_base in urospec.ABSTRACT_FEATURE_BASES]
        pkgs = [m.model_pkg for m in self.modules]
        remove = set(stale_classes) | {t.model for t in walkable}
        for cls, function, geometry in (
            ("FeatureWalker", False, False),
            ("GMLWalker", False, True),
            ("FeatureFunctionWalker", True, False),
            ("GMLFunctionWalker", True, True),
        ):
            self.walker_geometry = geometry
            p = os.path.join(self.src, "walker", cls + ".java")
            s = open(p, encoding="utf-8").read()
            if marker in s:
                s = s[: s.index(marker)].rstrip("\n") + "\n}\n"
            for c in remove:
                s = re.sub(
                    r"\n    public (?:void visit|T apply)\(%s \w+\) \{\n.*?\n    \}\n" % re.escape(c),
                    "\n",
                    s,
                    flags=re.S,
                )
            s = re.sub(r"\n{3,}", "\n\n", s)
            methods = "\n".join(self.walker_methods(t, function) for t in walkable)
            imports = {f"{t.module.model_pkg}.{t.model}" for t in walkable}
            imports |= {
                f"{f.target.module.model_pkg}.{f.target.model}"
                for t in walkable
                for f in t.fields
                if f.is_feature_property
            }
            imports |= {t.feature_base[0] for t in walkable}
            existing = re.findall(r"^import ([\w.*]+);", s, re.M)
            imports |= {i for i in existing if not any(i.startswith(pkg + ".") and not i.endswith("*") for pkg in pkgs)}
            imports -= {f"{m.model_pkg}.*" for m in self.modules if m.prefix != "uro"}
            first = re.search(r"^import .*;\n", s, re.M).start()
            last = list(re.finditer(r"^import .*;\n", s, re.M))[-1].end()
            s = s[:first] + render_imports(imports) + "\n" + s[last:]
            s = s.rstrip("\n")
            assert s.endswith("}")
            s = s[:-1].rstrip("\n") + "\n\n" + marker + methods + "}\n"
            write(p, s)

    def patch_module(self, module):
        """Write the ADEModule class of a module: namespace, JAXB package, feature types and feature properties."""
        p = os.path.join(self.src, "model", "module", module.module_class + ".java")
        features = [t for t in self.features if t.module is module]
        concrete = [t for t in features if not t.abstract]
        puts = "".join(f'        features.put("{t.element}", {t.model}.class);\n' for t in concrete)
        props = sorted(
            {f.name for t in features for f in t.fields if f.is_feature_property or f.kind == "cityObjectRef"}
            | {h.element for h in self.feature_hooks if h.module is module}
        )
        top = sorted(t.element for t in concrete if t.top_level)
        prop_test = " || ".join(f'"{n}".equals(name)' for n in props) or "false"
        top_test = " || ".join(f'"{n}".equals(name)' for n in top) or "false"
        version, jaxb = module.version_const, module.jaxb_pkg
        ctor = type(
            "C",
            (),
            {
                "group": lambda self, i: (
                    f'        super("{module.namespace}",\n                "{module.prefix}",\n'
                    f'                "{module.schema_url}",\n                CityGMLVersion.v2_0_0);\n'
                )
            },
        )()
        imports = {f"{module.model_pkg}.{t.model}" for t in concrete}
        imports |= {
            "org.citygml4j.model.gml.feature.AbstractFeature",
            "org.citygml4j.model.module.ade.ADEModule",
            "org.citygml4j.model.module.citygml.CityGMLVersion",
            "javax.xml.namespace.QName",
            "java.net.URL",
            "java.util.Collections",
            "java.util.HashMap",
            "java.util.List",
            "java.util.Map",
        }
        text = f"""{self.header}

package org.citygml4j.ade.iur.model.module;

{render_imports(imports)}

public class {module.module_class} extends ADEModule {{
    public static final {module.module_class} {version} = new {module.module_class}();

    private final Map<String, Class<? extends AbstractFeature>> features;

    private {module.module_class}() {{
{ctor.group(1)}
        features = new HashMap<>();
{puts}    }}

    @Override
    public URL getSchemaResource() {{
        return {module.module_class}.class.getResource("/org/citygml4j/ade/iur/schema/{urospec.XSD_FILES[module.prefix]}");
    }}

    @Override
    public List<String> getJAXBPackageNames() {{
        return Collections.singletonList("{jaxb}");
    }}

    public String getModelPackageName() {{
        return "{module.model_pkg}";
    }}

    @Override
    public boolean hasFeatureProperty(String name) {{
        return {prop_test};
    }}

    @Override
    public boolean hasFeature(String name) {{
        return features.containsKey(name);
    }}

    @Override
    public Class<? extends AbstractFeature> getFeatureClass(String name) {{
        return features.get(name);
    }}

    @Override
    public QName getFeatureName(Class<? extends AbstractFeature> featureClass) {{
        for (Map.Entry<String, Class<? extends AbstractFeature>> entry : features.entrySet()) {{
            if (entry.getValue() == featureClass)
                return new QName(getNamespaceURI(), entry.getKey());
        }}

        return null;
    }}

    @Override
    public Map<String, Class<? extends AbstractFeature>> getFeatures() {{
        return new HashMap<>(features);
    }}

    @Override
    public boolean isTopLevelFeature(String name) {{
        return {top_test};
    }}
}}
"""
        write(p, text)

    def patch_top_level(self):
        """Point the top-level Marshaller/Unmarshaller and the ADEContext at the module constants of the generated versions."""
        for rel in (
            ("bind", "Marshaller.java"),
            ("bind", "Unmarshaller.java"),
            ("UrbanRevitalizationADEContext.java",),
        ):
            p = os.path.join(self.src, *rel)
            s = open(p, encoding="utf-8").read()
            for m in self.modules:
                s = re.sub(r"\b%s\.v\d_\d\b" % m.module_class, f"{m.module_class}.{m.version_const}", s)
            if rel[-1] == "Unmarshaller.java":
                # unmarshal(Object) receives JAXB objects (cross-module references such as urf:keyValuePairAttribute of a
                # uro property type): dispatch by the JAXB package, not by the model package
                a = s.index("public ADEModelObject unmarshal(Object src)")
                s = s[:a] + re.sub(
                    r"(\w+Module\.v\d_\d)\.getModelPackageName\(\)\.equals\(packageName\)",
                    r"\1.getJAXBPackageNames().contains(packageName)",
                    s[a:],
                )
            write(p, s)

    def clean_stale(self):
        """Remove model and binding files of the generated modules that were not written in this run."""
        for m in self.modules:
            keep = {SPECIAL_HOOKS[h.element] for h in self.special if h.module is m}
            for d in (self.model_dir(m), self.bind_dir(m)):
                for fn in os.listdir(d):
                    path = os.path.join(d, fn)
                    if fn.endswith(".java") and fn[:-5] not in keep and os.path.normcase(path) not in self.written:
                        os.remove(path)
                        print("removed stale", m.prefix, fn)

    def patch_marshaller_base(self):
        """Add toCalendar(YearMonth) to bind/Marshaller.java when needed."""
        if not any(f.kind == "yearMonth" for t in self.types for f in t.fields):
            return
        p = os.path.join(self.src, "bind", "Marshaller.java")
        s = open(p, encoding="utf-8").read()
        if "toCalendar(YearMonth" in s:
            return
        s = s.replace("import java.time.Year;", "import java.time.Year;\nimport java.time.YearMonth;")
        s = s.rstrip()
        assert s.endswith("}")
        s = (
            s[:-1].rstrip("\n")
            + """

    public XMLGregorianCalendar toCalendar(YearMonth yearMonth) {
        return helper.getJAXBMarshaller().getDataTypeFactory()
                .newXMLGregorianCalendarDate(yearMonth.getYear(),
                        yearMonth.getMonthValue(),
                        DatatypeConstants.FIELD_UNDEFINED,
                        DatatypeConstants.FIELD_UNDEFINED);
    }
}
"""
        )
        write(p, s)


PRESETS = {
    "all": None,
    "phaseA": r"(^(bldg|brid|tun|luse|frn|tran|veg|wtr)FacilityAttribute$|DmAttribute$|^ifc|^indoor)",
    "phaseB": r"(DmAttribute$|^ifc|^indoor)",
    "phaseC": r"(^ifc|^indoor)",
}


def select_hooks(spec, preset):
    exclude = PRESETS[preset]
    pat = re.compile(exclude) if exclude else None
    hooks = []
    for h in spec.hooks:
        if pat is not None and pat.search(h.element):
            continue
        hooks.append(h)
    return hooks


def load_spec(repo, citydb, version, prefixes):
    return urospec.Spec(
        urospec.modules_for(repo, prefixes, version),
        os.path.join(citydb, "resources", "database", "schema-mapping", "schema-mapping.xml"),
        os.path.join(citydb, "resources", "database", "3dcitydb", "postgreSQL", "CREATE_ADE_DB.sql"),
    )


def main(argv: list[str] | None = None) -> None:
    argv = sys.argv[1:] if argv is None else list(argv)
    repo, citydb, version, exclude = argv[0:4]
    prefixes = argv[4].split(",") if len(argv) > 4 else ["uro"]
    spec = load_spec(repo, citydb, version, prefixes)
    gen = Generator(spec, repo, select_hooks(spec, exclude))
    stale = set()
    for m in gen.modules:
        d = gen.model_dir(m)
        stale |= {fn[:-5] for fn in os.listdir(d) if fn.endswith(".java")} if os.path.isdir(d) else set()
    gen.gen_model()
    for m in gen.modules:
        gen.gen_marshaller(m)
        gen.gen_unmarshaller(m)
    gen.patch_marshaller_base()
    gen.clean_stale()
    generated = {t.model for t in gen.types + gen.features}
    if gen.features:
        gen.patch_walkers(stale - generated)
    for m in gen.modules:
        if any(t.module is m for t in gen.features) or m.prefix != "uro":
            gen.patch_module(m)
    gen.patch_top_level()
    print(
        "types:",
        len(gen.types),
        "features:",
        len(gen.features),
        "hooks:",
        len(gen.hooks),
        "enums:",
        [e.qname for e in gen.enums.values()],
    )


if __name__ == "__main__":
    main()
