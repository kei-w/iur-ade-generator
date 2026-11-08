"""Semantic comparison of CityGML city objects between two files (original vs. round trip).

Usage: iur-ade compare ORIGINAL.gml ROUNDTRIP.gml [--ignore-creation-date] [--db] [--subset] [--keep-envelope]

Two comparisons are made for every top-level city object (matched by gml:id):

1. ADE content (any namespace outside CityGML/GML/xlink/xsi/xAL): every ADE property is
   compared strictly (attributes such as codeSpace/uom, text, nesting, repetition). The
   order of repeated properties of the same name is significant; the order between
   properties of different names is not (the CityGML schema allows any order for
   generic application properties), it is only reported as a count.
2. Standard CityGML content: compared after normalisation. With --db the known
   Importer/Exporter round-trip differences are neutralised: generated gml:id
   values are stripped, per-feature gml:boundedBy is ignored (bldg:boundedBy and the like,
   the thematic surfaces, are compared as a multiset), srsName /
   srsDimension attributes are ignored, the members of a surface aggregate
   (gml:CompositeSurface / gml:MultiSurface) and the generic attributes (gen:*)
   are compared as multisets because the exporter does not preserve their order.
   Coordinates are still compared numerically.
   With --subset, city objects that exist only in the roundtrip file are ignored.
   With --keep-envelope (with --db), the gml:boundedBy of the city objects is compared
   too, and a gml:boundedBy of the core:CityModel of the original must be present in
   the roundtrip (its extent is reported, not compared: an export of several files
   covers all of them).

Numbers in text (including posList) are compared as decimals so "4.0" == "4".
Whitespace-only text is ignored. Exit code 1 on any difference.
"""

from __future__ import annotations

import sys
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict
from collections.abc import Iterator, Sequence
from dataclasses import dataclass, field
from decimal import Decimal, InvalidOperation

GML = "http://www.opengis.net/gml"
ENVELOPE = f"{{{GML}}}boundedBy"
XLINK = "http://www.w3.org/1999/xlink"
# GML array properties (curveMembers) the Importer/Exporter writes as repeated single properties (curveMember)
ARRAY_PROPERTIES = {"curveMembers", "surfaceMembers", "pointMembers", "solidMembers"}
GROUP = "http://www.opengis.net/citygml/cityobjectgroup/2.0"
CORE = "http://www.opengis.net/citygml/2.0"
GENERICS = "http://www.opengis.net/citygml/generics/2.0"
STD_NS_PREFIXES = (
    "http://www.opengis.net/citygml/",
    "http://www.opengis.net/gml",
    "http://www.w3.org/1999/xlink",
    "http://www.w3.org/2001/XMLSchema-instance",
    "urn:oasis:names:tc:ciq:xsdschema:xAL:2.0",
)

type Canon = tuple[str, tuple[tuple[str, str], ...], str, tuple[Canon, ...]]
"""The canonical form of an element: (tag, sorted attributes, normalised text, children)."""


@dataclass
class Options:
    """The command line options."""

    ignore_elements: set[str] = field(default_factory=set)
    ignore_attributes: set[str] = field(default_factory=set)
    strip_ids: bool = False
    geometries: dict[str, ET.Element] = field(default_factory=dict)
    """gml:id -> GML element of the file being canonicalised (--db: xlinks to geometries are resolved)."""
    unordered: set[str] = field(default_factory=set)
    """Elements whose children are compared as multisets."""
    unordered_generics: bool = False
    subset: bool = False
    keep_envelope: bool = False

    @classmethod
    def parse(cls, argv: Sequence[str]) -> Options:
        o = cls()
        if "--ignore-creation-date" in argv:
            o.ignore_elements.add("creationDate")
        if "--db" in argv:
            # gml:boundedBy only: bldg:boundedBy etc. hold the thematic surfaces
            o.ignore_elements.update({"creationDate", ENVELOPE})
            o.ignore_attributes.update({"srsName", "srsDimension"})
            o.strip_ids = True
            # nested features (rooms, installations, ...) are exported in database order
            o.unordered.update({"CompositeSurface", "MultiSurface", "Building", "UndergroundBuilding"})
            o.unordered_generics = True
        if "--subset" in argv:
            o.subset = True
        if "--keep-envelope" in argv:
            o.keep_envelope = True
            o.ignore_elements.discard(ENVELOPE)
        return o


def ns_of(tag: str) -> str:
    return tag[1:].split("}")[0] if tag.startswith("{") else ""


def local(tag: str) -> str:
    return tag.split("}")[-1]


def is_ade(tag: str) -> bool:
    ns = ns_of(tag)
    return bool(ns) and not any(ns.startswith(p) for p in STD_NS_PREFIXES)


def norm_token(t: str) -> str:
    try:
        return str(Decimal(t).normalize())
    except InvalidOperation:
        return t


def norm_text(t: str | None) -> str:
    if t is None:
        return ""
    t = t.strip()
    if not t:
        return ""
    return " ".join(norm_token(x) for x in t.split())


def child_canons(el: ET.Element, strict: bool, o: Options) -> Iterator[Canon]:
    for c in el:
        if ignored(c, o) and not (strict and ns_of(c.tag) not in (CORE, GML)):
            continue
        if o.strip_ids and ns_of(c.tag) == GML and local(c.tag) in ARRAY_PROPERTIES:
            # gml:curveMembers etc. are exported as one gml:curveMember per geometry
            for g in c:
                yield c.tag[:-1], (), "", (canon(g, False, o),)
        else:
            yield canon(c, strict, o)


def canon(el: ET.Element, strict: bool, o: Options) -> Canon:
    # GML geometry embedded in ADE properties is written by the Importer/Exporter's
    # geometry machinery, so with --db it is normalised like standard content.
    if strict and o.strip_ids and ns_of(el.tag) == GML:
        strict = False
    # a shared geometry is written inline where the Importer/Exporter meets it first and referenced by xlink
    # elsewhere: a property that only refers to a geometry of the file is compared as if it held it
    resolved = o.geometries.get(el.get(f"{{{XLINK}}}href", "").lstrip("#")) if o.strip_ids and len(el) == 0 else None
    attrs = [(k, v) for k, v in el.attrib.items() if resolved is None or k != f"{{{XLINK}}}href"]
    if not strict:
        attrs = [
            (k, v)
            for k, v in attrs
            if local(k) not in o.ignore_attributes and not (o.strip_ids and k == f"{{{GML}}}id")
        ]
    if o.strip_ids:
        # the Importer/Exporter writes xlinks as "#id"; some data (the i-UR samples) omits the "#"
        attrs = [(k, "#" + v.lstrip("#") if k == f"{{{XLINK}}}href" else v) for k, v in attrs]
    # ADE feature types nest standard city object content (creationDate, gml:boundedBy), so the
    # ignored elements apply inside ADE content as well
    children = (canon(resolved, False, o),) if resolved is not None else tuple(child_canons(el, strict, o))
    if not strict and local(el.tag) in o.unordered:
        children = tuple(sorted(children))
    elif not strict and o.unordered_generics and any(is_surface_property(c) for c in el):
        surfaces = tuple(
            sorted(c for c in children if c[0].endswith("}boundedBy") and not c[0].startswith(f"{{{GML}}}"))
        )
        children = tuple(c for c in children if c not in surfaces) + surfaces
    if not strict and o.strip_ids and len(children) > 1 and all(c[0] == f"{{{GML}}}pos" for c in children):
        # the Importer/Exporter writes the positions of a ring as one posList
        children = ((f"{{{GML}}}posList", (), " ".join(c[2] for c in children), ()),)
    return el.tag, tuple(sorted(attrs)), norm_text(el.text), children


def fmt(c: Canon, indent: int = 0, max_lines: int = 40) -> str:
    tag, attrs, text, children = c
    s = "  " * indent + local(tag)
    if attrs:
        s += " " + " ".join(f'{local(k)}="{v}"' for k, v in attrs)
    if text:
        s += f" = {text[:80]}"
    lines = [s]
    for ch in children:
        lines.append(fmt(ch, indent + 1, max_lines))
    return "\n".join(lines[:max_lines])


def diff_paths(a: Canon, b: Canon, path: str, out: list[str]) -> None:
    if a[0] != b[0] or a[1] != b[1] or a[2] != b[2]:
        out.append(f"{path}: {fmt(a)[:200]!r}  !=  {fmt(b)[:200]!r}")
        return
    ca, cb = a[3], b[3]
    if len(ca) != len(cb):
        out.append(f"{path}/{local(a[0])}: child count {len(ca)} != {len(cb)}")
        sa, sb = Counter(ca), Counter(cb)
        for c in (sa - sb).elements():
            out.append("  only in ORIGINAL:\n" + fmt(c, 2))
        for c in (sb - sa).elements():
            out.append("  only in ROUNDTRIP:\n" + fmt(c, 2))
        return
    for i, (x, y) in enumerate(zip(ca, cb, strict=True)):
        if x != y:
            diff_paths(x, y, f"{path}/{local(a[0])}[{i}]", out)


def city_objects(root: ET.Element) -> dict[str, ET.Element]:
    """The top-level city objects by gml:id, and the objects written inline as group members (the Importer/Exporter
    exports them as top-level objects referenced by xlink)."""
    out = {}
    for tag in (f"{{{CORE}}}cityObjectMember", f"{{{GROUP}}}groupMember"):
        for member in root.iter(tag):
            for obj in member:
                out[obj.get(f"{{{GML}}}id", "")] = obj
    return out


def envelope_text(bounded_by: ET.Element | None) -> str:
    if bounded_by is None:
        return "none"
    corners = [" ".join(norm_text(c.text).split()) for c in bounded_by.iter() if local(c.tag).endswith("Corner")]
    return " / ".join(corners) or "empty"


def geometries(root: ET.Element) -> dict[str, ET.Element]:
    """The GML elements with a gml:id (the targets of geometry xlinks)."""
    return {el.get(f"{{{GML}}}id", ""): el for el in root.iter() if ns_of(el.tag) == GML and el.get(f"{{{GML}}}id")}


def ignored(el: ET.Element, o: Options) -> bool:
    """Whether an element is ignored: by local name (creationDate) or by qualified name (gml:boundedBy)."""
    return local(el.tag) in o.ignore_elements or el.tag in o.ignore_elements


def is_surface_property(el: ET.Element) -> bool:
    """A thematic surface property (bldg:boundedBy, brid:boundedBy, tun:boundedBy): the Importer/Exporter writes the
    surfaces of a feature in database order."""
    return local(el.tag) == "boundedBy" and ns_of(el.tag) != GML


def split(obj: ET.Element, o: Options) -> tuple[tuple[Canon, ...], Canon]:
    """(ADE children canonical tuple, standard children canonical tuple)."""
    ade = tuple(canon(c, True, o) for c in obj if is_ade(c.tag))
    std_children = [c for c in obj if not is_ade(c.tag) and not ignored(c, o)]
    if o.unordered_generics:
        generic = sorted(canon(c, False, o) for c in std_children if ns_of(c.tag) == GENERICS)
        surfaces = sorted(canon(c, False, o) for c in std_children if is_surface_property(c))
        other = [canon(c, False, o) for c in std_children if ns_of(c.tag) != GENERICS and not is_surface_property(c)]
        std_canon = tuple(other) + tuple(surfaces) + tuple(generic)
    else:
        std_canon = tuple(canon(c, False, o) for c in std_children)
    std: Canon = (
        obj.tag,
        tuple(sorted((k, v) for k, v in obj.attrib.items() if local(k) not in o.ignore_attributes)),
        norm_text(obj.text),
        std_canon,
    )
    return ade, std


def by_name(ade: tuple[Canon, ...]) -> dict[str, list[Canon]]:
    groups: dict[str, list[Canon]] = defaultdict(list)
    for c in ade:
        groups[c[0]].append(c)
    return groups


def main(argv: Sequence[str]) -> int:
    a, b = argv[0], argv[1]
    o = Options.parse(argv)
    ta = ET.parse(a).getroot()
    tb = ET.parse(b).getroot()
    oa, ob = city_objects(ta), city_objects(tb)
    ga_index, gb_index = geometries(ta), geometries(tb)
    ade_errors = std_errors = reordered = 0

    missing = set(oa) - set(ob)
    extra = set(ob) - set(oa)
    if missing:
        print(f"MISSING city objects in roundtrip: {sorted(missing)}")
        ade_errors += 1
    if extra and not o.subset:
        print(f"EXTRA city objects in roundtrip: {sorted(extra)}")
        ade_errors += 1

    if o.keep_envelope:
        ea, eb = ta.find(f"{{{GML}}}boundedBy"), tb.find(f"{{{GML}}}boundedBy")
        print(f"CityModel envelope: original {envelope_text(ea)}, roundtrip {envelope_text(eb)}")
        if ea is not None and eb is None:
            print("CityModel envelope missing in roundtrip")
            std_errors += 1

    ade_total = 0
    for gid in sorted(set(oa) & set(ob)):
        o.geometries = ga_index
        ade_a, std_a = split(oa[gid], o)
        o.geometries = gb_index
        ade_b, std_b = split(ob[gid], o)
        ade_total += len(ade_a)
        if ade_a != ade_b:
            ga, gb = by_name(ade_a), by_name(ade_b)
            if ga == gb:
                reordered += 1
            else:
                ade_errors += 1
                print(f"\n=== ADE content differs for {gid} ===")
                for name in sorted(set(ga) | set(gb), key=local):
                    if ga.get(name) != gb.get(name):
                        sa, sb = Counter(ga.get(name, [])), Counter(gb.get(name, []))
                        for c in (sa - sb).elements():
                            print("--- only in ORIGINAL:\n" + fmt(c))
                        for c in (sb - sa).elements():
                            print("+++ only in ROUNDTRIP:\n" + fmt(c))
                        if sa == sb:
                            print(f"(order of repeated {local(name)} differs)")
        if std_a != std_b:
            std_errors += 1
            out: list[str] = []
            diff_paths(std_a, std_b, "", out)
            print(f"\n=== standard content differs for {gid} ===")
            print("\n".join(out[:20]))

    print(
        f"\ncity objects compared: {len(set(oa) & set(ob))}, ADE properties in original: {ade_total}, "
        f"objects with ADE differences: {ade_errors}, objects with ADE properties in a different order: {reordered}, "
        f"objects with standard-content differences: {std_errors}"
    )
    return 0 if ade_errors == 0 and std_errors == 0 else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
