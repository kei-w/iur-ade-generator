"""Generate the uro importers, exporters and schema registrations of iur-ade-citydb from the ADE Manager mapping.

Usage: gen_citydb.py <citydb repo> <citygml4j repo> <version> <preset: all|phaseA|phaseB|phaseC> [modules: uro,urf]
"""

import os
import re
import sys
from collections import OrderedDict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from . import urospec
from .gen_citygml4j import SPECIAL_HOOKS, model_field, select_hooks
from .urospec import cap, uncap

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

GEOM_IMPORTS = {
    "GeometryObject": "org.citydb.config.geometry.GeometryObject",
    "GeometryConverter": "org.citydb.core.operation.importer.util.GeometryConverter",
    "AbstractGeometry": "org.citygml4j.model.gml.geometry.AbstractGeometry",
    "GMLConverter": "org.citydb.core.operation.exporter.database.content.GMLConverter",
    "SurfaceGeometryExporter": "org.citydb.core.operation.exporter.database.content.SurfaceGeometryExporter",
    "GeometrySetter": "org.citydb.core.operation.exporter.util.GeometrySetter",
}


def write(path, text):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    text = re.sub(r"\n{3,}", "\n\n", text)
    with open(path, "w", encoding="utf-8", newline="\n") as fp:
        fp.write(text)


def wrap(items, quote=False, limit=100):
    lines, cur = [], ""
    for c in items:
        piece = ('"%s", ' % c) if quote else (c + ", ")
        if len(cur) + len(piece) > limit:
            lines.append(cur.rstrip())
            cur = ""
        cur += piece
    lines.append(cur.rstrip().rstrip(","))
    return lines


def indent(text, n):
    if n < 0:
        pad = " " * -n
        return "".join(
            l[len(pad) :] if l.startswith(pad) else l.lstrip(" ") if l.strip() else l for l in text.splitlines(True)
        )
    pad = " " * n
    return "".join(pad + l if l.strip() else l for l in text.splitlines(True))


def hook_class(name):
    """Class name of the hook importer/exporter prefix for a mapping defaultBase."""
    target = BASE_TARGETS[name]
    return target[8:] if target.startswith("Abstract") else target


def simple(fqn):
    return fqn.rsplit(".", 1)[1]


def ref(fqn):
    s = simple(fqn)
    return fqn if s in AMBIGUOUS else s


class Table:
    def __init__(self, name, spec):
        self.name = name
        self.enum = name[3:].upper()
        self.columns = spec.ddl_tables[name]
        self.primary = None
        self.merged = []
        self.sub_tables = []
        self.parent = None
        self.parent_columns = []  # columns referencing an owner (1:n), from the mapping joins
        self.has_objectclass = "objectclass_id" in self.columns
        self.sequence = spec.table_sequence.get(name)
        self.used_single = False  # referenced through a 1:1 FK
        self.used_multi = False  # referenced through a parent column
        self.feature = False  # table of an ADE feature type hierarchy (rows share the cityobject id)
        self.module = None  # Module of the types stored in the table

    @property
    def row_types(self):
        return [self.primary] + self.merged

    @property
    def root(self):
        t = self
        while t.parent:
            t = t.parent
        return t

    def all_tables(self):
        out = [self]
        for s in self.sub_tables:
            out.extend(s.all_tables())
        return out

    @property
    def hierarchy_parent_columns(self):
        return [c for t in self.all_tables() for c in t.parent_columns]

    @property
    def concrete(self):
        """Parameter type of the importer: the primary type, or its single concrete merged type when the primary is abstract."""
        if self.primary.abstract and len(self.merged) == 1 and not self.sub_tables and not self.merged[0].subtypes:
            return self.merged[0]
        return self.primary

    @property
    def importer(self):
        return self.concrete.model + "Importer"

    @property
    def exporter(self):
        return self.concrete.model + "Exporter"

    @property
    def exportable(self):
        """A feature table that holds rows of concrete types (abstract-only tables are read through their subtypes)."""
        return any(not rt.abstract for rt in self.row_types)

    @property
    def prefix(self):
        """Column alias prefix of this table's columns in the select of a subtype exporter (the urf style: "uf")."""
        return "".join(c for c in self.concrete.model if c.isupper()).lower() + "_"

    @property
    def depth(self):
        return len(self.primary.ancestors())

    def __repr__(self):
        return "Table(%s)" % self.name


class HookField:
    """A hook property (injected into a CityGML feature) seen as a field by the join table helpers."""

    def __init__(self, h):
        self.column = h.mapping
        self.kind = "property"
        self.target = h.prop_type
        self.multi = h.multi
        self.is_feature_property = False
        self.name = h.element
        self.owner = None


class Generator:
    def __init__(self, spec, repo, hooks, features=True):
        self.spec = spec
        self.repo = repo
        self.cg4j = os.path.dirname(
            list(spec.modules.values())[0].xsd_path.split(os.sep + "resources" + os.sep)[0] + os.sep
        )
        self.modules = list(spec.modules.values())
        self.hooks = [h for h in hooks if h.prop_type is not None]
        self.special = [h for h in hooks if h.prop_type is None and h.element in SPECIAL_HOOKS]
        self.features = spec.feature_types() if features else []
        self.types = spec.closure(self.hooks, self.features)
        self.type_names = {t.qname for t in self.types}
        self.src = os.path.join(repo, "src", "main", "java", "org", "citydb", "ade", "iur")
        header_src = open(os.path.join(self.src, "importer", "urt", "FeedInfoImporter.java"), encoding="utf-8").read()
        self.header = header_src[: header_src.index("*/") + 2]
        self.tables = OrderedDict()
        self.feature_tables = OrderedDict()
        self.polymorphic_roots = set()
        self._build_tables()
        self.injections = self._injections()
        self.compute_lazy()
        # importer/exporter class -> module prefix (for cross-package imports) and the model names that need qualifying
        self.class_module = {}
        self.class_modules = {}
        self.join_importer_tables = {}
        for tbl in list(self.tables.values()) + list(self.feature_tables.values()):
            self.register_class(tbl.importer, tbl.module.prefix)
            self.register_class(tbl.exporter, tbl.module.prefix)
        by_name = {}
        for t in self.types + self.features:
            by_name.setdefault(t.model, set()).add(t.module.prefix)
        for prefix in ("urf", "urg", "urt"):
            d = os.path.join(self.cg4j, "src", "main", "java", "org", "citygml4j", "ade", "iur", "model", prefix)
            if prefix not in spec.modules and os.path.isdir(d):
                for fn in os.listdir(d):
                    by_name.setdefault(fn[:-5], set()).add(prefix)
        self.ambiguous_models = {n for n, mods in by_name.items() if len(mods) > 1} | AMBIGUOUS

    # --------------------------------------------------------------- tables
    def _build_tables(self):
        for t in self.types + self.features:
            mt = t.mapping
            if mt is None:
                raise ValueError("no mapping for " + t.name)
            tables = self.feature_tables if t.is_feature else self.tables
            tbl = tables.get(mt.table)
            if tbl is None:
                tbl = tables[mt.table] = Table(mt.table, self.spec)
                tbl.feature = t.is_feature
                tbl.module = t.module
            if t.base is not None and t.base.mapping.table == mt.table:
                tbl.merged.append(t)
            else:
                assert tbl.primary is None, (tbl, tbl.primary, t)
                tbl.primary = t
                if t.base is not None:
                    tbl.parent = tables[t.base.mapping.table]
                    tbl.parent.sub_tables.append(tbl)
        # polymorphic hierarchies: a property type targets a type that has subtypes
        for p in self.spec.property_types(self.types + self.features):
            if p.polymorphic and p.prop_target is not None and not p.prop_target.is_feature:
                self.polymorphic_roots.add(p.prop_target.root().qname)
        # parent columns and usage
        for t in self.types + self.features:
            for f in t.fields:
                p = f.column = t.mapping.props.get(f.name)
                if p is None:
                    raise ValueError("no mapping property for %s.%s" % (t.name, f.name))
                if p.get("joinTable"):
                    if f.kind == "property" and not f.is_feature_property:
                        self._note_usage(f.target.prop_target, p)
                    continue  # references through a join table (members, urf:target, data type lists)
                if f.is_feature_property:
                    child = self.feature_tables[p["join"][0]]
                    if p["join"][2] not in child.parent_columns:
                        child.parent_columns.append(p["join"][2])
                elif f.kind == "property":
                    self._note_usage(f.target.prop_target, p)
        for h in self.hooks:
            if (
                not h.prop_type.prop_target.is_feature
            ):  # feature hooks (pointCloud) are imported by the Importer/Exporter
                self._note_usage(h.prop_type.prop_target, h.mapping)

    def _note_usage(self, target, p):
        join = p.get("join")
        if p.get("joinTable"):
            self.tables[target.mapping.table].used_single = True
            return
        if join is None:
            raise ValueError("property %s without join" % p["path"])
        if join[3] == "parent":
            self.tables[target.mapping.table].used_single = True
        else:
            tbl = self.tables[join[0]]
            tbl.used_multi = True
            if join[2] not in tbl.parent_columns:
                tbl.parent_columns.append(join[2])

    def _injections(self):
        out = OrderedDict()
        for h in self.hooks + self.special:
            inj = h.injection
            if inj is None:
                raise ValueError("hook %s is not injected" % h.element)
            out.setdefault(inj.table, (inj, []))[1].append(h)
        return out

    def table_of(self, t):
        return (self.feature_tables if t.is_feature else self.tables)[t.mapping.table]

    # ---------------------------------------------------- dependency cycles
    def importer_deps(self, tbl):
        deps = []
        for rt in tbl.row_types:
            for f in rt.fields:
                if f.kind == "property" and not f.is_feature_property:
                    target = f.target.prop_target
                    deps.append(
                        self.table_of(target).root.importer
                        if f.column.get("join") and f.column["join"][3] == "child"
                        else self.importer_for(target)
                    )
                elif f.kind == "inline":
                    deps.append(self.importer_for(f.target))
        if self.dispatch_style(tbl):
            deps += [s.importer for s in tbl.sub_tables]
        elif tbl.parent is not None:
            deps.append(tbl.root.importer)
        return deps

    def exporter_deps(self, tbl):
        deps = []
        tables = tbl.all_tables() if self.dispatch_style(tbl) else [tbl]
        for t in tables:
            for rt in t.row_types:
                for f in rt.fields:
                    if f.kind == "property" and not f.is_feature_property:
                        target = f.target.prop_target
                        tt = self.table_of(target)
                        deps.append(
                            tt.root.exporter
                            if f.column.get("join") and f.column["join"][3] == "child"
                            else (tt.root.exporter if self.dispatch_style(tt) else tt.exporter)
                        )
                    elif f.kind == "inline":
                        deps.append(self.table_of(f.target).exporter)
        return deps

    @staticmethod
    def cyclic_edges(graph):
        """Edges (u, v) where v can reach u again: these must be resolved lazily."""

        def reaches(a, b, seen):
            if a == b:
                return True
            for c in graph.get(a, ()):
                if c not in seen:
                    seen.add(c)
                    if reaches(c, b, seen):
                        return True
            return False

        return {(u, v) for u, vs in graph.items() for v in vs if reaches(v, u, set())}

    def compute_lazy(self):
        imp_graph, exp_graph = {}, {}
        for tbl in self.tables.values():
            imp_graph[tbl.importer] = self.importer_deps(tbl)
            if not (self.dispatch_style(tbl) and tbl.parent is not None):
                exp_graph[tbl.exporter] = self.exporter_deps(tbl)
        self.lazy_imp = self.cyclic_edges(imp_graph)
        self.lazy_exp = self.cyclic_edges(exp_graph)
        self.current_importer = self.current_exporter = None

    def ref_imp(self, imp):
        return uncap(imp) + ("()" if (self.current_importer, imp) in self.lazy_imp else "")

    def ref_exp(self, exp):
        return uncap(exp) + ("()" if (self.current_exporter, exp) in self.lazy_exp else "")

    @staticmethod
    def lazy_accessor(cls, manager_getter, exception):
        var = uncap(cls)
        return (
            f"    private {cls} {var}() throws {exception}, SQLException {{\n        if ({var} == null)\n"
            f"            {var} = manager.{manager_getter}({cls}.class);\n\n        return {var};\n    }}\n\n"
        )

    def dispatch_style(self, tbl):
        return tbl.root.primary.qname in self.polymorphic_roots

    def parent_arg_style(self, tbl):
        """None, 'single' (one parent column, fixed) or 'multi' (parent column passed by name)."""
        cols = tbl.root.hierarchy_parent_columns
        if not cols:
            return None
        # a hierarchy used both through a FK and a parent column needs distinct doExport(long ...) signatures
        both = any(t.used_single for t in tbl.root.all_tables())
        return "single" if len(cols) == 1 and not both else "multi"

    # ----------------------------------------------------------- field code
    @staticmethod
    def code_pair(cols, set_code, null_code):
        return cols, set_code, null_code

    def join_importer(self, owner, f):
        """Importer of the join table of a reference to city objects (urf:target), to members (urf nested features) or
        to the rows of a multi-valued data type; owner is the owner table or the owner class name (hook tables)."""
        name = owner if isinstance(owner, str) else owner.concrete.model
        target = "CityObject" if f.kind == "cityObjectRef" else f.target.prop_target.model
        jt = f.column["joinTable"][0]
        cls = name + "To" + target + "Importer"
        if cls in self.join_importer_tables and self.join_importer_tables[cls] != jt:
            cls = name + cap(model_field(f)) + "To" + target + "Importer"
        self.join_importer_tables[cls] = jt
        return cls

    def import_field(self, var, f, i, tbl):
        """Returns (columns, set_code, null_code, post_code) for a field; i is the first parameter index."""
        g = "%s.get%s()" % (var, cap(model_field(f)))
        p = f.column
        k = f.kind
        if k == "property" and p.get("joinTable") and not f.is_feature_property:
            # multi-valued data types: the rows are imported on their own and linked through the join table
            target = f.target.prop_target
            imp = self.importer_for(target)
            jt_imp = uncap(self.join_importer(tbl, f))
            name = model_field(f)
            self.extra_imports.add(f"{f.target.module.model_pkg}.{f.target.model}")
            body = (
                f"            if (property.isSetObject()) {{\n                long {name}Id = {self.ref_imp(imp)}.doImport(property.getObject());\n"
                f"                {jt_imp}.doImport({name}Id, objectId);\n            }}\n"
            )
            if f.multi:
                return [], "", "", f"        for ({f.target.model} property : {g}) {{\n{body}        }}\n"
            return (
                [],
                "",
                "",
                f"        if ({g} != null) {{\n            {f.target.model} property = {g};\n{body}        }}\n",
            )
        if k == "cityObjectRef" or (f.is_member_reference and p.get("joinTable")):
            # references to other city objects (members): rows of a join table, xlinks resolved by the Importer/Exporter
            jt, owner_col, target_col = p["joinTable"]
            imp = uncap(self.join_importer(tbl, f))
            cls = "AbstractCityObject" if k == "cityObjectRef" else f.target.prop_target.model
            self.extra_imports |= {
                f"{f.target.module.model_pkg}.{f.target.model}",
                "org.citygml4j.model.citygml.core.AbstractCityObject"
                if k == "cityObjectRef"
                else f"{f.target.prop_target.module.model_pkg}.{cls}",
            }
            body = (
                f"            {cls} cityObject = property.getObject();\n"
                f"            if (cityObject != null) {{\n                long cityObjectId = helper.importObject(cityObject);\n"
                f"                property.unsetObject();\n                {imp}.doImport(cityObjectId, objectId);\n            }} else {{\n"
                f"                String href = property.getHref();\n                if (href != null && !href.isEmpty())\n"
                f'                    helper.propagateObjectXlink(schemaMapper.getTableName(ADETable.{jt[3:].upper()}), objectId, "{owner_col}", href, "{target_col}");\n'
                f"            }}\n"
            )
            if f.multi:
                return [], "", "", f"        for ({f.target.model} property : {g}) {{\n{body}        }}\n"
            return (
                [],
                "",
                "",
                f"        if ({g} != null) {{\n            {f.target.model} property = {g};\n{body}        }}\n",
            )
        if f.is_feature_property:
            # nested ADE features are imported through the Importer/Exporter with the parent id as foreign key
            child = self.feature_tables[p["join"][0]]
            target = f.target.prop_target
            column = p["join"][2]
            cvar = uncap(target.model.replace("Abstract", "", 1))
            self.extra_imports |= {
                f"{f.target.module.model_pkg}.{f.target.model}",
                f"{target.module.model_pkg}.{target.model}",
                "org.citydb.core.ade.importer.ForeignKeys",
            }
            if f.multi:
                return (
                    [],
                    "",
                    "",
                    (
                        f"        for ({f.target.model} property : {g}) {{\n            {target.model} {cvar} = property.getObject();\n"
                        f"            if ({cvar} != null) {{\n"
                        f'                helper.importObject({cvar}, ForeignKeys.create().with("{column}", objectId));\n'
                        f"                property.unsetObject();\n            }} else {{\n"
                        f"                String href = property.getHref();\n                if (href != null && !href.isEmpty())\n"
                        f'                    helper.propagateReverseObjectXlink(schemaMapper.getTableName(ADETable.{child.enum}), href, objectId, "{column}");\n'
                        f"            }}\n        }}\n"
                    ),
                )
            return (
                [],
                "",
                "",
                (
                    f"        if ({g} != null) {{\n            {target.model} {cvar} = {g}.getObject();\n"
                    f"            if ({cvar} != null) {{\n"
                    f'                helper.importObject({cvar}, ForeignKeys.create().with("{column}", objectId));\n'
                    f"                {g}.unsetObject();\n            }} else {{\n"
                    f"                String href = {g}.getHref();\n                if (href != null && !href.isEmpty())\n"
                    f'                    helper.propagateReverseObjectXlink(schemaMapper.getTableName(ADETable.{child.enum}), href, objectId, "{column}");\n'
                    f"            }}\n        }}\n"
                ),
            )
        if k == "multiSurface":
            col = p["refColumn"]
            name = model_field(f)
            set_code = (
                f"        long {name}Id = 0;\n        if ({g} != null) {{\n            MultiSurfaceProperty property = {g};\n"
                f"            if (property.isSetMultiSurface()) {{\n"
                f"                {name}Id = helper.importSurfaceGeometry(property.getMultiSurface(), objectId);\n"
                f"                property.unsetMultiSurface();\n            }} else {{\n"
                f"                String href = property.getHref();\n                if (href != null && !href.isEmpty())\n"
                f'                    helper.propagateSurfaceGeometryXlink(href, schemaMapper.getTableName(ADETable.{tbl.enum}), objectId, "{col}");\n'
                f"            }}\n        }}\n\n"
                f"        if ({name}Id != 0)\n            ps.setLong({i}, {name}Id);\n        else\n            ps.setNull({i}, Types.NULL);\n"
            )
            self.extra_imports.add("org.citygml4j.model.gml.geometry.aggregates.MultiSurfaceProperty")
            return [col], set_code, f"        ps.setNull({i}, Types.NULL);\n", ""
        if k in ("multiCurve", "multiPoint"):
            col = p["inlineColumn"]
            name = model_field(f)
            cls = cap(k)
            set_code = (
                f"        GeometryObject {name} = null;\n        if ({g} != null) {{\n"
                f"            {name} = geometryConverter.get{cls}({g});\n            {g}.unset{cls}();\n        }}\n\n"
                f"        if ({name} != null)\n            ps.setObject({i}, helper.getDatabaseAdapter().getGeometryConverter().getDatabaseObject({name}, connection));\n        else\n"
                f"            ps.setNull({i}, helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryType(),\n"
                f"                    helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryTypeName());\n"
            )
            null_code = (
                f"        ps.setNull({i}, helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryType(),\n"
                f"                helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryTypeName());\n"
            )
            return [col], set_code, null_code, ""
        if k == "directPosition":
            col = p["column"]
            return (
                [col],
                f'        if ({g} != null && {g}.isSetValue())\n            ps.setString({i}, valueJoiner.join(" ", {g}.getValue()));\n'
                f"        else\n            ps.setNull({i}, Types.VARCHAR);\n",
                f"        ps.setNull({i}, Types.VARCHAR);\n",
                "",
            )
        if k == "property" and p["tag"] == "complexProperty" and p["join"][3] == "child":
            # 1:n child objects imported after the row
            child = self.table_of(f.target.prop_target).root
            args = "objectId"
            if self.parent_arg_style(child) == "multi":
                args += ', "%s"' % p["join"][2]
            elif self.parent_arg_style(child) == "single":
                args = "objectId"
            post = (
                f"        for ({f.target.model} property : {g}) {{\n            if (property.isSetObject())\n"
                f"                {self.ref_imp(child.importer)}.doImport(property.getObject(), {args});\n        }}\n"
            )
            self.extra_imports.add(f"{f.target.module.model_pkg}.{f.target.model}")
            return [], "", "", post
        if k == "property":
            col = p["join"][1]
            target = f.target.prop_target
            imp = self.importer_for(target)
            name = model_field(f)
            set_code = (
                f"        long {name}Id = 0;\n        if ({g} != null && {g}.isSetObject())\n"
                f"            {name}Id = {self.ref_imp(imp)}.doImport({g}.getObject());\n\n"
                f"        if ({name}Id != 0)\n            ps.setLong({i}, {name}Id);\n        else\n            ps.setNull({i}, Types.NULL);\n"
            )
            return [col], set_code, f"        ps.setNull({i}, Types.NULL);\n", ""
        if k == "inline":
            col = p["join"][1]
            imp = self.importer_for(f.target)
            name = model_field(f)
            set_code = (
                f"        long {name}Id = 0;\n        if ({g} != null)\n            {name}Id = {self.ref_imp(imp)}.doImport({g});\n\n"
                f"        if ({name}Id != 0)\n            ps.setLong({i}, {name}Id);\n        else\n            ps.setNull({i}, Types.NULL);\n"
            )
            return [col], set_code, f"        ps.setNull({i}, Types.NULL);\n", ""
        if k == "address":
            col = p["join"][1]
            name = model_field(f)
            set_code = (
                f"        long {name}Id = 0;\n        if ({g} != null && {g}.isSetAddress())\n            {name}Id = helper.importObject({g}.getAddress());\n\n"
                f"        if ({name}Id != 0)\n            ps.setLong({i}, {name}Id);\n        else\n            ps.setNull({i}, Types.NULL);\n"
            )
            return [col], set_code, f"        ps.setNull({i}, Types.NULL);\n", ""
        if k in ("geometry", "complex"):
            ref_col, inline_col = p["refColumn"], p["inlineColumn"]
            name = model_field(f)
            owner = "objectId" if tbl.feature else "0"
            set_code = (
                f"        long {name}Id = 0;\n        Object {name}Geometry = null;\n"
                f"        if ({g} != null && {g}.isSetGeometry()) {{\n"
                f"            AbstractGeometry geometry = {g}.getGeometry();\n"
                f"            if (helper.isSurfaceGeometry(geometry))\n                {name}Id = helper.importSurfaceGeometry(geometry, {owner});\n"
                f"            else if (helper.isPointOrLineGeometry(geometry)) {{\n"
                f"                GeometryObject geometryObject = geometryConverter.getPointOrCurveGeometry(geometry);\n"
                f"                if (geometryObject != null)\n"
                f"                    {name}Geometry = helper.getDatabaseAdapter().getGeometryConverter().getDatabaseObject(geometryObject, connection);\n"
                f"            }}\n        }}\n\n"
                f"        if ({name}Id != 0)\n            ps.setLong({i}, {name}Id);\n        else\n            ps.setNull({i}, Types.NULL);\n\n"
                f"        if ({name}Geometry != null)\n            ps.setObject({i + 1}, {name}Geometry);\n        else\n"
                f"            ps.setNull({i + 1}, helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryType(),\n"
                f"                    helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryTypeName());\n"
            )
            null_code = (
                f"        ps.setNull({i}, Types.NULL);\n        ps.setNull({i + 1}, helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryType(),\n"
                f"                helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryTypeName());\n"
            )
            return [ref_col, inline_col], set_code, null_code, ""
        if k == "point":
            col = p["inlineColumn"]
            name = model_field(f)
            set_code = (
                f"        GeometryObject {name} = null;\n        if ({g} != null)\n            {name} = geometryConverter.getPoint({g});\n\n"
                f"        if ({name} != null)\n            ps.setObject({i}, helper.getDatabaseAdapter().getGeometryConverter().getDatabaseObject({name}, connection));\n        else\n"
                f"            ps.setNull({i}, helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryType(),\n"
                f"                    helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryTypeName());\n"
            )
            null_code = (
                f"        ps.setNull({i}, helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryType(),\n"
                f"                helper.getDatabaseAdapter().getGeometryConverter().getNullGeometryTypeName());\n"
            )
            return [col], set_code, null_code, ""
        col, q = p.get("column"), p.get("qualifier")
        if col is None:
            raise ValueError("no column for %s" % f.name)
        if f.multi:
            if k == "code":
                return (
                    [col, q],
                    f"        if (!{g}.isEmpty()) {{\n            valueJoiner.join({g}, Code::getValue, Code::getCodeSpace);\n"
                    f"            ps.setString({i}, valueJoiner.result(0));\n            ps.setString({i + 1}, valueJoiner.result(1));\n"
                    f"        }} else {{\n            ps.setNull({i}, Types.VARCHAR);\n            ps.setNull({i + 1}, Types.VARCHAR);\n        }}\n",
                    f"        ps.setNull({i}, Types.VARCHAR);\n        ps.setNull({i + 1}, Types.VARCHAR);\n",
                    "",
                )
            if k in ("string", "date", "integer", "double", "year", "yearMonth", "enum"):
                return (
                    [col],
                    f"        if (!{g}.isEmpty())\n            ps.setString({i}, valueJoiner.join({g}));\n        else\n            ps.setNull({i}, Types.VARCHAR);\n",
                    f"        ps.setNull({i}, Types.VARCHAR);\n",
                    "",
                )
            if k in ("measure", "length"):
                # lists of measures: the values and the units joined in the two columns of the measure
                cls = "Measure" if k == "measure" else "Length"
                return (
                    [col, q],
                    f"        if (!{g}.isEmpty()) {{\n            valueJoiner.join({g}, {uncap(cls)} -> String.valueOf({uncap(cls)}.getValue()), {cls}::getUom);\n"
                    f"            ps.setString({i}, valueJoiner.result(0));\n            ps.setString({i + 1}, valueJoiner.result(1));\n"
                    f"        }} else {{\n            ps.setNull({i}, Types.VARCHAR);\n            ps.setNull({i + 1}, Types.VARCHAR);\n        }}\n",
                    f"        ps.setNull({i}, Types.VARCHAR);\n        ps.setNull({i + 1}, Types.VARCHAR);\n",
                    "",
                )
            raise NotImplementedError("list of %s (%s)" % (k, f.name))
        if k == "string":
            return [col], f"        ps.setString({i}, {g});\n", f"        ps.setNull({i}, Types.VARCHAR);\n", ""
        if k == "stringOrRef":
            return (
                [col],
                f"        if ({g} != null && {g}.isSetValue())\n            ps.setString({i}, {g}.getValue());\n        else\n            ps.setNull({i}, Types.VARCHAR);\n",
                f"        ps.setNull({i}, Types.VARCHAR);\n",
                "",
            )
        if k == "enum":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setString({i}, {g}.value());\n        else\n            ps.setNull({i}, Types.VARCHAR);\n",
                f"        ps.setNull({i}, Types.VARCHAR);\n",
                "",
            )
        if k == "doubleList":
            return (
                [col],
                f"        if (!{g}.isEmpty())\n            ps.setString({i}, valueJoiner.join({g}));\n        else\n            ps.setNull({i}, Types.VARCHAR);\n",
                f"        ps.setNull({i}, Types.VARCHAR);\n",
                "",
            )
        if k == "integer":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setInt({i}, {g});\n        else\n            ps.setNull({i}, Types.INTEGER);\n",
                f"        ps.setNull({i}, Types.INTEGER);\n",
                "",
            )
        if k == "double":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setDouble({i}, {g});\n        else\n            ps.setNull({i}, Types.DOUBLE);\n",
                f"        ps.setNull({i}, Types.DOUBLE);\n",
                "",
            )
        if k == "boolean":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setInt({i}, {g} ? 1 : 0);\n        else\n            ps.setNull({i}, Types.INTEGER);\n",
                f"        ps.setNull({i}, Types.INTEGER);\n",
                "",
            )
        if k == "date":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setDate({i}, Date.valueOf({g}));\n        else\n            ps.setNull({i}, Types.DATE);\n",
                f"        ps.setNull({i}, Types.DATE);\n",
                "",
            )
        if k == "year":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setDate({i}, Date.valueOf(LocalDate.of({g}.getValue(), 1, 1)));\n        else\n            ps.setNull({i}, Types.DATE);\n",
                f"        ps.setNull({i}, Types.DATE);\n",
                "",
            )
        if k == "yearMonth":
            return (
                [col],
                f"        if ({g} != null)\n            ps.setDate({i}, Date.valueOf({g}.atDay(1)));\n        else\n            ps.setNull({i}, Types.DATE);\n",
                f"        ps.setNull({i}, Types.DATE);\n",
                "",
            )
        if k == "code":
            return (
                [col, q],
                f"        if ({g} != null && {g}.isSetValue()) {{\n            ps.setString({i}, {g}.getValue());\n            ps.setString({i + 1}, {g}.getCodeSpace());\n"
                f"        }} else {{\n            ps.setNull({i}, Types.VARCHAR);\n            ps.setNull({i + 1}, Types.VARCHAR);\n        }}\n",
                f"        ps.setNull({i}, Types.VARCHAR);\n        ps.setNull({i + 1}, Types.VARCHAR);\n",
                "",
            )
        if k in ("measure", "length"):
            return (
                [col, q],
                f"        if ({g} != null && {g}.isSetValue()) {{\n            ps.setDouble({i}, {g}.getValue());\n            ps.setString({i + 1}, {g}.getUom());\n"
                f"        }} else {{\n            ps.setNull({i}, Types.DOUBLE);\n            ps.setNull({i + 1}, Types.VARCHAR);\n        }}\n",
                f"        ps.setNull({i}, Types.DOUBLE);\n        ps.setNull({i + 1}, Types.VARCHAR);\n",
                "",
            )
        raise ValueError(k)

    def importer_for(self, target):
        """Importer class to call for a 1:1 nested or hooked object of the given type."""
        tbl = self.table_of(target)
        if self.dispatch_style(tbl):
            return tbl.root.importer
        return tbl.importer

    def export_field(self, var, f, alias):
        """Returns (columns, code) for reading a field of the given object variable; alias maps column -> result set label."""
        p = f.column
        k = f.kind
        if k == "property" and p.get("joinTable") and not f.is_feature_property:
            target = f.target.prop_target
            tbl = self.table_of(target)
            name = model_field(f)
            ps = "ps" + cap(name)
            setter, getter = "%s.set%s" % (var, cap(name)), "%s.get%s" % (var, cap(name))
            if name == var or name in ("code", "measure", "length", "objectId", "rs"):
                name += "Value"
            add = (
                f"{getter}().add(new {f.target.model}({name}))"
                if f.multi
                else f"{setter}(new {f.target.model}({name}))"
            )
            if self.dispatch_style(tbl):
                exp = tbl.root.exporter
                root_model = tbl.root.primary.model
                test = f"{name} instanceof {target.model}" if root_model != target.model else f"{name} != null"
                cast = f"({target.model}) " if root_model != target.model else ""
                add = (
                    f"{getter}().add(new {f.target.model}({cast}{name}))"
                    if f.multi
                    else f"{setter}(new {f.target.model}({cast}{name}))"
                )
                load = (
                    f'                        {root_model} {name} = {self.ref_exp(exp)}.doExport({name}Rs.getLong("{p["joinTable"][2]}"));\n'
                    f"                        if ({test})\n                            {add};\n"
                )
            else:
                exp = tbl.exporter
                load = (
                    f"                        {target.model} {name} = new {target.model}();\n"
                    f'                        {self.ref_exp(exp)}.doExport({name}, {name}Rs.getLong("{p["joinTable"][2]}"));\n'
                    f"                        {add};\n"
                )
            return [], (
                f"                {ps}.setLong(1, objectId);\n                try (ResultSet {name}Rs = {ps}.executeQuery()) {{\n"
                f"                    while ({name}Rs.next()) {{\n{load}                    }}\n                }}\n"
            )
        if k == "cityObjectRef" or (f.is_member_reference and p.get("joinTable")):
            name = model_field(f)
            ps = "ps" + cap(name)
            add = f"{var}.get{cap(name)}().add({name}Property)" if f.multi else f"{var}.set{cap(name)}({name}Property)"
            return [], (
                f"                {ps}.setLong(1, objectId);\n                try (ResultSet {name}Rs = {ps}.executeQuery()) {{\n"
                f"                    while ({name}Rs.next()) {{\n"
                f"                        {f.target.model} {name}Property = new {f.target.model}();\n"
                f'                        {name}Property.setHref("#" + {name}Rs.getString("gmlid"));\n'
                f"                        {add};\n                    }}\n                }}\n"
            )
        setter = "%s.set%s" % (var, cap(model_field(f)))
        getter = "%s.get%s" % (var, cap(model_field(f)))
        name = model_field(f)
        if name == var or name in ("code", "measure", "length", "objectId", "rs"):
            name += "Value"
        if f.is_feature_property:
            # nested ADE features: their ids are queried per parent, the objects are created by the Importer/Exporter
            target = f.target.prop_target
            cvar = uncap(target.model.replace("Abstract", "", 1))
            ps = "ps" + cap(name)
            add = (
                f"{getter}().add(new {f.target.model}({cvar}))"
                if f.multi
                else f"{setter}(new {f.target.model}({cvar}))"
            )
            # the Importer/Exporter creates nested ADE objects as stubs: their ADE content is exported here
            return [], (
                f"                {ps}.setLong(1, objectId);\n                try (ResultSet {name}Rs = {ps}.executeQuery()) {{\n"
                f"                    while ({name}Rs.next()) {{\n"
                f'                        long {cvar}Id = {name}Rs.getLong("id");\n'
                f'                        AbstractObjectType<?> {cvar}Type = helper.getAbstractObjectType({name}Rs.getInt("objectclass_id"));\n'
                f"                        {target.model} {cvar} = helper.createObject({cvar}Id, {cvar}Type.getObjectClassId(), {target.model}.class);\n"
                f"                        if ({cvar} != null) {{\n"
                f"                            manager.exportObject({cvar}, {cvar}Id, {cvar}Type, helper.getProjectionFilter({cvar}Type));\n"
                f"                            {add};\n                        }}\n"
                f"                    }}\n                }}\n"
            )
        if k == "multiSurface":
            col = alias(p["refColumn"])
            return [col], (
                f'                long {name}Id = rs.getLong("{col}");\n                if (!rs.wasNull())\n'
                f"                    surfaceGeometryExporter.addBatch({name}Id, {var}::set{cap(model_field(f))});\n"
            )
        if k in ("multiCurve", "multiPoint"):
            col = alias(p["inlineColumn"])
            cls = cap(k)
            return [col], (
                f'                Object {name}Object = rs.getObject("{col}");\n                if (!rs.wasNull()) {{\n'
                f"                    GeometryObject {name} = helper.getDatabaseAdapter().getGeometryConverter().get{cls}({name}Object);\n"
                f"                    if ({name} != null)\n                        {setter}(gmlConverter.get{cls}Property({name}));\n                }}\n"
            )
        if k == "directPosition":
            col = alias(p["column"])
            return [col], (
                f'                String {name} = rs.getString("{col}");\n                if (!rs.wasNull()) {{\n'
                f"                    DirectPosition directPosition = new DirectPosition();\n"
                f'                    directPosition.setValue(valueSplitter.splitDoubleList(Pattern.compile(" "), {name}));\n'
                f"                    {setter}(directPosition);\n                }}\n"
            )
        if k == "property" and p["tag"] == "complexProperty" and p["join"][3] == "child":
            child = self.table_of(f.target.prop_target).root
            exp = child.exporter
            args = "objectId"
            if self.parent_arg_style(child) == "multi":
                args += ', "%s"' % p["join"][2]
            return [], (
                f"                for ({child.primary.model} {name} : {self.ref_exp(exp)}.doExport({args}))\n"
                f"                    {getter}().add(new {f.target.model}({name}));\n"
            )
        if k == "property":
            col = alias(p["join"][1])
            target = f.target.prop_target
            tbl = self.table_of(target)
            if self.dispatch_style(tbl):
                exp = tbl.root.exporter
                root_model = tbl.root.primary.model
                test = f"{name} instanceof {target.model}" if root_model != target.model else f"{name} != null"
                cast = f"({target.model}) " if root_model != target.model else ""
                return [col], (
                    f'                long {name}Id = rs.getLong("{col}");\n                if ({name}Id != 0) {{\n'
                    f"                    {root_model} {name} = {self.ref_exp(exp)}.doExport({name}Id);\n"
                    f"                    if ({test})\n                        {setter}(new {f.target.model}({cast}{name}));\n                }}\n"
                )
            exp = tbl.exporter
            return [col], (
                f'                long {name}Id = rs.getLong("{col}");\n                if ({name}Id != 0) {{\n'
                f"                    {target.model} {name} = new {target.model}();\n                    {self.ref_exp(exp)}.doExport({name}, {name}Id);\n"
                f"                    {setter}(new {f.target.model}({name}));\n                }}\n"
            )
        if k == "inline":
            col = alias(p["join"][1])
            tbl = self.table_of(f.target)
            exp = tbl.exporter
            return [col], (
                f'                long {name}Id = rs.getLong("{col}");\n                if ({name}Id != 0) {{\n'
                f"                    {f.target.model} {name} = new {f.target.model}();\n                    {self.ref_exp(exp)}.doExport({name}, {name}Id);\n"
                f"                    {setter}({name});\n                }}\n"
            )
        if k == "address":
            col = alias(p["join"][1])
            return [col], (
                f'                long {name}Id = rs.getLong("{col}");\n                if ({name}Id != 0) {{\n'
                f"                    Address {name} = helper.createObject({name}Id, Util.getObjectClassId(Address.class), Address.class);\n"
                f"                    if ({name} != null)\n                        {setter}(new AddressProperty({name}));\n                }}\n"
            )
        if k in ("geometry", "complex"):
            ref_col, inline_col = alias(p["refColumn"]), alias(p["inlineColumn"])
            conv = "getPointOrCurveComplexProperty" if k == "complex" else "getPointOrCurveGeometryProperty"
            code = (
                f'                long {name}Id = rs.getLong("{ref_col}");\n                if ({name}Id != 0)\n'
                f"                    surfaceGeometryExporter.addBatch({name}Id, (GeometrySetter.AbstractGeometry) geometry -> {setter}(geometry));\n"
                f'                else {{\n                    Object {name}Object = rs.getObject("{inline_col}");\n'
                f"                    if (!rs.wasNull()) {{\n"
                f"                        GeometryObject {name} = helper.getDatabaseAdapter().getGeometryConverter().getGeometry({name}Object);\n"
                f"                        if ({name} != null)\n                            {setter}(gmlConverter.{conv}({name}));\n"
                f"                    }}\n                }}\n"
            )
            if k == "complex":
                code = code.replace(
                    f"(GeometrySetter.AbstractGeometry) geometry -> {setter}(geometry)",
                    f"(GeometrySetter.AbstractGeometry) geometry -> {{\n                        if (geometry.getGeometry() instanceof GeometricComplex)\n"
                    f"                            {setter}(new GeometricComplexProperty((GeometricComplex) geometry.getGeometry()));\n                    }}",
                )
            return [ref_col, inline_col], code
        if k == "point":
            col = alias(p["inlineColumn"])
            return [col], (
                f'                Object {name}Object = rs.getObject("{col}");\n                if (!rs.wasNull()) {{\n'
                f"                    GeometryObject {name} = helper.getDatabaseAdapter().getGeometryConverter().getPoint({name}Object);\n"
                f"                    if ({name} != null)\n                        {setter}(gmlConverter.getPointProperty({name}));\n                }}\n"
            )
        col, q = alias(p.get("column")), alias(p.get("qualifier")) if p.get("qualifier") else None
        if f.multi:
            if k == "code":
                return [col, q], (
                    f'                for (SplitValue splitValue : valueSplitter.split(rs.getString("{col}"), rs.getString("{q}"))) {{\n'
                    f"                    Code code = new Code(splitValue.result(0));\n                    code.setCodeSpace(splitValue.result(1));\n"
                    f"                    {getter}().add(code);\n                }}\n"
                )
            if k in ("measure", "length"):
                cls = "Measure" if k == "measure" else "Length"
                return [col, q], (
                    f'                for (SplitValue splitValue : valueSplitter.split(rs.getString("{col}"), rs.getString("{q}"))) {{\n'
                    f"                    {cls} {uncap(cls)} = new {cls}(splitValue.asDouble(0));\n                    {uncap(cls)}.setUom(splitValue.result(1));\n"
                    f"                    {getter}().add({uncap(cls)});\n                }}\n"
                )
            conv = {
                "string": "splitValue.result(0)",
                "date": "LocalDate.parse(splitValue.result(0))",
                "integer": "splitValue.asInteger(0)",
                "double": "splitValue.asDouble(0)",
                "year": "Year.parse(splitValue.result(0))",
                "yearMonth": "YearMonth.parse(splitValue.result(0))",
                "enum": "%s.fromValue(splitValue.result(0))" % (f.target.model if k == "enum" else ""),
            }[k]
            return [col], (
                f'                for (SplitValue splitValue : valueSplitter.split(rs.getString("{col}")))\n'
                f"                    {getter}().add({conv});\n"
            )
        if k == "string":
            return [col], f'                {setter}(rs.getString("{col}"));\n'
        if k == "stringOrRef":
            return (
                [col],
                f'                String {name} = rs.getString("{col}");\n                if (!rs.wasNull())\n                    {setter}(new StringOrRef({name}));\n',
            )
        if k == "enum":
            return (
                [col],
                f'                String {name} = rs.getString("{col}");\n                if (!rs.wasNull())\n                    {setter}({f.target.model}.fromValue({name}));\n',
            )
        if k == "doubleList":
            return [col], (
                f'                for (SplitValue splitValue : valueSplitter.split(rs.getString("{col}")))\n'
                f"                    {getter}().add(splitValue.asDouble(0));\n"
            )
        if k == "integer":
            return (
                [col],
                f'                int {name} = rs.getInt("{col}");\n                if (!rs.wasNull())\n                    {setter}({name});\n',
            )
        if k == "double":
            return (
                [col],
                f'                double {name} = rs.getDouble("{col}");\n                if (!rs.wasNull())\n                    {setter}({name});\n',
            )
        if k == "boolean":
            return (
                [col],
                f'                boolean {name} = rs.getBoolean("{col}");\n                if (!rs.wasNull())\n                    {setter}({name});\n',
            )
        if k == "date":
            return (
                [col],
                f'                Date {name} = rs.getDate("{col}");\n                if (!rs.wasNull())\n                    {setter}({name}.toLocalDate());\n',
            )
        if k == "year":
            return (
                [col],
                f'                Date {name} = rs.getDate("{col}");\n                if (!rs.wasNull())\n                    {setter}(Year.of({name}.toLocalDate().getYear()));\n',
            )
        if k == "yearMonth":
            return (
                [col],
                f'                Date {name} = rs.getDate("{col}");\n                if (!rs.wasNull())\n                    {setter}(YearMonth.from({name}.toLocalDate()));\n',
            )
        if k == "code":
            return [col, q], (
                f'                String {name} = rs.getString("{col}");\n                if (!rs.wasNull()) {{\n                    Code code = new Code({name});\n'
                f'                    code.setCodeSpace(rs.getString("{q}"));\n                    {setter}(code);\n                }}\n'
            )
        if k in ("measure", "length"):
            cls = "Measure" if k == "measure" else "Length"
            return [col, q], (
                f'                double {name} = rs.getDouble("{col}");\n                if (!rs.wasNull()) {{\n                    {cls} {uncap(cls)} = new {cls}({name});\n'
                f'                    {uncap(cls)}.setUom(rs.getString("{q}"));\n                    {setter}({uncap(cls)});\n                }}\n'
            )
        raise ValueError(k)

    # -------------------------------------------------------------- importer
    def _import_fields(self, t, v, i, tbl, ctx):
        """Import code of the fields of type t read from variable v; returns (columns, sets, nulls, posts, next index)."""
        child_importers, needs, imports = ctx
        sets, nulls, posts, cols = [], [], [], []
        for f in t.fields:
            c, s, n, p = self.import_field(v, f, i, tbl)
            i += len(c)
            cols += c
            if s:
                sets.append(s)
            if n:
                nulls.append(n)
            if p:
                posts.append(p)
            if f.kind == "cityObjectRef" or (f.kind == "property" and f.column.get("joinTable")):
                child_importers[self.join_importer(tbl, f)] = True
                if f.kind == "property" and not f.is_feature_property:
                    child_importers[self.importer_for(f.target.prop_target)] = True
                continue
            if f.is_feature_property:
                continue
            if f.kind == "property":
                target = f.target.prop_target
                child = self.table_of(target).root if f.column["join"][3] == "child" else None
                imp = child.importer if child else self.importer_for(target)
                child_importers[imp] = True
            if f.kind == "inline":
                child_importers[self.importer_for(f.target)] = True
            if f.kind in ("geometry", "complex", "point", "multiCurve", "multiPoint"):
                needs.add("geometry")
            if (
                f.multi
                and f.kind
                in ("code", "string", "date", "integer", "double", "year", "yearMonth", "enum", "measure", "length")
                or f.kind in ("doubleList", "directPosition")
            ):
                needs.add("joiner")
            if f.multi and f.kind == "code":
                imports.add("org.citygml4j.model.gml.basicTypes.Code")
            if f.multi and f.kind == "measure":
                imports.add("org.citygml4j.model.gml.basicTypes.Measure")
            if f.multi and f.kind == "length":
                imports.add("org.citygml4j.model.gml.measures.Length")
            if f.kind in ("year",):
                imports.add("java.time.LocalDate")
        return cols, sets, nulls, posts, i

    def gen_feature_importer(self, tbl):
        """Importer of one feature table: inserts the row of a city object that the Importer/Exporter has created (urf style)."""
        self.current_importer = tbl.importer
        concrete = tbl.concrete
        var = uncap(concrete.model)
        columns, body, post, i = ["id"], "        ps.setLong(1, objectId);\n", "", 2
        imports = {
            f"{PKG}.importer.ImportManager",
            f"{PKG}.schema.ADETable",
            f"{PKG}.schema.SchemaMapper",
            "org.citydb.core.ade.importer.CityGMLImportHelper",
            "org.citydb.core.ade.importer.ForeignKeys",
            "org.citydb.core.database.schema.mapping.AbstractObjectType",
            "org.citydb.core.operation.importer.CityGMLImportException",
            f"{concrete.module.model_pkg}.{concrete.model}",
        }
        fields, inits = [], []
        self.extra_imports = set()
        if tbl.has_objectclass:
            columns.append("objectclass_id")
            body += f"        ps.setInt({i}, objectType.getObjectClassId());\n"
            i += 1
        for c in tbl.parent_columns:
            columns.append(c)
            body += f'        if (foreignKeys.contains("{c}"))\n            ps.setLong({i}, foreignKeys.get("{c}"));\n        else\n            ps.setNull({i}, Types.NULL);\n'
            i += 1
        body += "\n"
        child_importers = OrderedDict()
        if tbl.parent is not None:
            child_importers[tbl.parent.importer] = True
        needs = set()
        ctx = (child_importers, needs, imports)
        cols, sets, nulls, posts, i = self._import_fields(tbl.primary, var, i, tbl, ctx)
        columns += cols
        body += "\n".join(sets)
        post += "".join(posts)
        for m in tbl.merged:
            if not m.fields:
                continue
            mvar = uncap(m.model)
            cols, sets, nulls, posts, i = self._import_fields(m, mvar, i, tbl, ctx)
            columns += cols
            imports.add(f"{m.module.model_pkg}.{m.model}")
            if m is concrete:
                body += ("\n" if sets else "") + "\n".join(sets)
                post += "".join(posts)
            else:
                body += (
                    f"\n        if ({var} instanceof {m.model}) {{\n            {m.model} {mvar} = ({m.model}) {var};\n"
                    + indent("\n".join(sets), 4)
                    + "        } else {\n"
                    + indent("".join(nulls), 4)
                    + "        }\n"
                )
                if posts:
                    post += f"        if ({var} instanceof {m.model}) {{\n" + indent("".join(posts), 4) + "        }\n"
        body = body.rstrip("\n") + "\n"
        for imp in child_importers:
            fields.append(f"    private final {imp} {uncap(imp)};\n")
            inits.append(f"        {uncap(imp)} = manager.getImporter({imp}.class);\n")
        if "joiner" in needs:
            fields.append("    private final AttributeValueJoiner valueJoiner;\n")
            inits.append("        valueJoiner = helper.getAttributeValueJoiner();\n")
            imports.add("org.citydb.core.operation.importer.util.AttributeValueJoiner")
        if "geometry" in needs:
            fields.append("    private final GeometryConverter geometryConverter;\n")
            inits.append("        geometryConverter = helper.getGeometryConverter();\n")
            imports |= {GEOM_IMPORTS[k] for k in ("GeometryObject", "GeometryConverter", "AbstractGeometry")}
        base_call = (
            f"        {uncap(tbl.parent.importer)}.doImport({var}, objectId, objectType, foreignKeys);\n\n"
            if tbl.parent is not None
            else ""
        )
        sql_cols = '" +\n                "'.join(wrap(columns))
        inits_block = ("\n" + "".join(inits)) if inits else ""
        conn_field = "    private final Connection connection;\n" if "geometry" in needs else ""
        conn_init = "        this.connection = connection;\n" if "geometry" in needs else ""
        imports.add("java.sql.*")
        imports |= self.extra_imports
        if "LocalDate" in body:
            imports.add("java.time.LocalDate")
        text = f"""{self.header}

package {PKG}.importer.{tbl.module.prefix};

{render_imports(imports)}

public class {tbl.importer} implements {tbl.module.importer_interface} {{
{conn_field}    private final CityGMLImportHelper helper;
    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;
{"".join(fields)}
    private int batchCounter;

    public {tbl.importer}(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {{
{conn_init}        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();

        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.{tbl.enum})) + " " +
                "({sql_cols}) " +
                "values ({", ".join("?" * len(columns))})");
{inits_block}    }}

    public void doImport({concrete.model} {var}, long objectId, AbstractObjectType<?> objectType, ForeignKeys foreignKeys) throws CityGMLImportException, SQLException {{
{base_call}{body}
        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(objectType);

{post}    }}

    @Override
    public void executeBatch() throws CityGMLImportException, SQLException {{
        if (batchCounter > 0) {{
            ps.executeBatch();
            batchCounter = 0;
        }}
    }}

    @Override
    public void close() throws CityGMLImportException, SQLException {{
        ps.close();
    }}
}}
"""
        text = text.replace("\n\n    }\n\n    @Override", "\n    }\n\n    @Override")
        self.out(os.path.join(self.src, "importer", tbl.module.prefix, tbl.importer + ".java"), text)
        return columns

    def gen_importer(self, tbl):
        self.current_importer = tbl.importer
        dispatch = self.dispatch_style(tbl)
        concrete = tbl.concrete
        var = uncap(concrete.model)
        parent_style = self.parent_arg_style(tbl)
        root = tbl.parent is None
        columns, body, nulls_unused, post, i = ["id"], "", "", "", 2
        imports = {
            f"{PKG}.importer.ImportManager",
            f"{PKG}.schema.ADETable",
            f"{PKG}.schema.SchemaMapper",
            "org.citydb.core.ade.importer.CityGMLImportHelper",
            "org.citydb.core.operation.importer.CityGMLImportException",
            f"{concrete.module.model_pkg}.{concrete.model}",
        }
        fields, inits = [], []
        self.extra_imports = set()
        body += "        ps.setLong(1, objectId);\n"
        if tbl.has_objectclass:
            columns.append("objectclass_id")
            body += f"        ps.setLong({i}, objectMapper.getTypeClassId({var}.getClass()));\n"
            i += 1
            imports.add(f"{PKG}.schema.ObjectMapper")
        for c in tbl.parent_columns:
            columns.append(c)
            if parent_style == "single":
                body += f"        ps.setLong({i}, parentId);\n"
            else:
                body += f'        if ("{c}".equals(parentColumn))\n            ps.setLong({i}, parentId);\n        else\n            ps.setNull({i}, Types.NULL);\n'
            i += 1
        body += "\n"
        child_importers = OrderedDict()
        needs = set()
        ctx = (child_importers, needs, imports)

        cols, sets, nulls, posts, i = self._import_fields(tbl.primary, var, i, tbl, ctx)
        columns += cols
        body += "\n".join(sets)
        post += "".join(posts)
        for m in tbl.merged:
            if not m.fields:
                continue
            mvar = uncap(m.model)
            cols, sets, nulls, posts, i = self._import_fields(m, mvar, i, tbl, ctx)
            columns += cols
            imports.add(f"{m.module.model_pkg}.{m.model}")
            if m is concrete:
                body += ("\n" if sets else "") + "\n".join(sets)
                post += "".join(posts)
            else:
                body += (
                    f"\n        if ({var} instanceof {m.model}) {{\n            {m.model} {mvar} = ({m.model}) {var};\n"
                    + indent("\n".join(sets), 4)
                    + "        } else {\n"
                    + indent("".join(nulls), 4)
                    + "        }\n"
                )
                if posts:
                    post += f"        if ({var} instanceof {m.model}) {{\n" + indent("".join(posts), 4) + "        }\n"
        body = body.rstrip("\n") + "\n"
        # sub tables
        for s in tbl.sub_tables:
            if dispatch:
                args = "objectId"
                if parent_style and s.hierarchy_parent_columns:
                    args += ", parentId" + (", parentColumn" if parent_style == "multi" else "")
                post += f"        if ({var} instanceof {s.primary.model})\n            {self.ref_imp(s.importer)}.doImport(({s.primary.model}) {var}, {args});\n\n"
                child_importers[s.importer] = True
                imports.add(f"{s.primary.module.model_pkg}.{s.primary.model}")
        if not dispatch and not root:
            child_importers = OrderedDict([(tbl.root.importer, True)] + list(child_importers.items()))
        lazy_methods = ""
        for imp in child_importers:
            if (tbl.importer, imp) in self.lazy_imp:
                fields.append(f"    private {imp} {uncap(imp)};\n")
                lazy_methods += self.lazy_accessor(imp, "getImporter", "CityGMLImportException")
            else:
                fields.append(f"    private final {imp} {uncap(imp)};\n")
                inits.append(f"        {uncap(imp)} = manager.getImporter({imp}.class);\n")
        if lazy_methods:
            fields.insert(0, "    private final ImportManager manager;\n")
        if "joiner" in needs:
            fields.append("    private final AttributeValueJoiner valueJoiner;\n")
            inits.append("        valueJoiner = helper.getAttributeValueJoiner();\n")
            imports.add("org.citydb.core.operation.importer.util.AttributeValueJoiner")
        if "geometry" in needs:
            fields.append("    private final GeometryConverter geometryConverter;\n")
            inits.append("        geometryConverter = helper.getGeometryConverter();\n")
            imports |= {GEOM_IMPORTS[k] for k in ("GeometryObject", "GeometryConverter", "AbstractGeometry")}

        # signature
        params = f"{concrete.model} {var}"
        if root:
            if parent_style == "single":
                params += ", long parentId"
            elif parent_style == "multi":
                params += ", long parentId, String parentColumn"
            if dispatch or tbl.sequence:
                head = (
                    f"    public long doImport({params}) throws CityGMLImportException, SQLException {{\n"
                    f"        long objectId = helper.getNextSequenceValue(schemaMapper.getSequenceName(ADESequence.{tbl.sequence[3:].upper()}));\n"
                )
                imports.add(f"{PKG}.schema.ADESequence")
            else:
                raise ValueError("root table without sequence: " + tbl.name)
            ret = "\n        return objectId;\n"
        elif dispatch:
            params += ", long objectId"
            if parent_style and tbl.hierarchy_parent_columns:
                params += ", long parentId" + (", String parentColumn" if parent_style == "multi" else "")
            head = f"    public void doImport({params}) throws CityGMLImportException, SQLException {{\n"
            ret = ""
        else:
            head = (
                f"    public long doImport({params}) throws CityGMLImportException, SQLException {{\n"
                f"        long objectId = {self.ref_imp(tbl.root.importer)}.doImport({var});\n"
            )
            ret = "\n        return objectId;\n"
        overload = ""
        if root and parent_style and any(t.used_single for t in tbl.all_tables()):
            overload = (
                f"    public long doImport({concrete.model} {var}) throws CityGMLImportException, SQLException {{\n"
                f"        return doImport({var}, 0" + (", null" if parent_style == "multi" else "") + ");\n    }\n\n"
            )

        om_field = "    private final ObjectMapper objectMapper;\n" if tbl.has_objectclass else ""
        om_init = "        this.objectMapper = manager.getObjectMapper();\n" if tbl.has_objectclass else ""
        sql_cols = '" +\n                "'.join(wrap(columns))
        inits_block = ("\n" + "".join(inits)) if inits else ""
        conn_field = "    private final Connection connection;\n" if "geometry" in needs else ""
        conn_init = "        this.connection = connection;\n" if "geometry" in needs else ""
        if lazy_methods:
            conn_init += "        this.manager = manager;\n"
        imports.add("java.sql.*")
        imports |= self.extra_imports
        if "LocalDate" in body:
            imports.add("java.time.LocalDate")
        text = f"""{self.header}

package {PKG}.importer.{tbl.module.prefix};

{render_imports(imports)}

public class {tbl.importer} implements {tbl.module.importer_interface} {{
{conn_field}    private final CityGMLImportHelper helper;
{om_field}    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;
{"".join(fields)}
    private int batchCounter;

    public {tbl.importer}(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {{
{conn_init}        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();
{om_init}
        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.{tbl.enum})) + " " +
                "({sql_cols}) " +
                "values ({", ".join("?" * len(columns))})");
{inits_block}    }}

{overload}{head}{body}
        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(schemaMapper.getTableName(ADETable.{tbl.enum}));

{post}{ret}    }}

{lazy_methods}    @Override
    public void executeBatch() throws CityGMLImportException, SQLException {{
        if (batchCounter > 0) {{
            ps.executeBatch();
            batchCounter = 0;
        }}
    }}

    @Override
    public void close() throws CityGMLImportException, SQLException {{
        ps.close();
    }}
}}
"""
        text = text.replace("\n\n    }\n\n    @Override", "\n    }\n\n    @Override").replace(
            "\n\n    }\n\n    private", "\n    }\n\n    private"
        )
        text = text.replace(
            "        this.schemaMapper = manager.getSchemaMapper();\n\n\n",
            "        this.schemaMapper = manager.getSchemaMapper();\n\n",
        )
        self.out(os.path.join(self.src, "importer", tbl.module.prefix, tbl.importer + ".java"), text)
        return columns

    # -------------------------------------------------------------- exporter
    def _export_fields(self, rt, v, alias, ctx, features_first=False):
        """Export code reading the fields of type rt into variable v (collects child exporters, needs and imports in ctx);
        with features_first the code of the feature properties is left out (the caller has emitted it before)."""
        child_exporters, needs, imports = ctx
        code = ""
        for f in rt.fields:
            c, s = self.export_field(v, f, alias)
            if f.is_feature_property and not f.column.get("joinTable"):
                needs |= {"helper", "manager"}
                imports |= {
                    f"{f.target.prop_target.module.model_pkg}.{f.target.prop_target.model}",
                    f"{f.target.module.model_pkg}.{f.target.model}",
                    "org.citydb.core.database.schema.mapping.AbstractObjectType",
                }
                if not features_first:
                    code += s + "\n"
                continue
            code += s + "\n"
            if f.kind == "cityObjectRef" or (f.is_feature_property and f.column.get("joinTable")):
                imports.add(f"{f.target.module.model_pkg}.{f.target.model}")
            if f.kind == "property" and f.column.get("joinTable") and not f.is_feature_property:
                target = f.target.prop_target
                tt = self.table_of(target)
                child_exporters[tt.root.exporter if self.dispatch_style(tt) else tt.exporter] = True
                imports.add(f"{target.module.model_pkg}.{target.model}")
                imports.add(f"{f.target.module.model_pkg}.{f.target.model}")
                if self.dispatch_style(tt):
                    imports.add(f"{tt.root.primary.module.model_pkg}.{tt.root.primary.model}")
            if f.kind == "property" and not f.column.get("joinTable"):
                target = f.target.prop_target
                child = self.table_of(target).root if f.column["join"][3] == "child" else None
                child_exporters[
                    child.exporter
                    if child
                    else (
                        self.table_of(target).root.exporter
                        if self.dispatch_style(self.table_of(target))
                        else self.table_of(target).exporter
                    )
                ] = True
                imports.add(f"{target.module.model_pkg}.{target.model}")
                imports.add(f"{f.target.module.model_pkg}.{f.target.model}")
                if child:
                    imports.add(f"{child.primary.module.model_pkg}.{child.primary.model}")
                elif self.dispatch_style(self.table_of(target)):
                    imports.add(
                        f"{self.table_of(target).root.primary.module.model_pkg}.{self.table_of(target).root.primary.model}"
                    )
            if f.kind == "inline":
                child_exporters[self.table_of(f.target).exporter] = True
                imports.add(f"{f.target.module.model_pkg}.{f.target.model}")
            if f.kind == "address":
                needs.add("helper")
                imports.update(
                    {
                        "org.citygml4j.model.citygml.core.Address",
                        "org.citygml4j.model.citygml.core.AddressProperty",
                        "org.citydb.core.util.Util",
                    }
                )
            if f.kind in ("geometry", "complex", "point", "multiSurface", "multiCurve", "multiPoint"):
                needs.add("geometry")
                if f.kind == "complex":
                    imports.add("org.citygml4j.model.gml.geometry.complexes.GeometricComplex")
                    imports.add("org.citygml4j.model.gml.geometry.complexes.GeometricComplexProperty")
            if f.multi or f.kind in ("doubleList", "directPosition"):
                needs.add("splitter")
            if f.kind == "directPosition":
                imports |= {"org.citygml4j.model.gml.geometry.primitives.DirectPosition", "java.util.regex.Pattern"}
            if f.kind == "code":
                imports.add("org.citygml4j.model.gml.basicTypes.Code")
            if f.kind == "stringOrRef":
                imports.add("org.citygml4j.model.gml.base.StringOrRef")
            if f.kind == "enum":
                imports.add(f"{f.target.module.model_pkg}.{f.target.model}")
            if f.kind == "measure":
                imports.add("org.citygml4j.model.gml.basicTypes.Measure")
            if f.kind == "length":
                imports.add("org.citygml4j.model.gml.measures.Length")
            if f.kind == "year" or (f.multi and f.kind == "year"):
                imports.add("java.time.Year")
            if f.kind == "yearMonth":
                imports.add("java.time.YearMonth")
            if f.multi and f.kind == "date":
                imports.add("java.time.LocalDate")
        return code

    def join_table_statements(self, fields_with_jt, owner_id="objectId"):
        """(statements, fields, closes, imports) of the prepared statements that read the rows of the join tables of
        the given properties: the gml:ids of referenced city objects, or the ids of the rows of a data type."""
        stmts, fields, closes = "", "", ""
        imports = set()
        need_cityobject = False
        for f in fields_with_jt:
            jt, owner_col, target_col = f.column["joinTable"]
            name = model_field(f) if not isinstance(f, urospec.Hook) else f.element
            var = name + "s" if name != "table" else "joinTable"
            stmts += f"        Table {var} = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.{jt[3:].upper()})));\n"
            if f.kind == "cityObjectRef" or f.is_feature_property:
                need_cityobject = True
                stmts += (
                    f'        Select {name}Select = new Select().addProjection(cityObject.getColumn("gmlid"))\n'
                    f'                .addJoin(JoinFactory.inner(cityObject, "id", ComparisonName.EQUAL_TO, {var}.getColumn("{target_col}")))\n'
                    f'                .addSelection(ComparisonFactory.equalTo({var}.getColumn("{owner_col}"), new PlaceHolder<>()))\n'
                    f'                .addOrderBy(new OrderByToken(cityObject.getColumn("id")));\n'
                )
                imports |= {
                    "org.citydb.sqlbuilder.select.join.JoinFactory",
                    "org.citydb.sqlbuilder.select.operator.comparison.ComparisonName",
                }
            else:
                stmts += (
                    f'        Select {name}Select = new Select().addProjection({var}.getColumn("{target_col}"))\n'
                    f'                .addSelection(ComparisonFactory.equalTo({var}.getColumn("{owner_col}"), new PlaceHolder<>()))\n'
                    f'                .addOrderBy(new OrderByToken({var}.getColumn("{target_col}")));\n'
                )
            stmts += f"        ps{cap(name)} = connection.prepareStatement({name}Select.toString());\n"
            fields += f"    private final PreparedStatement ps{cap(name)};\n"
            closes += f"        ps{cap(name)}.close();\n"
        if need_cityobject:
            stmts = (
                "        Table cityObject = new Table(helper.getTableNameWithSchema(MappingConstants.CITYOBJECT));\n"
                + stmts
            )
            imports.add("org.citydb.core.database.schema.mapping.MappingConstants")
        if stmts:
            imports |= {
                "org.citydb.sqlbuilder.select.OrderByToken",
                "org.citydb.sqlbuilder.expression.PlaceHolder",
                "org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory",
                "org.citydb.sqlbuilder.schema.Table",
                "org.citydb.sqlbuilder.select.Select",
            }
        return stmts, fields, closes, imports

    def gen_feature_exporter(self, tbl):
        """Exporter of one feature table (urf style): addProjection()/doExport(.., prefix, rs) for use by subtype exporters, and
        a statement joining the ancestor tables for the concrete types of the table. Returns False when there is nothing to export."""
        self.current_exporter = tbl.exporter
        primary, concrete = tbl.primary, tbl.concrete
        if tbl.parent is None and not any(rt.fields for rt in tbl.row_types):
            return False
        var = uncap(primary.model)
        imports = {
            f"{PKG}.exporter.ExportManager",
            f"{PKG}.schema.ADETable",
            "org.citydb.core.ade.exporter.CityGMLExportHelper",
            "org.citydb.core.operation.exporter.CityGMLExportException",
            "org.citydb.sqlbuilder.schema.Table",
            "org.citydb.sqlbuilder.select.Select",
            f"{primary.module.model_pkg}.{primary.model}",
        }
        # projection of the table's own columns
        plain, geoms = [], []
        for rt in tbl.row_types:
            for f in rt.fields:
                p = f.column
                if (
                    f.is_feature_property
                    or f.kind == "cityObjectRef"
                    or (f.kind == "property" and (p.get("joinTable") or p["join"][3] == "child"))
                ):
                    continue
                if f.kind in ("geometry", "complex"):
                    plain.append(p["refColumn"])
                    geoms.append(p["inlineColumn"])
                elif f.kind in ("point", "multiCurve", "multiPoint"):
                    geoms.append(p["inlineColumn"])
                elif f.kind == "multiSurface":
                    plain.append(p["refColumn"])
                elif f.kind in ("property", "inline", "address"):
                    plain.append(p["join"][1])
                else:
                    plain.append(p["column"])
                    if p.get("qualifier"):
                        plain.append(p["qualifier"])
        proj = [f'table.getColumn("{c}", prefix + "{c}")' for c in plain] + [
            f'helper.getGeometryColumn(table.getColumn("{c}"), prefix + "{c}")' for c in geoms
        ]
        projection = ("        select.addProjection(" + ",\n                ".join(proj) + ");\n\n") if proj else ""
        # row reader
        child_exporters, needs = OrderedDict(), set()
        ctx = (child_exporters, needs, imports)
        # nested features first: polygons shared by a nested surface and a solid of the parent are then written
        # inline in the surface and referenced from the solid (the structure of the PLATEAU files)
        read = "".join(
            self.export_field(var, f, lambda c: c)[1] + "\n"
            for f in primary.fields
            if f.is_feature_property and not f.column.get("joinTable")
        )
        read += self._export_fields(primary, var, lambda c: c, ctx, features_first=True)
        for m in tbl.merged:
            if not m.fields:
                continue
            mvar = uncap(m.model)
            code = self._export_fields(m, mvar, lambda c: c, ctx)
            read += (
                f"                if ({var} instanceof {m.model}) {{\n                    {m.model} {mvar} = ({m.model}) {var};\n\n"
                + indent(code.rstrip("\n") + "\n", 4)
                + "                }\n\n"
            )
            imports.add(f"{m.module.model_pkg}.{m.model}")
        read = re.sub(r'\brs\.get(\w+)\("(\w+)"\)', r'rs.get\1(prefix + "\2")', read)
        read = indent(read.rstrip("\n") + "\n", -8)
        if geoms:
            needs.add("helper")
        # statements
        ancestors = [self.table_of(a) for a in reversed(primary.ancestors())]  # root first
        fields, inits, stmts = "", "", ""
        for a in ancestors:
            fields += f"    private final {a.exporter} {uncap(a.exporter)};\n"
            inits += f"        {uncap(a.exporter)} = manager.getExporter({a.exporter}.class);\n"
        if tbl.exportable:
            fields += "    private final PreparedStatement ps;\n"
            decls = "        Table table = new Table(helper.getTableNameWithSchema(tableName));\n"
            joins = ""
            for a in ancestors:
                av = uncap(a.concrete.model)
                decls += f"        Table {av} = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.{a.enum})));\n"
                joins += f'\n                .addJoin(JoinFactory.inner({av}, "id", ComparisonName.EQUAL_TO, table.getColumn("id")))'
            if joins:
                imports |= {
                    "org.citydb.sqlbuilder.select.join.JoinFactory",
                    "org.citydb.sqlbuilder.select.operator.comparison.ComparisonName",
                }
            stmts += (
                decls
                + f'        Select select = new Select(){joins}\n                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));\n'
            )
            stmts += '        addProjection(select, table, "");\n'
            for a in ancestors:
                stmts += (
                    f'        {uncap(a.exporter)}.addProjection(select, {uncap(a.concrete.model)}, "{a.prefix}");\n'
                )
            stmts += "        ps = connection.prepareStatement(select.toString());\n"
            imports |= {
                "org.citydb.sqlbuilder.expression.PlaceHolder",
                "org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory",
                "org.citydb.core.database.schema.mapping.AbstractType",
                "org.citydb.core.query.filter.projection.ProjectionFilter",
                f"{concrete.module.model_pkg}.{concrete.model}",
            }
        # nested feature and join table statements
        feature_props = [
            f for rt in tbl.row_types for f in rt.fields if f.is_feature_property and not f.column.get("joinTable")
        ]
        ref_props = [
            f
            for rt in tbl.row_types
            for f in rt.fields
            if f.kind == "cityObjectRef" or (f.kind == "property" and f.column.get("joinTable"))
        ]
        jt_stmts, jt_fields, jt_closes, jt_imports = self.join_table_statements(ref_props)
        if feature_props or ref_props:
            stmts += "\n" if stmts else ""
            if feature_props and "Table cityObject" not in jt_stmts:
                stmts += "        Table cityObject = new Table(helper.getTableNameWithSchema(MappingConstants.CITYOBJECT));\n"
            stmts += jt_stmts
            fields += jt_fields
            imports |= jt_imports
            taken = {"table", "cityObject"} | {uncap(a.concrete.model) for a in ancestors}
            for f in feature_props:
                child = self.feature_tables[f.column["join"][0]]
                cv = uncap(child.primary.model.replace("Abstract", "", 1))
                name = model_field(f)
                if cv in taken:
                    cv = name + "Table"
                stmts += (
                    f"        Table {cv} = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.{child.enum})));\n"
                    f'        Select {name}Select = new Select().addProjection({cv}.getColumn("id"), cityObject.getColumn("objectclass_id"), cityObject.getColumn("gmlid"))\n'
                    f'                .addJoin(JoinFactory.inner(cityObject, "id", ComparisonName.EQUAL_TO, {cv}.getColumn("id")))\n'
                    f'                .addSelection(ComparisonFactory.equalTo({cv}.getColumn("{f.column["join"][2]}"), new PlaceHolder<>()))\n'
                    f'                .addOrderBy(new OrderByToken({cv}.getColumn("id")));\n'
                    f"        ps{cap(name)} = connection.prepareStatement({name}Select.toString());\n"
                )
                fields += f"    private final PreparedStatement ps{cap(name)};\n"
            imports |= {
                "org.citydb.core.database.schema.mapping.MappingConstants",
                "org.citydb.sqlbuilder.select.OrderByToken",
                "org.citydb.sqlbuilder.select.join.JoinFactory",
                "org.citydb.sqlbuilder.select.operator.comparison.ComparisonName",
                "org.citydb.sqlbuilder.expression.PlaceHolder",
                "org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory",
            }
        for exp in child_exporters:
            fields += f"    private final {exp} {uncap(exp)};\n"
            inits += f"        {uncap(exp)} = manager.getExporter({exp}.class);\n"
        if "splitter" in needs:
            fields += "    private final AttributeValueSplitter valueSplitter;\n"
            inits += "        valueSplitter = helper.getAttributeValueSplitter();\n"
            imports |= {
                "org.citydb.core.operation.exporter.util.AttributeValueSplitter",
                "org.citydb.core.operation.exporter.util.SplitValue",
            }
        if "geometry" in needs:
            fields += "    private final SurfaceGeometryExporter surfaceGeometryExporter;\n    private final GMLConverter gmlConverter;\n"
            inits += "        surfaceGeometryExporter = helper.getSurfaceGeometryExporter();\n        gmlConverter = helper.getGMLConverter();\n"
            imports |= {
                GEOM_IMPORTS[k] for k in ("GeometryObject", "GMLConverter", "SurfaceGeometryExporter", "GeometrySetter")
            }
        # the hooks of core:_CityObject (uro 3.2 pointCloud): the Importer/Exporter calls them for its own feature types
        # only, so the top-level features rooted directly in core:_CityObject export them themselves
        hooks = ""
        if tbl.exportable and primary.root().core_base == "core:AbstractCityObjectType":
            for table, (inj, _) in self.injections.items():
                if inj.default_base == "AbstractCityObjectType":
                    hooks += (
                        f"\n        manager.exportGenericApplicationProperties(manager.getSchemaMapper().getTableName(ADETable.{table[3:].upper()}), "
                        f"{uncap(concrete.model)}, objectId, (FeatureType) objectType, projectionFilter);\n"
                    )
                    needs.add("manager")
                    imports.add("org.citydb.core.database.schema.mapping.FeatureType")
        helper_field = "    private final CityGMLExportHelper helper;\n" if needs & {"geometry", "helper"} else ""
        helper_init = "        this.helper = helper;\n" if helper_field else ""
        if "manager" in needs:
            helper_field += "    private final ExportManager manager;\n"
            helper_init += "        this.manager = manager;\n"
        table_name = (
            f"        String tableName = manager.getSchemaMapper().getTableName(ADETable.{tbl.enum});\n"
            if tbl.exportable
            else ""
        )
        methods = ""
        if tbl.exportable:
            cvar = uncap(concrete.model)
            chain = "".join(
                f'                {uncap(a.exporter)}.doExport({cvar}, objectId, "{a.prefix}", rs);\n'
                for a in ancestors
            )
            methods += (
                f"    public void doExport({concrete.model} {cvar}, long objectId, AbstractType<?> objectType, ProjectionFilter projectionFilter) throws CityGMLExportException, SQLException {{\n"
                f"        ps.setLong(1, objectId);\n\n        try (ResultSet rs = ps.executeQuery()) {{\n            if (rs.next()) {{\n"
                f'{chain}                doExport({cvar}, objectId, "", rs);\n            }}\n        }}\n{hooks}    }}\n\n'
            )
        methods += (
            f"    public Select addProjection(Select select, Table table, String prefix) {{\n{projection}        return select;\n    }}\n\n"
            f"    public void doExport({primary.model} {var}, long objectId, String prefix, ResultSet rs) throws CityGMLExportException, SQLException {{\n"
            f"{read}    }}\n"
        )
        closes = jt_closes + "".join(f"        ps{cap(model_field(f))}.close();\n" for f in feature_props)
        if tbl.exportable:
            closes = "        ps.close();\n" + closes
        text = f"""{self.header}

package {PKG}.exporter.{tbl.module.prefix};

{render_imports(imports)}

import java.sql.*;

public class {tbl.exporter} implements {tbl.module.exporter_interface} {{
{helper_field}{fields}
    public {tbl.exporter}(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {{
{helper_init}{table_name}{inits}
{stmts}    }}

{methods}
    @Override
    public void close() throws CityGMLExportException, SQLException {{
{closes}    }}
}}
"""
        text = re.sub(r"\n{3,}", "\n\n", text)
        text = text.replace("    }\n\n    @Override", "    }\n\n    @Override").replace("{\n\n    }\n}", "{\n    }\n}")
        self.out(os.path.join(self.src, "exporter", tbl.module.prefix, tbl.exporter + ".java"), text)
        return True

    def gen_exporter(self, tbl):
        """One exporter per hierarchy root (dispatch style) or per table (otherwise)."""
        self.current_exporter = tbl.exporter
        dispatch = self.dispatch_style(tbl)
        if dispatch and tbl.parent is not None:
            return
        tables = tbl.all_tables() if dispatch else [tbl]
        used_single = any(t.used_single for t in tables)
        used_multi = any(t.used_multi for t in tables)
        concrete = tbl.concrete
        var = uncap(concrete.model)
        imports = {
            f"{PKG}.exporter.ExportManager",
            f"{PKG}.schema.ADETable",
            "org.citydb.core.ade.exporter.CityGMLExportHelper",
            "org.citydb.core.operation.exporter.CityGMLExportException",
            "org.citydb.sqlbuilder.expression.PlaceHolder",
            "org.citydb.sqlbuilder.schema.Table",
            "org.citydb.sqlbuilder.select.Select",
            "org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory",
            f"{concrete.module.model_pkg}.{concrete.model}",
        }
        # column aliases: duplicates across the joined tables get a table prefix
        seen = {}
        for t in tables:
            for rt in t.row_types:
                for f in rt.fields:
                    p = f.column
                    for c in (
                        p.get("column"),
                        p.get("qualifier"),
                        p.get("refColumn"),
                        p.get("inlineColumn"),
                        p["join"][1]
                        if f.kind in ("property", "inline", "address") and p.get("join") and p["join"][3] == "parent"
                        else None,
                    ):
                        if c:
                            seen.setdefault(c, set()).add(t.name)
        if dispatch:
            for t in tables:
                seen.setdefault("id", set()).add(t.name)
        aliases = {}

        def alias_for(t):
            def alias(c):
                if c and len(seen.get(c, ())) > 1 and t is not tbl:
                    a = "%s_%s" % (t.concrete.model.lower(), c)
                    aliases[(t.name, c)] = a
                    return a
                return c

            return alias

        # projections
        table_vars = {tbl.name: "table"}
        for t in tables[1:]:
            table_vars[t.name] = uncap(t.concrete.model)
        proj_lines, geom_lines, read_blocks = [], [], []
        proj_by_table, alias_proj = OrderedDict(), []
        child_exporters, needs = OrderedDict(), set()
        for t in tables:
            tv = table_vars[t.name]
            proj_by_table[tv] = []
            cols = []
            if t is tbl and dispatch:
                cols.append("id")
                if tbl.has_objectclass:
                    cols.append("objectclass_id")
            elif dispatch and not tbl.has_objectclass:
                cols.append("id")
            plain, geoms = [], []
            for rt in t.row_types:
                for f in rt.fields:
                    p = f.column
                    if f.kind in ("geometry", "complex"):
                        geoms += [(p["refColumn"], False), (p["inlineColumn"], True)]
                    elif f.kind == "point":
                        geoms.append((p["inlineColumn"], True))
                    elif f.kind in ("point", "multiCurve", "multiPoint"):
                        geoms.append((p["inlineColumn"], True))
                    elif f.kind == "multiSurface":
                        plain.append(p["refColumn"])
                    elif f.kind == "cityObjectRef" or (
                        f.kind == "property" and (p.get("joinTable") or p["join"][3] == "child")
                    ):
                        continue
                    elif f.kind in ("property", "inline", "address"):
                        plain.append(p["join"][1])
                    else:
                        plain.append(p["column"])
                        if p.get("qualifier"):
                            plain.append(p["qualifier"])
            al = alias_for(t)
            for c in cols + plain:
                a = al(c)
                if a != c:
                    alias_proj.append(f'{tv}.getColumn("{c}", "{a}")')
                else:
                    proj_by_table[tv].append(c)
            for c, is_geom in geoms:
                a = al(c)
                if is_geom:
                    geom_lines.append(
                        f'helper.getGeometryColumn({tv}.getColumn("{c}"), "{a}")'
                        if a != c
                        else f'helper.getGeometryColumn({tv}.getColumn("{c}"))'
                    )
                elif a != c:
                    alias_proj.append(f'{tv}.getColumn("{c}", "{a}")')
                else:
                    proj_by_table[tv].append(c)
        proj_lines = proj_by_table["table"]
        if not proj_lines and not alias_proj and not geom_lines:
            proj_lines = ["id"]  # a table whose content is all in join tables: the statement needs a projection
        ctx = (child_exporters, needs, imports)

        def read_type(rt, v):
            return self._export_fields(rt, v, alias_for(self.table_of(rt)), ctx)

        if dispatch:
            root_var = var
            read = ""
            # instantiate
            if tbl.has_objectclass:
                read += (
                    f'                int objectClassId = rs.getInt("objectclass_id");\n                if (rs.wasNull())\n                    return null;\n\n'
                    f"                {concrete.model} {var} = objectMapper.createType(objectClassId, {concrete.model}.class);\n"
                    f'                if ({var} == null) {{\n                    helper.logOrThrowErrorMessage("Failed to instantiate {self.describe(concrete)} (id: " + objectId + ").");\n'
                    f"                    return null;\n                }}\n\n"
                )
                imports.add(f"{PKG}.schema.ObjectMapper")
            else:
                conds = []
                for t in reversed(tables[1:]):
                    a = aliases.get((t.name, "id"), "id")
                    conds.append(f'rs.getLong("{a}") != 0 ? new {t.primary.model}()')
                read += (
                    f"                {concrete.model} {var} = " + " : ".join(conds) + f" : new {concrete.model}();\n\n"
                )
            for t in tables:
                for rt in t.row_types:
                    if not rt.fields and not any(f.kind == "property" for f in rt.fields):
                        continue
                    code = read_type(rt, uncap(rt.model) if rt is not concrete else var)
                    if not code.strip():
                        continue
                    if rt is concrete:
                        read += code
                    else:
                        v = uncap(rt.model)
                        read += (
                            f"                if ({var} instanceof {rt.model}) {{\n                    {rt.model} {v} = ({rt.model}) {var};\n\n"
                            + indent(code.rstrip("\n") + "\n", 4)
                            + "                }\n\n"
                        )
                        imports.add(f"{rt.module.model_pkg}.{rt.model}")
            read = read.rstrip("\n") + "\n"
        else:
            read = ""
            for rt in tbl.row_types:
                if rt is concrete:
                    read += read_type(rt, var)
                elif rt.fields:
                    v = uncap(rt.model)
                    code = read_type(rt, v)
                    read += (
                        f"                if ({var} instanceof {rt.model}) {{\n                    {rt.model} {v} = ({rt.model}) {var};\n\n"
                        + indent(code.rstrip("\n") + "\n", 4)
                        + "                }\n\n"
                    )
                    imports.add(f"{rt.module.model_pkg}.{rt.model}")
            read = read.rstrip("\n") + "\n"
            # base tables with fields (attribute style) are joined
            for a in [self.table_of(x) for x in tbl.primary.ancestors()]:
                if any(rt.fields for rt in a.row_types):
                    raise NotImplementedError("attribute-style base table with fields: " + a.name)

        # statements
        parent_style = self.parent_arg_style(tbl)
        joins = ""
        for t in tables[1:]:
            tv = table_vars[t.name]
            joins += f'                .addJoin(JoinFactory.left({tv}, "id", ComparisonName.EQUAL_TO, table.getColumn("id")))\n'
        if joins:
            imports |= {
                "org.citydb.sqlbuilder.select.join.JoinFactory",
                "org.citydb.sqlbuilder.select.operator.comparison.ComparisonName",
            }
        table_decls = "        Table table = new Table(helper.getTableNameWithSchema(tableName));\n"
        for t in tables[1:]:
            table_decls += f"        Table {table_vars[t.name]} = new Table(helper.getTableNameWithSchema(manager.getSchemaMapper().getTableName(ADETable.{t.enum})));\n"
        projection = "\n                        ".join(wrap(proj_lines, quote=True))
        extra_proj = ""
        for tv, cols in proj_by_table.items():
            if tv != "table" and cols:
                extra_proj += (
                    f"\n                .addProjection({tv}.getColumns("
                    + "\n                        ".join(wrap(cols, quote=True))
                    + "))"
                )
        extra_proj += "".join(f"\n                .addProjection({a})" for a in alias_proj)
        geom_proj = "".join(f"\n                .addProjection({g})" for g in geom_lines)
        select_base = f"        Select select = new Select().addProjection(table.getColumns({projection})){extra_proj}{geom_proj}\n{joins}"
        stmts, fields, inits = "", "", ""
        methods = ""
        jt_props = [
            f
            for t in tables
            for rt in t.row_types
            for f in rt.fields
            if f.kind == "property" and f.column.get("joinTable")
        ]
        jt_stmts, jt_fields, jt_closes, jt_imports = self.join_table_statements(jt_props)
        stmts += jt_stmts
        fields += jt_fields
        imports |= jt_imports
        use_single = used_single or (not used_multi)
        parent_cols = tbl.hierarchy_parent_columns
        if use_single:
            stmts += (
                select_base
                + '                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));\n        ps = connection.prepareStatement(select.toString());\n'
            )
            fields += "    private final PreparedStatement ps;\n"
        if used_multi:
            imports.add("org.citydb.sqlbuilder.select.OrderByToken")
            if parent_style == "multi":
                fields += "    private final Map<String, PreparedStatement> psByParent = new HashMap<>();\n"
                imports |= {"java.util.HashMap", "java.util.Map"}
                col_table = {}
                for t in tables:
                    for c in t.parent_columns:
                        col_table[c] = table_vars[t.name]
                stmts += "\n" if use_single else ""
                stmts += (
                    "        for (String parentColumn : Arrays.asList("
                    + ", ".join('"%s"' % c for c in parent_cols)
                    + ")) {\n"
                )
                stmts += indent(select_base.replace("Select select", "Select parentSelect"), 4)
                by_table = {}
                for c in parent_cols:
                    by_table.setdefault(col_table[c], []).append(c)
                if len(by_table) == 1:
                    tv = list(by_table)[0]
                    stmts += f"                    .addSelection(ComparisonFactory.equalTo({tv}.getColumn(parentColumn), new PlaceHolder<>()))\n"
                else:
                    stmts = stmts.rstrip("\n") + "\n"
                    parts, items = [], list(by_table.items())
                    for idx, (tv, cols) in enumerate(items):
                        if idx == len(items) - 1:
                            parts.append("%s.getColumn(parentColumn)" % tv)
                        else:
                            test = " || ".join('"%s".equals(parentColumn)' % c for c in cols)
                            parts.append("%s ? %s.getColumn(parentColumn)" % (test, tv))
                    cond = " : ".join(parts)
                    stmts += (
                        f"                    .addSelection(ComparisonFactory.equalTo({cond}, new PlaceHolder<>()))\n"
                    )
                stmts += '                    .addOrderBy(new OrderByToken(table.getColumn("id")));\n            psByParent.put(parentColumn, connection.prepareStatement(parentSelect.toString()));\n        }\n'
                imports.add("java.util.Arrays")
            else:
                c = parent_cols[0]
                tv = next(table_vars[t.name] for t in tables if c in t.parent_columns)
                stmts += "\n" if use_single else ""
                stmts += select_base.replace("Select select", "Select parentSelect") if use_single else select_base
                sel = "parentSelect" if use_single else "select"
                stmts += f'                .addSelection(ComparisonFactory.equalTo({tv}.getColumn("{c}"), new PlaceHolder<>()))\n                .addOrderBy(new OrderByToken(table.getColumn("id")));\n        psByParent = connection.prepareStatement({sel}.toString());\n'
                fields += "    private final PreparedStatement psByParent;\n"
        # methods
        reader_name = "doExport"
        if dispatch:
            reader = (
                f"    private {concrete.model} {reader_name}(long objectId, ResultSet rs) throws CityGMLExportException, SQLException {{\n"
                + indent(read, -8)
                + f"        return {var};\n    }}\n"
            )
            reader = reader.replace("\n" * 3, "\n\n")
            if use_single:
                methods += (
                    f"    public {concrete.model} doExport(long objectId) throws CityGMLExportException, SQLException {{\n        ps.setLong(1, objectId);\n\n"
                    f"        try (ResultSet rs = ps.executeQuery()) {{\n            return rs.next() ? {reader_name}(objectId, rs) : null;\n        }}\n    }}\n\n"
                )
            if used_multi:
                sig = "long parentId, String parentColumn" if parent_style == "multi" else "long parentId"
                psv = "psByParent.get(parentColumn)" if parent_style == "multi" else "psByParent"
                methods += (
                    f"    public List<{concrete.model}> doExport({sig}) throws CityGMLExportException, SQLException {{\n"
                    f"        PreparedStatement ps = {psv};\n        ps.setLong(1, parentId);\n\n        List<{concrete.model}> result = new ArrayList<>();\n"
                    f'        try (ResultSet rs = ps.executeQuery()) {{\n            while (rs.next()) {{\n                {concrete.model} {var} = {reader_name}(rs.getLong("id"), rs);\n'
                    f"                if ({var} != null)\n                    result.add({var});\n            }}\n        }}\n\n        return result;\n    }}\n\n"
                )
                imports |= {"java.util.ArrayList", "java.util.List"}
            methods += reader
        else:
            if use_single and used_multi:
                reader = (
                    f"    private void doExport({concrete.model} {var}, long objectId, ResultSet rs) throws CityGMLExportException, SQLException {{\n"
                    + indent(read, -8)
                    + "    }\n"
                )
                methods += (
                    f"    public void doExport({concrete.model} {var}, long objectId) throws CityGMLExportException, SQLException {{\n        ps.setLong(1, objectId);\n\n"
                    f"        try (ResultSet rs = ps.executeQuery()) {{\n            if (rs.next())\n                doExport({var}, objectId, rs);\n        }}\n    }}\n\n"
                )
            elif use_single:
                methods += (
                    f"    public void doExport({concrete.model} {var}, long objectId) throws CityGMLExportException, SQLException {{\n        ps.setLong(1, objectId);\n\n"
                    f"        try (ResultSet rs = ps.executeQuery()) {{\n            if (rs.next()) {{\n{read}            }}\n        }}\n    }}\n"
                )
                reader = ""
            if used_multi:
                sig = "long parentId, String parentColumn" if parent_style == "multi" else "long parentId"
                psv = "psByParent.get(parentColumn)" if parent_style == "multi" else "psByParent"
                inner = f"                doExport({var}, objectId, rs);\n" if use_single else read
                id_line = '                long objectId = rs.getLong("id");\n' if use_single else ""
                methods += (
                    f"    public List<{concrete.model}> doExport({sig}) throws CityGMLExportException, SQLException {{\n"
                    f"        PreparedStatement ps = {psv};\n        ps.setLong(1, parentId);\n\n        List<{concrete.model}> result = new ArrayList<>();\n"
                    f"        try (ResultSet rs = ps.executeQuery()) {{\n            while (rs.next()) {{\n                {concrete.model} {var} = new {concrete.model}();\n{id_line}{inner}\n                result.add({var});\n            }}\n        }}\n\n        return result;\n    }}\n\n"
                )
                imports |= {"java.util.ArrayList", "java.util.List"}
                if use_single:
                    methods += reader
                if not use_single:
                    proj_lines_needed = True
        if not dispatch and used_multi and not use_single:
            pass
        if dispatch and (used_multi or use_single) and not tbl.has_objectclass:
            pass
        if used_multi and not dispatch and (use_single or "objectId" in read):
            # the row id is needed by the 1:n reader (nested children, or the row reader shared with the 1:1 statement)
            old = "table.getColumns(" + projection + ")"
            new = "table.getColumns(" + "\n                        ".join(wrap(["id"] + proj_lines, quote=True)) + ")"
            stmts = stmts.replace(old, new)
            if not use_single:
                methods = methods.replace(
                    f"                {concrete.model} {var} = new {concrete.model}();\n",
                    f'                {concrete.model} {var} = new {concrete.model}();\n                long objectId = rs.getLong("id");\n',
                )
        lazy_methods = ""
        for exp in child_exporters:
            if (tbl.exporter, exp) in self.lazy_exp:
                fields += f"    private {exp} {uncap(exp)};\n"
                lazy_methods += self.lazy_accessor(exp, "getExporter", "CityGMLExportException")
            else:
                fields += f"    private final {exp} {uncap(exp)};\n"
                inits += f"        {uncap(exp)} = manager.getExporter({exp}.class);\n"
        if lazy_methods:
            fields = "    private final ExportManager manager;\n" + fields
            inits = "        this.manager = manager;\n" + inits
        if "splitter" in needs:
            fields += "    private final AttributeValueSplitter valueSplitter;\n"
            inits += "        valueSplitter = helper.getAttributeValueSplitter();\n"
            imports |= {
                "org.citydb.core.operation.exporter.util.AttributeValueSplitter",
                "org.citydb.core.operation.exporter.util.SplitValue",
            }
        if "geometry" in needs:
            fields += "    private final SurfaceGeometryExporter surfaceGeometryExporter;\n    private final GMLConverter gmlConverter;\n"
            inits += "        surfaceGeometryExporter = helper.getSurfaceGeometryExporter();\n        gmlConverter = helper.getGMLConverter();\n"
            imports |= {
                GEOM_IMPORTS[k] for k in ("GeometryObject", "GMLConverter", "SurfaceGeometryExporter", "GeometrySetter")
            }
        helper_field = (
            "    private final CityGMLExportHelper helper;\n"
            if (dispatch and tbl.has_objectclass) or needs & {"geometry", "helper"}
            else ""
        )
        helper_init = "        this.helper = helper;\n" if helper_field else ""
        om_field = "    private final ObjectMapper objectMapper;\n" if dispatch and tbl.has_objectclass else ""
        om_init = "        this.objectMapper = manager.getObjectMapper();\n" if om_field else ""
        text = f"""{self.header}

package {PKG}.exporter.{tbl.module.prefix};

{render_imports(imports)}

import java.sql.*;

public class {tbl.exporter} implements {tbl.module.exporter_interface} {{
{helper_field}{om_field}{fields}
    public {tbl.exporter}(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {{
{helper_init}{om_init}        String tableName = manager.getSchemaMapper().getTableName(ADETable.{tbl.enum});

{table_decls}{stmts}
{inits}    }}

{methods}
{lazy_methods}    @Override
    public void close() throws CityGMLExportException, SQLException {{
{"        ps.close();" if use_single else ""}
{"        for (PreparedStatement ps : psByParent.values())            ps.close();".replace("            ps.close();", chr(10) + "            ps.close();") if used_multi and parent_style == "multi" else ("        psByParent.close();" if used_multi else "")}{jt_closes}
    }}
}}
"""
        text = re.sub(r"\n{3,}", "\n\n", text)
        text = text.replace("    }\n\n    @Override", "    }\n\n    @Override")
        text = (
            text.replace("{\n\n        ps.close();", "{\n        ps.close();")
            .replace("{\n\n        psByParent", "{\n        psByParent")
            .replace("{\n\n        for (PreparedStatement", "{\n        for (PreparedStatement")
        )
        text = (
            text.replace("        ps.close();\n\n    }", "        ps.close();\n    }")
            .replace("            ps.close();\n\n    }", "            ps.close();\n    }")
            .replace("        psByParent.close();\n\n    }", "        psByParent.close();\n    }")
        )
        self.out(os.path.join(self.src, "exporter", tbl.module.prefix, tbl.exporter + ".java"), text)

    def describe(self, t):
        return re.sub(r"(?<!^)(?=[A-Z])", " ", t.model).lower()

    # ----------------------------------------------------------- hook classes
    def hook_parent(self, inj, hooks):
        """(param class FQN, dispatch classes) for the injection."""
        base = BASE_TARGETS[inj.default_base]
        targets = OrderedDict((h.target, True) for h in hooks)
        tops = OrderedDict()
        for tgt in targets:
            tops[SUBCLASS_OF.get(tgt, tgt)] = True
        if list(tops) == [base]:
            return HOOK_TARGETS[base][0], [HOOK_TARGETS[base][0]]
        return "org.citygml4j.model.citygml.core.AbstractCityObject", [HOOK_TARGETS[t][0] for t in tops]

    def gen_hook_importer(self, inj, hooks):
        name = hook_class(inj.default_base) + "PropertiesImporter"
        mod = hooks[0].module
        self.register_class(name, mod.prefix)
        parent_cls, _ = self.hook_parent(inj, hooks)
        imports = {
            f"{PKG}.importer.ImportManager",
            f"{PKG}.schema.ADETable",
            f"{PKG}.schema.SchemaMapper",
            "org.citydb.core.ade.importer.ADEPropertyCollection",
            "org.citydb.core.ade.importer.CityGMLImportHelper",
            "org.citydb.core.database.schema.mapping.FeatureType",
            "org.citydb.core.operation.importer.CityGMLImportException",
            f"{mod.model_pkg}.*",
            parent_cls,
        }
        columns, body, post, i = ["id"], "        ps.setLong(1, parentId);\n\n", "", 2
        importers = OrderedDict()
        for h in hooks:
            if h.prop_type is None:
                if h.element == "fiscalYearOfPublication":
                    columns.append("fiscalyearofpublication")
                    body += (
                        f"        FiscalYearOfPublicationProperty fiscalYearOfPublication = properties.getFirst(FiscalYearOfPublicationProperty.class);\n"
                        f"        if (fiscalYearOfPublication != null && fiscalYearOfPublication.isSetValue())\n"
                        f"            ps.setDate({i}, Date.valueOf(LocalDate.of(fiscalYearOfPublication.getValue().getValue(), 1, 1)));\n        else\n            ps.setNull({i}, Types.DATE);\n\n"
                    )
                    i += 1
                    imports.add("java.time.LocalDate")
                else:
                    columns += ["language", "language_codespace"]
                    body += (
                        f"        LanguageProperty language = properties.getFirst(LanguageProperty.class);\n        if (language != null && language.isSetValue()) {{\n"
                        f"            ps.setString({i}, language.getValue().getValue());\n            ps.setString({i + 1}, language.getValue().getCodeSpace());\n"
                        f"        }} else {{\n            ps.setNull({i}, Types.VARCHAR);\n            ps.setNull({i + 1}, Types.VARCHAR);\n        }}\n\n"
                    )
                    i += 2
                continue
            target = h.prop_type.prop_target
            tbl = self.table_of(target)
            join = h.mapping.get("join")
            el = h.model_element
            if h.mapping.get("joinTable"):
                imp = self.importer_for(target)
                jt_imp = self.join_importer(hook_class(inj.default_base), HookField(h))
                importers[imp] = True
                importers[jt_imp] = True
                v = h.element if h.element[0].islower() else uncap(h.element)
                post += (
                    f"        if (properties.contains({el}.class)) {{\n            for ({el} property : properties.getAll({el}.class)) {{\n"
                    f"                if (property.isSetValue() && property.getValue().isSetObject()) {{\n"
                    f"                    long {v}Id = {self.ref_imp(imp)}.doImport(property.getValue().getObject());\n"
                    f"                    {uncap(jt_imp)}.doImport({v}Id, parentId);\n                }}\n            }}\n        }}\n\n"
                )
            elif join[3] == "parent" and target.is_feature:
                # a feature (uro 3.2 pointCloud): imported by the Importer/Exporter, referenced by its id or by xlink
                col = join[1]
                v = h.element if h.element[0].islower() else uncap(h.element)
                columns.append(col)
                body += (
                    f"        long {v}Id = 0;\n        if (properties.contains({el}.class)) {{\n            {el} property = properties.getFirst({el}.class);\n"
                    f"            if (property.isSetValue()) {{\n                {target.model} {v} = property.getValue().getObject();\n"
                    f"                if ({v} != null) {{\n                    {v}Id = helper.importObject({v});\n                    property.getValue().unsetObject();\n"
                    f"                }} else {{\n                    String href = property.getValue().getHref();\n                    if (href != null && !href.isEmpty())\n"
                    f'                        helper.propagateObjectXlink(schemaMapper.getTableName(ADETable.{inj.table[3:].upper()}), parentId, href, "{col}");\n'
                    f"                }}\n            }}\n        }}\n\n        if ({v}Id != 0)\n            ps.setLong({i}, {v}Id);\n        else\n            ps.setNull({i}, Types.NULL);\n\n"
                )
                i += 1
            elif join[3] == "parent":
                imp = self.importer_for(target)
                importers[imp] = True
                col = join[1]
                v = uncap(target.model) if target.model != "DataQualityAttribute" or True else "x"
                v = h.element if h.element[0].islower() else uncap(h.element)
                columns.append(col)
                body += (
                    f"        long {v}Id = 0;\n        if (properties.contains({el}.class)) {{\n            {el} property = properties.getFirst({el}.class);\n"
                    f"            if (property.isSetValue() && property.getValue().isSetObject()) {{\n                {v}Id = {self.ref_imp(imp)}.doImport(property.getValue().getObject());\n"
                    f"                property.setValue(null);\n            }}\n        }}\n\n        if ({v}Id != 0)\n            ps.setLong({i}, {v}Id);\n        else\n            ps.setNull({i}, Types.NULL);\n\n"
                )
                i += 1
            else:
                child = self.tables[join[0]].root
                importers[child.importer] = True
                args = "parentId"
                if self.parent_arg_style(child) == "multi":
                    args += ', "%s"' % join[2]
                post += (
                    f"        if (properties.contains({el}.class)) {{\n            for ({el} property : properties.getAll({el}.class)) {{\n"
                    f"                if (property.isSetValue() && property.getValue().isSetObject())\n                    {self.ref_imp(child.importer)}.doImport(property.getValue().getObject(), {args});\n"
                    f"            }}\n        }}\n\n"
                )
        fields = "".join(f"    private final {imp} {uncap(imp)};\n" for imp in importers)
        inits = "".join(f"        {uncap(imp)} = manager.getImporter({imp}.class);\n" for imp in importers)
        sql_cols = '" +\n                "'.join(wrap(columns))
        text = f"""{self.header}

package {PKG}.importer.{mod.prefix};

{render_imports(imports)}

import java.sql.*;

public class {name} implements {mod.importer_interface} {{
    private final CityGMLImportHelper helper;
    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;

{fields}
    private int batchCounter;

    public {name}(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {{
        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();

        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.{inj.table[3:].upper()})) + " " +
                "({sql_cols}) " +
                "values ({", ".join("?" * len(columns))})");

{inits}    }}

    public void doImport(ADEPropertyCollection properties, {ref(parent_cls)} parent, long parentId, FeatureType parentType) throws CityGMLImportException, SQLException {{
{body}        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(schemaMapper.getTableName(ADETable.{inj.table[3:].upper()}));

{post}    }}

    @Override
    public void executeBatch() throws CityGMLImportException, SQLException {{
        if (batchCounter > 0) {{
            ps.executeBatch();
            batchCounter = 0;
        }}
    }}

    @Override
    public void close() throws CityGMLImportException, SQLException {{
        ps.close();
    }}
}}
"""
        text = text.replace("\n\n    }\n\n    @Override", "\n    }\n\n    @Override")
        text = text.replace('                "values (?)");\n\n    }', '                "values (?)");\n    }')
        self.out(os.path.join(self.src, "importer", mod.prefix, name + ".java"), text)
        return name, columns

    def gen_hook_exporter(self, inj, hooks):
        name = hook_class(inj.default_base) + "PropertiesExporter"
        mod = hooks[0].module
        self.register_class(name, mod.prefix)
        parent_cls, _ = self.hook_parent(inj, hooks)
        imports = {
            f"{PKG}.exporter.ExportManager",
            f"{PKG}.schema.ADETable",
            "org.citydb.core.ade.exporter.CityGMLExportHelper",
            "org.citydb.core.database.schema.mapping.FeatureType",
            "org.citydb.core.operation.exporter.CityGMLExportException",
            "org.citydb.core.query.filter.projection.ProjectionFilter",
            "org.citydb.sqlbuilder.expression.PlaceHolder",
            "org.citydb.sqlbuilder.schema.Table",
            "org.citydb.sqlbuilder.select.Select",
            "org.citydb.sqlbuilder.select.operator.comparison.ComparisonFactory",
            f"org.citygml4j.ade.iur.model.module.{mod.module_class}",
            f"{mod.model_pkg}.*",
            parent_cls,
        }
        columns, body = [], ""
        exporters = OrderedDict()
        jt_hooks, feature_hooks = [], []
        base = BASE_TARGETS[inj.default_base]
        for h in hooks:
            if h.prop_type is None:
                if h.element == "fiscalYearOfPublication":
                    columns.append("fiscalyearofpublication")
                    body += (
                        f'                Date fiscalYearOfPublication = rs.getDate("fiscalyearofpublication");\n'
                        f'                if (!rs.wasNull() && projectionFilter.containsProperty("fiscalYearOfPublication", module))\n'
                        f"                    parent.{HOOK_TARGETS[h.target][1]}(new FiscalYearOfPublicationProperty(Year.of(fiscalYearOfPublication.toLocalDate().getYear())));\n\n"
                    )
                    imports.add("java.time.Year")
                else:
                    columns += ["language", "language_codespace"]
                    body += (
                        f'                String language = rs.getString("language");\n                if (!rs.wasNull() && projectionFilter.containsProperty("language", module)) {{\n'
                        f'                    Code code = new Code(language);\n                    code.setCodeSpace(rs.getString("language_codespace"));\n'
                        f"                    parent.{HOOK_TARGETS[h.target][1]}(new LanguageProperty(code));\n                }}\n\n"
                    )
                    imports.add("org.citygml4j.model.gml.basicTypes.Code")
                continue
            target = h.prop_type.prop_target
            tbl = self.table_of(target)
            join = h.mapping.get("join")
            el = h.model_element
            prop = h.prop_type.model
            cls, adder = HOOK_TARGETS[h.target]
            if cls != parent_cls:
                imports.add(cls)
                add = f"(({ref(cls)}) parent).{adder}"
                guard = f"parent instanceof {ref(cls)} && "
            else:
                add = f"parent.{adder}"
                guard = ""
            v = h.element if h.element[0].islower() else uncap(h.element)
            if h.mapping.get("joinTable"):
                jt_hooks.append(HookField(h))
                target_col = h.mapping["joinTable"][2]
                if self.dispatch_style(tbl):
                    exp = tbl.root.exporter
                    exporters[exp] = True
                    root_model = tbl.root.primary.model
                    cast = f"({target.model}) " if root_model != target.model else ""
                    inst = f"instanceof {target.model}" if root_model != target.model else "!= null"
                    load = (
                        f'                            {root_model} {v} = {self.ref_exp(exp)}.doExport({v}Rs.getLong("{target_col}"));\n'
                        f"                            if ({v} {inst}) {{\n"
                        f"                                {el} property = new {el}(new {prop}({cast}{v}));\n                                {add}(property);\n                            }}\n"
                    )
                else:
                    exp = tbl.exporter
                    exporters[exp] = True
                    load = (
                        f"                            {target.model} {v} = new {target.model}();\n"
                        f'                            {self.ref_exp(exp)}.doExport({v}, {v}Rs.getLong("{target_col}"));\n\n'
                        f"                            {el} property = new {el}(new {prop}({v}));\n                            {add}(property);\n"
                    )
                body += (
                    f'                if ({guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                    f"                    ps{cap(h.element)}.setLong(1, parentId);\n                    try (ResultSet {v}Rs = ps{cap(h.element)}.executeQuery()) {{\n"
                    f"                        while ({v}Rs.next()) {{\n{load}                        }}\n                    }}\n                }}\n\n"
                )
            elif join[3] == "parent" and target.is_feature:
                col = join[1]
                columns.append(col)
                feature_hooks.append((v, col))
                body += (
                    f'                long {v}Id = rs.getLong("{col}");\n                if ({v}Id != 0 && {guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                    f'                    int {v}ObjectClassId = rs.getInt("{col}_objectclass_id");\n'
                    f"                    AbstractObjectType<?> {v}Type = helper.getAbstractObjectType({v}ObjectClassId);\n"
                    f"                    {target.model} {v} = helper.createObject({v}Id, {v}ObjectClassId, {target.model}.class);\n"
                    f"                    if ({v} != null) {{\n                        manager.exportObject({v}, {v}Id, {v}Type, helper.getProjectionFilter({v}Type));\n"
                    f"                        {el} property = new {el}(new {prop}({v}));\n                        {add}(property);\n                    }}\n                }}\n\n"
                )
                imports |= {
                    "org.citydb.core.database.schema.mapping.AbstractObjectType",
                    "org.citydb.core.database.schema.mapping.MappingConstants",
                    "org.citydb.sqlbuilder.select.join.JoinFactory",
                    "org.citydb.sqlbuilder.select.operator.comparison.ComparisonName",
                }
            elif join[3] == "parent":
                columns.append(join[1])
                if self.dispatch_style(tbl):
                    exp = tbl.root.exporter
                    exporters[exp] = True
                    root_model = tbl.root.primary.model
                    cast = f"({target.model}) " if root_model != target.model else ""
                    inst = f"instanceof {target.model}" if root_model != target.model else "!= null"
                    body += (
                        f'                long {v}Id = rs.getLong("{join[1]}");\n                if ({v}Id != 0 && {guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                        f"                    {root_model} {v} = {self.ref_exp(exp)}.doExport({v}Id);\n                    if ({v} {inst}) {{\n"
                        f"                        {el} property = new {el}(new {prop}({cast}{v}));\n                        {add}(property);\n                    }}\n                }}\n\n"
                    )
                else:
                    exp = tbl.exporter
                    exporters[exp] = True
                    body += (
                        f'                long {v}Id = rs.getLong("{join[1]}");\n                if ({v}Id != 0 && {guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                        f"                    {target.model} {v} = new {target.model}();\n                    {self.ref_exp(exp)}.doExport({v}, {v}Id);\n\n"
                        f"                    {el} property = new {el}(new {prop}({v}));\n                    {add}(property);\n                }}\n\n"
                    )
            else:
                child = self.tables[join[0]].root
                exp = child.exporter
                exporters[exp] = True
                args = "parentId"
                if self.parent_arg_style(child) == "multi":
                    args += ', "%s"' % join[2]
                root_model = child.primary.model
                if root_model != target.model:
                    body += (
                        f'                if ({guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                        f"                    for ({root_model} {v} : {self.ref_exp(exp)}.doExport({args})) {{\n                        if ({v} instanceof {target.model}) {{\n"
                        f"                            {el} property = new {el}(new {prop}(({target.model}) {v}));\n                            {add}(property);\n                        }}\n                    }}\n                }}\n\n"
                    )
                else:
                    body += (
                        f'                if ({guard}projectionFilter.containsProperty("{h.element}", module)) {{\n'
                        f"                    for ({target.model} {v} : {self.ref_exp(exp)}.doExport({args})) {{\n"
                        f"                        {el} property = new {el}(new {prop}({v}));\n                        {add}(property);\n                    }}\n                }}\n\n"
                    )
        fields = "".join(f"    private final {exp} {uncap(exp)};\n" for exp in exporters)
        inits = "".join(f"        {uncap(exp)} = manager.getExporter({exp}.class);\n" for exp in exporters)
        jt_stmts, jt_fields, jt_closes, jt_imports = self.join_table_statements(jt_hooks)
        fields += jt_fields
        inits = jt_stmts + inits
        imports |= jt_imports
        projection = "\n                        ".join(wrap(columns, quote=True))
        if columns:
            # the object class of a referenced feature (pointCloud) comes from its cityobject row
            feature_tables = "".join(
                f"        Table {v}CityObject = new Table(helper.getTableNameWithSchema(MappingConstants.CITYOBJECT));\n"
                for v, _ in feature_hooks
            )
            feature_joins = "".join(
                f'\n                .addJoin(JoinFactory.left({v}CityObject, "id", ComparisonName.EQUAL_TO, table.getColumn("{c}")))'
                f'\n                .addProjection({v}CityObject.getColumn("objectclass_id", "{c}_objectclass_id"))'
                for v, c in feature_hooks
            )
            select = (
                f"        Table table = new Table(helper.getTableNameWithSchema(tableName));\n{feature_tables}        Select select = new Select().addProjection(table.getColumns({projection})){feature_joins}\n"
                f'                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));\n        ps = connection.prepareStatement(select.toString());\n'
            )
            query = f"        ps.setLong(1, parentId);\n\n        try (ResultSet rs = ps.executeQuery()) {{\n            if (rs.next()) {{\n{body.rstrip()}\n            }}\n        }}\n"
        else:
            # hook table without 1:1 columns: the parent row is enough
            select = (
                '        Table table = new Table(helper.getTableNameWithSchema(tableName));\n        Select select = new Select().addProjection(table.getColumn("id"))\n'
                '                .addSelection(ComparisonFactory.equalTo(table.getColumn("id"), new PlaceHolder<>()));\n        ps = connection.prepareStatement(select.toString());\n'
            )
            query = f"        ps.setLong(1, parentId);\n\n        try (ResultSet rs = ps.executeQuery()) {{\n            if (rs.next()) {{\n{body.rstrip()}\n            }}\n        }}\n"
        text = f"""{self.header}

package {PKG}.exporter.{mod.prefix};

{render_imports(imports)}

import java.sql.*;

public class {name} implements {mod.exporter_interface} {{
{"    private final CityGMLExportHelper helper;" + chr(10) + "    private final ExportManager manager;" + chr(10) if feature_hooks else ""}    private final PreparedStatement ps;
    private final String module;

{fields}
    public {name}(Connection connection, CityGMLExportHelper helper, ExportManager manager) throws CityGMLExportException, SQLException {{
{"        this.helper = helper;" + chr(10) + "        this.manager = manager;" + chr(10) if feature_hooks else ""}        String tableName = manager.getSchemaMapper().getTableName(ADETable.{inj.table[3:].upper()});
        module = {mod.module_class}.{mod.version_const}.getNamespaceURI();

{select}
{inits}    }}

    public void doExport({ref(parent_cls)} parent, long parentId, FeatureType parentType, ProjectionFilter projectionFilter) throws CityGMLExportException, SQLException {{
{query}    }}

    @Override
    public void close() throws CityGMLExportException, SQLException {{
        ps.close();
{jt_closes}    }}
}}
"""
        text = re.sub(r"\n{3,}", "\n\n", text)
        text = text.replace(
            "        ps = connection.prepareStatement(select.toString());\n\n    }",
            "        ps = connection.prepareStatement(select.toString());\n    }",
        )
        self.out(os.path.join(self.src, "exporter", mod.prefix, name + ".java"), text)
        return name, columns

    # -------------------------------------------------------------- registry
    def register_class(self, name, prefix):
        """Record the module package of a generated importer/exporter class (a name may exist in several modules)."""
        self.class_module[name] = prefix
        self.class_modules.setdefault(name, set()).add(prefix)

    def out(self, path, text):
        """Write a generated class; importer/exporter classes of other modules get their imports added (a class of the
        own module or one that exists in several other modules is not imported: the code refers to it qualified)."""
        m = re.search(r"\n(package org\.citydb\.ade\.iur\.(importer|exporter)\.(\w+);)", text)
        if m:
            kind, prefix = m.group(2), m.group(3)
            classes = set(re.findall(r"\b(\w+(?:Importer|Exporter))\b", text))
            add = {
                f"{PKG}.{kind}.{self.class_module[c]}.{c}"
                for c in classes
                if c in self.class_modules
                and prefix not in self.class_modules[c]
                and len(self.class_modules[c]) == 1
                and c.endswith(kind.capitalize())
            }
            if add:
                existing = re.findall(r"^import ([\w.*]+);\n", text, re.M)
                first = re.search(r"^import .*;\n", text, re.M).start()
                last = list(re.finditer(r"^import .*;\n", text, re.M))[-1].end()
                text = text[:first] + render_imports(set(existing) | add) + "\n" + text[last:]
        self.written.add(os.path.normcase(path))
        write(path, text)

    def gen_all(self):
        self.table_columns = {}
        self.written = set()
        importers, exporters = [], []
        join_importers = []
        for tbl in self.tables.values():
            cols = self.gen_importer(tbl)
            self.table_columns[tbl.name] = cols
            importers.append(tbl.importer)
            for rt in tbl.row_types:
                for f in rt.fields:
                    if f.kind == "property" and f.column.get("joinTable"):
                        jt = f.column["joinTable"][0]
                        name = self.gen_join_importer(tbl, f, tbl.module)
                        importers.append(name)
                        join_importers.append((jt, name))
                        self.table_columns[jt] = list(self.spec.ddl_tables[jt])
            if self.dispatch_style(tbl) and tbl.parent is not None:
                continue
            if not self.dispatch_style(tbl) and not any(rt.fields for rt in tbl.row_types):
                continue  # attribute-style base table without columns of its own
            self.gen_exporter(tbl)
            exporters.append(tbl.exporter)
        # feature types: one importer per table, exporters for the tables with something to read (most specific first in dispatch)
        self.feature_importers, self.feature_exporters = [], []
        for tbl in sorted(self.feature_tables.values(), key=lambda x: -x.depth):
            cols = self.gen_feature_importer(tbl)
            self.table_columns[tbl.name] = cols
            importers.append(tbl.importer)
            for rt in tbl.row_types:
                for f in rt.fields:
                    if f.kind == "cityObjectRef" or (f.kind == "property" and f.column.get("joinTable")):
                        jt = f.column["joinTable"][0]
                        name = self.gen_join_importer(tbl, f, tbl.module)
                        importers.append(name)
                        join_importers.append((jt, name))
                        self.table_columns[jt] = list(self.spec.ddl_tables[jt])
            if tbl.exportable:
                self.feature_importers.append((tbl.module, tbl.concrete, tbl.importer))
            if self.gen_feature_exporter(tbl):
                exporters.append(tbl.exporter)
                if tbl.exportable:
                    self.feature_exporters.append((tbl.module, tbl.concrete, tbl.exporter))
        hook_importers, hook_exporters = [], []
        for table, (inj, hooks) in self.injections.items():
            name, cols = self.gen_hook_importer(inj, hooks)
            self.table_columns[table] = cols
            hook_importers.append((table, name))
            for h in hooks:
                if h.mapping is not None and h.mapping.get("joinTable"):
                    jt = h.mapping["joinTable"][0]
                    jname = self.gen_join_importer(hook_class(inj.default_base), HookField(h), h.module)
                    importers.append(jname)
                    join_importers.append((jt, jname))
                    self.table_columns[jt] = list(self.spec.ddl_tables[jt])
            name, _ = self.gen_hook_exporter(inj, hooks)
            hook_exporters.append((table, name))
        for m in self.modules:
            if m.prefix != "uro":
                self.gen_balloon_handler(m)
        for sub in ("importer", "exporter"):
            for m in self.modules:
                d = os.path.join(self.src, sub, m.prefix)
                for fn in os.listdir(d):
                    path = os.path.join(d, fn)
                    if (
                        fn.endswith(".java")
                        and not fn.endswith("Module%s.java" % sub.capitalize())
                        and os.path.normcase(path) not in self.written
                    ):
                        os.remove(path)
                        print("removed stale", sub, fn)
        self.patch_ade_table(importers, hook_importers + join_importers)
        self.patch_ade_sequence()
        self.patch_table_mapper()
        self.patch_object_mapper()
        self.patch_import_manager(importers, hook_importers)
        self.patch_export_manager(exporters, hook_exporters)
        self.patch_schema_files()
        self.patch_module_constants()

    def gen_join_importer(self, owner, f, module):
        """Importer of a join table (city object references, member references, multi-valued data types)."""
        name = self.join_importer(owner, f)
        self.register_class(name, module.prefix)
        jt, owner_col, target_col = f.column["joinTable"]
        enum = jt[3:].upper()
        owner_var = uncap(owner if isinstance(owner, str) else owner.concrete.model)
        text = f"""{self.header}

package {PKG}.importer.{module.prefix};

import {PKG}.importer.ImportManager;
import {PKG}.schema.ADETable;
import {PKG}.schema.SchemaMapper;
import org.citydb.core.ade.importer.CityGMLImportHelper;
import org.citydb.core.operation.importer.CityGMLImportException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class {name} implements {module.importer_interface} {{
    private final CityGMLImportHelper helper;
    private final SchemaMapper schemaMapper;
    private final PreparedStatement ps;

    private int batchCounter;

    public {name}(Connection connection, CityGMLImportHelper helper, ImportManager manager) throws CityGMLImportException, SQLException {{
        this.helper = helper;
        this.schemaMapper = manager.getSchemaMapper();

        ps = connection.prepareStatement("insert into " +
                helper.getTableNameWithSchema(schemaMapper.getTableName(ADETable.{enum})) + " " +
                "({target_col}, {owner_col}) " +
                "values (?, ?)");
    }}

    public void doImport(long {"cityObjectId" if f.kind == "cityObjectRef" else uncap(f.target.prop_target.model) + "Id"}, long {owner_var}Id) throws CityGMLImportException, SQLException {{
        ps.setLong(1, {"cityObjectId" if f.kind == "cityObjectRef" else uncap(f.target.prop_target.model) + "Id"});
        ps.setLong(2, {owner_var}Id);

        ps.addBatch();
        if (++batchCounter == helper.getDatabaseAdapter().getMaxBatchSize())
            helper.executeBatch(schemaMapper.getTableName(ADETable.{enum}));
    }}

    @Override
    public void executeBatch() throws CityGMLImportException, SQLException {{
        if (batchCounter > 0) {{
            ps.executeBatch();
            batchCounter = 0;
        }}
    }}

    @Override
    public void close() throws CityGMLImportException, SQLException {{
        ps.close();
    }}
}}
"""
        self.out(os.path.join(self.src, "importer", module.prefix, name + ".java"), text)
        return name

    def patch_ade_table(self, importers, hook_importers):
        p = os.path.join(self.src, "schema", "ADETable.java")
        s = open(p, encoding="utf-8").read()
        entries = dict(re.findall(r"^    ([A-Z_0-9]+)\((.*)\)[,;]\n", s, re.M))
        new = {}
        by_table = {
            tbl.name: (tbl.importer, tbl.module.prefix)
            for tbl in list(self.tables.values()) + list(self.feature_tables.values())
        }
        by_table.update({t: (n, self.class_module[n]) for t, n in hook_importers})
        ambiguous = {
            n
            for n in self.class_module
            if sum(
                1
                for d in ("uro", "urf", "urg", "urt")
                if os.path.exists(os.path.join(self.src, "importer", d, n + ".java"))
            )
            > 1
        }
        for table in self.spec.ddl_tables:
            k = table[3:].upper()
            if table in by_table:
                n, prefix = by_table[table]
                new[k] = (f"{PKG}.importer.{prefix}.{n}" if n in ambiguous else n) + ".class"
            elif k in entries and entries[k] != "null" and self._importer_exists(entries[k]):
                n = entries[k].replace(".class", "").split(".")[-1]
                new[k] = (f"{PKG}.importer.{self._importer_exists(entries[k])}.{n}" if n in ambiguous else n) + ".class"
            else:
                new[k] = "null"
        names = sorted(new)
        block = "".join("    %s(%s)%s\n" % (n, new[n], "," if i < len(names) - 1 else ";") for i, n in enumerate(names))
        a = s.index("public enum ADETable {\n") + len("public enum ADETable {\n")
        b = s.index("\n    private final Class<? extends ADEImporter> importerClass;")
        write(p, s[:a] + block + s[b:])

    def _importer_exists(self, entry):
        """Whether the importer class of a hand-written ADETable entry still exists (outside the generated modules)."""
        name = entry.replace(".class", "").split(".")[-1]
        for d in ("urf", "urg", "urt", "uro"):
            if d not in self.spec.modules and os.path.exists(os.path.join(self.src, "importer", d, name + ".java")):
                return d
        return None

    def patch_ade_sequence(self):
        p = os.path.join(self.src, "schema", "ADESequence.java")
        s = open(p, encoding="utf-8").read()
        seqs = sorted(q[3:].upper() for q in self.spec.sequences)
        block = "".join("    %s%s\n" % (q, "," if i < len(seqs) - 1 else "") for i, q in enumerate(seqs))
        a = s.index("public enum ADESequence {\n") + len("public enum ADESequence {\n")
        b = s.index("}", a)
        write(p, s[:a] + block + s[b:])

    def patch_table_mapper(self):
        p = os.path.join(self.src, "schema", "ADETableMapper.java")
        s = open(p, encoding="utf-8").read()
        pat = re.compile(
            r"            put\(schemaMapper\.getTableName\(ADETable\.([A-Z_0-9]+)\)\.toUpperCase\(\), new LinkedHashSet<String>\(\) \{\{\n((?:                add\(\"[A-Z_0-9]+\"\);\n)+)            \}\}\);\n"
        )
        blocks = OrderedDict(
            (m.group(1), m.group(0)) for m in pat.finditer(s) if "ur_" + m.group(1).lower() in self.spec.ddl_tables
        )
        uro_tables = set(self.table_columns)
        for table in uro_tables:
            k = table[3:].upper()
            cols = self.spec.ddl_tables[table]
            blocks[k] = (
                "            put(schemaMapper.getTableName(ADETable.%s).toUpperCase(), new LinkedHashSet<String>() {{\n"
                % k
                + "".join('                add("%s");\n' % c.upper() for c in cols)
                + "            }});\n"
            )
        first = pat.search(s).start()
        last = list(pat.finditer(s))[-1].end()
        write(p, s[:first] + "".join(blocks[k] for k in sorted(blocks)) + s[last:])

    def model_ref(self, t):
        """Reference to a model class from the managers (which import every module package): qualified when ambiguous."""
        return f"{t.module.model_pkg}.{t.model}" if t.model in self.ambiguous_models else t.model

    def patch_object_mapper(self):
        p = os.path.join(self.src, "schema", "ObjectMapper.java")
        s = open(p, encoding="utf-8").read()
        # feature types (object class ids)
        a = s.index("        for (AbstractObjectType<?> type : schemaMapping.getAbstractObjectTypes()) {")
        b = s.index("            switch (type.getPath()) {", a) + len("            switch (type.getPath()) {\n")
        c = s.index("            }\n        }\n", b)
        body = s[b:c]
        simple = re.compile(
            r'                case "(\w+)":\n                    objectClassIds\.put\(([\w.]+)\.class, objectClassId\);\n                    break;\n'
        )
        concrete = [t for t in self.features if not t.abstract]
        paths = {t.mapping.path for t in concrete}
        # cases of the generated paths and of the model classes of the generated modules are rewritten
        guarded = re.compile(
            r'                case "(\w+)":\n((?:                    if .*\n                        objectClassIds\.put\(([\w.]+)\.class, objectClassId\);\n|                    else if .*\n                        objectClassIds\.put\(([\w.]+)\.class, objectClassId\);\n)+)                    break;\n'
        )
        others = {}  # path -> [(module class constant, class)] of hand-written cases that share a path with a generated one
        for m in list(guarded.finditer(body))[::-1]:
            if m.group(1) in paths:
                kept = [
                    (mm.group(1), mm.group(2))
                    for mm in re.finditer(
                        r"matchesNamespaceURI\((\w+\.v\d_\d)\.getNamespaceURI\(\)\)\)\n\s*objectClassIds\.put\(([\w.]+)\.class",
                        m.group(2),
                    )
                    if not any(mm.group(1).startswith(x.module_class + ".") for x in self.modules)
                ]
                others[m.group(1)] = kept
                body = body[: m.start()] + body[m.end() :]
        for m in list(simple.finditer(body))[::-1]:
            cls = m.group(2).split(".")[-1]
            if m.group(1) in paths or not self.hand_written_model(cls):
                body = body[: m.start()] + body[m.end() :]
        body = body.rstrip("\n") + "\n"
        for path in sorted(paths):
            mine = [t for t in concrete if t.mapping.path == path]
            branches = [
                (f"{t.module.module_class}.{t.module.version_const}", self.model_ref(t)) for t in mine
            ] + others.get(path, [])
            if len(branches) == 1:
                body += f'                case "{path}":\n                    objectClassIds.put({branches[0][1]}.class, objectClassId);\n                    break;\n'
            else:
                body += f'                case "{path}":\n'
                for i, (const, cls) in enumerate(branches):
                    body += (
                        f"                    {'if' if i == 0 else 'else if'} (type.getSchema().matchesNamespaceURI({const}.getNamespaceURI()))\n"
                        f"                        objectClassIds.put({cls}.class, objectClassId);\n"
                    )
                body += "                    break;\n"
        s = s[:b] + body + s[c:]
        s = self._patch_imports(s, {f"org.citygml4j.ade.iur.model.module.{m.module_class}" for m in self.modules})
        # data types (type class ids)
        a = s.index("        for (ComplexType type : schemaMapping.getComplexTypes()) {")
        b = s.index("            switch (type.getPath()) {", a) + len("            switch (type.getPath()) {\n")
        c = s.index("            }\n        }\n    }", b)
        body = s[b:c]
        cases = re.findall(
            r'                case "(\w+)":\n                    typeClassIds\.put\((\w+)\.class, typeClassId\);\n                    break;\n',
            body,
        )
        gen_paths = {t.mapping.path for t in self.types}
        kept = [
            (path, cls)
            for path, cls in cases
            if path not in gen_paths
            and not any(
                os.path.exists(
                    os.path.join(
                        self.repo,
                        "..",
                        "iur-ade-citygml4j",
                        "src",
                        "main",
                        "java",
                        "org",
                        "citygml4j",
                        "ade",
                        "iur",
                        "model",
                        x.prefix,
                        cls + ".java",
                    )
                )
                for x in self.modules
            )
        ]
        new = kept + [(t.mapping.path, self.model_ref(t)) for t in self.types]
        block = "".join(
            '                case "%s":\n                    typeClassIds.put(%s.class, typeClassId);\n                    break;\n'
            % (path, cls)
            for path, cls in new
        )
        write(p, s[:b] + block + s[c:])

    def hook_dispatch(self, inj, hooks):
        _, classes = self.hook_parent(inj, hooks)
        return " || ".join("parent instanceof %s" % ref(c) for c in classes), classes

    def patch_object_dispatch(self, s, method, entries, call):
        """Rewrite importObject()/exportObject(): one branch per module (hand-written modules keep their branch), each an
        if-else chain by model class (most specific first)."""
        a = s.index(f"    public void {method}(")
        start = s.index("{\n", a) + 2
        end = s.index("\n    }\n", a)
        body = s[start:end]
        pat = re.compile(
            r"(?:        if| else if) \((\w+Module)\.(v\d_\d)\.getModelPackageName\(\)\.equals\(object\.getClass\(\)\.getPackage\(\)\.getName\(\)\)\) \{\n(.*?)\n        \}",
            re.S,
        )
        blocks = OrderedDict((m.group(1), (m.group(2), m.group(3))) for m in pat.finditer(body))
        for mod in self.modules:
            lines = []
            for i, (module, t, cls) in enumerate(e for e in entries if e[0] is mod):
                q = f"{PKG}.{method[:6]}er.{mod.prefix}.{cls}" if cls in self.ambiguous_classes else cls
                lines.append(
                    f"            {'if' if i == 0 else 'else if'} (object instanceof {self.model_ref(t)})\n"
                    f"                {call.format(cls=q, model=self.model_ref(t))}\n"
                )
            if lines:
                blocks[mod.module_class] = (mod.version_const, "".join(lines).rstrip("\n"))
            else:
                blocks.pop(mod.module_class, None)
        out = ""
        for i, (cls, (ver, text)) in enumerate(blocks.items()):
            out += (
                ("        if" if i == 0 else " else if")
                + f" ({cls}.{ver}.getModelPackageName().equals(object.getClass().getPackage().getName())) {{\n{text}\n        }}"
            )
        return s[:start] + out + s[end:]

    def patch_import_manager(self, importers, hook_importers):
        p = os.path.join(self.src, "importer", "ImportManager.java")
        s = open(p, encoding="utf-8").read()
        # ADE feature types
        s = self.patch_object_dispatch(
            s,
            "importObject",
            self.feature_importers,
            "getImporter({cls}.class).doImport(({model}) object, objectId, objectType, foreignKeys);",
        )
        s = self._patch_imports(
            s,
            {f"org.citygml4j.ade.iur.model.module.{m.module_class}" for m, _, _ in self.feature_importers}
            | {
                f"{t.module.model_pkg}.{t.model}"
                for _, t, _ in self.feature_importers
                if t.model not in self.ambiguous_models
            },
        )
        s = self._hand_written_imports(s, "importer")
        # generic application properties
        a = s.index("    public void importGenericApplicationProperties(")
        b = s.index("    @Override\n    public void executeBatch(")
        lines = [
            "    public void importGenericApplicationProperties(ADEPropertyCollection properties, AbstractFeature parent, long parentId, FeatureType parentType) throws CityGMLImportException, SQLException {\n"
        ]
        first = True
        imports = set()
        for table, (inj, hooks) in self.injections.items():
            name = hook_class(inj.default_base) + "PropertiesImporter"
            cond, classes = self.hook_dispatch(inj, hooks)
            param_cls, _ = self.hook_parent(inj, hooks)
            imports |= set(classes) | {param_cls}
            kw = "if"  # independent checks: a Road also carries the TransportationComplex hook table
            first = False
            if BASE_TARGETS[inj.default_base] == "CityObjectGroup":
                urf14 = (
                    ""
                    if "urf" in self.spec.modules
                    else (
                        "            if (properties.containsOneOf(org.citygml4j.ade.iur.model.urf.FiscalYearOfPublicationProperty.class,\n"
                        "                    org.citygml4j.ade.iur.model.urf.LanguageProperty.class)) {\n"
                        "                getImporter(org.citydb.ade.iur.importer.urf.CityObjectGroupPropertiesImporter.class).doImport(properties, (CityObjectGroup) parent, parentId, parentType);\n"
                        "            }\n"
                    )
                )
                lines.append(
                    f"        {kw} (parent instanceof CityObjectGroup) {{\n"
                    + urf14
                    + "            if (properties.containsOneOf(org.citygml4j.ade.iur.model.urg.FiscalYearOfPublicationProperty.class,\n"
                    "                    org.citygml4j.ade.iur.model.urg.LanguageProperty.class)) {\n"
                    "                getImporter(org.citydb.ade.iur.importer.urg.CityObjectGroupPropertiesImporter.class).doImport(properties, (CityObjectGroup) parent, parentId, parentType);\n"
                    "            }\n"
                    "            if (properties.containsOneOf("
                    + ",\n                    ".join(
                        "%s.%s.class"
                        % (h.module.model_pkg, SPECIAL_HOOKS[h.element] if h.prop_type is None else h.model_element)
                        for h in hooks
                    )
                    + ")) {\n"
                    f"                getImporter({PKG}.importer.{hooks[0].module.prefix}.{name}.class).doImport(properties, (CityObjectGroup) parent, parentId, parentType);\n"
                    "            }\n"
                    "            if (properties.contains(DataTypeProperty.class))\n"
                    "                getImporter(org.citydb.ade.iur.importer.urt.CityObjectGroupPropertiesImporter.class).doImport(properties, (CityObjectGroup) parent, parentId, parentType);\n"
                    "        }\n"
                )
            elif inj.default_base == "AbstractCityObjectType":
                classes_of = ", ".join(
                    "%s.%s.class" % (h.module.model_pkg, h.model_element) for h in hooks if h.prop_type is not None
                )
                lines.append(
                    f"        {kw} ({cond} && properties.containsOneOf({classes_of}))\n            getImporter({name}.class).doImport(properties, ({ref(param_cls)}) parent, parentId, parentType);\n"
                )
            else:
                lines.append(
                    f"        {kw} ({cond})\n            getImporter({name}.class).doImport(properties, ({ref(param_cls)}) parent, parentId, parentType);\n"
                )
        lines.append("    }\n\n")
        s = s[:a] + "".join(lines) + s[b:]
        s = self.patch_factories(s, "importer", [n for _, n in hook_importers] + importers)
        s = self._patch_imports(s, imports)
        write(p, s)

    def patch_factories(self, s, kind, names):
        """Rewrite the getImporter()/getExporter() factory section of every generated module."""
        for mod in self.modules:
            marker = "                // %s module\n" % re.sub(r"(?<!^)(?=[A-Z])", " ", mod.java_name).lower()
            a = s.index(marker) + len(marker)
            b = min(x for x in (s.find("\n            } else if (", a), s.find("\n            }\n", a)) if x >= 0) + 1
            fact = ""
            for i, n in enumerate(x for x in dict.fromkeys(names) if mod.prefix in self.class_modules.get(x, ())):
                q = f"{PKG}.{kind}.{mod.prefix}.{n}" if n in self.ambiguous_classes else n
                fact += f"                {'if' if i == 0 else 'else if'} (type == {q}.class)\n                    {kind} = new {q}(connection, helper, this);\n"
            s = s[:a] + fact + s[b:]
        return s

    @property
    def ambiguous_classes(self):
        """Importer/exporter class names that exist in more than one module package."""
        out = set()
        for n in self.class_module:
            if (
                sum(
                    1
                    for d in ("uro", "urf", "urg", "urt")
                    if os.path.exists(
                        os.path.join(self.src, "importer" if n.endswith("Importer") else "exporter", d, n + ".java")
                    )
                )
                > 1
            ):
                out.add(n)
        return out

    def patch_export_manager(self, exporters, hook_exporters):
        p = os.path.join(self.src, "exporter", "ExportManager.java")
        s = open(p, encoding="utf-8").read()
        s = self.patch_object_dispatch(
            s,
            "exportObject",
            self.feature_exporters,
            "getExporter({cls}.class).doExport(({model}) object, objectId, objectType, projectionFilter);",
        )
        s = self._patch_imports(
            s,
            {f"org.citygml4j.ade.iur.model.module.{m.module_class}" for m, _, _ in self.feature_exporters}
            | {
                f"{t.module.model_pkg}.{t.model}"
                for _, t, _ in self.feature_exporters
                if t.model not in self.ambiguous_models
            },
        )
        s = self._hand_written_imports(s, "exporter")
        a = s.index("    public void exportGenericApplicationProperties(")
        b = s.index("    @Override\n    public void close()")
        lines = [
            "    public void exportGenericApplicationProperties(String adeHookTable, AbstractFeature parent, long parentId, FeatureType parentType, ProjectionFilter projectionFilter) throws CityGMLExportException, SQLException {\n"
        ]
        first = True
        imports = set()
        for table, (inj, hooks) in self.injections.items():
            name = hook_class(inj.default_base) + "PropertiesExporter"
            cond, classes = self.hook_dispatch(inj, hooks)
            param_cls, _ = self.hook_parent(inj, hooks)
            imports |= set(classes) | {param_cls}
            kw = "if"
            first = False
            enum = table[3:].upper()
            if BASE_TARGETS[inj.default_base] == "CityObjectGroup":
                lines.append(
                    f"        {kw} (parent instanceof CityObjectGroup) {{\n"
                    "            if (adeHookTable.equals(schemaMapper.getTableName(ADETable.CITYOBJECTGROUP)))\n"
                    "                getExporter(org.citydb.ade.iur.exporter.urg.CityObjectGroupPropertiesExporter.class).doExport((CityObjectGroup) parent, parentId, parentType, projectionFilter);\n"
                    f"            else if (adeHookTable.equals(schemaMapper.getTableName(ADETable.{enum})))\n"
                    f"                getExporter({PKG}.exporter.{hooks[0].module.prefix}.{name}.class).doExport((CityObjectGroup) parent, parentId, parentType, projectionFilter);\n"
                    + (
                        ""
                        if "urf" in self.spec.modules
                        else "            else if (adeHookTable.equals(schemaMapper.getTableName(ADETable.CITYOBJECTGROUP_2)))\n"
                        "                getExporter(org.citydb.ade.iur.exporter.urf.CityObjectGroupPropertiesExporter.class).doExport((CityObjectGroup) parent, parentId, parentType, projectionFilter);\n"
                    )
                    + "            else if (adeHookTable.equals(schemaMapper.getTableName(ADETable.CITYOBJECTGROUP_3)))\n"
                    "                getExporter(org.citydb.ade.iur.exporter.urt.CityObjectGroupPropertiesExporter.class).doExport((CityObjectGroup) parent, parentId, parentType, projectionFilter);\n"
                    "        }\n"
                )
            else:
                c = f"({cond})" if " || " in cond else cond
                lines.append(
                    f"        {kw} (adeHookTable.equals(schemaMapper.getTableName(ADETable.{enum})) && {c})\n"
                    f"            getExporter({name}.class).doExport(({ref(param_cls)}) parent, parentId, parentType, projectionFilter);\n"
                )
        lines.append("    }\n\n")
        s = s[:a] + "".join(lines) + s[b:]
        s = self.patch_factories(s, "exporter", [n for _, n in hook_exporters] + exporters)
        s = self._patch_imports(s, imports)
        write(p, s)

    def hand_written_model(self, cls):
        """The hand-written module (not generated in this run) whose model package holds the class, if any."""
        for d in ("urf", "urg", "urt", "uro"):
            if d not in self.spec.modules and os.path.exists(
                os.path.join(
                    self.cg4j, "src", "main", "java", "org", "citygml4j", "ade", "iur", "model", d, cls + ".java"
                )
            ):
                return d
        return None

    def patch_module_constants(self):
        """Hand-written classes refer to the module constants of the generated versions (urg/urt exporters name the
        urban function module)."""
        for sub in ("importer", "exporter", "schema", "balloon", ""):
            d = os.path.join(self.src, sub)
            for root, dirs, files in os.walk(d):
                for fn in files:
                    path = os.path.join(root, fn)
                    if not fn.endswith(".java") or os.path.normcase(path) in self.written:
                        continue
                    text = open(path, encoding="utf-8").read()
                    new = text
                    for m in self.modules:
                        new = re.sub(r"\b%s\.v\d_\d\b" % m.module_class, f"{m.module_class}.{m.version_const}", new)
                    if new != text:
                        write(path, new)

    def _hand_written_imports(self, s, kind):
        """Explicit imports of the hand-written modules' classes whose simple names a generated module also uses
        (urg LandPrice vs urf 3.x LandPrice): the hand-written branches keep their simple names."""
        found = {}
        for d in ("urf", "urg", "urt", "uro"):
            if d in self.spec.modules:
                continue
            kind_dir = os.path.join(self.src, kind, d)
            for n in self.ambiguous_classes:
                if os.path.exists(os.path.join(kind_dir, n + ".java")):
                    found.setdefault(n, []).append(f"{PKG}.{kind}.{d}.{n}")
            model_dir = os.path.join(self.cg4j, "src", "main", "java", "org", "citygml4j", "ade", "iur", "model", d)
            for n in self.ambiguous_models:
                if os.path.exists(os.path.join(model_dir, n + ".java")):
                    found.setdefault(n, []).append(f"org.citygml4j.ade.iur.model.{d}.{n}")
        add = {v[0] for v in found.values() if len(v) == 1}
        for v in found.values():  # a name of several hand-written modules cannot be imported by its simple name
            if len(v) > 1:
                for c in v:
                    s = s.replace("import %s;\n" % c, "")
        existing = set(re.findall(r"^import ([\w.]+);", s, re.M))
        add = sorted(c for c in add if c not in existing)
        if not add:
            return s
        last = list(re.finditer(r"^import org\.citygml4j\.[\w.]+;\n", s, re.M))[-1]
        return s[: last.end()] + "".join("import %s;\n" % c for c in add) + s[last.end() :]

    def _patch_imports(self, s, classes):
        # imports of classes of the generated modules that no longer exist (renamed in a previous run) are dropped
        for m in re.finditer(
            r"^import (org\.citygml4j\.ade\.iur\.model|org\.citydb\.ade\.iur\.(?:importer|exporter))\.(\w+)\.(\w+);\n",
            s,
            re.M,
        ):
            pkg, prefix, cls = m.groups()
            if prefix not in self.spec.modules:
                continue
            if pkg.startswith("org.citygml4j"):
                path = os.path.join(
                    self.cg4j, "src", "main", "java", "org", "citygml4j", "ade", "iur", "model", prefix, cls + ".java"
                )
            else:
                path = os.path.join(self.src, pkg.split(".")[-1], prefix, cls + ".java")
            if not os.path.exists(path):
                s = s.replace(m.group(0), "")
        existing = set(re.findall(r"^import ([\w.]+);", s, re.M))
        add = sorted(c for c in classes if c not in existing and simple(c) not in self.ambiguous_models)
        if not add:
            return s
        # insert after the last org.citygml4j import
        last = list(re.finditer(r"^import org\.citygml4j\.[\w.]+;\n", s, re.M))[-1]
        return s[: last.end()] + "".join("import %s;\n" % c for c in add) + s[last.end() :]

    def gen_balloon_handler(self, module):
        """Balloon SQL of a feature module: the feature tables by city object id, their direct child tables by parent."""
        feature_tables = [t for t in self.feature_tables.values() if t.module is module]
        cond = "\n                || ".join(
            f"schemaMapper.getTableName(ADETable.{t.enum}).equalsIgnoreCase(table)" for t in feature_tables
        )
        branches = (
            f'        if ({cond}) {{\n            sqlStatement = "SELECT " + aggregateColumnsClause +\n'
            f'                    " FROM " + schemaName + "." + table + " " + tableShortId +\n'
            f'                    " WHERE " + tableShortId + ".id = ?";\n        }}'
        )
        done = set()
        for ft in feature_tables:
            for rt in ft.row_types:
                for f in rt.fields:
                    p = f.column
                    if f.kind not in ("property", "cityObjectRef") or p.get("joinTable") or f.is_feature_property:
                        continue
                    child = self.table_of(f.target.prop_target)
                    if child.name in done:
                        continue
                    done.add(child.name)
                    if p["join"][3] == "parent":
                        branches += (
                            f" else if (schemaMapper.getTableName(ADETable.{child.enum}).equalsIgnoreCase(table)) {{\n"
                            f'            sqlStatement = "SELECT " + aggregateColumnsClause +\n'
                            f'                    " FROM " + schemaName + "." + table + " " + tableShortId + ", " + schemaName + "." + schemaMapper.getTableName(ADETable.{ft.enum}) + " p" +\n'
                            f'                    " WHERE " + tableShortId + ".id = p.{p["join"][1]}" +\n'
                            f'                    " AND p.id = ?";\n        }}'
                        )
                    else:
                        branches += (
                            f" else if (schemaMapper.getTableName(ADETable.{child.enum}).equalsIgnoreCase(table)) {{\n"
                            f'            sqlStatement = "SELECT " + aggregateColumnsClause +\n'
                            f'                    " FROM " + schemaName + "." + table + " " + tableShortId +\n'
                            f'                    " WHERE " + tableShortId + ".{p["join"][2]} = ?";\n        }}'
                        )
        name = module.java_name + "BalloonHandler"
        write(
            os.path.join(self.src, "balloon", name + ".java"),
            BALLOON_TEMPLATE.format(header=self.header, name=name, branches=branches + "\n"),
        )

    def patch_schema_files(self):
        """Multi-valued date fields are stored as joined strings: adjust DDL and mapping column types."""
        changes = []
        for t in self.types:
            for f in t.fields:
                if f.multi and f.kind in ("date", "year", "yearMonth"):
                    changes.append(f.column["column"])
        if not changes:
            return
        for rel, old, new in [
            ("resources/database/3dcitydb/postgreSQL/CREATE_ADE_DB.sql", "TIMESTAMP WITH TIME ZONE", "VARCHAR(1000)"),
            ("resources/database/3dcitydb/postgreSQL/CREATE_ADE_DB.sql", "DATE", "VARCHAR(1000)"),
            ("resources/database/3dcitydb/oracle/CREATE_ADE_DB.sql", "TIMESTAMP", "VARCHAR2(1000)"),
            ("resources/database/3dcitydb/oracle/CREATE_ADE_DB.sql", "DATE", "VARCHAR2(1000)"),
        ]:
            p = os.path.join(self.repo, rel)
            s = open(p, encoding="utf-8").read()
            for c in changes:
                s = re.sub(r"^(    %s) %s,$" % (c, re.escape(old)), r"\1 %s," % new, s, flags=re.M)
            write_raw(p, s)
        p = os.path.join(self.repo, "resources/database/schema-mapping/schema-mapping.xml")
        s = open(p, encoding="utf-8").read()
        for c in changes:
            s = re.sub(r'column="%s" type="(timestamp|date)"' % c, 'column="%s" type="string"' % c, s)
        write_raw(p, s)
        print("schema columns changed to strings:", changes)


# ------------------------------------------------------------------ balloon
BALLOON_TEMPLATE = """{header}

package org.citydb.ade.iur.balloon;

import org.citydb.ade.iur.schema.ADETable;
import org.citydb.ade.iur.schema.SchemaMapper;
import org.citydb.core.ade.visExporter.ADEBalloonHandler;

public class {name} implements ADEBalloonHandler {{
    private final SchemaMapper schemaMapper;

    public {name}(BalloonManager manager) {{
        this.schemaMapper = manager.getSchemaMapper();
    }}

    @Override
    public String getSqlStatement(String table,
                                  String tableShortId,
                                  String aggregateColumnsClause,
                                  int lod,
                                  String schemaName) {{
        String sqlStatement = null;

{branches}
        return sqlStatement;
    }}
}}
"""


def write_raw(path, text):
    with open(path, "w", encoding="utf-8", newline="\n") as fp:
        fp.write(text)


def render_imports(imports):
    java = sorted(i for i in imports if not i.startswith("java"))
    jdk = sorted(i for i in imports if i.startswith("java"))
    out = "\n".join("import %s;" % i for i in java)
    if jdk:
        out += "\n\n" + "\n".join("import %s;" % i for i in jdk)
    return out


def main():
    repo, cg4j, version, preset = sys.argv[1:5]
    prefixes = sys.argv[5].split(",") if len(sys.argv) > 5 else ["uro"]
    spec = urospec.Spec(
        urospec.modules_for(cg4j, prefixes, version),
        os.path.join(repo, "resources", "database", "schema-mapping", "schema-mapping.xml"),
        os.path.join(repo, "resources", "database", "3dcitydb", "postgreSQL", "CREATE_ADE_DB.sql"),
    )
    gen = Generator(spec, repo, select_hooks(spec, preset))
    gen.gen_all()
    print("tables:", len(gen.tables), "injections:", len(gen.injections))


if __name__ == "__main__":
    main()
