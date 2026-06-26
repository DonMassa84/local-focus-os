#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== LOCAL FOCUS OS SETUP ===="
date
echo

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_SRC="$ROOT/bin"
BIN_DEST="$HOME/.local/bin"
DATA_HOME="${LF_HOME:-$HOME/.local/share/local-focus-os}"
CONFIG_HOME="$HOME/.config/local-focus-os"
SYSTEMD_USER="$HOME/.config/systemd/user"

mkdir -p "$BIN_DEST" "$DATA_HOME" "$CONFIG_HOME" "$SYSTEMD_USER"

echo "== 1) Check system =="

if [[ ! -d "$BIN_SRC" ]]; then
  echo "ERROR: bin directory not found: $BIN_SRC"
  exit 1
fi

if ! command -v bash >/dev/null 2>&1; then
  echo "ERROR: bash not found."
  exit 1
fi

echo "[OK] Base checks passed"
echo

echo "== 2) Install commands =="

for f in "$BIN_SRC"/lf-*; do
  if [[ -f "$f" ]]; then
    chmod +x "$f"
    ln -sf "$f" "$BIN_DEST/$(basename "$f")"
    echo "[OK] $(basename "$f") -> $BIN_DEST/$(basename "$f")"
  fi
done

echo
echo "== 3) Ensure PATH =="

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
  echo "[OK] Added ~/.local/bin to ~/.bashrc"
else
  echo "[OK] PATH already configured in ~/.bashrc"
fi

export PATH="$HOME/.local/bin:$PATH"
hash -r || true

echo
echo "== 4) Create config =="

cat > "$CONFIG_HOME/config.env" << CONFIG_EOF
# Local Focus OS config
LF_MODEL=llama3.2
LF_HOME=$DATA_HOME
CONFIG_EOF

echo "[OK] Config: $CONFIG_HOME/config.env"

echo
echo "== 5) Install systemd user timers =="

if command -v systemctl >/dev/null 2>&1; then
  systemctl --user disable --now lf-morning.timer lf-evening.timer >/dev/null 2>&1 || true

  cat > "$SYSTEMD_USER/lf-morning.service" << SERVICE_EOF
[Unit]
Description=Local Focus OS Morning Workflow

[Service]
Type=oneshot
EnvironmentFile=-%h/.config/local-focus-os/config.env
ExecStart=%h/.local/bin/lf-morning
SERVICE_EOF

  cat > "$SYSTEMD_USER/lf-morning.timer" << TIMER_EOF
[Unit]
Description=Run Local Focus OS Morning Workflow

[Timer]
OnCalendar=*-*-* 08:05:00
Persistent=true

[Install]
WantedBy=timers.target
TIMER_EOF

  cat > "$SYSTEMD_USER/lf-evening.service" << SERVICE_EOF
[Unit]
Description=Local Focus OS Evening Review

[Service]
Type=oneshot
EnvironmentFile=-%h/.config/local-focus-os/config.env
ExecStart=%h/.local/bin/lf-evening
SERVICE_EOF

  cat > "$SYSTEMD_USER/lf-evening.timer" << TIMER_EOF
[Unit]
Description=Run Local Focus OS Evening Review

[Timer]
OnCalendar=*-*-* 19:30:00
Persistent=true

[Install]
WantedBy=timers.target
TIMER_EOF

  systemctl --user daemon-reload
  systemctl --user reset-failed >/dev/null 2>&1 || true
  systemctl --user enable --now lf-morning.timer lf-evening.timer

  echo "[OK] systemd user timers installed"
else
  echo "[WARN] systemctl unavailable. Skipping timer installation."
fi

echo
echo "== 6) Optional Ollama check =="

if command -v ollama >/dev/null 2>&1; then
  echo "[OK] Ollama found"
  ollama list || true
else
  echo "[INFO] Ollama not found. Local AI commands require Ollama."
fi

echo
echo "== 7) Smoke test =="

if command -v lf-status >/dev/null 2>&1; then
  lf-status || true
else
  echo "[WARN] lf-status not found after install. Reload shell or check PATH."
fi

echo
echo "==== SETUP COMPLETE ===="
echo "Run:"
echo "  source ~/.bashrc"
echo "  lf-status"
echo
echo "Create workflow:"
echo '  echo "housing, authority documents, project documentation, exam drill" | lf-run custom'
