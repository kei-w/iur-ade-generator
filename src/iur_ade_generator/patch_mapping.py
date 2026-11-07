"""Structural fixes to the ADE Manager output (schema mapping and DDL) for the uro schema. Idempotent.

The ADE Manager drops two kinds of content of the i-UR ifc attributes:
  * a choice type without its own table (IfcCoordinateReferenceSystemSelect) is mapped to an empty table;
    the script adds one FK column per alternative and a complexType entry for it;
  * a complexProperty embedded as an inline <type> loses its geometry (IfcAxis2Placement3D.location);
    the script turns it into a join on a new FK column to the type's own table.
Rule 5 replaces the ADE Manager's mapping of multi-valued data type properties (one foreign key column per owner in the
target table, toRole="child") by join tables: the Importer/Exporter orders its batch commits by table weights
(TableHelper) that accumulate along the join dependencies in int arithmetic, and the shared data types (DataQualityAttribute,
FacilityTypeAttribute, ...) referenced from every feature make the weights overflow, which scrambles the commit order
(foreign key violations on import). Join tables are leaves of that dependency graph and keep the weights small.

Usage: patch_mapping.py <citydb repo> <citygml4j repo> <uro version> [modules: uro,urf]
"""
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from . import urospec

PG = "resources/database/3dcitydb/postgreSQL/CREATE_ADE_DB.sql"
PG_DROP = "resources/database/3dcitydb/postgreSQL/DROP_ADE_DB.sql"
ORA = "resources/database/3dcitydb/oracle/CREATE_ADE_DB.sql"
ORA_DROP = "resources/database/3dcitydb/oracle/DROP_ADE_DB.sql"
MAP = "resources/database/schema-mapping/schema-mapping.xml"


def read(p):
    return open(p, encoding="utf-8").read()


def write(p, s):
    with open(p, "w", encoding="utf-8", newline="\n") as fp:
        fp.write(s)


def unique(base, limit, taken):
    name = base[:limit]
    n = 1
    while name in taken:
        n += 1
        suffix = "_%d" % n
        name = base[:limit - len(suffix)] + suffix
    taken.add(name)
    return name


def join_table_ddl(ddl, pg, target, column, jt, owner, owner_col, target_col, taken_names):
    """Move a 1:n foreign key column of the target table into a join table: column, constraint and index removed,
    the join table with its constraints and indexes appended to the sections of the DDL."""
    m = re.search(r"^CREATE TABLE %s\n\((.*?)\n\);" % target, ddl, re.S | re.M)
    assert m, target
    body = re.sub(r"^    %s \w[^\n]*,\n" % column, "", m.group(1), flags=re.M)
    ddl = ddl[:m.start(1)] + body + ddl[m.end(1):]
    ddl = re.sub(r"ALTER TABLE %s ADD CONSTRAINT \w+ FOREIGN KEY \(%s\)\nREFERENCES \w+ \(id\)[^;]*;\n\n" % (target, column), "", ddl)
    ddl = re.sub(r"CREATE INDEX \w+ ON %s\n    USING btree\n    \(\n      %s ASC NULLS LAST\n    \)   WITH \(FILLFACTOR = 90\);\n\n" % (target, column), "", ddl)
    ddl = re.sub(r"CREATE INDEX \w+ ON %s \(%s\);\n\n" % (target, column), "", ddl)
    idt = "BIGINT" if pg else "NUMBER(38)"
    header = "-- -------------------------------------------------------------------- \n-- %s \n-- -------------------------------------------------------------------- \n" % jt
    table = header + "CREATE TABLE %s\n(\n    %s %s NOT NULL,\n    %s %s NOT NULL,\n    PRIMARY KEY (%s, %s)\n);\n\n" % (jt, target_col, idt, owner_col, idt, target_col, owner_col)
    fk1 = unique("%s_%s_fk" % (jt[:12], target_col[:11]), 30, taken_names)
    fk2 = unique("%s_%s_fk" % (jt[:12], owner_col[:11]), 30, taken_names)
    fks = header + ("ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (%s)\nREFERENCES %s (id)\nON DELETE CASCADE;\n\n" % (jt, fk1, target_col, target)
                    + "ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (%s)\nREFERENCES %s (id)\nON DELETE CASCADE;\n\n" % (jt, fk2, owner_col, owner))
    idxs = header
    for col in (target_col, owner_col):
        name = unique("%s_%s_fkx" % (jt[:12], col[:10]), 30, taken_names)
        if pg:
            idxs += "CREATE INDEX %s ON %s\n    USING btree\n    (\n      %s ASC NULLS LAST\n    )   WITH (FILLFACTOR = 90);\n\n" % (name, jt, col)
        else:
            idxs += "CREATE INDEX %s ON %s (%s);\n\n" % (name, jt, col)
    ddl = append_to_section(ddl, "Create tables", table)
    ddl = append_to_section(ddl, "Create foreign keys", fks)
    ddl = append_to_section(ddl, "Create Indexes", idxs)
    return ddl


def injection_table_ddl(ddl, pg, new_table, moved):
    """Create an injection table for the moved hook columns: the columns, their foreign keys and indexes leave the
    previous injection table."""
    header = "-- -------------------------------------------------------------------- \n-- %s \n-- -------------------------------------------------------------------- \n"
    idt = "BIGINT" if pg else "NUMBER(38)"
    col_lines, fks, idxs = [], "", ""
    for _, old_table, columns in moved:
        for col in columns:
            m = re.search(r"^CREATE TABLE %s\n\((.*?)\n\);" % old_table, ddl, re.S | re.M)
            assert m, old_table
            line = re.search(r"^    %s \w[^\n]*,\n" % col, m.group(1), re.M)
            assert line, col
            col_lines.append(line.group(0).rstrip("\n"))
            ddl = ddl[:m.start(1)] + m.group(1).replace(line.group(0), "") + ddl[m.end(1):]
            fk = re.search(r"ALTER TABLE %s ADD CONSTRAINT (\w+) FOREIGN KEY \(%s\)\n(REFERENCES \w+ \(id\)[^;]*;)\n\n" % (old_table, col), ddl)
            if fk:
                ddl = ddl.replace(fk.group(0), "")
                fks += "ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (%s)\n%s\n\n" % (new_table, "%s_%s_fk" % (new_table[:12], col[:11]), col, fk.group(2))
            if pg:
                idx = re.search(r"CREATE INDEX \w+ ON %s\n    USING btree\n    \(\n      %s ASC NULLS LAST\n    \)   WITH \(FILLFACTOR = 90\);\n\n" % (old_table, col), ddl)
                if idx:
                    ddl = ddl.replace(idx.group(0), "")
                    idxs += "CREATE INDEX %s ON %s\n    USING btree\n    (\n      %s ASC NULLS LAST\n    )   WITH (FILLFACTOR = 90);\n\n" % ("%s_%s_fkx" % (new_table[:12], col[:10]), new_table, col)
            else:
                idx = re.search(r"CREATE INDEX \w+ ON %s \(%s\);\n\n" % (old_table, col), ddl)
                if idx:
                    ddl = ddl.replace(idx.group(0), "")
                    idxs += "CREATE INDEX %s ON %s (%s);\n\n" % ("%s_%s_fkx" % (new_table[:12], col[:10]), new_table, col)
    table = header % new_table + "CREATE TABLE %s\n(\n    id %s NOT NULL,\n%s\n    PRIMARY KEY (id)\n);\n\n" % (new_table, idt, "\n".join(col_lines))
    fks = header % new_table + "ALTER TABLE %s ADD CONSTRAINT %s_fk FOREIGN KEY (id)\nREFERENCES cityobject (id)\nON DELETE CASCADE;\n\n" % (new_table, new_table) + fks
    ddl = append_to_section(ddl, "Create tables", table)
    ddl = append_to_section(ddl, "Create foreign keys", fks)
    if idxs:
        ddl = append_to_section(ddl, "Create Indexes", header % new_table + idxs)
    return ddl


def append_to_section(text, title, block):
    m = re.search(r"-- \*+ %s \*+ \n-- \++ \n\n?" % re.escape(title), text)
    assert m, title
    nxt = re.search(r"\n-- \+{10,}", text[m.end():])
    pos = m.end() + nxt.start() + 1 if nxt else len(text)
    return text[:pos] + block + text[pos:]


def sync_drop_script(drop, create):
    """Rebuild the foreign key and table sections of a DROP script from the CREATE script."""
    header = "-- -------------------------------------------------------------------- \n-- %s \n-- -------------------------------------------------------------------- \n"
    fks = {}
    for m in re.finditer(r"ALTER TABLE (\w+) ADD CONSTRAINT (\w+) FOREIGN KEY", create):
        fks.setdefault(m.group(1), []).append(m.group(2))
    fk_text = "".join(header % t + "".join("ALTER TABLE %s\n    DROP CONSTRAINT %s;\n\n" % (t, c) for c in cs) for t, cs in sorted(fks.items()))
    tables = sorted(set(re.findall(r"^CREATE TABLE (\w+)$", create, re.M)))
    table_text = "".join(header % t + "DROP TABLE %s;\n\n" % t for t in tables)
    a = re.search(r"-- \*+ Drop foreign keys \*+ \n-- \++ \n", drop).end()
    b = re.search(r"-- \++ \n-- \*+ Drop tables", drop).start()
    drop = drop[:a] + fk_text + drop[b:]
    a = re.search(r"-- \*+ Drop tables \*+ \n-- \++ \n", drop).end()
    b = re.search(r"-- \++ \n-- \*+ Drop Sequences", drop).start()
    return drop[:a] + table_text + drop[b:]


def add_column(ddl, table, column, pg):
    """Insert a BIGINT column before the primary key of the table (if not there yet)."""
    m = re.search(r"^CREATE TABLE %s\n\((.*?)\n\);" % table, ddl, re.S | re.M)
    assert m, table
    if re.search(r"^\s+%s\s" % column, m.group(1), re.M):
        return ddl
    body = m.group(1)
    ctype = "BIGINT" if pg else "NUMBER"
    new_body = body.replace("    PRIMARY KEY (id)", "    %s %s,\n    PRIMARY KEY (id)" % (column, ctype))
    return ddl[:m.start(1)] + new_body + ddl[m.end(1):]


def main():
    repo, cg4j, version = sys.argv[1:4]
    prefixes = sys.argv[4].split(",") if len(sys.argv) > 4 else ["uro"]
    spec = urospec.Spec(urospec.modules_for(cg4j, prefixes, version), os.path.join(repo, MAP), os.path.join(repo, PG))
    schema_ids = {m.schema_id: m for m in spec.modules.values()}
    mapping = read(os.path.join(repo, MAP))
    pg = read(os.path.join(repo, PG))
    ora = read(os.path.join(repo, ORA))
    max_id = max(int(x) for x in re.findall(r'objectClassId="(\d+)"', mapping))
    changes = []

    # 1. complexProperty with an inline <type>: replace by a join to the type's table
    pat = re.compile(r'( *)<complexProperty([^>]*?) path="(\w+)" schema="(ur_\d)">\s*<type path="(\w+)" schema="(ur_\d)">.*?</type>\s*</complexProperty>\n', re.S)
    while True:
        m = pat.search(mapping)
        if not m or m.group(4) not in schema_ids:
            break
        ind, attrs, path, sid, type_path = m.group(1), m.group(2), m.group(3), m.group(4), m.group(5)
        module = schema_ids[sid]
        target = schema_ids[m.group(6)].mapping_types[type_path]
        owner = [mt for mt in module.mapping_types.values() if path in mt.props and mt.props[path].get("inline") is not None][0]
        column = path.lower() + "_id"
        block = (f'{ind}<complexProperty refType="{target.id}"{attrs} path="{path}" schema="{sid}">\n'
                 f'{ind}    <join table="{target.table}" fromColumn="{column}" toColumn="id" toRole="parent"/>\n'
                 f'{ind}</complexProperty>\n')
        mapping = mapping[:m.start()] + block + mapping[m.end():]
        pg = add_column(pg, owner.table, column, True)
        ora = add_column(ora, owner.table, column, False)
        changes.append("%s.%s -> join %s.%s" % (owner.table, path, target.table, column))

    # 2. choice types without a mapping of their own (the ADE Manager created an empty table for them)
    for t in spec.types.values():
        if t.is_property or not t.choice or t.mapping is not None:
            continue
        refs = [(o, f) for o in spec.types.values() if not o.is_property for f in o.fields if f.kind == "inline" and f.target is t]
        if not refs:
            continue
        owner, field = refs[0]
        prop = owner.mapping.props[field.name]
        table = prop["join"][0]
        if ('table="%s"' % table) in mapping and ('path="%s"' % t.model) in mapping:
            continue
        max_id += 1
        sid = t.module.schema_id
        tid = "%s_%s" % (sid, t.name)
        lines = [f'        <complexType id="{tid}" table="{table}" objectClassId="{max_id}" path="{t.model}" schema="{sid}">']
        for f in t.fields:
            target = f.target.prop_target
            column = f.name.lower() + "_id"
            cond = ('\n                    <condition column="objectclass_id" value="${target.objectclass_id}" type="integer"/>\n                </join>'
                    if target.subtypes and "objectclass_id" in spec.ddl_tables[target.mapping.table] else "/>")
            lines.append(f'            <complexProperty refType="{target.mapping.id}" maxOccurs="1" path="{f.name}" schema="{sid}">')
            lines.append(f'                <join table="{target.mapping.table}" fromColumn="{column}" toColumn="id" toRole="parent"{cond}')
            lines.append('            </complexProperty>')
            pg = add_column(pg, table, column, True)
            ora = add_column(ora, table, column, False)
        lines.append('        </complexType>')
        # insert before the owner's complexType and point the owner's property at the new type
        anchor = '        <complexType id="%s"' % owner.mapping.id
        assert anchor in mapping
        mapping = mapping.replace(anchor, "\n".join(lines) + "\n" + anchor, 1)
        old = re.search(r'<complexProperty refType="[^"]+"( maxOccurs="1")? path="%s" schema="%s">\s*<join table="%s"' % (field.name, sid, table), mapping)
        assert old, field.name
        mapping = mapping[:old.start()] + re.sub(r'refType="[^"]+"', 'refType="%s"' % tid, old.group(0), 1) + mapping[old.end():]
        changes.append("%s mapped to %s (objectClassId %d)" % (t.name, table, max_id))

    # 7. hooks of core:_CityObject (uro 3.2 pointCloud) get an injection table of their own, ur_cityobject_2 with base
    #    AbstractCityObjectType: the ADE Manager put them into the vegetation injection ur_cityobject, whose row per
    #    vegetation object cannot be shared with a row per city object
    moved = []
    for h in spec.hooks:
        if h.target != "CityObject":
            continue
        pat = re.compile(r'( *)<(featureProperty|complexProperty|attribute|complexAttribute)([^>]*) path="%s" schema="(ur_\d)"(?:/>|>.*?</\2>)\n' % re.escape(h.element), re.S)
        for m in pat.finditer(mapping):
            inj_start = mapping.rfind("<propertyInjection ", 0, m.start())
            inj_tag = mapping[inj_start:mapping.index(">", inj_start)]
            if 'defaultBase="AbstractCityObjectType"' in inj_tag:
                continue
            old_table = re.search(r'table="(\w+)"', inj_tag).group(1)
            columns = re.findall(r'(?:<attribute column|<join table="\w+" fromColumn)="(\w+)"', m.group(0))
            mapping = mapping.replace(m.group(0), "", 1)
            moved.append((m.group(0), old_table, columns))
            break
    if moved:
        new_table = "ur_cityobject_2"
        inj = ('        <propertyInjection table="%s" defaultBase="AbstractCityObjectType">\n'
               '            <join table="%s" fromColumn="ID" toColumn="ID" toRole="child"/>\n' % (new_table, new_table)
               + "".join(b for b, _, _ in moved) + '        </propertyInjection>\n')
        mapping = mapping.replace("    </propertyInjections>", inj + "    </propertyInjections>", 1)
        pg = injection_table_ddl(pg, True, new_table, moved)
        ora = injection_table_ddl(ora, False, new_table, moved)
        pg_drop, ora_drop = read(os.path.join(repo, PG_DROP)), read(os.path.join(repo, ORA_DROP))
        write(os.path.join(repo, PG_DROP), sync_drop_script(pg_drop, pg))
        write(os.path.join(repo, ORA_DROP), sync_drop_script(ora_drop, ora))
        changes.append("city object hooks %s moved to %s" % ([h.element for h in spec.hooks if h.target == "CityObject"], new_table))

    # 3. a property injection whose properties belong to several unrelated feature types (uro 3.0 maps the
    #    vegetation hooks into the AbstractTransportationObject injection): split it by feature type
    hook_target = {h.element: h.target for h in spec.hooks}
    pat = re.compile(r'( *)<propertyInjection table="(\w+)" defaultBase="(\w+)">\n(.*?)\n\1</propertyInjection>\n', re.S)
    pos = 0
    while True:
        m = pat.search(mapping, pos)
        if not m:
            break
        ind, table, base, body = m.groups()
        base_target = BASE_TARGETS.get(base)
        groups = {}
        items, current, closing = [], [], None
        for line in body.splitlines(True):
            if current:
                current.append(line)
                if line.rstrip() == closing:
                    items.append("".join(current))
                    current = []
            elif line.startswith(ind + "    <"):
                tag = re.match(r"\s*<(\w+)", line).group(1)
                if line.rstrip().endswith("/>"):
                    items.append(line)
                else:
                    current, closing = [line], ind + "    </" + tag + ">"
        items = [item if item.endswith("\n") else item + "\n" for item in items]
        for item in items:
            if item.lstrip().startswith("<join "):
                continue
            path = re.search(r'path="(\w+)"', item).group(1)
            target = hook_target.get(path)
            top = TOP_CLASS.get(target, target)
            key = base if (top == base_target or target is None or path not in hook_target) else TARGET_BASE.get(top)
            groups.setdefault(key, []).append(item)
        if list(groups) == [base] or None in groups:
            pos = m.end()
            continue
        join = re.search(r"(?m)^%s    <join .*$" % ind, body).group(0)
        blocks = ""
        for b, items in groups.items():
            blocks += '%s<propertyInjection table="%s" defaultBase="%s">\n%s\n%s%s</propertyInjection>\n' % (ind, table, b, join, "".join(items), ind)
        mapping = mapping[:m.start()] + blocks + mapping[m.end():]
        pos = m.start() + len(blocks)
        changes.append("injection %s split into %s" % (table, ", ".join(groups)))

    # 5. multi-valued data type properties: join tables instead of foreign key columns in the target table
    taken_tables = set(re.findall(r"^CREATE TABLE (\w+)$", pg, re.M))
    taken_names = set(re.findall(r"CONSTRAINT (\w+)", pg)) | set(re.findall(r"CREATE INDEX (\w+)", pg))
    pat = re.compile(r'( *)<complexProperty([^>]*) path="(\w+)" schema="(ur_\d)">\n *<join table="(\w+)" fromColumn="id" toColumn="(\w+)" toRole="child"(?:/>|>\s*<condition[^>]*/>\s*</join>)\n *</complexProperty>\n', re.S)
    pair_counts = {}
    for m in pat.finditer(mapping):
        owner = [x for x in re.finditer(r'<(?:featureType|complexType|objectType|propertyInjection) [^>]*table="(\w+)"', mapping[:m.start()])][-1].group(1)
        pair_counts[(owner, m.group(5))] = pair_counts.get((owner, m.group(5)), 0) + 1
    pos = 0
    while True:
        m = pat.search(mapping, pos)
        if not m:
            break
        ind, attrs, path, sid, target, column = m.groups()
        owner_m = [x for x in re.finditer(r'<(?:featureType|complexType|objectType|propertyInjection) [^>]*table="(\w+)"', mapping[:m.start()])][-1]
        owner = owner_m.group(1)
        if pair_counts[(owner, target)] > 1:
            # several list properties of the same type in one table (also across the split injections of
            # ur_cityobject): the ADE Manager's delete functions declare one variable per referenced table and reject
            # two join tables to it, so these keep their foreign key columns
            pos = m.end()
            continue
        jt = unique("ur_%s_to_%s" % (owner[3:][:9], target[3:][:9]), 25, taken_tables)
        owner_col, target_col = (owner[3:] + "_id")[:28], (target[3:] + "_id")[:28]
        if owner_col == target_col:
            target_col = target_col[:26] + "_2"
        shared_owner = re.search(r"^CREATE TABLE %s\n\((.*?)\n\);" % owner, pg, re.S | re.M)
        shared_target = re.search(r"^CREATE TABLE %s\n\((.*?)\n\);" % target, pg, re.S | re.M)
        cond = '%s            <condition column="objectclass_id" value="${target.objectclass_id}" type="integer"/>\n' % ind
        owner_cond = cond if shared_owner and "objectclass_id " in shared_owner.group(1) else ""
        target_cond = cond if shared_target and "objectclass_id " in shared_target.group(1) else ""
        block = (f'{ind}<complexProperty{attrs} path="{path}" schema="{sid}">\n'
                 f'{ind}    <joinTable table="{jt}">\n'
                 f'{ind}        <join table="{owner}" fromColumn="{owner_col}" toColumn="id" toRole="parent"{">" if owner_cond else "/>"}\n'
                 + (owner_cond + f'{ind}        </join>\n' if owner_cond else "")
                 + f'{ind}        <inverseJoin table="{target}" fromColumn="{target_col}" toColumn="id" toRole="parent"{">" if target_cond else "/>"}\n'
                 + (target_cond + f'{ind}        </inverseJoin>\n' if target_cond else "")
                 + f'{ind}    </joinTable>\n{ind}</complexProperty>\n')
        mapping = mapping[:m.start()] + block + mapping[m.end():]
        pos = m.start() + len(block)
        pg = join_table_ddl(pg, True, target, column, jt, owner, owner_col, target_col, taken_names)
        ora = join_table_ddl(ora, False, target, column, jt, owner, owner_col, target_col, taken_names)
        changes.append("%s.%s -> join table %s" % (owner, path, jt))
    if any("join table" in c for c in changes):
        pg_drop, ora_drop = read(os.path.join(repo, PG_DROP)), read(os.path.join(repo, ORA_DROP))
        write(os.path.join(repo, PG_DROP), sync_drop_script(pg_drop, pg))
        write(os.path.join(repo, ORA_DROP), sync_drop_script(ora_drop, ora))

    # 6. subtype rows go with their base rows: the delete functions of the ADE Manager delete base rows reached through
    #    join tables (rule 5) without visiting the subtype tables
    for name in ("pg", "ora"):
        ddl = pg if name == "pg" else ora
        new, n = re.subn(r"(ALTER TABLE ur_\w+ ADD CONSTRAINT \w+ FOREIGN KEY \(id\)\nREFERENCES \w+ \(id\));", r"\1\nON DELETE CASCADE;", ddl)
        if n:
            changes.append("%s: %d subtype foreign keys cascade" % (name, n))
        if name == "pg":
            pg = new
        else:
            ora = new

    # 4. top-level ADE feature types the ADE Manager left without topLevel="true" (e.g. uro:OtherConstruction,
    #    uro:UndergroundBuilding): the Importer/Exporter exports only top-level feature types
    for t in spec.feature_types():
        if t.top_level and not t.mapping.top_level:
            m = re.search(r'<featureType id="%s" table="\w+" objectClassId="\d+"' % re.escape(t.mapping.id), mapping)
            assert m, t.name
            mapping = mapping[:m.end()] + ' topLevel="true"' + mapping[m.end():]
            changes.append("%s marked top-level" % t.name)

    write(os.path.join(repo, MAP), mapping)
    write(os.path.join(repo, PG), pg)
    write(os.path.join(repo, ORA), ora)
    print("mapping patches:", changes or "none (already applied)")


# mapping defaultBase ids of the CityGML feature types and the hook targets they cover
BASE_TARGETS = {
    "AbstractBuildingType": "AbstractBuilding", "AbstractBridgeType": "AbstractBridge", "AbstractTunnelType": "AbstractTunnel",
    "LandUseType": "LandUse", "CityFurnitureType": "CityFurniture", "ReliefFeatureType": "ReliefFeature",
    "AbstractReliefComponentType": "ReliefComponent", "AbstractVegetationObjectType": "VegetationObject", "WaterBodyType": "WaterBody",
    "TransportationComplexType": "TransportationComplex", "TrafficAreaType": "TrafficArea", "CityObjectGroupType": "CityObjectGroup",
    "RoomType": "Room", "AbstractOpeningType": "Opening", "AbstractBoundarySurfaceType": "BoundarySurface",
    "BuildingInstallationType": "BuildingInstallation", "BuildingFurnitureType": "BuildingFurniture",
    "IntBuildingInstallationType": "IntBuildingInstallation", "RoadType": "Road", "RailwayType": "Railway",
    "TrackType": "Track", "SquareType": "Square", "AbstractTransportationObjectType": "TransportationObject",
    "AbstractCityObjectType": "CityObject",
}
TARGET_BASE = {v: k for k, v in BASE_TARGETS.items()}
TOP_CLASS = {"Road": "TransportationComplex", "Railway": "TransportationComplex", "Track": "TransportationComplex",
             "Square": "TransportationComplex", "IntBuildingInstallation": "BuildingInstallation"}


if __name__ == "__main__":
    main()
