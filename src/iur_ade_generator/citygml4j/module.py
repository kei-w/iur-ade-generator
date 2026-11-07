"""The ADEModule class of a module: namespace, JAXB package, feature types and feature properties."""

from __future__ import annotations

import os

from ..spec import XSD_FILES, Module
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
            | {h.element for h in self.feature_hooks if h.module is module}
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
        text = f"""{self.header}

package org.citygml4j.ade.iur.model.module;

{render_imports(imports)}

public class {module.module_class} extends ADEModule {{
    public static final {module.module_class} {version} = new {module.module_class}();

    private final Map<String, Class<? extends AbstractFeature>> features;

    private {module.module_class}() {{
{super_call}
        features = new HashMap<>();
{puts}    }}

    @Override
    public URL getSchemaResource() {{
        return {module.module_class}.class.getResource("/org/citygml4j/ade/iur/schema/{XSD_FILES[module.prefix]}");
    }}

    @Override
    public List<String> getJAXBPackageNames() {{
        return Collections.singletonList("{jaxb}");
    }}

    public String getModelPackageName() {{
        return "{module.model_pkg}";
    }}

    @Override
    public boolean hasFeatureProperty(String name) {{
        return {prop_test};
    }}

    @Override
    public boolean hasFeature(String name) {{
        return features.containsKey(name);
    }}

    @Override
    public Class<? extends AbstractFeature> getFeatureClass(String name) {{
        return features.get(name);
    }}

    @Override
    public QName getFeatureName(Class<? extends AbstractFeature> featureClass) {{
        for (Map.Entry<String, Class<? extends AbstractFeature>> entry : features.entrySet()) {{
            if (entry.getValue() == featureClass)
                return new QName(getNamespaceURI(), entry.getKey());
        }}

        return null;
    }}

    @Override
    public Map<String, Class<? extends AbstractFeature>> getFeatures() {{
        return new HashMap<>(features);
    }}

    @Override
    public boolean isTopLevelFeature(String name) {{
        return {top_test};
    }}
}}
"""
        write(p, text)
