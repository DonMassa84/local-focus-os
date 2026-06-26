#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_SRC="$ROOT/bin"
BIN_DEST="$HOME/.local/bin"
DATA_HOME="${LF_HOME:-$HOME/.local/share/local-focus-os}"
SYSTEMD_USER="$HOME/.config/systemd/user"

mkdir -p "$BIN_DEST" "$DATA_HOME" "$SYSTEMD_USER"

for f in "$BIN_SRC"/lf-*; do
ln -sf "$f" "$BIN_DEST/$(basename "$f")"
done

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

cat > "$SYSTEMD_USER/lf-morning.service" << SERVICE
[Unit]
Description=Local Focus OS Morning Workflow

[Service]
Type=oneshot
ExecStart=/bin/bash -lc '$BIN_DEST/lf-morning'
SERVICE

cat > "$SYSTEMD_USER/lf-morning.timer" << TIMER
[Unit]
Description=Run Local Focus OS Morning Workflow

[Timer]
OnCalendar=--* 08:05:00
Persistent=true

[Install]
WantedBy=timers.target
TIMER

cat > "$SYSTEMD_USER/lf-evening.service" << SERVICE
[Unit]
Description=Local Focus OS Evening Review

[Service]
Type=oneshot
ExecStart=/bin/bash -lc '$BIN_DEST/lf-evening'
SERVICE

cat > "$SYSTEMD_USER/lf-evening.timer" << TIMER
[Unit]
Description=Run Local Focus OS Evening Review

[Timer]
OnCalendar=--* 19:30:00
Persistent=true

[Install]
WantedBy=timers.target
TIMER

systemctl --user daemon-reload
systemctl --user enable --now lf-morning.timer lf-evening.timer

echo "[OK] Local Focus OS installed."
echo "Run:"
echo " source ~/.bashrc"
echo " lf-status"
echo " lf-run"
