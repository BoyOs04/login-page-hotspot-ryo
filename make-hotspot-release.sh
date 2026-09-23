#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
VERSION="${1:-v1.0.0}"
OUTPUT="${2:-$HOME/hotspotV3-${VERSION}.zip}"

if [ ! -d "$REPO_DIR/hotspotV3" ]; then
  echo "Error: hotspotV3 directory not found."
  exit 1
fi

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
