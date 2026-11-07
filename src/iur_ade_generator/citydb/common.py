"""Constants and text helpers of the citydb generator: the hook targets of citygml4j, imports, Java text layout."""

from __future__ import annotations

import os
import re
from collections.abc import Iterable

from ..errors import GeneratorError

PKG = "org.citydb.ade.iur"

# XSD hook target -> (citygml4j class, adder method)
HOOK_TARGETS = {
    "CityObject": ("org.citygml4j.model.citygml.core.AbstractCityObject", "addGenericApplicationPropertyOfCityObject"),
    "AbstractBuilding": (
        "org.citygml4j.model.citygml.building.AbstractBuilding",
        "addGenericApplicationPropertyOfAbstractBuilding",
    ),
    "AbstractBridge": (
        "org.citygml4j.model.citygml.bridge.AbstractBridge",
        "addGenericApplicationPropertyOfAbstractBridge",
    ),
    "AbstractTunnel": (
        "org.citygml4j.model.citygml.tunnel.AbstractTunnel",
        "addGenericApplicationPropertyOfAbstractTunnel",
    ),
    "LandUse": ("org.citygml4j.model.citygml.landuse.LandUse", "addGenericApplicationPropertyOfLandUse"),
    "CityFurniture": (
        "org.citygml4j.model.citygml.cityfurniture.CityFurniture",
        "addGenericApplicationPropertyOfCityFurniture",
    ),
    "ReliefFeature": (
        "org.citygml4j.model.citygml.relief.ReliefFeature",
        "addGenericApplicationPropertyOfReliefFeature",
    ),
    "ReliefComponent": (
        "org.citygml4j.model.citygml.relief.AbstractReliefComponent",
        "addGenericApplicationPropertyOfReliefComponent",
    ),
    "VegetationObject": (
        "org.citygml4j.model.citygml.vegetation.AbstractVegetationObject",
        "addGenericApplicationPropertyOfVegetationObject",
    ),
    "WaterBody": ("org.citygml4j.model.citygml.waterbody.WaterBody", "addGenericApplicationPropertyOfWaterBody"),
    "TransportationComplex": (
        "org.citygml4j.model.citygml.transportation.TransportationComplex",
        "addGenericApplicationPropertyOfTransportationComplex",
    ),
    "Road": ("org.citygml4j.model.citygml.transportation.Road", "addGenericApplicationPropertyOfRoad"),
    "Railway": ("org.citygml4j.model.citygml.transportation.Railway", "addGenericApplicationPropertyOfRailway"),
    "Track": ("org.citygml4j.model.citygml.transportation.Track", "addGenericApplicationPropertyOfTrack"),
    "Square": ("org.citygml4j.model.citygml.transportation.Square", "addGenericApplicationPropertyOfSquare"),
    "TrafficArea": (
        "org.citygml4j.model.citygml.transportation.TrafficArea",
        "addGenericApplicationPropertyOfTrafficArea",
    ),
    "TransportationObject": (
        "org.citygml4j.model.citygml.transportation.AbstractTransportationObject",
        "addGenericApplicationPropertyOfTransportationObject",
    ),
    "CityObjectGroup": (
        "org.citygml4j.model.citygml.cityobjectgroup.CityObjectGroup",
        "addGenericApplicationPropertyOfCityObjectGroup",
    ),
    "Room": ("org.citygml4j.model.citygml.building.Room", "addGenericApplicationPropertyOfRoom"),
    "Opening": ("org.citygml4j.model.citygml.building.AbstractOpening", "addGenericApplicationPropertyOfOpening"),
    "BoundarySurface": (
        "org.citygml4j.model.citygml.building.AbstractBoundarySurface",
        "addGenericApplicationPropertyOfBoundarySurface",
    ),
    "BuildingInstallation": (
        "org.citygml4j.model.citygml.building.BuildingInstallation",
        "addGenericApplicationPropertyOfBuildingInstallation",
    ),
    "IntBuildingInstallation": (
        "org.citygml4j.model.citygml.building.IntBuildingInstallation",
        "addGenericApplicationPropertyOfIntBuildingInstallation",
    ),
    "BuildingFurniture": (
        "org.citygml4j.model.citygml.building.BuildingFurniture",
        "addGenericApplicationPropertyOfBuildingFurniture",
    ),
}
# mapping defaultBase -> hook target name of the base class
BASE_TARGETS = {
    "AbstractBuildingType": "AbstractBuilding",
    "AbstractBridgeType": "AbstractBridge",
    "AbstractTunnelType": "AbstractTunnel",
    "LandUseType": "LandUse",
    "CityFurnitureType": "CityFurniture",
    "ReliefFeatureType": "ReliefFeature",
    "AbstractReliefComponentType": "ReliefComponent",
    "AbstractVegetationObjectType": "VegetationObject",
    "WaterBodyType": "WaterBody",
    "TransportationComplexType": "TransportationComplex",
    "TrafficAreaType": "TrafficArea",
    "CityObjectGroupType": "CityObjectGroup",
    "RoomType": "Room",
    "AbstractOpeningType": "Opening",
    "AbstractBoundarySurfaceType": "BoundarySurface",
    "BuildingInstallationType": "BuildingInstallation",
    "BuildingFurnitureType": "BuildingFurniture",
    "IntBuildingInstallationType": "IntBuildingInstallation",
    "RoadType": "Road",
    "RailwayType": "Railway",
    "TrackType": "Track",
    "SquareType": "Square",
    "AbstractTransportationObjectType": "TransportationObject",
    "AbstractCityObjectType": "CityObject",
}
SUBCLASS_OF = {
    "Road": "TransportationComplex",
    "Railway": "TransportationComplex",
    "Track": "TransportationComplex",
    "Square": "TransportationComplex",
}
# classes that are ambiguous across citygml4j packages must be referenced fully qualified
AMBIGUOUS = {"AbstractBoundarySurface", "AbstractOpening"}
MODULE_PREFIXES = ("uro", "urf", "urg", "urt")

GEOM_IMPORTS = {
    "GeometryObject": "org.citydb.config.geometry.GeometryObject",
    "GeometryConverter": "org.citydb.core.operation.importer.util.GeometryConverter",
    "AbstractGeometry": "org.citygml4j.model.gml.geometry.AbstractGeometry",
    "GMLConverter": "org.citydb.core.operation.exporter.database.content.GMLConverter",
    "SurfaceGeometryExporter": "org.citydb.core.operation.exporter.database.content.SurfaceGeometryExporter",
    "GeometrySetter": "org.citydb.core.operation.exporter.util.GeometrySetter",
}
NULL_GEOMETRY = (
    "helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryType(),\n"
    "                    helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryTypeName()"
)


def read(path: str) -> str:
    with open(path, encoding="utf-8") as fp:
        return fp.read()


def write_raw(path: str, text: str) -> None:
    with open(path, "w", encoding="utf-8", newline="\n") as fp:
        fp.write(text)


def write(path: str, text: str) -> None:
    """Writes a Java file with runs of blank lines collapsed."""
    os.makedirs(os.path.dirname(path), exist_ok=True)
    write_raw(path, re.sub(r"\n{3,}", "\n\n", text))


def render_imports(imports: Iterable[str]) -> str:
    imports = set(imports)
    java = sorted(i for i in imports if not i.startswith("java"))
    jdk = sorted(i for i in imports if i.startswith("java"))
    out = "\n".join("import %s;" % i for i in java)
    if jdk:
        out += "\n\n" + "\n".join("import %s;" % i for i in jdk)
    return out


def wrap(items: Iterable[str], quote: bool = False, limit: int = 100) -> list[str]:
    """Joins the items with commas into lines of at most ``limit`` characters."""
    lines, cur = [], ""
    for c in items:
        piece = ('"%s", ' % c) if quote else (c + ", ")
        if len(cur) + len(piece) > limit:
            lines.append(cur.rstrip())
            cur = ""
        cur += piece
    lines.append(cur.rstrip().rstrip(","))
    return lines


def indent(text: str, n: int) -> str:
    """Indents (n > 0) or dedents (n < 0) every non-blank line by ``n`` spaces."""
    if n < 0:
        pad = " " * -n
        return "".join(
            line[len(pad) :] if line.startswith(pad) else line.lstrip(" ") if line.strip() else line
            for line in text.splitlines(True)
        )
    pad = " " * n
    return "".join(pad + line if line.strip() else line for line in text.splitlines(True))


def hook_class(default_base: str) -> str:
    """Class name prefix of the hook importer/exporter for a mapping defaultBase."""
    target = BASE_TARGETS[default_base]
    return target[8:] if target.startswith("Abstract") else target


def simple(fqn: str) -> str:
    return fqn.rsplit(".", 1)[1]


def ref(fqn: str) -> str:
    s = simple(fqn)
    return fqn if s in AMBIGUOUS else s


def safe_var(name: str, var: str) -> str:
    """A local variable name that does not clash with the object variable or the fixed names of the exporters."""
    if name == var or name in ("code", "measure", "length", "objectId", "rs"):
        return name + "Value"
    return name


def required(value: str | None, what: str) -> str:
    if value is None:
        raise GeneratorError(f"the mapping has no {what}")
    return value
