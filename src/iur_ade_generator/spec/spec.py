"""The specification of one edition: the modules linked with their JAXB classes and the schema mapping."""

from __future__ import annotations

import logging
import os
from collections import OrderedDict
from collections.abc import Iterable, Sequence

from ..naming import FEATURE_FIELD_NAMES, java_name, norm
from .jaxb import jaxb_properties, read_jaxb
from .mapping import Ddl, MappingInjection, SchemaMapping, read_ddl, read_mapping
from .model import SCALAR_KINDS, XSD_FILES, Enum, Hook, JaxbProperty, Module, Type, split_ref
from .xsd import read_xsd, target_namespace

log = logging.getLogger(__name__)


class Spec:
    """Combines three sources into one model: the XSD of every generated module (types, fields, generic application
    property hooks), the ade-xjc generated JAXB classes (exact accessor names and types) and the ADE Manager schema
    mapping (tables, columns, joins). Types are kept per module (the XSD prefix: uro, urf) and referenced by their
    qualified name across modules."""

    def __init__(self, modules: Sequence[Module], mapping_path: str, ddl_path: str) -> None:
        self.modules: OrderedDict[str, Module] = OrderedDict((m.prefix, m) for m in modules)
        for m in modules:
            m.spec = self
        self.mapping: SchemaMapping = read_mapping(mapping_path)
        self.ddl: Ddl = read_ddl(ddl_path)
        self.nested_features: set[str] = set()
        for m in modules:
            read_xsd(m)
            read_jaxb(m)
        self._assign_mapping(mapping_path)
        self._link()

    # ---------------------------------------------------------------- views
    @property
    def injections(self) -> list[MappingInjection]:
        return self.mapping.injections

    @property
    def ddl_tables(self) -> OrderedDict[str, list[str]]:
        return self.ddl.tables

    @property
    def table_sequence(self) -> dict[str, str]:
        return self.ddl.table_sequence

    @property
    def sequences(self) -> list[str]:
        return self.ddl.sequences

    @property
    def types(self) -> OrderedDict[str, Type]:
        """All types of all modules by qualified name."""
        return OrderedDict((t.qname, t) for m in self.modules.values() for t in m.types.values())

    @property
    def hooks(self) -> list[Hook]:
        return [h for m in self.modules.values() for h in m.hooks]

    def resolve(self, qref: str) -> Type | Enum | None:
        """Type or Enum for a qualified XSD type reference, None for references outside the generated modules."""
        prefix, name = split_ref(qref)
        m = self.modules.get(prefix)
        if m is None:
            return None
        return m.types.get(name) or m.enums.get(name)

    def type(self, qname: str) -> Type:
        t = self.resolve(qname)
        if not isinstance(t, Type):
            raise KeyError(qname)
        return t

    def jaxb_properties(self, t: Type) -> dict[str, JaxbProperty]:
        return jaxb_properties(t)

    # -------------------------------------------------------------- mapping
    def _assign_mapping(self, path: str) -> None:
        """The schema ids of the module namespaces (the ADE Manager numbers the i-UR schemas ur_0.. in its own order)
        and the mapping types of every module."""
        for m in self.modules.values():
            m.schema_id = self.mapping.schema_ids.get(m.namespace.rstrip("/"))
            if m.schema_id is None:
                # no ADE Manager mapping of this module yet: the citygml4j side can still be generated
                log.warning("%s schema (%s) not found in %s", m.prefix, m.namespace, path)
            else:
                m.mapping_types = self.mapping.types.get(m.schema_id, OrderedDict())

    # ----------------------------------------------------------------- link
    def _link(self) -> None:
        link_types(self.modules.values())
        for t in self.types.values():
            if t.is_property and t.prop_target_ref:
                prefix, el = split_ref(t.prop_target_ref)
                m = self.modules.get(prefix)
                if m is not None and el in m.elements:
                    t.prop_target = m.types[m.elements[el]]
                else:
                    t.foreign_target = t.prop_target_ref  # e.g. core:_CityObject
                props = jaxb_properties(t)
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
            props = jaxb_properties(t)
            for f in t.fields:
                f.owner = t
                xt = f.xsd_type
                target = self.resolve(xt)
                if xt in SCALAR_KINDS:
                    f.kind = SCALAR_KINDS[xt]
                elif isinstance(target, Enum):
                    f.kind, f.enum = "enum", target
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
                    f.enum_values = f.enum_type.values
                    f.kind, f.enum = "string", None
                if f.kind == "inline" and f.target is t:
                    f.kind = "unsupported"  # a type nested in itself (uro 2.0/3.0 ControlPoint.parameter)
            t.dropped = [f for f in t.fields if f.kind == "unsupported"]
            t.fields = [f for f in t.fields if f.kind != "unsupported"]
            t.mapping = t.module.mapping_types.get(t.mapping_path)
        for h in self.hooks:
            if h.xsd_type:
                target = self.resolve(h.xsd_type)
                if isinstance(target, Type):
                    h.prop_type = target
            for inj in self.injections:
                if h.element in inj.props and inj.props[h.element].schema == h.module.schema_id:
                    h.injection = inj
                    h.mapping = inj.props[h.element]
        # feature types (with their subtypes) that are reachable through a feature property or a feature-typed hook:
        # they are nested in other features and not exported as city object members
        for t in self.types.values():
            if not t.is_property:
                for f in t.fields:
                    if f.kind == "property" and f.nested.is_feature:
                        self.nested_features.add(f.nested.qname)
        for h in self.hooks:
            if h.prop_type is not None and h.prop_type.prop_target is not None and h.prop_type.prop_target.is_feature:
                self.nested_features.add(h.prop_type.prop_target.qname)

    # -------------------------------------------------------------- helpers
    def feature_types(self, module: Module | None = None) -> list[Type]:
        """The ADE feature types (ancestors first), of one module or of all."""
        out: OrderedDict[str, Type] = OrderedDict()
        for t in self.types.values():
            if t.is_property or not t.is_feature or (module is not None and t.module is not module):
                continue
            for a in reversed(t.ancestors()):
                out.setdefault(a.qname, a)
            out[t.qname] = t
        return list(out.values())

    def closure(self, hooks: Iterable[Hook], features: Iterable[Type] = ()) -> list[Type]:
        """All non-property data types reachable from the given hooks and feature types (including subtypes and nested
        types)."""
        out: OrderedDict[str, Type] = OrderedDict()

        def add(t: Type) -> None:
            if t.qname in out or t.is_feature:
                return
            out[t.qname] = t
            for s in t.subtypes:
                add(s)
            for f in t.all_fields():
                if f.kind in ("property", "inline"):
                    add(f.nested)

        for h in hooks:
            if h.prop_type is not None:
                add(h.nested)
        for t in features:
            for f in t.fields:
                if f.kind in ("property", "inline"):
                    add(f.nested)
        # abstract base types of the reachable types (their own fields are inherited)
        for t in list(out.values()):
            for a in t.ancestors():
                out.setdefault(a.qname, a)
        ordered: OrderedDict[str, Type] = OrderedDict()
        for t in out.values():
            for a in reversed(t.ancestors()):
                ordered.setdefault(a.qname, a)
            ordered[t.qname] = t
        return list(ordered.values())

    def property_types(self, types: Iterable[Type], hooks: Iterable[Hook] | None = None) -> list[Type]:
        """Property types used by the given types or hooks (city object references included)."""
        types = list(types)
        names = {t.qname for t in types}
        out: OrderedDict[str, Type] = OrderedDict()
        for h in self.hooks if hooks is None else hooks:
            if (
                h.prop_type is not None
                and h.prop_type.prop_target is not None
                and h.prop_type.prop_target.qname in names
            ):
                out[h.prop_type.qname] = h.prop_type
        for t in types:
            for f in t.fields:
                if f.kind in ("property", "cityObjectRef"):
                    out[f.property_type.qname] = f.property_type
        return list(out.values())


def link_types(modules: Iterable[Module]) -> None:
    """Links the types of the modules to their base types (subtypes, hierarchy roots with their CityGML base); the
    first step of ``Spec``, usable on the XSDs alone."""
    modules = list(modules)
    by_qname = {t.qname: t for m in modules for t in m.types.values()}
    for t in by_qname.values():
        base = by_qname.get(t.base_name) if t.base_name else None
        if base is not None:
            t.base = base
            base.subtypes.append(t)
        else:
            t.core_base = t.base_name


def modules_for(cg4j_repo: str, prefixes: Iterable[str], version: str) -> list[Module]:
    """Module objects of the given prefixes for one edition (XSDs under resources/ade-xjc/schemas, JAXB under
    src-gen)."""
    out = []
    for prefix in prefixes:
        pkg = "jp.geospatial.iur._{}.{}".format(version.replace(".", "_"), prefix)
        xsd = os.path.join(cg4j_repo, "resources", "ade-xjc", "schemas", XSD_FILES[prefix])
        out.append(
            Module(
                prefix,
                xsd,
                pkg,
                os.path.join(cg4j_repo, "src-gen", "main", "java", *pkg.split(".")),
                target_namespace(xsd),
            )
        )
    return out
