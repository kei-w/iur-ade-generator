"""The model classes of the citygml4j fork: data types, feature types, property types, hook elements and enumerations."""

from __future__ import annotations

import os
import re

from ..naming import cap
from ..spec import ABSTRACT_FEATURE_BASES, Enum, Hook, Type
from .common import IMPORTS, VISITORS, GeneratorBase, infer_imports, render_imports


class ModelWriter(GeneratorBase):
    def gen_model(self) -> None:
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

    @staticmethod
    def accessors(t: Type, imports: set[str]) -> tuple[list[str], list[str]]:
        """Field declarations and accessor methods of a model class."""
        fields, methods = [], []
        for f in t.fields:
            fname, ftype = f.model_name, f.model_type
            if f.foreign:
                target = f.enum_type if f.kind == "enum" else f.property_type
                imports.add(f"{target.module.model_pkg}.{target.model}")
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
    def copy_methods(t: Type, super_copy: str) -> str:
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

    def gen_feature_type(self, t: Type) -> None:
        """An ADE feature class: a subclass of the citygml4j class of its CityGML base type."""
        name = t.model
        core_model = t.feature_base.model
        root = t.base is None
        base = t.base.model if t.base is not None else core_model.rsplit(".", 1)[1]
        imports = {"org.citygml4j.builder.copy.CopyBuilder", "org.citygml4j.builder.copy.ObjectCopier"}
        if root:
            imports |= {core_model, IMPORTS["ADEModelObject"]}
        fields, methods = self.accessors(t, imports)
        lods = [
            f
            for f in t.fields
            if f.lod is not None and f.kind in ("geometry", "multiSurface", "multiCurve", "multiPoint")
        ]
        visitable = root and t.core_base in ABSTRACT_FEATURE_BASES
        if visitable:
            methods.append("""    @Override
    public BoundingShape calcBoundedBy(BoundingBoxOptions options) {
        return SimpleBoundingBoxCalculator.calcBoundedBy(this, options);
    }
""")
            imports |= {IMPORTS[k] for k in ("BoundingShape", "BoundingBoxOptions", "SimpleBoundingBoxCalculator")}
        if lods:
            lines = "".join(f"        lodRepresentation.addRepresentation({f.lod}, {f.model_name});\n" for f in lods)
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

    def gen_feature_property_type(self, p: Type, target: str, target_import: str | None = None) -> None:
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

    def gen_data_type(self, t: Type) -> None:
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

    def gen_property_type(self, p: Type) -> None:
        name, target = p.model, p.target.model
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

    def gen_property_element(self, h: Hook) -> None:
        name, value = h.model_element, h.property_type.model
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

    def gen_enum(self, e: Enum) -> None:
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
