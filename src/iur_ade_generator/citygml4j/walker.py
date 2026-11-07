"""The visit()/apply() methods of the ADE feature types in the hand-written walkers of the fork."""

from __future__ import annotations

import os
import re
from collections.abc import Iterable

from ..errors import GeneratorError
from ..naming import cap, uncap
from ..spec import ABSTRACT_FEATURE_BASES, Type
from .common import GeneratorBase, read, render_imports, write

WALKERS = (
    ("FeatureWalker", False, False),
    ("GMLWalker", False, True),
    ("FeatureFunctionWalker", True, False),
    ("GMLFunctionWalker", True, True),
)
MARKER = "    // uro feature types (generated)\n"


class WalkerWriter(GeneratorBase):
    def walker_methods(self, t: Type, function: bool) -> str:
        """visit()/apply() methods of the ADE walkers for a feature type rooted in an abstract citygml4j class."""
        var = uncap(t.model)
        core = t.feature_base.model.rsplit(".", 1)[1]
        if t.base is not None:
            if function:
                return (
                    f"    public T apply({t.model} {var}) {{\n        return apply(({t.base.model}) {var});\n    }}\n"
                )
            return f"    public void visit({t.model} {var}) {{\n        visit(({t.base.model}) {var});\n    }}\n"
        steps = []
        for f in t.fields:
            g = f"{var}.get{cap(f.model_name)}()"
            if f.is_feature_property:
                if f.multi:
                    steps.append(
                        (
                            "loop",
                            f"for ({f.property_type.model} property : new ArrayList<>({g}))",
                            "(FeatureProperty<?>) property",
                        )
                    )
                else:
                    steps.append(("if", f"if ({g} != null)", f"(FeatureProperty<?>) {g}"))
            elif (
                f.kind in ("geometry", "multiSurface", "multiCurve", "multiPoint", "point", "complex")
                and self.walker_geometry
            ):
                steps.append(("if", f"if ({g} != null)", g))
        if function:
            body = (
                f"        T object = walker.apply(({core}) {var});\n        if (object != null)\n"
                f"            return object;\n"
            )
            for _, head, arg in steps:
                body += (
                    f"\n        {head} {{\n            object = walker.apply({arg});\n            if (object != null)\n"
                    f"                return object;\n        }}\n"
                )
            return f"    public T apply({t.model} {var}) {{\n{body}\n        return null;\n    }}\n"
        body = f"        walker.visit(({core}) {var});\n"
        for _, head, arg in steps:
            body += f"\n        {head}\n            walker.visit({arg});\n"
        return f"    public void visit({t.model} {var}) {{\n{body}    }}\n"

    def patch_walkers(self, stale_classes: Iterable[str] = ()) -> None:
        """Append the visit()/apply() methods of the ADE feature types to the four hand-written walkers; hand-written
        methods of classes that are generated now (or no longer exist) are removed first."""
        walkable = [t for t in self.features if t.root().core_base in ABSTRACT_FEATURE_BASES]
        pkgs = [m.model_pkg for m in self.modules]
        remove = set(stale_classes) | {t.model for t in walkable}
        for cls, function, geometry in WALKERS:
            self.walker_geometry = geometry
            p = os.path.join(self.src, "walker", cls + ".java")
            s = read(p)
            if MARKER in s:
                s = s[: s.index(MARKER)].rstrip("\n") + "\n}\n"
            for c in remove:
                s = re.sub(
                    r"\n    public (?:void visit|T apply)\(%s \w+\) \{\n.*?\n    \}\n" % re.escape(c),
                    "\n",
                    s,
                    flags=re.S,
                )
            s = re.sub(r"\n{3,}", "\n\n", s)
            methods = "\n".join(self.walker_methods(t, function) for t in walkable)
            imports = {f"{t.module.model_pkg}.{t.model}" for t in walkable}
            imports |= {
                f"{f.property_type.module.model_pkg}.{f.property_type.model}"
                for t in walkable
                for f in t.fields
                if f.is_feature_property
            }
            imports |= {t.feature_base.model for t in walkable}
            existing = re.findall(r"^import ([\w.*]+);", s, re.M)
            imports |= {i for i in existing if not any(i.startswith(pkg + ".") and not i.endswith("*") for pkg in pkgs)}
            imports -= {f"{m.model_pkg}.*" for m in self.modules if m.prefix != "uro"}
            all_imports = list(re.finditer(r"^import .*;\n", s, re.M))
            if not all_imports:
                raise GeneratorError(f"{p} has no imports")
            first, last = all_imports[0].start(), all_imports[-1].end()
            s = s[:first] + render_imports(imports) + "\n" + s[last:]
            s = s.rstrip("\n")
            if not s.endswith("}"):
                raise GeneratorError(f"{p} does not end with a class body")
            s = s[:-1].rstrip("\n") + "\n\n" + MARKER + methods + "}\n"
            write(p, s)
