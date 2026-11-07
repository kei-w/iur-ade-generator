"""Reads the types, enumerations, elements and hooks of a module from its XSD."""

from __future__ import annotations

import xml.etree.ElementTree as ET
from collections import OrderedDict

from .model import Enum, Field, Hook, Module, Type, split_ref

XS = "{http://www.w3.org/2001/XMLSchema}"


def local(tag: str) -> str:
    return tag.split("}")[-1]


def target_namespace(xsd_path: str) -> str:
    return ET.parse(xsd_path).getroot().get("targetNamespace", "")


def _fields(t: Type, container: ET.Element, in_choice: bool) -> list[str]:
    """Collects the elements of a sequence or choice into the fields of ``t``; returns their names."""
    names: list[str] = []
    for e in container:
        tag = local(e.tag)
        if tag == "element":
            name = e.get("name")
            if name:
                t.fields.append(
                    Field(
                        name,
                        e.get("type", ""),
                        required=("0" if in_choice else e.get("minOccurs", "1")) != "0",
                        multi=e.get("maxOccurs", "1") != "1",
                    )
                )
                names.append(name)
            elif e.get("ref") and t.is_property:
                t.prop_target_ref = e.get("ref")
        elif tag in ("sequence", "choice"):
            inner = _fields(t, e, in_choice or tag == "choice")
            if tag == "choice":
                t.choice_groups.append(inner)
            names.extend(inner)
    return names


def read_xsd(m: Module) -> None:
    """Fills the enumerations, types, elements and hooks of the module from its XSD."""
    root = ET.parse(m.xsd_path).getroot()
    for st in root.findall(XS + "simpleType"):
        values = list(OrderedDict.fromkeys(e.get("value", "") for e in st.iter(XS + "enumeration")))
        if values:
            m.enums[st.get("name", "")] = Enum(st.get("name", ""), values, m)
    for ct in root.findall(XS + "complexType"):
        t = Type(ct.get("name", ""), m)
        t.abstract = ct.get("abstract") == "true"
        for ext in ct.iter(XS + "extension"):
            t.base_name = ext.get("base")
            break
        top = next((c for c in ct.iter() if local(c.tag) in ("sequence", "choice")), None)
        if top is not None:
            t.choice = local(top.tag) == "choice"
            names = _fields(t, top, t.choice)
            if t.choice:
                t.choice_groups.append(names)
        m.types[t.name] = t
    for e in root.findall(XS + "element"):
        name, tname, sg = e.get("name", ""), e.get("type"), e.get("substitutionGroup") or ""
        if tname and split_ref(tname)[0] == m.prefix:
            m.elements[name] = split_ref(tname)[1]
            if e.get("abstract") == "true" and split_ref(tname)[1] in m.types:
                m.types[split_ref(tname)[1]].abstract = True  # abstract element: never instantiated
        if "_GenericApplicationPropertyOf" in sg:
            h = Hook(name, sg.split("_GenericApplicationPropertyOf")[1], m)
            h.prefix = sg.split(":")[0]
            h.xsd_type = tname
            m.hooks.append(h)
