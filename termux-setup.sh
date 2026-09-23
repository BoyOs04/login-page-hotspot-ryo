#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BASHRC="$HOME/.bashrc"
START="# >>> hotspot-github-shortcuts >>>"
END="# <<< hotspot-github-shortcuts <<<"

echo "Repository: $REPO_DIR"

# Git safety for Android shared storage.
if ! git config --global --get-all safe.directory | grep -Fxq "$REPO_DIR"; then
  git config --global --add safe.directory "$REPO_DIR"
fi

# Keep README.md tracked on GitHub, but omit it from the local working tree.
git -C "$REPO_DIR" sparse-checkout init --no-cone
printf '/*\n!/README.md\n' > "$REPO_DIR/.git/info/sparse-checkout"
git -C "$REPO_DIR" read-tree -mu HEAD

# Remove a previous shortcut block so the script is safe to run again.
if [ -f "$BASHRC" ]; then
  awk -v start="$START" -v end="$END" '
    $0 == start {skip=1; next}
    $0 == end {skip=0; next}
    !skip {print}
  ' "$BASHRC" > "$BASHRC.tmp"
  mv "$BASHRC.tmp" "$BASHRC"
fi

cat >> "$BASHRC" <<EOF

$START
hotspot() {
  cd "$REPO_DIR"
}

sync_file_github() {
  cd "$REPO_DIR" || return 1
  git pull --ff-only origin main
}

push_file_github() {
  cd "$REPO_DIR" || return 1
  git add .

  if git diff --cached --quiet; then
    echo "Tidak ada perubahan untuk dikirim ke GitHub."
    return 0
  fi

  local message="$*"
  [ -n "$message" ] || message="Update from HP"

  git commit -m "$message"
  git push origin main
}

alias sync-file-github='sync_file_github'
alias push-file-github='push_file_github'
$END
EOF

# Load the shortcuts immediately.
# shellcheck disable=SC1090
source "$BASHRC"

echo
echo "Setup selesai."
echo
echo "Shortcut:"
echo "  hotspot             -> masuk ke repository"
echo "  sync-file-github    -> GitHub -> HP"
echo "  push-file-github    -> HP -> GitHub"
echo
echo "Contoh commit:"
echo "  push-file-github \"Fix login page\""
