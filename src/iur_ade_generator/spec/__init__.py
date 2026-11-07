"""Specification model for the i-UR ADE code generators (uro, urf): the XSD types, the JAXB accessors and the schema
mapping of the generated modules, linked into one model (``Spec``)."""

from .mapping import Ddl, Join, JoinTable, MappingInjection, MappingProperty, MappingType, SchemaMapping
from .model import (
    ABSTRACT_FEATURE_BASES,
    FEATURE_BASES,
    MEMBER_FEATURE_MODULES,
    MODEL_RENAMES,
    MODULE_NAMES,
    SCALAR_KINDS,
    XSD_FILES,
    Enum,
    FeatureBase,
    Field,
    Hook,
    JaxbProperty,
    Module,
    Type,
    split_ref,
)
from .spec import Spec, modules_for

__all__ = [
    "ABSTRACT_FEATURE_BASES",
    "FEATURE_BASES",
    "MEMBER_FEATURE_MODULES",
    "MODEL_RENAMES",
    "MODULE_NAMES",
    "SCALAR_KINDS",
    "XSD_FILES",
    "Ddl",
    "Enum",
    "FeatureBase",
    "Field",
    "Hook",
    "JaxbProperty",
    "Join",
    "JoinTable",
    "MappingInjection",
    "MappingProperty",
    "MappingType",
    "Module",
    "SchemaMapping",
    "Spec",
    "Type",
    "modules_for",
    "split_ref",
]
