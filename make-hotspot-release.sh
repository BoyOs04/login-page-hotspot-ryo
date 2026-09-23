#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
VERSION="\${1:-v1.0.0}"
RELEASE_DIR="\${2:-$REPO_DIR/releases}"
OUTPUT="$RELEASE_DIR/hotspotV3-\${VERSION}.zip"

if [ ! -d "$REPO_DIR/hotspotV3" ]; then
  echo "Error: hotspotV3 directory not found."
  exit 1
fi

mkdir -p "$RELEASE_DIR"
rm -f "$OUTPUT"

cd "$REPO_DIR"
zip -r "$OUTPUT" hotspotV3 \
  -x 'hotspotV3/.git/*' \
  -x 'hotspotV3/*.DS_Store' \
  -x 'hotspotV3/**/.DS_Store' \
  -x 'hotspotV3/demo.html'

echo
echo "Release package created:"
echo "$OUTPUT"
echo
echo "Contents:"
unzip -l "$OUTPUT"
