#!/usr/bin/env bash
# Recreate a 3DCityDB 4.4.1 verification database and register an i-UR ADE extension in it.
# Usage: recreate_db.sh <database> <extension dir (impexp ade-extensions-*/iur-ade-x.y.z)> [password]
set -e
DB=$1
EXT=$2
export PGPASSWORD=${3:-password}
PSQL="/c/Program Files/pgAdmin 4/runtime/psql.exe"
SCRIPTS=/d/Tools/3dcitydb-4.4.1/3dcitydb-4.4.1/postgresql/SQLScripts
HERE=$(cd "$(dirname "$0")" && pwd)

"$PSQL" -h localhost -p 35432 -U postgres -d postgres -q -c "DROP DATABASE IF EXISTS $DB;" -c "CREATE DATABASE $DB;"
"$PSQL" -h localhost -p 35432 -U postgres -d "$DB" -q -c "CREATE EXTENSION IF NOT EXISTS postgis;" -c "CREATE EXTENSION IF NOT EXISTS postgis_raster;"
(cd "$SCRIPTS" && "$PSQL" -h localhost -p 35432 -U postgres -d "$DB" -q -v srsno=6697 -v gmlsrsname=urn:ogc:def:crs:EPSG::6697 -f CREATE_DB.sql > /dev/null 2>&1)
"$PSQL" -h localhost -p 35432 -U postgres -d "$DB" -t -c "select 'core tables: ' || count(*) from information_schema.tables where table_schema='citydb'"
"$HERE/../java/ade-transform/gradlew" -q -p "$HERE/../java/ade-transform" register --args="$EXT localhost 35432 $DB postgres $PGPASSWORD" 2>&1 | tail -1
"$PSQL" -h localhost -p 35432 -U postgres -d "$DB" -t -c "select 'ade tables: ' || count(*) from information_schema.tables where table_schema='citydb' and table_name like 'ur\_%'"
