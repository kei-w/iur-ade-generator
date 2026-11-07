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
  key column per owner into the target table instead, see mapping.patch rule 5 for why this is avoided);
* a feature property to a nested feature is a foreign key column in the target table (toRole child); references to
  city object members (urf, see spec.MEMBER_FEATURE_MODULES) and to core:_CityObject (urf:target) are join tables:
  a foreign key in a member's table would close a cycle with the inheritance joins, on which the Importer/Exporter's
  table ordering (TableHelper) does not terminate.

Usage: iur-ade gen-mapping <citydb repo> <citygml4j repo> <version> <module prefix> [modules the module depends on: uro]
"""

from __future__ import annotations

import logging
import os
import re
import sys
from collections import OrderedDict
from collections.abc import Iterable, Sequence

from ..errors import GeneratorError
from ..naming import RESERVED, Names, sql_name
from ..spec import Field, Module, Spec, Type, modules_for
from . import ddl as ddl_
from .ddl import DDL_FILES, MAP, ORA, PG, append_to_section, header, read, write

log = logging.getLogger(__name__)

TABLE_LEN, COLUMN_LEN, NAME_LEN, SEQ_STEM_LEN = 25, 28, 30, 18
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
    "time": "timestamp",
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
DIMINFO = (
    "MDSYS.SDO_DIM_ARRAY(MDSYS.SDO_DIM_ELEMENT('X', 0.000, 10000000.000, 0.0005), "
    "MDSYS.SDO_DIM_ELEMENT('Y', 0.000, 10000000.000, 0.0005),"
    "MDSYS.SDO_DIM_ELEMENT('Z', -1000, 10000, 0.0005))"
)
CONDITION = '<condition column="objectclass_id" value="${target.objectclass_id}" type="integer"/>'


class Column:
    def __init__(
        self, name: str, sql_type: str, fk: str | None = None, on_delete: str | None = None, spatial: bool = False
    ) -> None:
        self.name, self.sql_type, self.fk, self.on_delete, self.spatial = name, sql_type, fk, on_delete, spatial


class Table:
    def __init__(self, name: str, feature: bool) -> None:
        self.name, self.feature = name, feature
        self.columns: OrderedDict[str, Column] = OrderedDict()
        self.sequence: str | None = None
        self.base_table: str | None = None
        """The table joined on id (base type or cityobject)."""
        self.types: list[Type] = []
        self.pk = ["id"]

    def add(self, column: Column) -> Column:
        self.columns[column.name] = column
        return column


class MappingGenerator:
    """The tables and the mapping XML of the types of one module."""

    def __init__(
        self,
        spec: Spec,
        module: Module,
        schema_id: str,
        first_id: int,
        existing_tables: Iterable[str],
        existing_names: Iterable[str],
    ) -> None:
        self.spec, self.module, self.sid = spec, module, schema_id
        # ancestors first (the 3.2 schema declares _UrbanFunctionType after its subtypes)
        self.types = sorted(
            [t for t in spec.types.values() if t.module is module and not t.is_property],
            key=lambda t: len(t.ancestors()),
        )
        self.tables: OrderedDict[str, Table] = OrderedDict()
        self.table_names = Names(existing_tables)
        self.names = Names(existing_names)
        self.seq_names = Names(existing_names)
        self.column_names: dict[str, set[str]] = {}
        self.object_class_ids: dict[str, int] = {}
        self.type_table: dict[str, Table] = {}
        self.join_tables: list[tuple[str, str, str, str, str]] = []
        """(table, owner table, owner column, target table, target column)."""
        self.foreign_columns: list[tuple[str, str, str]] = []
        """(table of another module, column, referenced table): added to the existing DDL."""
        self.xml: dict[str, list[str]] = {}
        """type -> mapping xml lines."""
        for t in self.types:
            self.object_class_ids[t.qname] = first_id
            first_id += 1
        self._assign_tables()
        for t in self.types:
            self.xml[t.qname] = self._map_type(t)

    # ---------------------------------------------------------------- tables
    def _assign_tables(self) -> None:
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

    def column(self, tbl: Table, base: str, suffix: str = "", limit: int = COLUMN_LEN) -> str:
        name = sql_name(base)
        if name in RESERVED:
            name += "_"
        if len(name) + len(suffix) > limit:
            name = name[: limit - len(suffix)]
        return self.table_names.unique(name + suffix, limit, self.column_names[tbl.name])

    # --------------------------------------------------------------- mapping
    @staticmethod
    def occurs(f: Field) -> str:
        return ('minOccurs="1" ' if f.required else "") + ('maxOccurs="1" ' if not f.multi else "")

    def _map_type(self, t: Type) -> list[str]:
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

    def _target_table(self, target: Type) -> tuple[Table | None, str, str, bool]:
        """(table object of this module or None, table name, mapping id, shared table?) of a target type."""
        if target.module is self.module:
            ttbl = self.type_table[target.qname]
            return ttbl, ttbl.name, "%s_%s" % (self.sid, target.name), "objectclass_id" in ttbl.columns
        # a type of another module (urf -> uro): mapped already
        tname = target.mapped.table
        return None, tname, target.mapped.id, "objectclass_id" in self.spec.ddl_tables[tname]

    def _map_field(self, t: Type, tbl: Table, f: Field) -> list[str]:
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
            and sum(1 for x in t.fields if x.kind == "property" and x.nested is f.nested) > 1
        )
        if k == "cityObjectRef" or f.is_member_reference or (k == "property" and f.multi and not repeated):
            if k == "cityObjectRef":
                target_table, target_id, shared = "cityobject", "AbstractCityObjectType", True
                tag = "featureProperty"
            else:
                target = f.nested
                _, target_table, target_id, shared = self._target_table(target)
                tag = "featureProperty" if target.is_feature else "complexProperty"
            ref = ('target="%s"' if tag == "featureProperty" else 'refType="%s"') % target_id
            target_stem = target_table[3:] if target_table.startswith("ur_") else target_table
            jt = self.table_names.unique("ur_%s_to_%s" % (tbl.name[3:][:9], target_stem[:9]), TABLE_LEN)
            self.column_names[jt] = set()
            jt_table = Table(jt, False)
            owner_col = self.column(jt_table, tbl.name[3:], "_id")
            target_col = self.column(jt_table, target_stem, "_id")
            self.join_tables.append((jt, tbl.name, owner_col, target_table, target_col))
            cond = "                        " + CONDITION
            owner_cond = [cond, "                    </join>"] if "objectclass_id" in tbl.columns else []
            target_cond = [cond, "                    </inverseJoin>"] if shared else []
            return [
                '            <%s %s %spath="%s" schema="%s">' % (tag, ref, occ, f.name, sid),
                '                <joinTable table="%s">' % jt,
                '                    <join table="%s" fromColumn="%s" toColumn="id" toRole="parent"%s'
                % (tbl.name, owner_col, ">" if owner_cond else "/>"),
                *owner_cond,
                '                    <inverseJoin table="%s" fromColumn="%s" toColumn="id" toRole="parent"%s'
                % (target_table, target_col, ">" if target_cond else "/>"),
                *target_cond,
                "                </joinTable>",
                "            </%s>" % tag,
            ]
        if k in ("property", "inline"):
            target = f.nested
            tag = "featureProperty" if target.is_feature else "complexProperty"
            ttbl, tname, tid, shared = self._target_table(target)
            ref = ('target="%s"' if target.is_feature else 'refType="%s"') % tid
            cond_lines = ["                    " + CONDITION, "                </join>"] if shared else []
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
            return [
                '            <%s %s %spath="%s" schema="%s">' % (tag, ref, occ, f.name, sid),
                join,
                *cond_lines,
                "            </%s>" % tag,
            ]
        raise GeneratorError("unsupported field %s.%s (%s)" % (t.name, f.name, k))

    # ------------------------------------------------------------------- ddl
    def ddl(self, pg: bool) -> list[str]:
        """(sequences, tables, foreign keys, indexes, drop foreign keys, drop tables, drop sequences) text blocks."""
        i = 0 if pg else 1
        seqs: list[str] = []
        tables: list[str] = []
        fks: list[str] = []
        idxs: list[str] = []
        drop_fks: list[str] = []
        drop_tables: list[str] = []
        drop_seqs: list[str] = []
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
                        "CREATE SEQUENCE %s\nINCREMENT BY 1\nMINVALUE 0\nMAXVALUE 9223372036854775807\n"
                        "START WITH 1\nCACHE 1\nNO CYCLE\nOWNED BY NONE;\n\n\n" % tbl.sequence
                    )
                else:
                    seqs.append(
                        "CREATE SEQUENCE %s INCREMENT BY 1 START WITH 1 MINVALUE 1 CACHE 10000;\n\n" % tbl.sequence
                    )
                drop_seqs.append("DROP SEQUENCE %s;\n\n" % tbl.sequence)
            cols = []
            if "id" in tbl.columns:
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
            tables.append(header(tbl.name) + "CREATE TABLE %s\n(\n%s\n);\n\n" % (tbl.name, "\n".join(cols)))
            drop_tables.append(header(tbl.name) + "DROP TABLE %s;\n\n" % tbl.name)
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
                    idx_lines.append(ddl_.index(pg, name, tbl.name, c.name))
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
                            "INSERT INTO USER_SDO_GEOM_METADATA (TABLE_NAME, COLUMN_NAME, DIMINFO, SRID)\n"
                            "VALUES ('%s','%s',\n%s, &SRSNO);\n"
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
                fks.append(header(tbl.name) + "".join(fk_lines))
                drop_fks.append(header(tbl.name) + "".join(drop_lines))
            if idx_lines:
                idxs.append(header(tbl.name) + "".join(idx_lines))
        # foreign key columns added to the tables of other modules
        for tname, col, ref in self.foreign_columns:
            name = self.names.unique("%s_%s_fk" % (tname[:12], col[:11]), NAME_LEN)
            fks.append(
                header(tname)
                + "ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (%s)\nREFERENCES %s (id);\n\n" % (tname, name, col, ref)
            )
            drop_fks.append(header(tname) + "ALTER TABLE %s\n    DROP CONSTRAINT %s;\n\n" % (tname, name))
            name = self.names.unique("%s_%s_fkx" % (tname[:12], col[:10]), NAME_LEN)
            idxs.append(header(tname) + ddl_.index(pg, name, tname, col))
        return ["".join(x) for x in (seqs, tables, fks, idxs, drop_fks, drop_tables, drop_seqs)]


# ------------------------------------------------------------------- merging
def object_class_start(mapping: str, module: Module, spec: Spec, old_ids: set[int]) -> int:
    """The first object class id of the module: the start of its previous range when the types still fit in front
    of the other ids (keeps the ids stable across regenerations), else after the highest id in use."""
    count = sum(1 for t in spec.types.values() if t.module is module and not t.is_property)
    used = {int(x) for x in re.findall(r'objectClassId="(\d+)"', mapping)}
    if old_ids:
        start = min(old_ids)
        if not any(start <= i < start + count for i in used):
            return start
    return max(used) + 1


def generate(repo: str, cg4j: str, version: str, prefix: str, deps: Sequence[str] = ("uro",)) -> str:
    """Generates the mapping and DDL of the module ``prefix`` into the citydb repository; returns a summary line."""
    spec = Spec(modules_for(cg4j, [*deps, prefix], version), os.path.join(repo, MAP), os.path.join(repo, PG))
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
            '        <schema id="%s" isADERoot="true">\n            <namespace context="citygml-2.0">%s</namespace>\n'
            "        </schema>\n    </applicationSchemas>" % (sid, module.namespace),
        )
    # (also the self-closing tags of abstract types without properties, the 1.4 urt _PublicTransitDataType)
    old_blocks = re.findall(
        r' {8}<(?:featureType|complexType) [^>]*schema="%s"(?:/>|>.*?</(?:featureType|complexType)>)\n' % sid,
        mapping,
        re.S,
    )
    old_tables: set[str] = set()
    old_ids: set[int] = set()
    for b in old_blocks:
        old_ids |= {int(x) for x in re.findall(r'objectClassId="(\d+)"', b)}
        # the tables of the module's types and their join tables (not the tables of other modules they join to)
        old_tables |= set(re.findall(r'<(?:featureType|complexType) [^>]*table="(\w+)"', b))
        old_tables |= set(re.findall(r'<joinTable table="(\w+)"', b))
        mapping = mapping.replace(b, "")
    old_tables = {t for t in old_tables if t.startswith("ur_")}
    pg = read(os.path.join(repo, PG))
    old_sequences: set[str] = set()
    for t in old_tables:
        tm = re.search(r"CREATE TABLE %s\n\((.*?)\n\);" % t, pg, re.S)
        if tm:
            old_sequences |= set(re.findall(r"nextval\('(\w+)'", tm.group(1)))
    # the injection tables of the hooks and their join tables keep their columns: the regenerated tables of the
    # module keep their names, so the foreign keys stay valid
    injection_tables = set(re.findall(r'<propertyInjection table="(\w+)"', mapping))
    for inj in re.findall(r"<propertyInjection .*?</propertyInjection>", mapping, re.S):
        injection_tables |= set(re.findall(r'<joinTable table="(\w+)"', inj))
    cleaned = {}
    for create, drop, _ in DDL_FILES:
        c = ddl_.remove_blocks(read(os.path.join(repo, create)), old_tables, old_sequences)
        d = ddl_.remove_blocks(read(os.path.join(repo, drop)), old_tables, old_sequences)
        cleaned[create], cleaned[drop] = ddl_.remove_foreign_columns(c, d, old_tables, keep=injection_tables)
    pg = cleaned[PG]
    remaining_tables = set(re.findall(r"^CREATE TABLE (\w+)$", pg, re.M))
    remaining_names = (
        set(re.findall(r"CONSTRAINT (\w+)", pg))
        | set(re.findall(r"CREATE INDEX (\w+)", pg))
        | set(re.findall(r"CREATE SEQUENCE (\w+)", pg))
    )
    first_id = object_class_start(mapping, module, spec, old_ids)
    gen = MappingGenerator(
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
    if complex_xml:
        mapping = mapping.replace("    </complexTypes>", complex_xml + "\n    </complexTypes>", 1)
    if feature_xml:
        mapping = mapping.replace("    </featureTypes>", feature_xml + "\n    </featureTypes>", 1)
    write(os.path.join(repo, MAP), mapping)

    # ddl: previous tables of the module removed, new blocks appended to the sections
    for create, drop, is_pg in DDL_FILES:
        c, d = cleaned[create], cleaned[drop]
        c = ddl_.add_foreign_columns(c, gen.foreign_columns, is_pg)
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
    return (
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


def main(argv: list[str] | None = None) -> None:
    argv = sys.argv[1:] if argv is None else list(argv)
    repo, cg4j, version, prefix = argv[0:4]
    deps = argv[4].split(",") if len(argv) > 4 else ["uro"]
    log.info("%s", generate(repo, cg4j, version, prefix, deps))


__all__ = ["ORA", "MappingGenerator", "generate", "main"]
