"""The 3DCityDB schema mapping and DDL of the ADE as the generators read them (tables, columns, joins, sequences)."""

from __future__ import annotations

import re
import xml.etree.ElementTree as ET
from collections import OrderedDict
from dataclasses import dataclass, field
from pathlib import Path


def local(tag: str) -> str:
    return tag.split("}")[-1]


@dataclass(frozen=True)
class Join:
    """``<join table fromColumn toColumn toRole/>``; ``to_role`` is ``parent`` (the row references the target) or
    ``child`` (the target rows reference the row)."""

    table: str
    from_column: str
    to_column: str
    to_role: str


@dataclass(frozen=True)
class JoinTable:
    """``<joinTable table>`` with its join (``owner_column`` references the owner row) and inverse join
    (``target_column`` references the target row)."""

    table: str
    owner_column: str
    target_column: str


@dataclass
class MappingProperty:
    """One property element of a type or injection: an attribute, a complex attribute (value + qualifier), a complex or
    feature property (join or join table) or a geometry property."""

    tag: str
    path: str
    max_occurs: str | None = None
    min_occurs: str | None = None
    schema: str | None = None
    column: str | None = None
    type: str | None = None
    qualifier: str | None = None
    ref_type: str | None = None
    join: Join | None = None
    condition: bool = False
    join_table: JoinTable | None = None
    inline: list[MappingProperty] | None = None
    ref_column: str | None = None
    inline_column: str | None = None
    geometry_type: str | None = None

    @property
    def multi(self) -> bool:
        return self.max_occurs != "1"

    def require_join(self) -> Join:
        if self.join is None:
            raise ValueError(f"property {self.path} without join")
        return self.join

    def require_join_table(self) -> JoinTable:
        if self.join_table is None:
            raise ValueError(f"property {self.path} without join table")
        return self.join_table

    def require_column(self) -> str:
        if self.column is None:
            raise ValueError(f"no column for {self.path}")
        return self.column


def _join(el: ET.Element | None) -> Join | None:
    if el is None:
        return None
    return Join(el.get("table", ""), el.get("fromColumn", ""), el.get("toColumn", ""), el.get("toRole", ""))


def parse_property(c: ET.Element) -> MappingProperty | None:
    tag = local(c.tag)
    p = MappingProperty(tag, c.get("path", ""), c.get("maxOccurs"), c.get("minOccurs"), c.get("schema"))
    if tag == "attribute":
        p.column, p.type = c.get("column"), c.get("type")
    elif tag == "complexAttribute":
        for a in c:
            if local(a.tag) == "attribute":
                if a.get("path") == ".":
                    p.column, p.type = a.get("column"), a.get("type")
                else:
                    p.qualifier = a.get("column")
    elif tag in ("complexProperty", "featureProperty"):
        p.ref_type = c.get("refType") or c.get("target")
        j = c.find("{*}join")
        if j is not None:
            p.join = _join(j)
            p.condition = j.find("{*}condition") is not None
        jt = c.find("{*}joinTable")
        if jt is not None:
            j, inv = jt.find("{*}join"), jt.find("{*}inverseJoin")
            if j is not None and inv is not None:
                p.join_table = JoinTable(jt.get("table", ""), j.get("fromColumn", ""), inv.get("fromColumn", ""))
        t = c.find("{*}type")
        if t is not None:
            p.inline = [q for q in (parse_property(a) for a in t) if q is not None]
    elif tag == "geometryProperty":
        p.ref_column, p.inline_column, p.geometry_type = c.get("refColumn"), c.get("inlineColumn"), c.get("type")
    else:
        return None
    return p


class MappingType:
    """A ``<complexType>`` or ``<featureType>`` of the mapping: its table, object class id, base and properties."""

    def __init__(self, el: ET.Element) -> None:
        self.id = el.get("id", "")
        self.table = el.get("table", "")
        self.object_class_id = int(el.get("objectClassId", "0"))
        self.path = el.get("path", "")
        self.abstract = el.get("abstract") == "true"
        self.top_level = el.get("topLevel") == "true"
        self.base_id: str | None = None
        self.base_join: Join | None = None
        self.base: MappingType | None = None
        self.props: OrderedDict[str, MappingProperty] = OrderedDict()
        for c in el:
            if local(c.tag) == "extension":
                self.base_id = c.get("base")
                self.base_join = _join(c.find("{*}join"))
            else:
                p = parse_property(c)
                if p is not None:
                    self.props[p.path] = p

    def __repr__(self) -> str:
        return f"MappingType({self.id})"


class MappingInjection:
    """A ``<propertyInjection>``: the hook properties of one CityGML base type in one injection table."""

    def __init__(self, el: ET.Element) -> None:
        self.table = el.get("table", "")
        self.default_base = el.get("defaultBase", "")
        self.props: OrderedDict[str, MappingProperty] = OrderedDict()
        for c in el:
            if local(c.tag) == "join":
                continue
            p = parse_property(c)
            if p is not None:
                self.props[p.path] = p

    def __repr__(self) -> str:
        return f"MappingInjection({self.table})"


@dataclass
class SchemaMapping:
    """The parsed ``schema-mapping.xml``: schema ids by namespace, the types by schema id and the injections."""

    schema_ids: dict[str, str] = field(default_factory=dict)
    """namespace (without trailing slash) -> schema id (``ur_0``, ...)."""
    types: dict[str, OrderedDict[str, MappingType]] = field(default_factory=dict)
    """schema id -> mapping path -> type."""
    injections: list[MappingInjection] = field(default_factory=list)

    def all_types(self) -> list[MappingType]:
        return [mt for types in self.types.values() for mt in types.values()]


def read_mapping(path: Path | str) -> SchemaMapping:
    root = ET.parse(path).getroot()
    mapping = SchemaMapping()
    for sch in root.iter():
        if local(sch.tag) == "schema":
            for ns in sch:
                if local(ns.tag) == "namespace":
                    mapping.schema_ids[(ns.text or "").rstrip("/")] = sch.get("id", "")
    for el in root.iter():
        tag = local(el.tag)
        schema = el.get("schema")
        if tag in ("complexType", "featureType") and schema is not None:
            mt = MappingType(el)
            mapping.types.setdefault(schema, OrderedDict())[mt.path] = mt
        elif tag == "propertyInjection":
            mapping.injections.append(MappingInjection(el))
    all_types = mapping.all_types()
    for mt in all_types:
        mt.base = next((x for x in all_types if x.id == mt.base_id), None) if mt.base_id else None
    return mapping


@dataclass
class Ddl:
    """The tables, columns and sequences of the PostgreSQL ``CREATE_ADE_DB.sql``."""

    tables: OrderedDict[str, list[str]] = field(default_factory=OrderedDict)
    """table -> column names."""
    table_sequence: dict[str, str] = field(default_factory=dict)
    """table -> sequence used as default of its id column."""
    sequences: list[str] = field(default_factory=list)


def read_ddl(path: Path | str) -> Ddl:
    ddl = Ddl()
    text = Path(path).read_text(encoding="utf-8")
    for m in re.finditer(r"^CREATE TABLE (\w+)\n\((.*?)\n\);", text, re.S | re.M):
        cols = []
        for line in m.group(2).splitlines():
            line = line.strip()
            if line and not line.startswith("PRIMARY"):
                cols.append(line.split()[0])
                seq = re.search(r"nextval\('(\w+)'", line)
                if seq:
                    ddl.table_sequence[m.group(1)] = seq.group(1)
        ddl.tables[m.group(1)] = cols
    ddl.sequences = re.findall(r"^CREATE SEQUENCE (\w+)$", text, re.M)
    return ddl
