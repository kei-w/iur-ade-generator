"""Generate the model classes and the JAXB (un)marshallers of iur-ade-citygml4j from the XSD.

Usage: iur-ade gen-citygml4j <citygml4j repo> <citydb repo> <version> <preset: all|phaseA|phaseB|phaseC> [modules: uro,urf]

The generated code follows the style of the hand-written iur-ade classes.
"""

from __future__ import annotations

import logging
import os
import re
import sys
from collections import OrderedDict
from collections.abc import Sequence

from ..errors import GeneratorError
from ..spec import Enum, Hook, Spec, Type, modules_for
from .bind import BindWriter
from .common import SPECIAL_HOOKS, read
from .model import ModelWriter
from .module import ModuleWriter
from .walker import WalkerWriter

log = logging.getLogger(__name__)

PRESETS = {
    "all": None,
    "phaseA": r"(^(bldg|brid|tun|luse|frn|tran|veg|wtr)FacilityAttribute$|DmAttribute$|^ifc|^indoor)",
    "phaseB": r"(DmAttribute$|^ifc|^indoor)",
    "phaseC": r"(^ifc|^indoor)",
}


def select_hooks(spec: Spec, preset: str) -> list[Hook]:
    """The hooks of the specification without those a preset excludes."""
    exclude = PRESETS[preset]
    pat = re.compile(exclude) if exclude else None
    return [h for h in spec.hooks if pat is None or not pat.search(h.element)]


def load_spec(repo: str, citydb: str, version: str, prefixes: Sequence[str]) -> Spec:
    return Spec(
        modules_for(repo, prefixes, version),
        os.path.join(citydb, "resources", "database", "schema-mapping", "schema-mapping.xml"),
        os.path.join(citydb, "resources", "database", "3dcitydb", "postgreSQL", "CREATE_ADE_DB.sql"),
    )


class Generator(ModelWriter, BindWriter, WalkerWriter, ModuleWriter):
    """The citygml4j code of the modules of a specification."""

    def __init__(self, spec: Spec, repo: str, hooks: Sequence[Hook], features: bool = True) -> None:
        self.spec = spec
        self.repo = repo
        self.modules = list(spec.modules.values())
        self.hooks = [h for h in hooks if h.prop_type is not None]
        self.special = [h for h in hooks if h.prop_type is None and h.element in SPECIAL_HOOKS]
        self.features = spec.feature_types() if features else []
        self.types = spec.closure(self.hooks, self.features)
        self.items = self._order()
        self.enums: OrderedDict[str, Enum] = OrderedDict()
        for t in self.types + self.features:
            for f in t.fields:
                if f.kind == "enum":
                    self.enums[f.enum_type.qname] = f.enum_type
                if f.jaxb is None:
                    raise GeneratorError("cannot generate %s.%s (%s)" % (t.name, f.name, f.xsd_type))
            for f in t.dropped:
                log.warning("dropped unsupported field %s.%s (%s)", t.model, f.name, f.xsd_type)
        self.src = os.path.join(repo, "src", "main", "java", "org", "citygml4j", "ade", "iur")
        header_src = read(os.path.join(self.src, "UrbanRevitalizationADEContext.java"))
        self.header = header_src[: header_src.index("*/") + 2]
        self.written = set()
        self.walker_geometry = False

    def _order(self) -> list[Type]:
        """Types and property types in the order used for mapper registrations and methods."""
        items: list[Type] = []
        done: set[str] = set()
        prop_of: dict[str, Type] = {}
        refs: list[Type] = []
        for p in self.spec.property_types(self.types + self.features):
            if p.prop_target is not None:
                prop_of[p.prop_target.qname] = p
            else:
                refs.append(p)  # city object references (urf:target)

        def visit(t: Type) -> None:
            if t.qname in done:
                return
            done.add(t.qname)
            items.append(t)
            for s in t.subtypes:
                visit(s)
            if t.qname in prop_of:
                items.append(prop_of[t.qname])
            for f in t.fields:
                if f.kind in ("property", "inline"):
                    visit(f.nested)

        for h in self.hooks:
            visit(h.nested)
        for t in self.features:
            if t.base is None:
                visit(t)
        return items + refs

    def clean_stale(self) -> None:
        """Remove model and binding files of the generated modules that were not written in this run."""
        for m in self.modules:
            keep = {SPECIAL_HOOKS[h.element] for h in self.special if h.module is m}
            for d in (self.model_dir(m), self.bind_dir(m)):
                for fn in os.listdir(d):
                    path = os.path.join(d, fn)
                    if fn.endswith(".java") and fn[:-5] not in keep and os.path.normcase(path) not in self.written:
                        os.remove(path)
                        log.debug("removed stale %s %s", m.prefix, fn)

    def run(self) -> str:
        """Generates everything; returns a summary line."""
        stale: set[str] = set()
        for m in self.modules:
            d = self.model_dir(m)
            stale |= {fn[:-5] for fn in os.listdir(d) if fn.endswith(".java")} if os.path.isdir(d) else set()
        self.gen_model()
        for m in self.modules:
            self.gen_marshaller(m)
            self.gen_unmarshaller(m)
        self.patch_marshaller_base()
        self.clean_stale()
        generated = {t.model for t in self.types + self.features}
        if self.features:
            self.patch_walkers(stale - generated)
        for m in self.modules:
            if any(t.module is m for t in self.features) or m.prefix != "uro":
                self.patch_module(m)
        self.patch_top_level()
        return "types: %d features: %d hooks: %d enums: %s" % (
            len(self.types),
            len(self.features),
            len(self.hooks),
            [e.qname for e in self.enums.values()],
        )


def generate(repo: str, citydb: str, version: str, preset: str, prefixes: Sequence[str] = ("uro",)) -> str:
    """Generates the citygml4j code of the edition; returns a summary line."""
    spec = load_spec(repo, citydb, version, prefixes)
    return Generator(spec, repo, select_hooks(spec, preset)).run()


def main(argv: list[str] | None = None) -> None:
    argv = sys.argv[1:] if argv is None else list(argv)
    repo, citydb, version, preset = argv[0:4]
    prefixes = argv[4].split(",") if len(argv) > 4 else ["uro"]
    log.info("%s", generate(repo, citydb, version, preset, prefixes))
