"""Generates the 3DCityDB schema mapping and DDL of one i-UR module in the style of the ADE Manager and merges them into
the citydb repository (replacing the module's previous mapping and tables).

The ADE Manager (2.3.0) does not finish the transformation of the urf 3.x schemas: its graph transformation engine needs
minutes per inheritance step for the 160 feature types of the urban function hierarchy. This generator applies the same
mapping rules deterministically:

* a complex type with properties of its own gets a table ur_<name> (25 characters); a subtype without own properties
  shares the table of its base type, which then carries an objectclass_id column;
* feature types extend their base through a join on id (the root: the cityobject table); data types have a sequence;
* simple properties are columns (gml:CodeType and measures as value + codeSpace/uom pairs, lists joined in one column),
  multi surfaces reference surface_geometry, multi curves and points are inline geometry columns;
* a single-valued property of a data type is a foreign key column in the owner (with an objectclass_id condition when
  the target table is shared); a multi-valued one is a join table ur_<owner>_to_<target> (the ADE Manager puts a foreign
  key column per owner into the target table instead, see patch_mapping rule 5 for why this is avoided);
* a feature property to a nested feature is a foreign key column in the target table (toRole child); references to
  city object members (urf, see urospec.MEMBER_FEATURE_MODULES) and to core:_CityObject (urf:target) are join tables:
  a foreign key in a member's table would close a cycle with the inheritance joins, on which the Importer/Exporter's
  table ordering (TableHelper) does not terminate.

Usage: gen_mapping.py <citydb repo> <citygml4j repo> <version> <module prefix> [modules the module depends on: uro]
"""

import os
import re
import sys
from collections import OrderedDict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from . import urospec

PG = "resources/database/3dcitydb/postgreSQL/CREATE_ADE_DB.sql"
PG_DROP = "resources/database/3dcitydb/postgreSQL/DROP_ADE_DB.sql"
ORA = "resources/database/3dcitydb/oracle/CREATE_ADE_DB.sql"
ORA_DROP = "resources/database/3dcitydb/oracle/DROP_ADE_DB.sql"
MAP = "resources/database/schema-mapping/schema-mapping.xml"

TABLE_LEN, COLUMN_LEN, NAME_LEN, SEQ_STEM_LEN = 25, 28, 30, 18
# SQL reserved words (PostgreSQL and Oracle) that get a trailing underscore as column names, as the ADE Manager does
RESERVED = set(
    """id objectclass_id access add all alter analyze and any array as asc audit authorization between binary both by case cast char
    check cluster collate column comment compress concurrently connect constraint create cross current date decimal default
    delete desc distinct do drop else end except exclusive exists false fetch file float for freeze from full grant group
    having identified ilike immediate in increment index initial inner insert integer intersect into is isnull join lateral
    leading left level like limit localtime lock long minus mode modify natural noaudit nocompress not notnull nowait null
    number of offline offset on online only option or order outer overlaps pctfree placing primary prior public raw references
    rename resource returning revoke right row rowid rownum rows select session set share similar size smallint some start
    successful symmetric synonym sysdate table tablesample then to trailing trigger true uid union unique update user using
    validate values varchar varchar2 variadic verbose view when whenever where window with""".split()
)
SQL_TYPES = {  # mapping attribute type -> (PostgreSQL, Oracle)
    "string": ("VARCHAR(1000)", "VARCHAR2(1000)"),
    "integer": ("INTEGER", "INTEGER"),
    "double": ("NUMERIC", "NUMBER"),
    "boolean": ("NUMERIC", "NUMBER"),
    "date": ("DATE", "DATE"),
    "timestamp": ("TIMESTAMP WITH TIME ZONE", "TIMESTAMP"),
    "clob": ("TEXT", "CLOB"),
    "id": ("BIGINT", "NUMBER(38)"),
    "geometry": ("geometry(GEOMETRYZ)", "MDSYS.SDO_GEOMETRY"),
    "objectclass": ("INTEGER", "INTEGER"),
}
ATTRIBUTE_TYPES = {
    "string": "string",
    "stringOrRef": "string",
    "enum": "string",
    "integer": "integer",
    "double": "double",
    "boolean": "boolean",
    "date": "timestamp",
    "dateTime": "timestamp",
    "year": "date",
    "yearMonth": "date",
    "directPosition": "clob",
    "doubleList": "clob",
}
GEOMETRY_TYPES = {
    "multiSurface": "MultiSurface",
    "multiCurve": "MultiCurve",
    "multiPoint": "MultiPoint",
    "point": "Point",
}
HEADER = "-- -------------------------------------------------------------------- \n-- %s \n-- -------------------------------------------------------------------- \n"
DIMINFO = (
    "MDSYS.SDO_DIM_ARRAY(MDSYS.SDO_DIM_ELEMENT('X', 0.000, 10000000.000, 0.0005), MDSYS.SDO_DIM_ELEMENT('Y', 0.000, 10000000.000, 0.0005),"
    "MDSYS.SDO_DIM_ELEMENT('Z', -1000, 10000, 0.0005))"
)


def read(p):
    return open(p, encoding="utf-8").read()


def write(p, s):
    with open(p, "w", encoding="utf-8", newline="\n") as fp:
        fp.write(s)


def sql_name(name):
    return re.sub(r"[^a-z0-9_]", "_", name.lower())


class Names:
    """Unique SQL identifiers (tables, columns per table, constraints and indexes, sequences)."""

    def __init__(self, taken):
        self.taken = set(taken)

    def unique(self, base, limit, taken=None):
        taken = self.taken if taken is None else taken
        name = base[:limit]
        n = 1
        while name in taken:
            n += 1
            suffix = "_%d" % n
            name = base[: limit - len(suffix)] + suffix
        taken.add(name)
        return name


class Column:
    def __init__(self, name, sql_type, fk=None, on_delete=None, spatial=False):
        self.name, self.sql_type, self.fk, self.on_delete, self.spatial = name, sql_type, fk, on_delete, spatial


class Table:
    def __init__(self, name, feature):
        self.name, self.feature = name, feature
        self.columns = OrderedDict()
        self.sequence = None
        self.base_table = None  # table joined on id (base type or cityobject)
        self.types = []
        self.pk = ["id"]

    def add(self, column):
        self.columns[column.name] = column
        return column


class Generator:
    def __init__(self, spec, module, schema_id, first_id, existing_tables, existing_names):
        self.spec, self.module, self.sid = spec, module, schema_id
        # ancestors first (the 3.2 schema declares _UrbanFunctionType after its subtypes)
        self.types = sorted(
            [t for t in spec.types.values() if t.module is module and not t.is_property],
            key=lambda t: len(t.ancestors()),
        )
        self.tables = OrderedDict()
        self.table_names = Names(existing_tables)
        self.names = Names(existing_names)
        self.seq_names = Names(existing_names)
        self.column_names = {}
        self.object_class_ids = {}
        self.type_table = {}
        self.join_tables = []  # (table, owner table, owner column, target table, target column)
        self.foreign_columns = []  # (table of another module, column, referenced table): added to the existing DDL
        self.xml = {}  # type -> mapping xml lines
        for t in self.types:
            self.object_class_ids[t.qname] = first_id
            first_id += 1
        self._assign_tables()
        for t in self.types:
            self.xml[t.qname] = self._map_type(t)

    # ---------------------------------------------------------------- tables
    def _assign_tables(self):
        for t in self.types:  # ancestors precede their subtypes in the spec
            if t.base is not None and not t.fields and t.base.module is self.module:
                tbl = self.type_table[t.base.qname]
            else:
                name = self.table_names.unique("ur_" + sql_name(t.model), TABLE_LEN)
                tbl = Table(name, t.is_feature)
                self.tables[name] = tbl
                self.column_names[name] = set()
                tbl.add(Column("id", "id"))
                if t.is_feature:
                    tbl.base_table = (
                        self.type_table[t.base.qname].name
                        if t.base is not None and t.base.module is self.module
                        else "cityobject"
                    )
                else:
                    tbl.sequence = self.seq_names.unique(
                        ("ur_" + sql_name(t.model))[: 3 + SEQ_STEM_LEN] + "_seq", NAME_LEN
                    )
            tbl.types.append(t)
            self.type_table[t.qname] = tbl
        for tbl in self.tables.values():
            if any(t.subtypes for t in tbl.types) or len(tbl.types) > 1:
                tbl.add(Column("objectclass_id", "objectclass", fk="objectclass"))

    def column(self, tbl, base, suffix="", limit=COLUMN_LEN):
        name = sql_name(base)
        if name in RESERVED:
            name += "_"
        if len(name) + len(suffix) > limit:
            name = name[: limit - len(suffix)]
        return self.table_names.unique(name + suffix, limit, self.column_names[tbl.name])

    # --------------------------------------------------------------- mapping
    def occurs(self, f):
        return ('minOccurs="1" ' if f.required else "") + ('maxOccurs="1" ' if not f.multi else "")

    def _map_type(self, t):
        tbl = self.type_table[t.qname]
        tag = "featureType" if t.is_feature else "complexType"
        attrs = 'abstract="true" ' if t.abstract else ""
        attrs += 'id="%s_%s" table="%s" objectClassId="%d" ' % (
            self.sid,
            t.name,
            tbl.name,
            self.object_class_ids[t.qname],
        )
        if t.top_level:
            attrs += 'topLevel="true" '
        attrs += 'path="%s" schema="%s"' % (t.mapping_path, self.sid)
        lines = ["        <%s %s>" % (tag, attrs)]
        if t.base is not None and t.base.module is self.module:
            base_tbl = self.type_table[t.base.qname]
            if base_tbl is tbl:
                lines.append('            <extension base="%s_%s"/>' % (self.sid, t.base.name))
            else:
                lines.append('            <extension base="%s_%s">' % (self.sid, t.base.name))
                lines.append(
                    '                <join table="%s" fromColumn="id" toColumn="id" toRole="parent"/>' % base_tbl.name
                )
                lines.append("            </extension>")
        elif t.is_feature:
            lines.append('            <extension base="AbstractCityObjectType">')
            lines.append('                <join table="cityobject" fromColumn="id" toColumn="id" toRole="parent"/>')
            lines.append("            </extension>")
        for f in t.fields:
            lines.extend(self._map_field(t, tbl, f))
        lines.append("        </%s>" % tag)
        return lines

    def _map_field(self, t, tbl, f):
        k, occ, sid = f.kind, self.occurs(f), self.sid
        if k in ATTRIBUTE_TYPES:
            # lists of simple values are stored joined in one string column (the Importer/Exporter convention)
            atype = "string" if f.multi else ATTRIBUTE_TYPES[k]
            col = tbl.add(Column(self.column(tbl, f.name), atype)).name
            return [
                '            <attribute column="%s" type="%s" %spath="%s" schema="%s"/>'
                % (col, atype, occ, f.name, sid)
            ]
        if k == "code":
            col = tbl.add(Column(self.column(tbl, f.name), "string")).name
            qual = tbl.add(Column(self.column(tbl, f.name, "_codespace"), "string")).name
            return [
                '            <complexAttribute %spath="%s" schema="%s">' % (occ, f.name, sid),
                '                <attribute column="%s" type="string" path="@codespace" schema="gml"/>' % qual,
                '                <attribute column="%s" type="string" path="." schema="%s"/>' % (col, sid),
                "            </complexAttribute>",
            ]
        if k in ("measure", "length"):
            vtype = "string" if f.multi else "double"
            qual = tbl.add(Column(self.column(tbl, f.name, "_uom"), "string")).name
            col = tbl.add(Column(self.column(tbl, f.name), vtype)).name
            return [
                '            <complexAttribute %spath="%s" schema="%s">' % (occ, f.name, sid),
                '                <attribute column="%s" type="string" path="@uom" schema="gml"/>' % qual,
                '                <attribute column="%s" type="%s" path="." schema="%s"/>' % (col, vtype, sid),
                "            </complexAttribute>",
            ]
        if k in GEOMETRY_TYPES:
            lod = 'lod="%s" ' % f.lod if f.lod is not None and f.lod >= 0 else ""
            if k == "multiSurface":
                col = tbl.add(Column(self.column(tbl, f.name, "_id"), "id", fk="surface_geometry")).name
                return [
                    '            <geometryProperty %srefColumn="%s" type="%s" %spath="%s" schema="%s"/>'
                    % (lod, col, GEOMETRY_TYPES[k], occ, f.name, sid)
                ]
            col = tbl.add(Column(self.column(tbl, f.name), "geometry", spatial=True)).name
            return [
                '            <geometryProperty %sinlineColumn="%s" type="%s" %spath="%s" schema="%s"/>'
                % (lod, col, GEOMETRY_TYPES[k], occ, f.name, sid)
            ]
        # a multi-valued data type property is a join table, unless the owner has several properties of that type: the
        # ADE Manager's delete functions declare one variable per referenced table and reject two join tables to it
        repeated = (
            k == "property"
            and not f.is_feature_property
            and f.multi
            and sum(1 for x in t.fields if x.kind == "property" and x.target.prop_target is f.target.prop_target) > 1
        )
        if k == "cityObjectRef" or f.is_member_reference or (k == "property" and f.multi and not repeated):
            target = f.target.prop_target if k == "property" else None
            if k == "cityObjectRef":
                target_table, target_id, shared = "cityobject", "AbstractCityObjectType", True
            elif target.module is self.module:
                ttbl = self.type_table[target.qname]
                target_table, target_id, shared = (
                    ttbl.name,
                    "%s_%s" % (self.sid, target.name),
                    "objectclass_id" in ttbl.columns,
                )
            else:
                target_table, target_id = target.mapping.table, target.mapping.id
                shared = "objectclass_id" in self.spec.ddl_tables[target_table]
            tag = "featureProperty" if k == "cityObjectRef" or target.is_feature else "complexProperty"
            ref = ('target="%s"' if tag == "featureProperty" else 'refType="%s"') % target_id
            target_stem = target_table[3:] if target_table.startswith("ur_") else target_table
            jt = self.table_names.unique("ur_%s_to_%s" % (tbl.name[3:][:9], target_stem[:9]), TABLE_LEN)
            self.column_names[jt] = set()
            jt_table = Table(jt, False)
            owner_col = self.column(jt_table, tbl.name[3:], "_id")
            target_col = self.column(jt_table, target_stem, "_id")
            self.join_tables.append((jt, tbl.name, owner_col, target_table, target_col))
            cond = '                        <condition column="objectclass_id" value="${target.objectclass_id}" type="integer"/>'
            owner_cond = [cond, "                    </join>"] if "objectclass_id" in tbl.columns else []
            target_cond = [cond, "                    </inverseJoin>"] if shared else []
            return (
                [
                    '            <%s %s %spath="%s" schema="%s">' % (tag, ref, occ, f.name, sid),
                    '                <joinTable table="%s">' % jt,
                    '                    <join table="%s" fromColumn="%s" toColumn="id" toRole="parent"%s'
                    % (tbl.name, owner_col, ">" if owner_cond else "/>"),
                ]
                + owner_cond
                + [
                    '                    <inverseJoin table="%s" fromColumn="%s" toColumn="id" toRole="parent"%s'
                    % (target_table, target_col, ">" if target_cond else "/>")
                ]
                + target_cond
                + ["                </joinTable>", "            </%s>" % tag]
            )
        if k in ("property", "inline"):
            target = f.target.prop_target if k == "property" else f.target
            tag = "featureProperty" if target.is_feature else "complexProperty"
            if target.module is self.module:
                ttbl = self.type_table[target.qname]
                tname, tid, shared = ttbl.name, "%s_%s" % (self.sid, target.name), "objectclass_id" in ttbl.columns
            else:
                # a type of another module (urf -> uro): mapped already
                ttbl, tname, tid = None, target.mapping.table, target.mapping.id
                shared = "objectclass_id" in self.spec.ddl_tables[tname]
            ref = ('target="%s"' if target.is_feature else 'refType="%s"') % tid
            cond = (
                [
                    '                    <condition column="objectclass_id" value="${target.objectclass_id}" type="integer"/>',
                    "                </join>",
                ]
                if shared
                else []
            )
            close = ">" if shared else "/>"
            if f.multi or target.is_feature:
                # foreign key column in the target table (one per owner property)
                base = "%s_%s" % (tbl.name[3:], f.name)
                if ttbl is not None:
                    col = ttbl.add(Column(self.column(ttbl, base, "_id"), "id", fk=tbl.name)).name
                else:
                    self.column_names.setdefault(tname, set(self.spec.ddl_tables[tname]))
                    col = self.column(Table(tname, False), base, "_id")
                    self.foreign_columns.append((tname, col, tbl.name))
                join = '                <join table="%s" fromColumn="id" toColumn="%s" toRole="child"%s' % (
                    tname,
                    col,
                    close,
                )
            else:
                col = tbl.add(Column(self.column(tbl, f.name, "_id"), "id", fk=tname, on_delete="SET NULL")).name
                join = '                <join table="%s" fromColumn="%s" toColumn="id" toRole="parent"%s' % (
                    tname,
                    col,
                    close,
                )
            return (
                ['            <%s %s %spath="%s" schema="%s">' % (tag, ref, occ, f.name, sid), join]
                + cond
                + ["            </%s>" % tag]
            )
        raise ValueError("unsupported field %s.%s (%s)" % (t.name, f.name, k))

    # ------------------------------------------------------------------- ddl
    def ddl(self, pg):
        """(sequences, tables, foreign keys, indexes, drop foreign keys, drop tables, drop sequences) text blocks."""
        i = 0 if pg else 1
        seqs, tables, fks, idxs, drop_fks, drop_tables, drop_seqs = [], [], [], [], [], [], []
        all_tables = list(self.tables.values())
        for jt, owner, owner_col, target, target_col in self.join_tables:
            tbl = Table(jt, False)
            tbl.add(Column(target_col, "id", fk=target, on_delete="CASCADE"))
            tbl.add(Column(owner_col, "id", fk=owner, on_delete="CASCADE"))
            tbl.pk = [target_col, owner_col]
            all_tables.append(tbl)
        for tbl in sorted(all_tables, key=lambda x: x.name):
            if tbl.sequence:
                if pg:
                    seqs.append(
                        "CREATE SEQUENCE %s\nINCREMENT BY 1\nMINVALUE 0\nMAXVALUE 9223372036854775807\nSTART WITH 1\nCACHE 1\nNO CYCLE\nOWNED BY NONE;\n\n\n"
                        % tbl.sequence
                    )
                else:
                    seqs.append(
                        "CREATE SEQUENCE %s INCREMENT BY 1 START WITH 1 MINVALUE 1 CACHE 10000;\n\n" % tbl.sequence
                    )
                drop_seqs.append("DROP SEQUENCE %s;\n\n" % tbl.sequence)
            cols = []
            for c in [tbl.columns["id"]] if "id" in tbl.columns else []:
                if tbl.sequence and pg:
                    cols.append("    id BIGINT NOT NULL DEFAULT nextval('%s'::regclass) NOT NULL," % tbl.sequence)
                else:
                    cols.append("    id %s NOT NULL," % SQL_TYPES["id"][i])
            for c in sorted(tbl.columns.values(), key=lambda x: x.name):
                if c.name == "id":
                    continue
                not_null = " NOT NULL" if c.name in tbl.pk else ""
                cols.append("    %s %s%s," % (c.name, SQL_TYPES[c.sql_type][i], not_null))
            cols.append("    PRIMARY KEY (%s)" % ", ".join(tbl.pk))
            tables.append(HEADER % tbl.name + "CREATE TABLE %s\n(\n%s\n);\n\n" % (tbl.name, "\n".join(cols)))
            drop_tables.append(HEADER % tbl.name + "DROP TABLE %s;\n\n" % tbl.name)
            fk_lines, drop_lines, idx_lines = [], [], []
            if "objectclass_id" in tbl.columns:
                name = self.names.unique("%s_objectclass_fk" % tbl.name[: NAME_LEN - 15], NAME_LEN)
                fk_lines.append(
                    "ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (objectclass_id)\nREFERENCES objectclass (id);\n\n"
                    % (tbl.name, name)
                )
                drop_lines.append("ALTER TABLE %s\n    DROP CONSTRAINT %s;\n\n" % (tbl.name, name))
            if tbl.base_table:
                name = self.names.unique("%s_fk" % tbl.name, NAME_LEN)
                # a subtype row goes with its base row (the delete functions of the ADE Manager delete base rows reached
                # through join tables without visiting the subtype tables)
                fk_lines.append(
                    "ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (id)\nREFERENCES %s (id)\nON DELETE CASCADE;\n\n"
                    % (tbl.name, name, tbl.base_table)
                )
                drop_lines.append("ALTER TABLE %s\n    DROP CONSTRAINT %s;\n\n" % (tbl.name, name))
            for c in sorted(tbl.columns.values(), key=lambda x: x.name):
                if c.fk and c.name != "objectclass_id":
                    stem = "%s_%s" % (tbl.name[:12], c.name[:11])
                    name = self.names.unique(stem + "_fk", NAME_LEN)
                    on_delete = "\nON DELETE %s" % c.on_delete if c.on_delete else ""
                    fk_lines.append(
                        "ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (%s)\nREFERENCES %s (id)%s;\n\n"
                        % (tbl.name, name, c.name, c.fk, on_delete)
                    )
                    drop_lines.append("ALTER TABLE %s\n    DROP CONSTRAINT %s;\n\n" % (tbl.name, name))
                if (c.fk and c.name not in tbl.pk) or c.name == "objectclass_id":
                    name = self.names.unique("%s_%s_fkx" % (tbl.name[:12], c.name[:10]), NAME_LEN)
                    if pg:
                        idx_lines.append(
                            "CREATE INDEX %s ON %s\n    USING btree\n    (\n      %s ASC NULLS LAST\n    )   WITH (FILLFACTOR = 90);\n\n"
                            % (name, tbl.name, c.name)
                        )
                    else:
                        idx_lines.append("CREATE INDEX %s ON %s (%s);\n\n" % (name, tbl.name, c.name))
                if c.spatial:
                    name = self.names.unique("%s_%s_spx" % (tbl.name[:12], c.name[:10]), NAME_LEN)
                    if pg:
                        idx_lines.append(
                            "CREATE INDEX %s ON %s\n    USING gist\n    (\n      %s\n    );\n\n"
                            % (name, tbl.name, c.name)
                        )
                    else:
                        idx_lines.append(
                            "DELETE FROM USER_SDO_GEOM_METADATA WHERE TABLE_NAME='%s' AND COLUMN_NAME='%s';\n"
                            "INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, DIMINFO, SRID)\nVALUES ('%s','%s',\n%s, &SRSNO);\n"
                            "CREATE INDEX %s ON %s (%s) INDEXTYPE IS MDSYS.SPATIAL_INDEX;\n\n"
                            % (
                                tbl.name.upper(),
                                c.name.upper(),
                                tbl.name.upper(),
                                c.name.upper(),
                                DIMINFO,
                                name,
                                tbl.name,
                                c.name,
                            )
                        )
            if fk_lines:
                fks.append(HEADER % tbl.name + "".join(fk_lines))
                drop_fks.append(HEADER % tbl.name + "".join(drop_lines))
            if idx_lines:
                idxs.append(HEADER % tbl.name + "".join(idx_lines))
        # foreign key columns added to the tables of other modules
        for tname, col, ref in self.foreign_columns:
            name = self.names.unique("%s_%s_fk" % (tname[:12], col[:11]), NAME_LEN)
            fks.append(
                HEADER % tname
                + "ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (%s)\nREFERENCES %s (id);\n\n" % (tname, name, col, ref)
            )
            drop_fks.append(HEADER % tname + "ALTER TABLE %s\n    DROP CONSTRAINT %s;\n\n" % (tname, name))
            name = self.names.unique("%s_%s_fkx" % (tname[:12], col[:10]), NAME_LEN)
            if pg:
                idxs.append(
                    HEADER % tname
                    + "CREATE INDEX %s ON %s\n    USING btree\n    (\n      %s ASC NULLS LAST\n    )   WITH (FILLFACTOR = 90);\n\n"
                    % (name, tname, col)
                )
            else:
                idxs.append(HEADER % tname + "CREATE INDEX %s ON %s (%s);\n\n" % (name, tname, col))
        return ["".join(x) for x in (seqs, tables, fks, idxs, drop_fks, drop_tables, drop_seqs)]


# ------------------------------------------------------------------- merging
def remove_blocks(text, tables, sequences):
    """Drop the header blocks of the given tables and the statements of the given sequences from a DDL text."""
    out, pos = [], 0
    for m in re.finditer(r"-- -+ \n-- (\w+) \n-- -+ \n", text):
        if m.group(1) in tables:
            out.append(text[pos : m.start()])
            nxt = re.search(r"-- -+ \n-- \w+ \n|-- \+{10,}", text[m.end() :])
            pos = m.end() + (nxt.start() if nxt else len(text) - m.end())
    out.append(text[pos:])
    text = "".join(out)
    for s in sequences:
        text = re.sub(r"CREATE SEQUENCE %s\b.*?;\n\n(\n)?" % re.escape(s), "", text, flags=re.S)
        text = re.sub(r"DROP SEQUENCE %s;\n\n" % re.escape(s), "", text)
    return text


def remove_foreign_columns(create, drop, tables):
    """Drop the foreign key columns (with their constraints and indexes) that tables of other modules hold for the given
    (previous) tables of the module."""
    for m in re.finditer(
        r"ALTER TABLE (\w+) ADD CONSTRAINT (\w+) FOREIGN KEY \((\w+)\)\nREFERENCES (\w+) \(id\)[^;]*;\n\n", create
    ):
        table, constraint, column, ref = m.groups()
        if ref not in tables or table in tables:
            continue
        create = create.replace(m.group(0), "")
        create = re.sub(r"^    %s \w+[^\n]*,\n" % column, "", create, flags=re.M)
        create = re.sub(
            r"CREATE INDEX \w+ ON %s\n    USING btree\n    \(\n      %s ASC NULLS LAST\n    \)   WITH \(FILLFACTOR = 90\);\n\n"
            % (table, column),
            "",
            create,
        )
        create = re.sub(r"CREATE INDEX \w+ ON %s \(%s\);\n\n" % (table, column), "", create)
        drop = drop.replace("ALTER TABLE %s\n    DROP CONSTRAINT %s;\n\n" % (table, constraint), "")
    return create, drop


def add_foreign_columns(create, columns, pg):
    for table, column, ref in columns:
        m = re.search(r"^CREATE TABLE %s\n\((.*?)\n\);" % table, create, re.S | re.M)
        assert m, table
        body = m.group(1).replace(
            "    PRIMARY KEY (id)", "    %s %s,\n    PRIMARY KEY (id)" % (column, SQL_TYPES["id"][0 if pg else 1])
        )
        create = create[: m.start(1)] + body + create[m.end(1) :]
    return create


def append_to_section(text, title, block):
    """Append a block at the end of the DDL section with the given title (before the next section header)."""
    m = re.search(r"-- \*+ %s \*+ \n-- \++ \n\n?" % re.escape(title), text)
    assert m, title
    nxt = re.search(r"\n-- \+{10,}", text[m.end() :])
    pos = m.end() + nxt.start() + 1 if nxt else len(text)
    return text[:pos] + block + text[pos:]


def main(argv: list[str] | None = None) -> None:
    argv = sys.argv[1:] if argv is None else list(argv)
    repo, cg4j, version, prefix = argv[0:4]
    deps = argv[4].split(",") if len(argv) > 4 else ["uro"]
    spec = urospec.Spec(
        urospec.modules_for(cg4j, deps + [prefix], version), os.path.join(repo, MAP), os.path.join(repo, PG)
    )
    module = spec.modules[prefix]
    mapping = read(os.path.join(repo, MAP))
    # the schema entry of the module (its previous version) and the types and tables mapped so far
    m = re.search(
        r'<schema id="(ur_\d+)" isADERoot="true">\s*<namespace context="citygml-2.0">([^<]*/%s/[^<]*)</namespace>'
        % prefix,
        mapping,
    )
    if m:
        sid, old_ns = m.group(1), m.group(2)
        mapping = mapping.replace(">%s</namespace>" % old_ns, ">%s</namespace>" % module.namespace, 1)
    else:
        sid = "ur_%d" % (max(int(x) for x in re.findall(r'<schema id="ur_(\d+)"', mapping)) + 1)
        mapping = mapping.replace(
            "    </applicationSchemas>",
            '        <schema id="%s" isADERoot="true">\n            <namespace context="citygml-2.0">%s</namespace>\n        </schema>\n    </applicationSchemas>'
            % (sid, module.namespace),
        )
    old_blocks = re.findall(
        r' {8}<(?:featureType|complexType) [^>]*schema="%s">.*?</(?:featureType|complexType)>\n' % sid, mapping, re.S
    )
    old_tables = set()
    for b in old_blocks:
        # the tables of the module's types and their join tables (not the tables of other modules they join to)
        old_tables |= set(re.findall(r'<(?:featureType|complexType) [^>]*table="(\w+)"', b))
        old_tables |= set(re.findall(r'<joinTable table="(\w+)"', b))
        mapping = mapping.replace(b, "")
    old_tables = {t for t in old_tables if t.startswith("ur_")}
    pg, ora = read(os.path.join(repo, PG)), read(os.path.join(repo, ORA))
    old_sequences = set()
    for t in old_tables:
        tm = re.search(r"CREATE TABLE %s\n\((.*?)\n\);" % t, pg, re.S)
        if tm:
            old_sequences |= set(re.findall(r"nextval\('(\w+)'", tm.group(1)))
    cleaned = {}
    for create, drop in ((PG, PG_DROP), (ORA, ORA_DROP)):
        c = remove_blocks(read(os.path.join(repo, create)), old_tables, old_sequences)
        d = remove_blocks(read(os.path.join(repo, drop)), old_tables, old_sequences)
        cleaned[create], cleaned[drop] = remove_foreign_columns(c, d, old_tables)
    pg = cleaned[PG]
    remaining_tables = set(re.findall(r"^CREATE TABLE (\w+)$", pg, re.M))
    remaining_names = (
        set(re.findall(r"CONSTRAINT (\w+)", pg))
        | set(re.findall(r"CREATE INDEX (\w+)", pg))
        | set(re.findall(r"CREATE SEQUENCE (\w+)", pg))
    )
    first_id = max(int(x) for x in re.findall(r'objectClassId="(\d+)"', mapping)) + 1
    gen = Generator(
        spec,
        module,
        sid,
        first_id,
        remaining_tables | {"cityobject", "objectclass", "surface_geometry"},
        remaining_names,
    )

    # mapping: the module's complex types before </complexTypes>, its feature types before </featureTypes>
    complex_xml = "\n".join("\n".join(gen.xml[t.qname]) for t in gen.types if not t.is_feature)
    feature_xml = "\n".join("\n".join(gen.xml[t.qname]) for t in gen.types if t.is_feature)
    mapping = mapping.replace("    </complexTypes>", complex_xml + "\n    </complexTypes>", 1)
    mapping = mapping.replace("    </featureTypes>", feature_xml + "\n    </featureTypes>", 1)
    write(os.path.join(repo, MAP), mapping)

    # ddl: previous tables of the module removed, new blocks appended to the sections
    for create, drop, is_pg in ((PG, PG_DROP, True), (ORA, ORA_DROP, False)):
        c, d = cleaned[create], cleaned[drop]
        c = add_foreign_columns(c, gen.foreign_columns, is_pg)
        seqs, tables, fks, idxs, drop_fks, drop_tables, drop_seqs = gen.ddl(is_pg)
        c = append_to_section(c, "Create Sequences", seqs)
        c = append_to_section(c, "Create tables", tables)
        c = append_to_section(c, "Create foreign keys", fks)
        c = append_to_section(c, "Create Indexes", idxs)
        d = append_to_section(d, "Drop foreign keys", drop_fks)
        d = append_to_section(d, "Drop tables", drop_tables)
        d = append_to_section(d, "Drop Sequences", drop_seqs)
        write(os.path.join(repo, create), c)
        write(os.path.join(repo, drop), d)
    print(
        "%s %s: %d types (%d features) in %d tables, %d join tables, object class ids %d-%d, previous tables removed: %d"
        % (
            prefix,
            version,
            len(gen.types),
            sum(1 for t in gen.types if t.is_feature),
            len(gen.tables),
            len(gen.join_tables),
            first_id,
            first_id + len(gen.types) - 1,
            len(old_tables),
        )
    )


if __name__ == "__main__":
    main()
