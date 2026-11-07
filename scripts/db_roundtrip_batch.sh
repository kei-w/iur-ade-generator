#!/usr/bin/env bash
# Imports CityGML files into a fresh verification database, exports everything and compares each input file with the
# export (iur-ade compare --db --subset). Prints one line per file and a total.
# Usage: bash scripts/db_roundtrip_batch.sh <db> <extension folder name (ade-extensions-iurNN)> <extension dir> <outDir> <file...>
set -u
DB=$1; EXTS=$2; EXT=$3; OUT=$4; shift 4
REPO=$(cd "$(dirname "$0")/.." && pwd)
IUR_ADE="uv run --project $REPO iur-ade"
IMPEXP=/d/Tools/3DCityDB-Importer-Exporter-5.5.0/3DCityDB-Importer-Exporter-5.5.0
mkdir -p "$OUT"
OUT=$(cd "$OUT" && pwd)
FILES=()
for f in "$@"; do FILES+=("$(cd "$(dirname "$f")" && pwd)/$(basename "$f")"); done
set -- "${FILES[@]}"
bash "$REPO/scripts/recreate_db.sh" "$DB" "$(cygpath -w "$EXT")" 2>&1 | tail -1
total=0; bad=0
for f in "$@"; do
    total=$((total + 1))
    name=$(basename "$f" .gml)
    (cd "$IMPEXP" && ./bin/impexp.bat import -H localhost -P 35432 -d "$DB" -u postgres -p=password --ade-extensions="$EXTS" --creation-date=complement --no-appearance "$(cygpath -w "$f")" > "$OUT/$name.import.log" 2>&1)
    if grep -qi 'aborted\|fatal' "$OUT/$name.import.log"; then
        bad=$((bad + 1)); echo "FAIL (import) $name: $(grep -m1 -i 'caused by' "$OUT/$name.import.log" | cut -c1-200)"
    fi
done
(cd "$IMPEXP" && ./bin/impexp.bat export -H localhost -P 35432 -d "$DB" -u postgres -p=password --ade-extensions="$EXTS" --no-appearance -o "$(cygpath -w "$OUT/all_db.gml")" > "$OUT/all.export.log" 2>&1)
grep -i 'error\|exception' "$OUT/all.export.log" | head -3
for f in "$@"; do
    name=$(basename "$f" .gml)
    grep -qi 'aborted\|fatal' "$OUT/$name.import.log" && continue
    summary=$($IUR_ADE compare "$f" "$OUT/all_db.gml" --db --subset 2>&1 | tail -1)
    if echo "$summary" | grep -q 'objects with ADE differences: 0, .*different order: 0'; then
        echo "ok   $name: $summary"
    elif echo "$summary" | grep -q 'objects with ADE differences: 0,'; then
        echo "ok   $name (generic property order only): $summary"
    else
        bad=$((bad + 1)); echo "DIFF $name: $summary"
        $IUR_ADE compare "$f" "$OUT/all_db.gml" --db --subset > "$OUT/$name.cmp.txt" 2>&1
    fi
done
echo "files: $total, failed or different: $bad"
