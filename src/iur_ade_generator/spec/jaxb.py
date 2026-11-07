"""Reads the accessors of the ade-xjc generated JAXB classes (exact property names and types)."""

from __future__ import annotations

import os
import re

from ..naming import norm
from .model import JaxbProperty, Module, Type

FACTORY_METHOD = re.compile(
    r'@XmlElementDecl\(namespace = "[^"]*", name = "([^"]+)"[^)]*\)\s*public JAXBElement<[^>]+> (create\w+)\('
)
GETTER = re.compile(r"public ([\w.<>?, ]+?) ((?:get|is)[A-Z_]\w*)\(\)")
SETTER = re.compile(r"public void (set[A-Z_]\w*)\(([\w.<>?, ]+?) value\)")


def read_jaxb(m: Module) -> None:
    """Records the JAXB classes of the module and the element factory methods of its ObjectFactory."""
    for fn in os.listdir(m.jaxb_dir):
        if fn.endswith(".java"):
            m.jaxb_classes.add(fn[:-5])
    with open(os.path.join(m.jaxb_dir, "ObjectFactory.java"), encoding="utf-8") as f:
        src = f.read()
    for mm in FACTORY_METHOD.finditer(src):
        m.factory[mm.group(1)] = mm.group(2)


def jaxb_properties(t: Type) -> dict[str, JaxbProperty]:
    """Parses the accessors of the generated JAXB class of a type: normalized property name -> JaxbProperty."""
    with open(os.path.join(t.module.jaxb_dir, t.name + ".java"), encoding="utf-8") as f:
        src = f.read()
    props: dict[str, JaxbProperty] = {}
    for m in GETTER.finditer(src):
        jtype, getter = m.group(1), m.group(2)
        if getter.startswith("isSet"):
            continue
        prop = getter[3:] if getter.startswith("get") else getter[2:]
        props[norm(prop)] = JaxbProperty(
            getter,
            None,
            jtype,
            jtype.startswith("List<"),
            jtype.startswith("JAXBElement<"),
            jtype in ("double", "boolean", "int", "long"),
        )
    for m in SETTER.finditer(src):
        prop = m.group(1)[3:]
        if norm(prop) in props:
            props[norm(prop)].setter = m.group(1)
    return props
