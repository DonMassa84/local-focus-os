#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== LOCAL FOCUS OS UNINSTALL ===="
date
echo

BIN_DEST="$HOME/.local/bin"
SYSTEMD_USER="$HOME/.config/systemd/user"

echo "== 1) Stop timers =="

systemctl --user disable --now \
  lf-morning.timer \
  lf-evening.timer \
  lf-autonomy-morning.timer \
  lf-autonomy-evening.timer \
  lf-autonomy-healthcheck.timer >/dev/null 2>&1 || true

rm -f "$SYSTEMD_USER"/lf-morning.service
rm -f "$SYSTEMD_USER"/lf-morning.timer
rm -f "$SYSTEMD_USER"/lf-evening.service
rm -f "$SYSTEMD_USER"/lf-evening.timer
rm -f "$SYSTEMD_USER"/lf-autonomy-morning.service
rm -f "$SYSTEMD_USER"/lf-autonomy-morning.timer
rm -f "$SYSTEMD_USER"/lf-autonomy-evening.service
rm -f "$SYSTEMD_USER"/lf-autonomy-evening.timer
rm -f "$SYSTEMD_USER"/lf-autonomy-healthcheck.service
rm -f "$SYSTEMD_USER"/lf-autonomy-healthcheck.timer

systemctl --user daemon-reload >/dev/null 2>&1 || true

echo "[OK] Timers removed"
echo

echo "== 2) Remove commands =="

for cmd in lf-run lf-task lf-ai lf-email lf-morning lf-evening lf-status lf-secret-scan lf-autonomy lf-autonomy-run; do
  rm -f "$BIN_DEST/$cmd"
  echo "[OK] removed $BIN_DEST/$cmd"
done

echo
echo "== 3) Data kept =="

echo "Data was NOT deleted:"
echo "  $HOME/.local/share/local-focus-os"
echo "  $HOME/.config/local-focus-os"

echo
echo "==== UNINSTALL COMPLETE ===="
