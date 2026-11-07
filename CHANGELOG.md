# Changelog

## Unreleased

- The class skeletons of the generated Java (importers, exporters, hook and join table classes, balloon handler,
  model classes, marshaller, unmarshaller, module class) are Jinja2 templates under `templates/`; the field and method
  code stays in Python.
- The generators are typed packages checked by mypy in strict mode: `spec` (the specification model as dataclasses
  read from the XSDs, the JAXB classes and the schema mapping), `mapping` (the ADE Manager patches, the generated urf
  mapping and the DDL editing), `citygml4j` (model classes, bind code, walkers, module class), `citydb` (table model,
  field code, importers, exporters, join tables, hook classes, registrations, balloon handler) and the modules
  `naming`, `binding`, `fixture`, `compare` and `changes`; `compare` keeps its options in a dataclass. Unit tests cover the
  specification model and the generators on a small uro/urf module pair with golden files, the real urf schemas, the
  CHANGES sections and the configuration; the integration test regenerates the four editions into the forks.
- `iur-ade regen <version>` replaces `scripts/regen_edition.sh`, `iur-ade verify <version> [--db] <paths...>` replaces
  `scripts/roundtrip_batch.sh` and `scripts/db_roundtrip_batch.sh`, `iur-ade recreate-db <version>` replaces
  `scripts/recreate_db.sh`. The tool folders, the database connection and the forks are configured in `iur-ade.toml`
  (`iur-ade.example.toml`) or `IUR_ADE_*` environment variables instead of paths in the scripts; the editions
  (branches, artifact versions, databases, extension folders) are in `config.EDITIONS`. ade-xjc runs in
  `out/ade-xjc/<version>` with the schema imports pointed at its installation; `java/ade-transform` takes the
  Importer/Exporter folder as `-PimpexpHome` or `IMPEXP_HOME`.
- The generator modules take their arguments as `main(argv)`; the `iur-ade` command is an argparse CLI.
- Initial repository: the generators (`urospec`, `patch_binding`, `patch_mapping`, `gen_mapping`, `gen_citygml4j`,
  `gen_citydb`, `gen_fixture`, `compare`, `update_changes_*`), the shell scripts, the i-UR schemas (urf 2.0-3.2 from the
  PLATEAU datasets, urg/urt 2.0-3.2 from geospatial.jp), the Java harnesses (`java/ade-transform`, `java/roundtrip`) and
  the hand-written building fixtures moved from the PoC workspace of the `plateau-citygml-ade-investigation` as they
  ran there.
