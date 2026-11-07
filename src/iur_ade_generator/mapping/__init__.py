"""The 3DCityDB schema mapping and DDL of the forks: the fixes of the ADE Manager output (``patch``) and the generated
mapping of the modules the ADE Manager cannot transform (``generate``)."""

from . import ddl, generate, patch

__all__ = ["ddl", "generate", "patch"]
