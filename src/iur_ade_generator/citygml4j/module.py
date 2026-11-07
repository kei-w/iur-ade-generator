"""The ADEModule class of a module: namespace, JAXB package, feature types and feature properties."""

from __future__ import annotations

import os

from ..spec import XSD_FILES, Module
from ..templates import render
from .common import GeneratorBase, render_imports, write


class ModuleWriter(GeneratorBase):
    def patch_module(self, module: Module) -> None:
        """Write the ADEModule class of a module: namespace, JAXB package, feature types and feature properties."""
        p = os.path.join(self.src, "model", "module", module.module_class + ".java")
        features = [t for t in self.features if t.module is module]
        concrete = [t for t in features if not t.abstract]
        puts = "".join(f'        features.put("{t.element}", {t.model}.class);\n' for t in concrete)
        props = sorted(
            {f.name for t in features for f in t.fields if f.is_feature_property or f.kind == "cityObjectRef"}
        )
        top = sorted(t.element_name for t in concrete if t.top_level)
        prop_test = " || ".join(f'"{n}".equals(name)' for n in props) or "false"
        top_test = " || ".join(f'"{n}".equals(name)' for n in top) or "false"
        version, jaxb = module.version_const, module.jaxb_pkg
        super_call = (
            f'        super("{module.namespace}",\n                "{module.prefix}",\n'
            f'                "{module.schema_url}",\n                CityGMLVersion.v2_0_0);\n'
        )
        imports = {f"{module.model_pkg}.{t.model}" for t in concrete}
        imports |= {
            "org.citygml4j.model.gml.feature.AbstractFeature",
            "org.citygml4j.model.module.ade.ADEModule",
            "org.citygml4j.model.module.citygml.CityGMLVersion",
            "javax.xml.namespace.QName",
            "java.net.URL",
            "java.util.Collections",
            "java.util.HashMap",
            "java.util.List",
            "java.util.Map",
        }
        text = render(
            "citygml4j/module.java.j2",
            header=self.header,
            imports=render_imports(imports),
            name=module.module_class,
            version=version,
            super_call=super_call,
            puts=puts,
            xsd=XSD_FILES[module.prefix],
            jaxb=jaxb,
            model_pkg=module.model_pkg,
            prop_test=prop_test,
            top_test=top_test,
        )
        write(p, text)
