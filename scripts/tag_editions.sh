#!/usr/bin/env bash
# Tag the four i-UR editions in both forks (annotated tags, local only) and build their distributions.
# Usage: tag_editions.sh [--retag] [outDir]   (default: out/releases; --retag moves existing tags to the branch heads)
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
ROOT=$(cd "$HERE/../.." && pwd)
RETAG=0
if [ "${1:-}" = "--retag" ]; then RETAG=1; shift; fi
OUT=${1:-$HERE/../out/releases}
mkdir -p "$OUT"
G=$ROOT/iur-ade-citygml4j
D=$ROOT/iur-ade-citydb
MODULES="Urban Object, Urban Function, Statistical Grid and Public Transit modules"

tag_one() {   # repo branch tag message
    if git -C "$1" rev-parse -q --verify "refs/tags/$3" > /dev/null; then
        if [ "$RETAG" = 1 ]; then
            git -C "$1" tag -d "$3" > /dev/null
        else
            echo "$3 exists in $(basename "$1")"; return
        fi
    fi
    git -C "$1" tag -a "$3" "$2" -m "$4"
    echo "tagged $(basename "$1") $3 at $(git -C "$1" rev-parse --short "$2")"
}

for spec in "2.0 iur-2.0 2.0.0 2.2.0" "3.0 iur-3.0 3.0.0 3.0.0" "3.1 iur-3.1 3.1.0 3.1.0" "3.2 iur-3.2 3.2.0 3.2.0"; do
    set -- $spec
    iur=$1; branch=$2; gver=$3; dver=$4
    tag_one "$G" "$branch" "v$gver" "iur-ade-citygml4j $gver: i-UR $iur $MODULES"
    tag_one "$D" "$branch" "v$dver" "iur-ade-citydb $dver: i-UR $iur extension for the 3D City Database ($MODULES)"
done

# distributions (the citydb distZip bundles the citygml4j jar of the same edition from mavenLocal)
for spec in "iur-2.0 2.2.0" "iur-3.0 3.0.0" "iur-3.1 3.1.0" "iur-3.2 3.2.0"; do
    set -- $spec
    git -C "$D" checkout -q "$1"
    git -C "$G" checkout -q "$1"
    (cd "$G" && ./gradlew -q publishToMavenLocal 2>&1 | grep -v 'Xlint\|unchecked\|^$' | head -2)
    (cd "$D" && ./gradlew -q distZip 2>&1 | grep -v 'Xlint\|unchecked\|^$' | head -2)
    cp "$D"/build/distributions/iur-ade-$2.zip "$OUT/" && echo "built $OUT/iur-ade-$2.zip"
done
ls -la "$OUT"
