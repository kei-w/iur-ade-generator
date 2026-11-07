"""The visit()/apply() methods of the ADE feature types in the hand-written walkers of the fork."""

from __future__ import annotations

import os
import re
from collections.abc import Iterable

from ..errors import GeneratorError
from ..naming import cap, uncap
from ..spec import ABSTRACT_FEATURE_BASES, Field, Hook, Type
from .common import GeneratorBase, read, render_imports, write

WALKERS = (
    ("FeatureWalker", False, False),
    ("GMLWalker", False, True),
    ("FeatureFunctionWalker", True, False),
    ("GMLFunctionWalker", True, True),
)
MARKER = "    // uro feature types (generated)\n"
GEOMETRY_KINDS = ("geometry", "multiSurface", "multiCurve", "multiPoint", "point", "complex")


class WalkerWriter(GeneratorBase):
    ambiguous_models: set[str]
    walked_types: set[str]

    def walker_ref(self, t: Type) -> str:
        """Simple name of a model class, fully qualified when another generated module has a class of the same name
        (urf and urg LandPrice, LandUseDiversion)."""
        return f"{t.module.model_pkg}.{t.model}" if t.model in self.ambiguous_models else t.model

    @staticmethod
    def nested_geometries(f: Field) -> list[Field]:
        """The geometry fields of the data type a property field holds (urt Shape/point -> Point/point)."""
        if f.kind != "property" or f.nested.is_feature:
            return []
        return [x for x in f.nested.fields if x.kind in GEOMETRY_KINDS]

    def walker_steps(self, t: Type, var: str) -> list[tuple[str, str, str]]:
        """(kind, head, argument) of the walker calls for the own fields of a type: feature properties and, in the GML
        walkers, geometries (also those of a nested data type, as in urt Shape/point)."""
        steps = []
        for f in t.fields:
            g = f"{var}.get{cap(f.model_name)}()"
            if f.is_feature_property:
                if f.multi:
                    steps.append(
                        (
                            "loop",
                            f"for ({self.walker_ref(f.property_type)} property : new ArrayList<>({g}))",
                            "(FeatureProperty<?>) property",
                        )
                    )
                else:
                    steps.append(("if", f"if ({g} != null)", f"(FeatureProperty<?>) {g}"))
            elif f.kind in GEOMETRY_KINDS and self.walker_geometry:
                steps.append(("if", f"if ({g} != null)", g))
            elif self.walker_geometry and self.nested_geometries(f):
                for n in self.nested_geometries(f):
                    ng = f"getObject().get{cap(n.model_name)}()"
                    if f.multi:
                        steps.append(
                            (
                                "loop-if",
                                f"for ({self.walker_ref(f.property_type)} property : new ArrayList<>({g}))\n"
                                f"            if (property.getObject() != null && property.{ng} != null)",
                                f"property.{ng}",
                            )
                        )
                    else:
                        steps.append(
                            ("if", f"if ({g} != null && {g}.getObject() != null && {g}.{ng} != null)", f"{g}.{ng}")
                        )
        return steps

    def walker_methods(self, t: Type, function: bool) -> str:
        """visit()/apply() methods of the ADE walkers for a feature type rooted in an abstract citygml4j class, or for
        a data type with feature properties."""
        var = uncap(t.model)
        name = self.walker_ref(t)
        steps = self.walker_steps(t, var)
        if t.base is not None and (t.is_feature or t.base.qname in self.walked_types):
            first = f"(({self.walker_ref(t.base)}) {var})"
            if not steps:
                if function:
                    return f"    public T apply({name} {var}) {{\n        return apply{first};\n    }}\n"
                return f"    public void visit({name} {var}) {{\n        visit{first};\n    }}\n"
            head = f"        T object = apply{first};\n" if function else f"        visit{first};\n"
        elif t.is_feature:
            core = t.feature_base.model.rsplit(".", 1)[1]
            first = f"(({core}) {var})"
            head = f"        T object = walker.apply{first};\n" if function else f"        walker.visit{first};\n"
        else:
            head = ""
        if function:
            # without a base call (data types) every block declares its own variable, the last step returns directly
            body = head + ("        if (object != null)\n            return object;\n" if head else "")
            for i, (_, step_head, arg) in enumerate(steps):
                sep = "" if not head and i == 0 else "\n"
                if not head and i == len(steps) - 1:
                    body += f"{sep}        {step_head}\n            return walker.apply({arg});\n"
                    continue
                body += (
                    f"{sep}        {step_head} {{\n"
                    f"            {'' if head else 'T '}object = walker.apply({arg});\n            if (object != null)\n"
                    f"                return object;\n        }}\n"
                )
            return f"    public T apply({name} {var}) {{\n{body}\n        return null;\n    }}\n"
        body = head
        for i, (_, step_head, arg) in enumerate(steps):
            body += f"{'' if not head and i == 0 else chr(10)}        {step_head}\n            walker.visit({arg});\n"
        return f"    public void visit({name} {var}) {{\n{body}    }}\n"

    def hook_methods(self, h: Hook, function: bool) -> str:
        """visit()/apply() of a hook property element whose data type is walked (urt dataType)."""
        name = h.model_element
        value = "property.getValue().getObject()"
        if function:
            return (
                f"    public T apply({name} property) {{\n"
                f"        return property.isSetValue() && {value} != null ?\n"
                f"                walker.apply({value}) :\n                null;\n    }}\n"
            )
        return (
            f"    public void visit({name} property) {{\n"
            f"        if (property.isSetValue() && {value} != null)\n            walker.visit({value});\n    }}\n"
        )

    def walked_data_types(self) -> list[Type]:
        """Data types with feature properties: the GML walkers visit them (and the hook elements holding them) so that
        their feature references are reached, as the hand-written urt walkers did."""
        return [t for t in self.types if not t.is_feature and any(f.is_feature_property for f in t.fields)]

    def patch_walkers(self, stale_classes: Iterable[str] = ()) -> None:
        """Append the visit()/apply() methods of the ADE feature types to the four hand-written walkers; hand-written
        methods of classes that are generated now (or no longer exist) are removed first."""
        walkable = [t for t in self.features if t.root().core_base in ABSTRACT_FEATURE_BASES]
        data_types = self.walked_data_types()
        self.walked_types = {t.qname for t in data_types}
        hooks = [
            h for h in self.hooks if any(s.qname in self.walked_types for s in [h.nested, *h.nested.descendants()])
        ]
        # the classes the walkers refer to; a simple name shared by two modules is written qualified
        referenced = [*walkable, *data_types, *[t.base for t in walkable if t.base is not None]]
        referenced += [f.property_type for t in walkable + data_types for f in t.fields if f.kind == "property"]
        by_name: dict[str, set[str]] = {}
        for i in referenced:
            by_name.setdefault(i.model, set()).add(i.module.prefix)
        self.ambiguous_models = {n for n, mods in by_name.items() if len(mods) > 1}
        pkgs = [m.model_pkg for m in self.modules]
        remove = set(stale_classes) | {t.model for t in walkable + data_types} | {h.model_element for h in hooks}
        for cls, function, geometry in WALKERS:
            self.walker_geometry = geometry
            p = os.path.join(self.src, "walker", cls + ".java")
            s = read(p)
            if MARKER in s:
                s = s[: s.index(MARKER)].rstrip("\n") + "\n}\n"
            for c in remove:
                s = re.sub(
                    r"\n    public (?:void visit|T apply)\((?:[\w.]+\.)?%s \w+\) \{\n.*?\n    \}\n" % re.escape(c),
                    "\n",
                    s,
                    flags=re.S,
                )
            s = re.sub(r"\n{3,}", "\n\n", s)
            types = walkable + (data_types if geometry else [])
            methods = [self.walker_methods(t, function) for t in types]
            if geometry:
                methods += [self.hook_methods(h, function) for h in hooks]
            imports = {f"{t.module.model_pkg}.{t.model}" for t in types}  # the property types of the loops:
            imports |= {
                f"{f.property_type.module.model_pkg}.{f.property_type.model}"
                for t in types
                for f in t.fields
                if f.multi and (f.is_feature_property or (geometry and self.nested_geometries(f)))
            }
            imports |= {t.feature_base.model for t in walkable}
            if geometry:
                imports |= {f"{h.module.model_pkg}.{h.model_element}" for h in hooks}
            existing = re.findall(r"^import ([\w.*]+);", s, re.M)
            imports |= {i for i in existing if not any(i.startswith(pkg + ".") and not i.endswith("*") for pkg in pkgs)}
            imports -= {f"{m.model_pkg}.*" for m in self.modules if m.prefix != "uro"}
            imports -= {f"{m.model_pkg}.{n}" for m in self.modules for n in self.ambiguous_models}
            all_imports = list(re.finditer(r"^import .*;\n", s, re.M))
            if not all_imports:
                raise GeneratorError(f"{p} has no imports")
            first, last = all_imports[0].start(), all_imports[-1].end()
            s = s[:first] + render_imports(imports) + "\n" + s[last:]
            s = s.rstrip("\n")
            if not s.endswith("}"):
                raise GeneratorError(f"{p} does not end with a class body")
            s = s[:-1].rstrip("\n") + "\n\n" + MARKER + "\n".join(methods) + "}\n"
            write(p, s)
