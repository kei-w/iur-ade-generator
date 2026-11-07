"""Structural fixes to the ADE Manager output (schema mapping and DDL) for the uro schema. Idempotent.

The ADE Manager drops two kinds of content of the i-UR ifc attributes:
  * a choice type without its own table (IfcCoordinateReferenceSystemSelect) is mapped to an empty table;
    the script adds one FK column per alternative and a complexType entry for it;
  * a complexProperty embedded as an inline <type> loses its geometry (IfcAxis2Placement3D.location);
    the script turns it into a join on a new FK column to the type's own table.
Rule 5 replaces the ADE Manager's mapping of multi-valued data type properties (one foreign key column per owner in the
target table, toRole="child") by join tables: the Importer/Exporter orders its batch commits by table weights
(TableHelper) that accumulate along the join dependencies in int arithmetic, and the shared data types
(DataQualityAttribute, FacilityTypeAttribute, ...) referenced from every feature make the weights overflow, which
scrambles the commit order (foreign key violations on import). Join tables are leaves of that dependency graph and keep
the weights small.

Usage: iur-ade patch-mapping <citydb repo> <citygml4j repo> <uro version> [modules: uro,urf]
"""

from __future__ import annotations

import logging
import os
import re
import sys
from collections.abc import Sequence

from ..errors import GeneratorError
from ..naming import unique
from ..spec import Spec, modules_for
from .ddl import (
    MAP,
    ORA,
    ORA_DROP,
    PG,
    PG_DROP,
    add_column,
    injection_table_ddl,
    join_table_ddl,
    read,
    sync_drop_script,
    write,
)

log = logging.getLogger(__name__)

# mapping defaultBase ids of the CityGML feature types and the hook targets they cover
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
TARGET_BASE = {v: k for k, v in BASE_TARGETS.items()}
TOP_CLASS = {
    "Road": "TransportationComplex",
    "Railway": "TransportationComplex",
    "Track": "TransportationComplex",
    "Square": "TransportationComplex",
    "IntBuildingInstallation": "BuildingInstallation",
}
CONDITION = '<condition column="objectclass_id" value="${target.objectclass_id}" type="integer"/>'
OWNER_TAG = re.compile(r'<(?:featureType|complexType|objectType|propertyInjection) [^>]*table="(\w+)"')


def _owner_table(mapping: str, pos: int) -> str:
    """The table of the type or injection that encloses the position."""
    owners = list(OWNER_TAG.finditer(mapping[:pos]))
    if not owners:
        raise GeneratorError("property outside a type or injection")
    return owners[-1].group(1)


def patch(repo: str, cg4j: str, version: str, prefixes: Sequence[str] = ("uro",)) -> list[str]:
    """Applies the rules to the mapping and DDL in the citydb repository; returns the changes made."""
    spec = Spec(modules_for(cg4j, prefixes, version), os.path.join(repo, MAP), os.path.join(repo, PG))
    schema_ids = {m.schema_id: m for m in spec.modules.values() if m.schema_id is not None}
    mapping = read(os.path.join(repo, MAP))
    pg = read(os.path.join(repo, PG))
    ora = read(os.path.join(repo, ORA))
    max_id = max(int(x) for x in re.findall(r'objectClassId="(\d+)"', mapping))
    changes: list[str] = []

    # 1. complexProperty with an inline <type>: replace by a join to the type's table
    pat = re.compile(
        r'( *)<complexProperty([^>]*?) path="(\w+)" schema="(ur_\d)">\s*<type path="(\w+)" schema="(ur_\d)">.*?</type>'
        r"\s*</complexProperty>\n",
        re.S,
    )
    while True:
        m = pat.search(mapping)
        if not m or m.group(4) not in schema_ids:
            break
        ind, attrs, path, sid, type_path = m.group(1), m.group(2), m.group(3), m.group(4), m.group(5)
        module = schema_ids[sid]
        target = schema_ids[m.group(6)].mapping_types[type_path]
        owner_mt = next(
            mt for mt in module.mapping_types.values() if path in mt.props and mt.props[path].inline is not None
        )
        column = path.lower() + "_id"
        block = (
            f'{ind}<complexProperty refType="{target.id}"{attrs} path="{path}" schema="{sid}">\n'
            f'{ind}    <join table="{target.table}" fromColumn="{column}" toColumn="id" toRole="parent"/>\n'
            f"{ind}</complexProperty>\n"
        )
        mapping = mapping[: m.start()] + block + mapping[m.end() :]
        pg = add_column(pg, owner_mt.table, column, True)
        ora = add_column(ora, owner_mt.table, column, False)
        changes.append("%s.%s -> join %s.%s" % (owner_mt.table, path, target.table, column))

    # 2. choice types without a mapping of their own (the ADE Manager created an empty table for them)
    for t in spec.types.values():
        if t.is_property or not t.choice or t.mapping is not None:
            continue
        refs = [
            (o, f)
            for o in spec.types.values()
            if not o.is_property
            for f in o.fields
            if f.kind == "inline" and f.target is t
        ]
        if not refs:
            continue
        owner_type, field = refs[0]
        prop = owner_type.mapped.props[field.name]
        table = prop.require_join().table
        if ('table="%s"' % table) in mapping and ('path="%s"' % t.model) in mapping:
            continue
        max_id += 1
        sid = t.module.schema_id or ""
        tid = "%s_%s" % (sid, t.name)
        lines = [
            f'        <complexType id="{tid}" table="{table}" objectClassId="{max_id}" path="{t.model}" schema="{sid}">'
        ]
        for f in t.fields:
            target_type = f.nested
            column = f.name.lower() + "_id"
            cond = (
                "\n                    " + CONDITION + "\n                </join>"
                if target_type.subtypes and "objectclass_id" in spec.ddl_tables[target_type.mapped.table]
                else "/>"
            )
            lines.append(
                f'            <complexProperty refType="{target_type.mapped.id}" maxOccurs="1" path="{f.name}" schema="{sid}">'
            )
            lines.append(
                f'                <join table="{target_type.mapped.table}" fromColumn="{column}" toColumn="id" toRole="parent"{cond}'
            )
            lines.append("            </complexProperty>")
            pg = add_column(pg, table, column, True)
            ora = add_column(ora, table, column, False)
        lines.append("        </complexType>")
        # insert before the owner's complexType and point the owner's property at the new type
        anchor = '        <complexType id="%s"' % owner_type.mapped.id
        if anchor not in mapping:
            raise GeneratorError(f"owner type {owner_type.mapped.id} not found in the mapping")
        mapping = mapping.replace(anchor, "\n".join(lines) + "\n" + anchor, 1)
        old = re.search(
            r'<complexProperty refType="[^"]+"( maxOccurs="1")? path="%s" schema="%s">\s*<join table="%s"'
            % (field.name, sid, table),
            mapping,
        )
        if old is None:
            raise GeneratorError(f"property {field.name} not found in the mapping")
        mapping = (
            mapping[: old.start()]
            + re.sub(r'refType="[^"]+"', 'refType="%s"' % tid, old.group(0), count=1)
            + mapping[old.end() :]
        )
        changes.append("%s mapped to %s (objectClassId %d)" % (t.name, table, max_id))

    # 7. hooks of core:_CityObject (uro 3.2 pointCloud) get an injection table of their own, ur_cityobject_2 with base
    #    AbstractCityObjectType: the ADE Manager put them into the vegetation injection ur_cityobject, whose row per
    #    vegetation object cannot be shared with a row per city object
    moved: list[tuple[str, str, list[str]]] = []
    for h in spec.hooks:
        if h.target != "CityObject":
            continue
        pat = re.compile(
            r'( *)<(featureProperty|complexProperty|attribute|complexAttribute)([^>]*) path="%s" schema="(ur_\d)"'
            r"(?:/>|>.*?</\2>)\n" % re.escape(h.element),
            re.S,
        )
        for m in pat.finditer(mapping):
            inj_start = mapping.rfind("<propertyInjection ", 0, m.start())
            inj_tag = mapping[inj_start : mapping.index(">", inj_start)]
            if 'defaultBase="AbstractCityObjectType"' in inj_tag:
                continue
            old_table_m = re.search(r'table="(\w+)"', inj_tag)
            if old_table_m is None:
                raise GeneratorError("injection without table")
            columns = re.findall(r'(?:<attribute column|<join table="\w+" fromColumn)="(\w+)"', m.group(0))
            mapping = mapping.replace(m.group(0), "", 1)
            moved.append((m.group(0), old_table_m.group(1), columns))
            break
    if moved:
        new_table = "ur_cityobject_2"
        inj = (
            '        <propertyInjection table="%s" defaultBase="AbstractCityObjectType">\n'
            '            <join table="%s" fromColumn="ID" toColumn="ID" toRole="child"/>\n'
            % (new_table, new_table)
            + "".join(b for b, _, _ in moved)
            + "        </propertyInjection>\n"
        )
        mapping = mapping.replace("    </propertyInjections>", inj + "    </propertyInjections>", 1)
        pg = injection_table_ddl(pg, True, new_table, moved)
        ora = injection_table_ddl(ora, False, new_table, moved)
        pg_drop, ora_drop = read(os.path.join(repo, PG_DROP)), read(os.path.join(repo, ORA_DROP))
        write(os.path.join(repo, PG_DROP), sync_drop_script(pg_drop, pg))
        write(os.path.join(repo, ORA_DROP), sync_drop_script(ora_drop, ora))
        changes.append(
            "city object hooks %s moved to %s"
            % ([h.element for h in spec.hooks if h.target == "CityObject"], new_table)
        )

    # 3. a property injection whose properties belong to several unrelated feature types (uro 3.0 maps the
    #    vegetation hooks into the AbstractTransportationObject injection): split it by feature type
    hook_target = {h.element: h.target for h in spec.hooks}
    pat = re.compile(
        r'( *)<propertyInjection table="(\w+)" defaultBase="(\w+)">\n(.*?)\n\1</propertyInjection>\n', re.S
    )
    pos = 0
    while True:
        m = pat.search(mapping, pos)
        if not m:
            break
        ind, table, base, body = m.groups()
        base_target = BASE_TARGETS.get(base)
        groups: dict[str | None, list[str]] = {}
        items: list[str] = []
        current: list[str] = []
        closing = None
        for line in body.splitlines(True):
            if current:
                current.append(line)
                if line.rstrip() == closing:
                    items.append("".join(current))
                    current = []
            elif line.startswith(ind + "    <"):
                tag_m = re.match(r"\s*<(\w+)", line)
                tag = tag_m.group(1) if tag_m else ""
                if line.rstrip().endswith("/>"):
                    items.append(line)
                else:
                    current, closing = [line], ind + "    </" + tag + ">"
        items = [item if item.endswith("\n") else item + "\n" for item in items]
        for item in items:
            if item.lstrip().startswith("<join "):
                continue
            path_m = re.search(r'path="(\w+)"', item)
            path = path_m.group(1) if path_m else ""
            hook_tgt = hook_target.get(path)
            top = TOP_CLASS.get(hook_tgt, hook_tgt) if hook_tgt is not None else None
            key = (
                base
                if (top == base_target or hook_tgt is None or path not in hook_target)
                else TARGET_BASE.get(top or "")
            )
            groups.setdefault(key, []).append(item)
        if list(groups) == [base] or None in groups:
            pos = m.end()
            continue
        join_m = re.search(r"(?m)^%s    <join .*$" % ind, body)
        join = join_m.group(0) if join_m else ""
        blocks = ""
        for b, group_items in groups.items():
            blocks += '%s<propertyInjection table="%s" defaultBase="%s">\n%s\n%s%s</propertyInjection>\n' % (
                ind,
                table,
                b,
                join,
                "".join(group_items),
                ind,
            )
        mapping = mapping[: m.start()] + blocks + mapping[m.end() :]
        pos = m.start() + len(blocks)
        changes.append("injection %s split into %s" % (table, ", ".join(str(g) for g in groups)))

    # 5. multi-valued data type properties: join tables instead of foreign key columns in the target table
    taken_tables = set(re.findall(r"^CREATE TABLE (\w+)$", pg, re.M))
    taken_names = set(re.findall(r"CONSTRAINT (\w+)", pg)) | set(re.findall(r"CREATE INDEX (\w+)", pg))
    pat = re.compile(
        r'( *)<complexProperty([^>]*) path="(\w+)" schema="(ur_\d)">\n *<join table="(\w+)" fromColumn="id" '
        r'toColumn="(\w+)" toRole="child"(?:/>|>\s*<condition[^>]*/>\s*</join>)\n *</complexProperty>\n',
        re.S,
    )
    pair_counts: dict[tuple[str, str], int] = {}
    for m in pat.finditer(mapping):
        pair = (_owner_table(mapping, m.start()), m.group(5))
        pair_counts[pair] = pair_counts.get(pair, 0) + 1
    pos = 0
    while True:
        m = pat.search(mapping, pos)
        if not m:
            break
        ind, attrs, path, sid, target_table, column = m.groups()
        owner = _owner_table(mapping, m.start())
        if pair_counts[(owner, target_table)] > 1:
            # several list properties of the same type in one table (also across the split injections of
            # ur_cityobject): the ADE Manager's delete functions declare one variable per referenced table and reject
            # two join tables to it, so these keep their foreign key columns
            pos = m.end()
            continue
        jt = unique("ur_%s_to_%s" % (owner[3:][:9], target_table[3:][:9]), 25, taken_tables)
        owner_col, target_col = (owner[3:] + "_id")[:28], (target_table[3:] + "_id")[:28]
        if owner_col == target_col:
            target_col = target_col[:26] + "_2"
        shared_owner = re.search(r"^CREATE TABLE %s\n\((.*?)\n\);" % owner, pg, re.S | re.M)
        shared_target = re.search(r"^CREATE TABLE %s\n\((.*?)\n\);" % target_table, pg, re.S | re.M)
        cond = "%s            %s\n" % (ind, CONDITION)
        owner_cond = cond if shared_owner and "objectclass_id " in shared_owner.group(1) else ""
        target_cond = cond if shared_target and "objectclass_id " in shared_target.group(1) else ""
        block = (
            f'{ind}<complexProperty{attrs} path="{path}" schema="{sid}">\n'
            f'{ind}    <joinTable table="{jt}">\n'
            f'{ind}        <join table="{owner}" fromColumn="{owner_col}" toColumn="id" toRole="parent"{">" if owner_cond else "/>"}\n'
            + (owner_cond + f"{ind}        </join>\n" if owner_cond else "")
            + f'{ind}        <inverseJoin table="{target_table}" fromColumn="{target_col}" toColumn="id" toRole="parent"{">" if target_cond else "/>"}\n'
            + (target_cond + f"{ind}        </inverseJoin>\n" if target_cond else "")
            + f"{ind}    </joinTable>\n{ind}</complexProperty>\n"
        )
        mapping = mapping[: m.start()] + block + mapping[m.end() :]
        pos = m.start() + len(block)
        pg = join_table_ddl(pg, True, target_table, column, jt, owner, owner_col, target_col, taken_names)
        ora = join_table_ddl(ora, False, target_table, column, jt, owner, owner_col, target_col, taken_names)
        changes.append("%s.%s -> join table %s" % (owner, path, jt))
    if any("join table" in c for c in changes):
        pg_drop, ora_drop = read(os.path.join(repo, PG_DROP)), read(os.path.join(repo, ORA_DROP))
        write(os.path.join(repo, PG_DROP), sync_drop_script(pg_drop, pg))
        write(os.path.join(repo, ORA_DROP), sync_drop_script(ora_drop, ora))

    # 6. subtype rows go with their base rows: the delete functions of the ADE Manager delete base rows reached through
    #    join tables (rule 5) without visiting the subtype tables
    cascade = re.compile(r"(ALTER TABLE ur_\w+ ADD CONSTRAINT \w+ FOREIGN KEY \(id\)\nREFERENCES \w+ \(id\));")
    pg, n = cascade.subn(r"\1\nON DELETE CASCADE;", pg)
    if n:
        changes.append("pg: %d subtype foreign keys cascade" % n)
    ora, n = cascade.subn(r"\1\nON DELETE CASCADE;", ora)
    if n:
        changes.append("ora: %d subtype foreign keys cascade" % n)

    # 4. top-level ADE feature types the ADE Manager left without topLevel="true" (e.g. uro:OtherConstruction,
    #    uro:UndergroundBuilding): the Importer/Exporter exports only top-level feature types
    for t in spec.feature_types():
        if t.top_level and not t.mapped.top_level:
            m = re.search(r'<featureType id="%s" table="\w+" objectClassId="\d+"' % re.escape(t.mapped.id), mapping)
            if m is None:
                raise GeneratorError(f"feature type {t.name} not found in the mapping")
            mapping = mapping[: m.end()] + ' topLevel="true"' + mapping[m.end() :]
            changes.append("%s marked top-level" % t.name)

    write(os.path.join(repo, MAP), mapping)
    write(os.path.join(repo, PG), pg)
    write(os.path.join(repo, ORA), ora)
    return changes


def main(argv: list[str] | None = None) -> None:
    argv = sys.argv[1:] if argv is None else list(argv)
    repo, cg4j, version = argv[0:3]
    prefixes = argv[3].split(",") if len(argv) > 3 else ["uro"]
    changes = patch(repo, cg4j, version, prefixes)
    log.info("mapping patches: %s", changes or "none (already applied)")
