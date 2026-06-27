#!/usr/bin/env bash
set -Eeuo pipefail

REPO="/home/schattenmacher/openclaw_training/open_source/local-focus-os"
DASHBOARD="$REPO/docs/ui/local-focus-os-dashboard/index.html"

if [[ ! -f "$DASHBOARD" ]]; then
  echo "Dashboard nicht gefunden: $DASHBOARD"
  exit 1
fi

xdg-open "$DASHBOARD" >/dev/null 2>&1 &
echo "[OK] Dashboard geöffnet: $DASHBOARD"
