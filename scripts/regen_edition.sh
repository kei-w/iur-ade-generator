#!/usr/bin/env bash
# Regenerate one i-UR edition (uro + urf) end to end and verify it with its generated fixture:
# urf schema of the edition, JAXB classes (ade-xjc), schema mapping (uro patches + generated urf mapping), citygml4j and
# citydb code generation, builds, extension folder, verification database, fixture import/export/comparison, XSD
# validation.
# Usage: bash scripts/regen_edition.sh <version: 2.0|3.0|3.1|3.2> [password]
set -e
VER=$1
PW=${2:-password}
case "$VER" in
    2.0) BR=iur-2.0; DB=citydb_poc;   EXTS=ade-extensions-iur20; DVER=2.2.0; NN=20;;
    3.0) BR=iur-3.0; DB=citydb_poc30; EXTS=ade-extensions-iur30; DVER=3.0.0; NN=30;;
    3.1) BR=iur-3.1; DB=citydb_poc31; EXTS=ade-extensions-iur31; DVER=3.1.0; NN=31;;
    3.2) BR=iur-3.2; DB=citydb_poc32; EXTS=ade-extensions-iur32; DVER=3.2.0; NN=32;;
    *) echo "unknown version $VER"; exit 1;;
esac
PKG=jp.geospatial.iur._${VER/./_}
HERE=$(cd "$(dirname "$0")" && pwd)
ROOT=$(cd "$HERE/../.." && pwd)
G=$ROOT/iur-ade-citygml4j
D=$ROOT/iur-ade-citydb
REPO=$(cd "$HERE/.." && pwd)
IUR_ADE="uv run --project $REPO iur-ade"
OUT=$REPO/out
mkdir -p "$OUT"
TOOL=/d/Tools/ade-xjc-2.10.0/ade-xjc-2.10.0/iur-$VER
IMPEXP=/d/Tools/3DCityDB-Importer-Exporter-5.5.0/3DCityDB-Importer-Exporter-5.5.0
EXT=$IMPEXP/$EXTS/iur-ade-$DVER
XSD=D:/Tools/ade-xjc-2.10.0/ade-xjc-2.10.0/schemas/citygml/2.0.0
FIXTURE=$REPO/fixtures/iur${NN}_all.gml

echo "== $VER: branch $BR"
git -C "$G" checkout -q "$BR"
git -C "$D" checkout -q "$BR"

# 0. the urf schema of the edition: the original (PLATEAU dataset) as schema resource, a copy with relative imports
#    of the GML/CityGML schemas for ade-xjc and the generators
cp "$REPO/schemas/iur/urf/$VER/urbanFunction.xsd" "$G/src/main/resources/org/citygml4j/ade/iur/schema/urbanFunction.xsd"
sed 's#schemaLocation="http://schemas.opengis.net/gml/3.1.1/base/gml.xsd"#schemaLocation="../../schemas/gml/3.1.1/base/gml.xsd"#; s#schemaLocation="http://schemas.opengis.net/citygml/2.0/cityGMLBase.xsd"#schemaLocation="../../schemas/citygml/2.0.0/cityGMLBase.xsd"#; s#schemaLocation="../../uro/'"$VER"'/urbanObject.xsd"#schemaLocation="urbanObject.xsd"#' \
    "$REPO/schemas/iur/urf/$VER/urbanFunction.xsd" | sed 's/\r$//' > "$G/resources/ade-xjc/schemas/urbanFunction.xsd"
cp "$G/resources/ade-xjc/schemas/urbanFunction.xsd" "$TOOL/schemas/urbanFunction.xsd"
sed -i 's#namespace="[^"]*/urf/[0-9.]*" schemaLocation="schemas/urbanFunction.xsd"#namespace="https://www.geospatial.jp/iur/urf/'"$VER"'" schemaLocation="schemas/urbanFunction.xsd"#' "$TOOL/UrbanRevitalizationADE.xsd"

# 1. JAXB classes: ade-xjc with the repository binding (English Javadoc, LF line endings); all four packages are taken
#    from the same run (the urt classes refer to the urf feature classes)
$IUR_ADE patch-binding "$G"
cp "$G/resources/ade-xjc/binding.xjb" "$TOOL/binding.xjb"
# run through PowerShell: the start script uses relative paths and cmd.exe started from bash does not find it
(export JAVA_TOOL_OPTIONS="-Duser.language=en -Duser.country=US"
 powershell -NoProfile -Command "Push-Location '$(cygpath -w "$TOOL")'; & cmd.exe /c '.\run_ade-xjc.bat' 2>&1 | Select-Object -Last 1; Pop-Location")
for pkg in $PKG.uro $PKG.urf jp.go.kantei.iur._1_4.urg jp.go.kantei.iur._1_4.urt; do
    SRC=$TOOL/src-gen/$(echo $pkg | tr . /)
    DST=$G/src-gen/main/java/$(echo $pkg | tr . /)
    test -d "$SRC" || { echo "ade-xjc did not generate $pkg"; exit 1; }
    mkdir -p "$DST"
    rm -f "${DST:?}"/*.java
    for f in "$SRC"/*.java; do sed 's/\r$//' "$f" > "$DST/$(basename "$f")"; done
    echo "JAXB classes of $pkg: $(ls "$DST" | wc -l) files"
done
rm -rf "$G/src-gen/main/java/jp/go/kantei/iur/_1_4/urf"
# JAXB files that only differ by their generation timestamp are kept as committed
(cd "$G" && for f in $(git diff --name-only src-gen); do
    if [ -f "$f" ] && git show "HEAD:$f" 2>/dev/null | diff -q -I '^// Generated:' - "$f" > /dev/null; then git checkout -q -- "$f"; fi
done)

# 2. schema mapping and code generation (from the committed mapping; the patches and the urf generation are idempotent)
git -C "$D" checkout -q -- resources/database
$IUR_ADE patch-mapping "$D" "$G" "$VER" uro
$IUR_ADE gen-citygml4j "$G" "$D" "$VER" all uro,urf 2>&1 | grep -v 'removed stale' | tail -1
(cd "$G" && ./gradlew -q publishToMavenLocal 2>&1 | grep -i 'error' | head -5 || true)
$IUR_ADE gen-mapping "$D" "$G" "$VER" urf uro 2>&1 | tail -1
$IUR_ADE gen-citydb "$D" "$G" "$VER" all uro,urf 2>&1 | grep -v 'removed stale' | tail -1
(cd "$D" && ./gradlew -q installDist 2>&1 | grep -i 'error' | head -5 || true)
test -f "$D/build/install/iur-ade/lib/iur-ade-citydb-$DVER.jar" || { echo "citydb build failed"; exit 1; }
rm -rf "${EXT:?}/lib" "${EXT:?}/3dcitydb" "${EXT:?}/schema-mapping"
cp -r "$D/build/install/iur-ade/." "$EXT/"
echo "extension installed: $EXT"

# 3. fixture, verification database, round trip
$IUR_ADE fixture "$G" "$D" "$VER" all "$FIXTURE" uro,urf 2>&1 | tail -1
bash "$HERE/recreate_db.sh" "$DB" "$(cygpath -w "$EXT")" "$PW" 2>&1 | tail -1
(cd "$IMPEXP" && ./bin/impexp.bat import -H localhost -P 35432 -d "$DB" -u postgres -p="$PW" --ade-extensions="$EXTS" --creation-date=complement "$(cygpath -w "$FIXTURE")" > "$OUT/fixture${NN}_import.log" 2>&1) || true
grep -i 'error' "$OUT/fixture${NN}_import.log" | head -3 || true
(cd "$IMPEXP" && ./bin/impexp.bat export -H localhost -P 35432 -d "$DB" -u postgres -p="$PW" --ade-extensions="$EXTS" -o "$(cygpath -w "$OUT/fixture${NN}_db.gml")" > "$OUT/fixture${NN}_export.log" 2>&1) || true
grep -i 'error' "$OUT/fixture${NN}_export.log" | head -3 || true
$IUR_ADE compare "$FIXTURE" "$OUT/fixture${NN}_db.gml" --db > "$OUT/cmp_fixture${NN}.txt" 2>&1 || true
grep '^===\|^city objects' "$OUT/cmp_fixture${NN}.txt"
SCHEMAS="$XSD/cityGMLBase.xsd $XSD/building.xsd $XSD/bridge.xsd $XSD/tunnel.xsd $XSD/landUse.xsd $XSD/cityFurniture.xsd $XSD/relief.xsd $XSD/transportation.xsd $XSD/vegetation.xsd $XSD/waterBody.xsd $XSD/cityObjectGroup.xsd $(cygpath -m "$G")/resources/ade-xjc/schemas/urbanObject.xsd $(cygpath -m "$G")/resources/ade-xjc/schemas/urbanFunction.xsd"
for f in "$FIXTURE" "$OUT/fixture${NN}_db.gml"; do
    (cd "$REPO/java/roundtrip" && ./gradlew -q validate --args="$(cygpath -m "$f") $SCHEMAS" 2>&1 | grep 'VALID\|ERROR' | head -3)
done
echo "== $VER done"
