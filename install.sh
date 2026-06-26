#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== LOCAL FOCUS OS INSTALLER ===="
date
echo

GITHUB_URL="${LOCAL_FOCUS_OS_GIT_URL:-https://github.com/DonMassa84/local-focus-os.git}"
INSTALL_ROOT="${LOCAL_FOCUS_OS_INSTALL_ROOT:-$HOME/.local/share/local-focus-os/source}"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$BIN_DIR" "$(dirname "$INSTALL_ROOT")"

echo "== 1) System prüfen =="

for cmd in bash git ln mkdir find sort; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "FEHLER: Befehl fehlt: $cmd"
    exit 1
  fi
done

echo "[OK] Basisbefehle vorhanden"

echo
echo "== 2) Repo installieren oder aktualisieren =="

if [[ -d "$INSTALL_ROOT/.git" ]]; then
  echo "[INFO] Aktualisiere vorhandenes Repo: $INSTALL_ROOT"
  git -C "$INSTALL_ROOT" fetch --all --tags
  git -C "$INSTALL_ROOT" checkout main
  git -C "$INSTALL_ROOT" pull --ff-only || true
else
  echo "[INFO] Klone Repo nach: $INSTALL_ROOT"
  git clone "$GITHUB_URL" "$INSTALL_ROOT"
fi

cd "$INSTALL_ROOT"

echo
echo "== 3) Rechte setzen =="

chmod +x setup.sh uninstall.sh 2>/dev/null || true
find bin -maxdepth 1 -type f -name 'lf-*' -exec chmod +x {} \; 2>/dev/null || true
[[ -f bin/local-focus-os ]] && chmod +x bin/local-focus-os || true
[[ -f tools/build_release.sh ]] && chmod +x tools/build_release.sh || true
[[ -f tests/test_commands.sh ]] && chmod +x tests/test_commands.sh || true

echo "[OK] Rechte gesetzt"

echo
echo "== 4) setup.sh ausführen =="

if [[ -x ./setup.sh ]]; then
  ./setup.sh
else
  echo "FEHLER: setup.sh fehlt oder ist nicht ausführbar."
  exit 1
fi

echo
echo "== 5) Haupt-CLI verlinken =="

if [[ -x "$INSTALL_ROOT/bin/local-focus-os" ]]; then
  ln -sf "$INSTALL_ROOT/bin/local-focus-os" "$BIN_DIR/local-focus-os"
  echo "[OK] local-focus-os -> $BIN_DIR/local-focus-os"
else
  echo "[WARN] bin/local-focus-os fehlt. Basisbefehle lf-* wurden trotzdem installiert."
fi

echo
echo "== 6) PATH prüfen =="

if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  if [[ -f "$HOME/.bashrc" ]] && ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo "[OK] PATH in ~/.bashrc ergänzt"
  else
    echo "[INFO] PATH bitte nachladen: source ~/.bashrc"
  fi
else
  echo "[OK] ~/.local/bin ist im PATH"
fi

export PATH="$BIN_DIR:$PATH"
hash -r || true

echo
echo "== 7) Smoke Test =="

command -v lf-status >/dev/null 2>&1 && lf-status || true
command -v local-focus-os >/dev/null 2>&1 && local-focus-os version || true

echo
echo "==== INSTALL COMPLETE ===="
echo
echo "Installationspfad:"
echo "  $INSTALL_ROOT"
echo
echo "Befehle:"
echo "  local-focus-os help"
echo "  local-focus-os status"
echo "  local-focus-os doctor"
echo "  lf-status"
echo "  lf-schedule status"
echo "  lf-library status"
echo
echo "Falls Befehle nicht gefunden werden:"
echo "  source ~/.bashrc"
