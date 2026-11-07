# Changelog

## Unreleased

- The Statistical Grid (`urg`) and Public Transit (`urt`) modules are generated like `urf`: `regen` copies the three
  module schemas of the edition into the citygml4j fork and runs `gen-mapping` per module (`config.MODULES`), and
  `changes-urgt` writes the CHANGES sections. Elements of feature types that clash with inherited GML properties are
  renamed as the hand-written 1.4 classes named them (`naming.feature_field`: `identifier`, `boundedBySurface`,
  `locationDescription` and the type-prefixed `routeDescription`, `agencyName`, `officeName`); `xs:time` elements are
  `LocalTime` values stored in timestamp columns; enumeration constants keep non-ASCII letters (urg
  `LandSlideTypeValue`); a model class of the module shadows an imported class of the same simple name (urt
  `PointProperty`) unless a field is of the imported type; the walkers visit the own fields of derived feature types
  and, in the GML walkers, the data types with feature references held by a hook (urt `dataType`), and write
  ambiguous names (urf and urg `LandPrice`) qualified. `gen-mapping` also replaces self-closing previous type tags;
  the ADETable importer class of an injection table is resolved by the injection's module (the hook importers of
  all modules share their class name); join table statements, self-referencing join importers and geometry locals
  get unique names; data type paths shared by two modules (urf and urg 2.0 `NumberOfHouseholds`) are told apart by
  namespace in the ObjectMapper.
- `verify` accepts `.xml` files, gives city objects without `gml:id` one before importing them (`<name>.in.xml`, the
  i-UR sample data), and the comparison under `--db` treats inline group members as top-level objects, a run of
  `gml:pos` as a `gml:posList`, `gml:curveMembers` as repeated `gml:curveMember`, a geometry xlink as the geometry it
  refers to, and an xlink without `#` as one with it. XSD validation includes the urg and urt schemas.
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
