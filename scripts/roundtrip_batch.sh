#!/bin/bash
# Round-trips every CityGML file below a folder through java/roundtrip (citygml4j + ADE module) and compares each
# result with its source (iur-ade compare). Prints one summary line per file and a total.
# Usage: bash scripts/roundtrip_batch.sh <folder> <outDir>
set -u
SRC=$1
OUT=$2
REPO=$(cd "$(dirname "$0")/.." && pwd)
IUR_ADE="uv run --project $REPO iur-ade"
mkdir -p "$OUT"
total=0; bad=0
while IFS= read -r f; do
    total=$((total + 1))
    name=$(basename "$f" .gml)
    rt="$OUT/$name.rt.gml"
    (cd "$REPO/java/roundtrip" && ./gradlew -q run --args="$(cygpath -m "$f") $(cygpath -m "$rt")" > "$OUT/$name.log" 2>&1)
    if [ ! -s "$rt" ]; then
        bad=$((bad + 1)); echo "FAIL (no output) $name: $(grep -m1 -i 'exception\|error' "$OUT/$name.log" | cut -c1-160)"; continue
    fi
    summary=$($IUR_ADE compare "$f" "$rt" 2>&1 | tail -1)
    if echo "$summary" | grep -q 'objects with ADE differences: 0, .*different order: 0, .*standard-content differences: 0'; then
        echo "ok   $name: $summary"
    else
        bad=$((bad + 1)); echo "DIFF $name: $summary"
    fi
done < <(find "$SRC" -name '*.gml' | sort)
echo "files: $total, failed or different: $bad"
