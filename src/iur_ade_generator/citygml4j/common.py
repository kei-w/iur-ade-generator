"""Shared state and helpers of the citygml4j generator: imports, file writing and the class names of the modules."""

from __future__ import annotations

import os
import re
from collections import OrderedDict
from collections.abc import Iterable

from ..spec import Enum, Hook, Module, Spec, Type

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


def write(path: str, text: str) -> None:
    d, name = os.path.split(path)
    os.makedirs(d, exist_ok=True)
    # case-insensitive file systems keep the old name of a file whose class name changed its case
    for existing in os.listdir(d):
        if existing != name and existing.lower() == name.lower():
            os.remove(os.path.join(d, existing))
    with open(path, "w", encoding="utf-8", newline="\n") as fp:
        fp.write(text)


def read(path: str) -> str:
    with open(path, encoding="utf-8") as fp:
        return fp.read()


def render_imports(imports: Iterable[str]) -> str:
    imports = set(imports)
    java = sorted(i for i in imports if not i.startswith("java"))
    jdk = sorted(i for i in imports if i.startswith("java"))
    out = "\n".join("import %s;" % i for i in java)
    if jdk:
        out += ("\n\n" if out else "") + "\n".join("import %s;" % i for i in jdk)
    return out


def infer_imports(body: str, extra: Iterable[str] = ()) -> set[str]:
    imports = set(extra)
    for token, imp in IMPORTS.items():
        if re.search(r"\b%s\b" % token, body):
            imports.add(imp)
    return imports


class GeneratorBase:
    """The state shared by the writers of the citygml4j generator (model classes, bind code, walkers, modules)."""

    spec: Spec
    repo: str
    modules: list[Module]
    hooks: list[Hook]
    """Hooks with a property type."""
    special: list[Hook]
    """The simple hooks of SPECIAL_HOOKS."""
    features: list[Type]
    types: list[Type]
    """The data types reachable from the hooks and features."""
    items: list[Type]
    """Types and property types in the order used for mapper registrations and methods."""
    enums: OrderedDict[str, Enum]
    src: str
    """The source folder of the fork (``org/citygml4j/ade/iur``)."""
    header: str
    """The license header of the generated files."""
    written: set[str]
    walker_geometry: bool

    def model_dir(self, module: Module) -> str:
        return os.path.join(self.src, "model", module.prefix)

    def bind_dir(self, module: Module) -> str:
        return os.path.join(self.src, "bind", module.prefix)

    def out(self, path: str, text: str) -> None:
        self.written.add(os.path.normcase(path))
        write(path, text)

    @staticmethod
    def model_ref(t: Type, module: Module) -> str:
        """Simple name of a model class, fully qualified when it belongs to another module."""
        return t.model if t.module is module else f"{t.module.model_pkg}.{t.model}"

    @staticmethod
    def jaxb_enum(e: Enum) -> str:
        return e.module.jaxb_pkg + "." + e.jaxb

    @staticmethod
    def jaxb_fqn(t: Type) -> str:
        return f"{t.module.jaxb_pkg}.{t.jaxb}"

    def clashing_models(self, module: Module) -> set[str]:
        """Model class names of a module that are also JAXB class names (urf 3.x UrbanDevelopmentProjectTypeType ->
        UrbanDevelopmentProjectType, ThreeDimensionalExtent): the bind code imports them explicitly and refers to the
        JAXB classes by their qualified names."""
        items = [i for i in self.items if i.module is module]
        return {i.model for i in items} & {i.jaxb for i in items}

    def jaxb_ref(self, t: Type) -> str:
        return self.jaxb_fqn(t) if t.jaxb in self.clashing_models(t.module) else t.jaxb
