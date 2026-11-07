# Changelog

## Unreleased

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
