#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== LOCAL FOCUS OS RELEASE BUILD ===="
date
echo

REPO="${1:-$HOME/openclaw_training/open_source/local-focus-os}"

cd "$REPO"

VERSION="$(cat VERSION | tr -d '[:space:]')"
NAME="local-focus-os"
DIST="dist"
BUILD_ROOT="/tmp/${NAME}-build"
PKG_DIR="$BUILD_ROOT/${NAME}-${VERSION}"
TARBALL="$DIST/${NAME}-${VERSION}.tar.gz"
SHA="$TARBALL.sha256"
MANIFEST="$DIST/${NAME}-${VERSION}.manifest.txt"
SBOM="$DIST/${NAME}-${VERSION}.sbom.txt"

rm -rf "$BUILD_ROOT"
mkdir -p "$PKG_DIR" "$DIST"

echo "== 1) Preconditions =="

git status --short
if [[ -n "$(git status --short)" ]]; then
  echo "FEHLER: Git Arbeitsverzeichnis ist nicht sauber."
  exit 1
fi

echo "[OK] Git clean"

echo
echo "== 2) Tests =="

./tests/test_commands.sh "$REPO"

echo
echo "== 3) Copy release files =="

rsync -a \
  --exclude='.git' \
  --exclude='dist' \
  --exclude='.repair_backup_*' \
  --exclude='*.tmp' \
  --exclude='*.log' \
  ./ "$PKG_DIR/"

echo
echo "== 4) Manifest =="

{
  echo "# Release Manifest"
  echo
  echo "Name: $NAME"
  echo "Version: $VERSION"
  echo "Date: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo "Git commit: $(git rev-parse HEAD)"
  echo "Git branch: $(git branch --show-current)"
  echo
  echo "## Files"
  cd "$PKG_DIR"
  find . -type f | sort | while read -r f; do
    sha256sum "$f"
  done
} > "$MANIFEST"

echo "[OK] Manifest: $MANIFEST"

echo
echo "== 5) Simple SBOM =="

{
  echo "# Simple SBOM"
  echo
  echo "Name: $NAME"
  echo "Version: $VERSION"
  echo "Generated: $(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  echo
  echo "## Runtime Requirements"
  echo "- bash"
  echo "- coreutils"
  echo "- systemd user services"
  echo "- git"
  echo "- optional: ollama"
  echo "- optional: poppler-utils for pdfinfo"
  echo
  echo "## Executables"
  find "$PKG_DIR/bin" -maxdepth 1 -type f -printf '%f\n' | sort
  echo
  echo "## Documentation"
  find "$PKG_DIR/docs" -maxdepth 1 -type f -printf '%f\n' | sort
} > "$SBOM"

echo "[OK] SBOM: $SBOM"

echo
echo "== 6) Reproducible tarball =="

tar \
  --sort=name \
  --owner=0 \
  --group=0 \
  --numeric-owner \
  --mtime='UTC 2026-01-01' \
  -czf "$TARBALL" \
  -C "$BUILD_ROOT" \
  "${NAME}-${VERSION}"

sha256sum "$TARBALL" > "$SHA"

echo
echo "==== BUILD OK ===="
echo "Package:  $TARBALL"
echo "SHA256:   $SHA"
echo "Manifest: $MANIFEST"
echo "SBOM:     $SBOM"
