#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export PATH="$ROOT/bin:$PATH"
export LF_HOME="$(mktemp -d)"

echo "authority documents, housing, local workflow, exam drill, email already sent" | lf-task
echo "authority documents, housing, local workflow, exam drill" | lf-run custom
lf-status
lf-secret-scan "$ROOT"

echo "[OK] basic test completed"
