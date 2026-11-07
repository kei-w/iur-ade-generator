"""Naming helpers shared by the generators: Java identifiers, SQL identifiers and unique names."""

from __future__ import annotations

import re
from collections.abc import Iterable

# Java keywords that occur as XSD element names; the model accessors get a "Value" suffix
JAVA_KEYWORDS = {
    "class",
    "default",
    "package",
    "new",
    "public",
    "private",
    "static",
    "final",
    "import",
    "switch",
    "case",
}
MODEL_FIELD_NAMES = {"class": "classifier"}
# fields of feature types whose accessor would clash with one inherited from the base class; the JAXB property is
# renamed alike in binding.xjb (otherwise ade-xjc binds the whole content model as a generic "rest" list)
FEATURE_FIELD_NAMES = {"id": "identifier", "boundedBy": "boundedBySurface", "location": "locationDescription"}

# SQL reserved words (PostgreSQL and Oracle) that get a trailing underscore as column names, as the ADE Manager does
RESERVED = set(
    [
        "id",
        "objectclass_id",
        "access",
        "add",
        "all",
        "alter",
        "analyze",
        "and",
        "any",
        "array",
        "as",
        "asc",
        "audit",
        "authorization",
        "between",
        "binary",
        "both",
        "by",
        "case",
        "cast",
        "char",
        "check",
        "cluster",
        "collate",
        "column",
        "comment",
        "compress",
        "concurrently",
        "connect",
        "constraint",
        "create",
        "cross",
        "current",
        "date",
        "decimal",
        "default",
        "delete",
        "desc",
        "distinct",
        "do",
        "drop",
        "else",
        "end",
        "except",
        "exclusive",
        "exists",
        "false",
        "fetch",
        "file",
        "float",
        "for",
        "freeze",
        "from",
        "full",
        "grant",
        "group",
        "having",
        "identified",
        "ilike",
        "immediate",
        "in",
        "increment",
        "index",
        "initial",
        "inner",
        "insert",
        "integer",
        "intersect",
        "into",
        "is",
        "isnull",
        "join",
        "lateral",
        "leading",
        "left",
        "level",
        "like",
        "limit",
        "localtime",
        "lock",
        "long",
        "minus",
        "mode",
        "modify",
        "natural",
        "noaudit",
        "nocompress",
        "not",
        "notnull",
        "nowait",
        "null",
        "number",
        "of",
        "offline",
        "offset",
        "on",
        "online",
        "only",
        "option",
        "or",
        "order",
        "outer",
        "overlaps",
        "pctfree",
        "placing",
        "primary",
        "prior",
        "public",
        "raw",
        "references",
        "rename",
        "resource",
        "returning",
        "revoke",
        "right",
        "row",
        "rowid",
        "rownum",
        "rows",
        "select",
        "session",
        "set",
        "share",
        "similar",
        "size",
        "smallint",
        "some",
        "start",
        "successful",
        "symmetric",
        "synonym",
        "sysdate",
        "table",
        "tablesample",
        "then",
        "to",
        "trailing",
        "trigger",
        "true",
        "uid",
        "union",
        "unique",
        "update",
        "user",
        "using",
        "validate",
        "values",
        "varchar",
        "varchar2",
        "variadic",
        "verbose",
        "view",
        "when",
        "whenever",
        "where",
        "window",
        "with",
    ]
)


def cap(s: str) -> str:
    return s[0].upper() + s[1:]


def uncap(s: str) -> str:
    return s[0].lower() + s[1:]


def norm(name: str) -> str:
    """Case- and punctuation-insensitive key of a name (to match XSD element names with JAXB property names)."""
    return re.sub(r"[^a-z0-9]", "", name.lower())


def java_name(name: str) -> str:
    """Java identifier of an XSD element name: "lod-1MultiSurface" -> "lodMinus1MultiSurface"."""
    return re.sub(r"[^A-Za-z0-9_]", "", re.sub(r"^lod-(\d)", r"lodMinus\1", name))


def model_field(name: str, feature: bool = False) -> str:
    """Name of the model accessor of an XSD element: feature fields clashing with inherited accessors are renamed, Java
    keywords get a suffix."""
    name = java_name(name)
    if feature and name in FEATURE_FIELD_NAMES:
        return FEATURE_FIELD_NAMES[name]
    return MODEL_FIELD_NAMES.get(name, name + "Value" if name in JAVA_KEYWORDS else name)


def sql_name(name: str) -> str:
    return re.sub(r"[^a-z0-9_]", "_", name.lower())


def words(name: str) -> str:
    """Lower-case words of a camel-case name: "DataQualityAttribute" -> "data quality attribute"."""
    return re.sub(r"(?<!^)(?=[A-Z])", " ", name).lower()


def unique(base: str, limit: int, taken: set[str]) -> str:
    """``base`` cut to ``limit`` characters, numbered (``_2``, ``_3``, ...) while it is taken; the result is added to
    ``taken``."""
    name = base[:limit]
    n = 1
    while name in taken:
        n += 1
        suffix = "_%d" % n
        name = base[: limit - len(suffix)] + suffix
    taken.add(name)
    return name


class Names:
    """Unique SQL identifiers (tables, columns per table, constraints and indexes, sequences)."""

    def __init__(self, taken: Iterable[str]) -> None:
        self.taken = set(taken)

    def unique(self, base: str, limit: int, taken: set[str] | None = None) -> str:
        return unique(base, limit, self.taken if taken is None else taken)
