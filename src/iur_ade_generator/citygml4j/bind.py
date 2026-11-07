"""The JAXB marshaller and unmarshaller of every module, and the patches of the hand-written top-level bind classes."""

from __future__ import annotations

import os
import re
from collections.abc import Iterable

from ..errors import GeneratorError
from ..naming import cap, norm
from ..spec import Field, Module, Type, split_ref
from ..templates import render
from .common import IMPORTS, SPECIAL_HOOKS, GeneratorBase, read, render_imports, write

CODE_MARSHALLERS = {"code": "marshalCode", "measure": "marshalMeasure", "length": "marshalLength"}
CODE_UNMARSHALLERS = {"code": "unmarshalCode", "measure": "unmarshalMeasure", "length": "unmarshalLength"}
XLINK_MARSHAL = """
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
XLINK_UNMARSHAL = """
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


def join(parts: Iterable[str]) -> str:
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


def method_body(head: str, base_call: str, fields: str, tail: str) -> str:
    """head line(s), optional base call, blank line, fields, blank line, tail."""
    body = head + base_call
    if fields:
        body += "\n" + fields + "\n"
    return body + tail


class BindWriter(GeneratorBase):
    # ------------------------------------------------------------- marshaller
    def marshal_field(self, f: Field) -> str:
        g = "src.get%s()" % cap(f.model_name)
        j = f.jaxb_property
        setter = "dest.%s" % j.setter if j.setter else None
        adder = "dest.%s().add" % j.getter
        k = f.kind
        target_model = f.property_type.model if k in ("property", "inline", "cityObjectRef") else ""
        if f.multi:
            var = f.model_name
            elem = f.model_type[5:-1]
            conv = {
                "string": var,
                "code": "helper.getGMLMarshaller().marshalCode(%s)" % var,
                "measure": "helper.getGMLMarshaller().marshalMeasure(%s)" % var,
                "length": "helper.getGMLMarshaller().marshalLength(%s)" % var,
                "date": "marshaller.toCalendar(%s)" % var,
                "time": "marshaller.toCalendar(%s)" % var,
                "year": "marshaller.toCalendar(%s)" % var,
                "yearMonth": "marshaller.toCalendar(%s)" % var,
                "integer": "BigInteger.valueOf(%s)" % var,
                "double": var,
                "boolean": var,
                "enum": "%s.fromValue(%s.value())" % (self.jaxb_enum(f.enum_type) if k == "enum" else "", var),
                "property": "marshal%s(%s)" % (target_model, var),
                "inline": "marshal%s(%s)" % (target_model, var),
                "cityObjectRef": "marshal%s(%s)" % (target_model, var),
            }[k]
            if k in ("property", "inline") and f.foreign:
                # a type of another module: through the JAXB marshaller, which dispatches to that module
                conv = "(%s) helper.getJAXBMarshaller().marshal(%s)" % (self.jaxb_fqn(f.property_type), var)
                elem = f"{f.property_type.module.model_pkg}.{target_model}"
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
        if k in ("date", "time", "year", "yearMonth"):
            return f"        if ({g} != null)\n            {setter}(marshaller.toCalendar({g}));\n"
        if k in CODE_MARSHALLERS:
            return f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().{CODE_MARSHALLERS[k]}({g}));\n"
        if k == "enum":
            return (
                f"        if ({g} != null)\n"
                f"            {setter}({self.jaxb_enum(f.enum_type)}.fromValue({g}.value()));\n"
            )
        if k == "doubleList":
            var = f.model_name
            return f"        for (Double {var} : {g})\n            dest.{j.getter}().add({var});\n"
        if k in ("property", "inline") and f.foreign:
            return (
                f"        if ({g} != null)\n"
                f"            {setter}(({self.jaxb_fqn(f.property_type)}) helper.getJAXBMarshaller().marshal({g}));\n"
            )
        if k in ("property", "inline", "cityObjectRef"):
            return f"        if ({g} != null)\n            {setter}(marshal{target_model}({g}));\n"
        if k == "geometry":
            return f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().marshalGeometryProperty({g}));\n"
        if k == "point":
            return f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().marshalPointProperty({g}));\n"
        if k == "complex":
            return (
                f"        if ({g} != null)\n"
                f"            {setter}(helper.getGMLMarshaller().marshalGeometricComplexProperty({g}));\n"
            )
        if k == "address":
            return (
                f"        if ({g} != null)\n"
                f"            {setter}(helper.getCore200Marshaller().marshalAddressProperty({g}));\n"
            )
        if k == "stringOrRef":
            return (
                f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().marshalStringOrRef({g}));\n"
            )
        if k in ("multiSurface", "multiCurve", "multiPoint"):
            return (
                f"        if ({g} != null)\n"
                f"            {setter}(helper.getGMLMarshaller().marshal{cap(k)}Property({g}));\n"
            )
        if k == "directPosition":
            return f"        if ({g} != null)\n            {setter}(helper.getGMLMarshaller().marshalDirectPosition({g}));\n"
        raise GeneratorError(f"cannot marshal a field of kind {k}")

    def unmarshal_field(self, f: Field) -> str:
        s = "dest.set%s" % cap(f.model_name)
        adder = "dest.get%s().add" % cap(f.model_name)
        j = f.jaxb_property
        g = "src.%s()" % j.getter
        k = f.kind
        target_model = f.property_type.model if k in ("property", "inline", "cityObjectRef") else ""
        if f.multi:
            var = f.model_name
            jelem = j.java_type[5:-1]
            conv = {
                "string": var,
                "code": "helper.getGMLUnmarshaller().unmarshalCode(%s)" % var,
                "measure": "helper.getGMLUnmarshaller().unmarshalMeasure(%s)" % var,
                "length": "helper.getGMLUnmarshaller().unmarshalLength(%s)" % var,
                "date": "%s.toGregorianCalendar().toZonedDateTime().toLocalDate()" % var,
                "time": "%s.toGregorianCalendar().toZonedDateTime().toLocalTime()" % var,
                "year": "Year.of(%s.getYear())" % var,
                "yearMonth": "YearMonth.of(%s.getYear(), %s.getMonth())" % (var, var),
                "integer": "%s.intValue()" % var,
                "double": var,
                "boolean": var,
                "enum": "%s.%s.fromValue(%s.value())"
                % (
                    f.enum_type.module.model_pkg if k == "enum" else "",
                    f.enum_type.model if k == "enum" else "",
                    var,
                ),
                "property": "unmarshal%s(%s)" % (target_model, var),
                "inline": "unmarshal%s(%s)" % (target_model, var),
                "cityObjectRef": "unmarshal%s(%s)" % (target_model, var),
            }[k]
            if k in ("property", "inline") and f.foreign:
                conv = "(%s.%s) helper.getJAXBUnmarshaller().unmarshal(%s)" % (
                    f.property_type.module.model_pkg,
                    target_model,
                    var,
                )
                jelem = self.jaxb_fqn(f.property_type)
            return (
                f"        if (src.{j.is_set}()) {{\n            for ({jelem} {var} : {g})\n"
                f"                {adder}({conv});\n        }}\n"
            )
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
            return (
                f"        if (src.{j.is_set}())\n"
                f"            {s}({g}.toGregorianCalendar().toZonedDateTime().toLocalDate());\n"
            )
        if k == "time":
            return (
                f"        if (src.{j.is_set}())\n"
                f"            {s}({g}.toGregorianCalendar().toZonedDateTime().toLocalTime());\n"
            )
        if k == "year":
            return (
                f"        if (src.{j.is_set}()) {{\n"
                f"            LocalDate date = {g}.toGregorianCalendar().toZonedDateTime().toLocalDate();\n"
                f"            {s}(Year.of(date.getYear()));\n        }}\n"
            )
        if k == "yearMonth":
            return (
                f"        if (src.{j.is_set}()) {{\n"
                f"            LocalDate date = {g}.toGregorianCalendar().toZonedDateTime().toLocalDate();\n"
                f"            {s}(YearMonth.of(date.getYear(), date.getMonthValue()));\n        }}\n"
            )
        if k in CODE_UNMARSHALLERS:
            return (
                f"        if (src.{j.is_set}())\n"
                f"            {s}(helper.getGMLUnmarshaller().{CODE_UNMARSHALLERS[k]}({g}));\n"
            )
        if k == "enum":
            return (
                f"        if (src.{j.is_set}())\n"
                f"            {s}({f.enum_type.module.model_pkg}.{f.enum_type.model}.fromValue({g}.value()));\n"
            )
        if k == "doubleList":
            var = f.model_name
            return (
                f"        if (src.{j.is_set}()) {{\n            for (Double {var} : {g})\n"
                f"                {adder}({var});\n        }}\n"
            )
        if k in ("property", "inline") and f.foreign:
            return (
                f"        if (src.{j.is_set}())\n            {s}(({f.property_type.module.model_pkg}.{target_model}) "
                f"helper.getJAXBUnmarshaller().unmarshal({g}));\n"
            )
        if k in ("property", "inline", "cityObjectRef"):
            return f"        if (src.{j.is_set}())\n            {s}(unmarshal{target_model}({g}));\n"
        if k == "geometry":
            return (
                f"        if (src.{j.is_set}())\n"
                f"            {s}(helper.getGMLUnmarshaller().unmarshalGeometryProperty({g}));\n"
            )
        if k == "point":
            return (
                f"        if (src.{j.is_set}())\n"
                f"            {s}(helper.getGMLUnmarshaller().unmarshalPointProperty({g}));\n"
            )
        if k == "complex":
            return (
                f"        if (src.{j.is_set}())\n"
                f"            {s}(helper.getGMLUnmarshaller().unmarshalGeometricComplexProperty({g}));\n"
            )
        if k == "address":
            return (
                f"        if (src.{j.is_set}())\n"
                f"            {s}(helper.getCore200Unmarshaller().unmarshalAddressProperty({g}));\n"
            )
        if k == "stringOrRef":
            return (
                f"        if (src.{j.is_set}())\n"
                f"            {s}(helper.getGMLUnmarshaller().unmarshalStringOrRef({g}));\n"
            )
        if k in ("multiSurface", "multiCurve", "multiPoint"):
            return (
                f"        if (src.{j.is_set}())\n"
                f"            {s}(helper.getGMLUnmarshaller().unmarshal{cap(k)}Property({g}));\n"
            )
        if k == "directPosition":
            return (
                f"        if (src.{j.is_set}())\n"
                f"            {s}(helper.getGMLUnmarshaller().unmarshalDirectPosition({g}));\n"
            )
        raise GeneratorError(f"cannot unmarshal a field of kind {k}")

    def marshal_type_methods(self, t: Type) -> list[str]:
        name, jt = t.model, self.jaxb_ref(t)
        fields = join(self.marshal_field(f) for f in t.fields)
        out = []
        if t.is_feature:
            # feature types always delegate to their base: the citygml4j marshaller of the CityGML base type at the root
            base_call = (
                f"        marshal{t.base.model}(src, dest);\n"
                if t.base
                else f"        helper.{t.feature_base.marshal}(src, dest);\n"
            )
            with_dest = t.abstract or bool(t.subtypes)
        else:
            base_call = f"        marshal{t.base.model}(src, dest);\n" if t.base and t.base.all_fields() else ""
            with_dest = (t.abstract or bool(t.subtypes)) and bool(t.all_fields())
        if with_dest:
            body = join([base_call, fields])
            out.append(f"    private void marshal{name}({name} src, {jt} dest) {{\n{body}    }}\n")
        if not t.abstract:
            head = f"    private {jt} marshal{name}({name} src) {{\n        {jt} dest = factory.create{t.jaxb}();\n"
            if with_dest:
                base_call, fields = f"        marshal{name}(src, dest);\n", ""
            out.append(method_body(head, base_call, fields, "        return dest;\n    }\n"))
        return out

    def marshal_property_method(self, p: Type) -> str:
        name, jt, target = p.model, self.jaxb_ref(p), p.prop_target
        if target is None:  # city object reference (core:_CityObject)
            jp = self.spec.jaxb_properties(p)[norm(split_ref(p.foreign_target or "")[1])]
            target_jaxb, feature = "AbstractCityObjectType", True
        else:
            jp = self.spec.jaxb_properties(p)[norm(target.element_name)]
            target_jaxb, feature = self.jaxb_ref(target), target.is_feature
        if p.polymorphic:
            body = (
                f"        if (src.getObject() != null) {{\n"
                f"            JAXBElement<?> elem = helper.getJAXBMarshaller().marshalJAXBElement(src.getObject());\n"
                f"            if (elem != null && elem.getValue() instanceof {target_jaxb})\n"
                f"                dest.{jp.setter}((JAXBElement<? extends {target_jaxb}>) elem);\n        }}\n"
            )
        else:
            body = (
                f"        if (src.isSetObject())\n"
                f"            dest.{jp.setter}(marshal{p.target.model}(src.getObject()));\n"
            )
        if feature:
            body += XLINK_MARSHAL
        return (
            f"    private {jt} marshal{name}({name} src) {{\n        {jt} dest = factory.create{p.jaxb}();\n\n{body}\n"
            f"        return dest;\n    }}\n"
        )

    def unmarshal_type_methods(self, t: Type) -> list[str]:
        name, jt = t.model, self.jaxb_ref(t)
        fields = join(self.unmarshal_field(f) for f in t.fields)
        out = []
        if t.is_feature:
            base_call = (
                f"        unmarshal{t.base.model}(src, dest);\n"
                if t.base
                else f"        helper.{t.feature_base.unmarshal}(src, dest);\n"
            )
            with_dest = t.abstract or bool(t.subtypes)
        else:
            base_call = f"        unmarshal{t.base.model}(src, dest);\n" if t.base and t.base.all_fields() else ""
            with_dest = (t.abstract or bool(t.subtypes)) and bool(t.all_fields())
        if with_dest:
            body = join([base_call, fields])
            out.append(
                f"    private void unmarshal{name}({jt} src, {name} dest) throws MissingADESchemaException {{\n"
                f"{body}    }}\n"
            )
        if not t.abstract:
            head = (
                f"    private {name} unmarshal{name}({jt} src) throws MissingADESchemaException {{\n"
                f"        {name} dest = new {name}();\n"
            )
            if with_dest:
                base_call, fields = f"        unmarshal{name}(src, dest);\n", ""
            out.append(method_body(head, base_call, fields, "        return dest;\n    }\n"))
        return out

    def unmarshal_property_method(self, p: Type) -> str:
        name, jt, target = p.model, self.jaxb_ref(p), p.prop_target
        if target is None:  # city object reference (core:_CityObject)
            jp = self.spec.jaxb_properties(p)[norm(split_ref(p.foreign_target or "")[1])]
            target_model, feature = "AbstractCityObject", True
        else:
            jp = self.spec.jaxb_properties(p)[norm(target.element_name)]
            target_model, feature = target.model, target.is_feature
        if p.polymorphic:
            body = (
                f"        if (src.{jp.is_set}()) {{\n"
                f"            ModelObject object = helper.getJAXBUnmarshaller().unmarshal(src.{jp.getter}());\n"
                f"            if (object instanceof {target_model})\n"
                f"                dest.setObject(({target_model}) object);\n        }}\n"
            )
        else:
            body = (
                f"        if (src.{jp.is_set}())\n"
                f"            dest.setObject(unmarshal{p.target.model}(src.{jp.getter}()));\n"
            )
        if feature:
            body += XLINK_UNMARSHAL
        return (
            f"    private {name} unmarshal{name}({jt} src) throws MissingADESchemaException {{\n"
            f"        {name} dest = new {name}();\n\n{body}\n        return dest;\n    }}\n"
        )

    def gen_marshaller(self, module: Module) -> None:
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
                f"        return factory.{module.factory[h.element]}(marshal{h.property_type.model}(src.getValue()));\n"
                f"    }}\n"
            )
        for h in [x for x in self.special if x.module is module]:
            cls = SPECIAL_HOOKS[h.element]
            element_entries.append(f"                    .with({cls}.class, this::create{cls})")
            if h.element == "fiscalYearOfPublication":
                creates.append(
                    f"    private JAXBElement<?> create{cls}({cls} src) {{\n"
                    f"        return factory.{module.factory[h.element]}(marshaller.toCalendar(src.getValue()));\n"
                    f"    }}\n"
                )
            else:
                creates.append(
                    f"    private JAXBElement<?> create{cls}({cls} src) {{\n"
                    f"        return factory.{module.factory[h.element]}"
                    f"(helper.getGMLMarshaller().marshalCode(src.getValue()));\n    }}\n"
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
                "LocalTime",
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
        text = render(
            "citygml4j/marshaller.java.j2",
            header=self.header,
            prefix=module.prefix,
            imports=render_imports(imports),
            name=module.marshaller,
            element_entries="\n".join(element_entries),
            type_entries="\n".join(type_entries),
            body=body,
        )
        self.out(os.path.join(self.bind_dir(module), module.marshaller + ".java"), text)

    def gen_unmarshaller(self, module: Module) -> None:
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
            p = h.property_type
            cases.append(
                f'            case "{h.element}":\n'
                f"                return new {h.model_element}(unmarshal{p.model}(({self.jaxb_ref(p)}) value));"
            )
        for h in [x for x in self.special if x.module is module]:
            if h.element == "fiscalYearOfPublication":
                cases.append(
                    '            case "fiscalYearOfPublication":\n'
                    "                LocalDate fiscalYearOfPublication = ((XMLGregorianCalendar) value)"
                    ".toGregorianCalendar().toZonedDateTime().toLocalDate();\n"
                    "                return new FiscalYearOfPublicationProperty("
                    "Year.of(fiscalYearOfPublication.getYear()));"
                )
            else:
                cases.append(
                    '            case "language":\n                return new LanguageProperty('
                    "helper.getGMLUnmarshaller().unmarshalCode((CodeType) value));"
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
                "LocalTime",
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
        text = render(
            "citygml4j/unmarshaller.java.j2",
            header=self.header,
            prefix=module.prefix,
            imports=render_imports(imports),
            name=module.unmarshaller,
            type_entries="\n".join(type_entries),
            cases="\n".join(cases),
            body=body,
        )
        self.out(os.path.join(self.bind_dir(module), module.unmarshaller + ".java"), text)

    # ---------------------------------------------------- hand-written classes
    def patch_top_level(self) -> None:
        """Point the top-level Marshaller/Unmarshaller and the ADEContext at the module constants of the generated
        versions."""
        for rel in (
            ("bind", "Marshaller.java"),
            ("bind", "Unmarshaller.java"),
            ("UrbanRevitalizationADEContext.java",),
        ):
            p = os.path.join(self.src, *rel)
            s = read(p)
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

    def patch_marshaller_base(self) -> None:
        """Add toCalendar(YearMonth) to bind/Marshaller.java when needed."""
        if not any(f.kind == "yearMonth" for t in self.types for f in t.fields):
            return
        p = os.path.join(self.src, "bind", "Marshaller.java")
        s = read(p)
        if "toCalendar(YearMonth" in s:
            return
        s = s.replace("import java.time.Year;", "import java.time.Year;\nimport java.time.YearMonth;")
        s = s.rstrip()
        if not s.endswith("}"):
            raise GeneratorError(f"{p} does not end with a class body")
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
