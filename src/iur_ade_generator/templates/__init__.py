"""The Jinja2 templates of the generated Java classes: the class skeletons (``citydb/*.java.j2``,
``citygml4j/*.java.j2``). The code of the single fields and methods is assembled in Python and passed in as text."""

from __future__ import annotations

from jinja2 import Environment, PackageLoader, StrictUndefined

ENV = Environment(
    loader=PackageLoader("iur_ade_generator", "templates"),
    autoescape=False,
    keep_trailing_newline=True,
    undefined=StrictUndefined,
)


def render(template: str, /, **context: object) -> str:
    """Renders the template (a path below ``templates/``) with the given variables."""
    return ENV.get_template(template).render(**context)
