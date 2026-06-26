#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== LOCAL FOCUS OS BOOTSTRAP INSTALLER ===="
date
echo

GITHUB_URL="${LOCAL_FOCUS_OS_GIT_URL:-https://github.com/DonMassa84/local-focus-os.git}"
INSTALL_ROOT="${LOCAL_FOCUS_OS_INSTALL_ROOT:-$HOME/.local/share/local-focus-os/source}"

mkdir -p "$(dirname "$INSTALL_ROOT")"

echo "== 1) Prüfe Basisbefehle =="

for cmd in bash git; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "FEHLER: Befehl fehlt: $cmd"
    exit 1
  fi
done

echo "[OK] Basisbefehle vorhanden"

echo
echo "== 2) Repo holen =="

if [[ -d "$INSTALL_ROOT/.git" ]]; then
  echo "[INFO] Aktualisiere: $INSTALL_ROOT"
  git -C "$INSTALL_ROOT" fetch --all --tags
  git -C "$INSTALL_ROOT" checkout main
  git -C "$INSTALL_ROOT" pull --ff-only || true
else
  echo "[INFO] Klone nach: $INSTALL_ROOT"
  git clone "$GITHUB_URL" "$INSTALL_ROOT"
fi

echo
echo "== 3) Installer starten =="

cd "$INSTALL_ROOT"
chmod +x install.sh

exec ./install.sh
