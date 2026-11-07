"""Reading and editing the schema mapping and DDL resources of the citydb fork (the ADE Manager's file layout)."""

from __future__ import annotations

import re
from collections.abc import Collection, Iterable
from pathlib import Path

from ..naming import unique

PG = "resources/database/3dcitydb/postgreSQL/CREATE_ADE_DB.sql"
PG_DROP = "resources/database/3dcitydb/postgreSQL/DROP_ADE_DB.sql"
ORA = "resources/database/3dcitydb/oracle/CREATE_ADE_DB.sql"
ORA_DROP = "resources/database/3dcitydb/oracle/DROP_ADE_DB.sql"
MAP = "resources/database/schema-mapping/schema-mapping.xml"
# (create script, drop script, PostgreSQL?) of both database systems
DDL_FILES = ((PG, PG_DROP, True), (ORA, ORA_DROP, False))

NAME_LEN = 30
HEADER = (
    "-- -------------------------------------------------------------------- \n-- %s \n"
    "-- -------------------------------------------------------------------- \n"
)
PG_INDEX = "CREATE INDEX %s ON %s\n    USING btree\n    (\n      %s ASC NULLS LAST\n    )   WITH (FILLFACTOR = 90);\n\n"
ORA_INDEX = "CREATE INDEX %s ON %s (%s);\n\n"
PG_INDEX_RE = (
    r"CREATE INDEX \w+ ON %s\n    USING btree\n    \(\n      %s ASC NULLS LAST\n    \)   WITH \(FILLFACTOR = 90\);\n\n"
)
ORA_INDEX_RE = r"CREATE INDEX \w+ ON %s \(%s\);\n\n"


def read(path: Path | str) -> str:
    return Path(path).read_text(encoding="utf-8")


def write(path: Path | str, text: str) -> None:
    Path(path).write_text(text, encoding="utf-8", newline="\n")


def header(name: str) -> str:
    return HEADER % name


def id_type(pg: bool) -> str:
    return "BIGINT" if pg else "NUMBER(38)"


def index(pg: bool, name: str, table: str, column: str) -> str:
    return (PG_INDEX if pg else ORA_INDEX) % (name, table, column)


def index_pattern(pg: bool, table: str, column: str) -> str:
    return (PG_INDEX_RE if pg else ORA_INDEX_RE) % (table, column)


def table_body(ddl: str, table: str) -> re.Match[str]:
    """The match of ``CREATE TABLE <table> (...)``; group 1 is the column list."""
    m = re.search(r"^CREATE TABLE %s\n\((.*?)\n\);" % table, ddl, re.S | re.M)
    if m is None:
        raise ValueError(f"table {table} not found in the DDL")
    return m


def append_to_section(text: str, title: str, block: str) -> str:
    """Append a block at the end of the DDL section with the given title (before the next section header)."""
    m = re.search(r"-- \*+ %s \*+ \n-- \++ \n\n?" % re.escape(title), text)
    if m is None:
        raise ValueError(f"section {title} not found in the DDL")
    nxt = re.search(r"\n-- \+{10,}", text[m.end() :])
    pos = m.end() + nxt.start() + 1 if nxt else len(text)
    return text[:pos] + block + text[pos:]


def add_column(ddl: str, table: str, column: str, pg: bool, column_type: str | None = None) -> str:
    """Insert an id column before the primary key of the table (if not there yet)."""
    m = table_body(ddl, table)
    if re.search(r"^\s+%s\s" % column, m.group(1), re.M):
        return ddl
    ctype = column_type or ("BIGINT" if pg else "NUMBER")
    new_body = m.group(1).replace("    PRIMARY KEY (id)", "    %s %s,\n    PRIMARY KEY (id)" % (column, ctype))
    return ddl[: m.start(1)] + new_body + ddl[m.end(1) :]


def join_table_ddl(
    ddl: str,
    pg: bool,
    target: str,
    column: str,
    jt: str,
    owner: str,
    owner_col: str,
    target_col: str,
    taken_names: set[str],
) -> str:
    """Move a 1:n foreign key column of the target table into a join table: column, constraint and index removed,
    the join table with its constraints and indexes appended to the sections of the DDL."""
    m = table_body(ddl, target)
    body = re.sub(r"^    %s \w[^\n]*,\n" % column, "", m.group(1), flags=re.M)
    ddl = ddl[: m.start(1)] + body + ddl[m.end(1) :]
    ddl = re.sub(
        r"ALTER TABLE %s ADD CONSTRAINT \w+ FOREIGN KEY \(%s\)\nREFERENCES \w+ \(id\)[^;]*;\n\n" % (target, column),
        "",
        ddl,
    )
    ddl = re.sub(index_pattern(True, target, column), "", ddl)
    ddl = re.sub(index_pattern(False, target, column), "", ddl)
    idt = id_type(pg)
    table = header(
        jt
    ) + "CREATE TABLE %s\n(\n    %s %s NOT NULL,\n    %s %s NOT NULL,\n    PRIMARY KEY (%s, %s)\n);\n\n" % (
        jt,
        target_col,
        idt,
        owner_col,
        idt,
        target_col,
        owner_col,
    )
    fk1 = unique("%s_%s_fk" % (jt[:12], target_col[:11]), NAME_LEN, taken_names)
    fk2 = unique("%s_%s_fk" % (jt[:12], owner_col[:11]), NAME_LEN, taken_names)
    fks = header(jt) + (
        "ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (%s)\nREFERENCES %s (id)\nON DELETE CASCADE;\n\n"
        % (jt, fk1, target_col, target)
        + "ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (%s)\nREFERENCES %s (id)\nON DELETE CASCADE;\n\n"
        % (jt, fk2, owner_col, owner)
    )
    idxs = header(jt)
    for col in (target_col, owner_col):
        name = unique("%s_%s_fkx" % (jt[:12], col[:10]), NAME_LEN, taken_names)
        idxs += index(pg, name, jt, col)
    ddl = append_to_section(ddl, "Create tables", table)
    ddl = append_to_section(ddl, "Create foreign keys", fks)
    ddl = append_to_section(ddl, "Create Indexes", idxs)
    return ddl


def injection_table_ddl(ddl: str, pg: bool, new_table: str, moved: Iterable[tuple[str, str, list[str]]]) -> str:
    """Create an injection table for the moved hook columns: the columns, their foreign keys and indexes leave the
    previous injection table."""
    idt = id_type(pg)
    col_lines, fks, idxs = [], "", ""
    for _, old_table, columns in moved:
        for col in columns:
            m = table_body(ddl, old_table)
            line = re.search(r"^    %s \w[^\n]*,\n" % col, m.group(1), re.M)
            if line is None:
                raise ValueError(f"column {col} not found in {old_table}")
            col_lines.append(line.group(0).rstrip("\n"))
            ddl = ddl[: m.start(1)] + m.group(1).replace(line.group(0), "") + ddl[m.end(1) :]
            fk = re.search(
                r"ALTER TABLE %s ADD CONSTRAINT (\w+) FOREIGN KEY \(%s\)\n(REFERENCES \w+ \(id\)[^;]*;)\n\n"
                % (old_table, col),
                ddl,
            )
            if fk:
                ddl = ddl.replace(fk.group(0), "")
                fks += "ALTER TABLE %s ADD CONSTRAINT %s FOREIGN KEY (%s)\n%s\n\n" % (
                    new_table,
                    "%s_%s_fk" % (new_table[:12], col[:11]),
                    col,
                    fk.group(2),
                )
            idx = re.search(index_pattern(pg, old_table, col), ddl)
            if idx:
                ddl = ddl.replace(idx.group(0), "")
                idxs += index(pg, "%s_%s_fkx" % (new_table[:12], col[:10]), new_table, col)
    table = header(new_table) + "CREATE TABLE %s\n(\n    id %s NOT NULL,\n%s\n    PRIMARY KEY (id)\n);\n\n" % (
        new_table,
        idt,
        "\n".join(col_lines),
    )
    fks = (
        header(new_table)
        + "ALTER TABLE %s ADD CONSTRAINT %s_fk FOREIGN KEY (id)\nREFERENCES cityobject (id)\nON DELETE CASCADE;\n\n"
        % (new_table, new_table)
        + fks
    )
    ddl = append_to_section(ddl, "Create tables", table)
    ddl = append_to_section(ddl, "Create foreign keys", fks)
    if idxs:
        ddl = append_to_section(ddl, "Create Indexes", header(new_table) + idxs)
    return ddl


def sync_drop_script(drop: str, create: str) -> str:
    """Rebuild the foreign key and table sections of a DROP script from the CREATE script."""
    fks: dict[str, list[str]] = {}
    for m in re.finditer(r"ALTER TABLE (\w+) ADD CONSTRAINT (\w+) FOREIGN KEY", create):
        fks.setdefault(m.group(1), []).append(m.group(2))
    fk_text = "".join(
        header(t) + "".join("ALTER TABLE %s\n    DROP CONSTRAINT %s;\n\n" % (t, c) for c in cs)
        for t, cs in sorted(fks.items())
    )
    tables = sorted(set(re.findall(r"^CREATE TABLE (\w+)$", create, re.M)))
    table_text = "".join(header(t) + "DROP TABLE %s;\n\n" % t for t in tables)
    a = _end(drop, r"-- \*+ Drop foreign keys \*+ \n-- \++ \n")
    b = _start(drop, r"-- \++ \n-- \*+ Drop tables")
    drop = drop[:a] + fk_text + drop[b:]
    a = _end(drop, r"-- \*+ Drop tables \*+ \n-- \++ \n")
    b = _start(drop, r"-- \++ \n-- \*+ Drop Sequences")
    return drop[:a] + table_text + drop[b:]


def _end(text: str, pattern: str) -> int:
    m = re.search(pattern, text)
    if m is None:
        raise ValueError(f"{pattern!r} not found in the DROP script")
    return m.end()


def _start(text: str, pattern: str) -> int:
    m = re.search(pattern, text)
    if m is None:
        raise ValueError(f"{pattern!r} not found in the DROP script")
    return m.start()


def remove_blocks(text: str, tables: set[str], sequences: set[str]) -> str:
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


def remove_foreign_columns(create: str, drop: str, tables: set[str], keep: Collection[str] = ()) -> tuple[str, str]:
    """Drop the foreign key columns (with their constraints and indexes) that tables of other modules hold for the given
    (previous) tables of the module; the tables in ``keep`` are left alone."""
    for m in re.finditer(
        r"ALTER TABLE (\w+) ADD CONSTRAINT (\w+) FOREIGN KEY \((\w+)\)\nREFERENCES (\w+) \(id\)[^;]*;\n\n", create
    ):
        table, constraint, column, ref = m.groups()
        if ref not in tables or table in tables or table in keep:
            continue
        create = create.replace(m.group(0), "")
        create = re.sub(r"^    %s \w+[^\n]*,\n" % column, "", create, flags=re.M)
        create = re.sub(index_pattern(True, table, column), "", create)
        create = re.sub(index_pattern(False, table, column), "", create)
        drop = drop.replace("ALTER TABLE %s\n    DROP CONSTRAINT %s;\n\n" % (table, constraint), "")
    return create, drop


def add_foreign_columns(create: str, columns: Iterable[tuple[str, str, str]], pg: bool) -> str:
    for table, column, _ in columns:
        create = add_column(create, table, column, pg, id_type(pg))
    return create
