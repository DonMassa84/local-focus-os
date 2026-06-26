#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== LOCAL FOCUS OS UNINSTALL ===="
date
echo

BIN_DEST="$HOME/.local/bin"
SYSTEMD_USER="$HOME/.config/systemd/user"

echo "== 1) Stop timers =="

systemctl --user disable --now lf-morning.timer lf-evening.timer >/dev/null 2>&1 || true

rm -f "$SYSTEMD_USER/lf-morning.service"
rm -f "$SYSTEMD_USER/lf-morning.timer"
rm -f "$SYSTEMD_USER/lf-evening.service"
rm -f "$SYSTEMD_USER/lf-evening.timer"

systemctl --user daemon-reload >/dev/null 2>&1 || true

echo "[OK] Timers removed"
echo

echo "== 2) Remove commands =="

for cmd in lf-run lf-task lf-ai lf-email lf-morning lf-evening lf-status lf-secret-scan; do
  rm -f "$BIN_DEST/$cmd"
  echo "[OK] removed $BIN_DEST/$cmd"
done

echo
echo "== 3) Data kept =="

echo "Data was NOT deleted:"
echo "  $HOME/.local/share/local-focus-os"
echo "  $HOME/.config/local-focus-os"
echo
echo "Delete manually if needed:"
echo "  rm -rf ~/.local/share/local-focus-os ~/.config/local-focus-os"

echo
echo "==== UNINSTALL COMPLETE ===="
