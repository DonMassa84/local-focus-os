#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== REPO DOCTOR ===="
echo "Repo: $(basename "$PWD")"
echo "Path: $PWD"
echo

fail=0

check() {
  if [ -e "$1" ]; then
    echo "[OK] $1"
  else
    echo "[MISS] $1"
    fail=1
  fi
}

check README.md
check Makefile
check .env.example
check docs/ARCHITECTURE.md
check docs/RUNBOOK.md
check docs/REPRODUCIBILITY.md
check docs/SECURITY.md
check docs/RELEASE_PROCESS.md
check scripts/smoke-test.sh
check scripts/security-scan.sh
check scripts/release-check.sh
check scripts/agent-doctor.sh
check docs/agent/AI_AGENT_KNOWLEDGE.md

echo
git status --short || true

if [ "$fail" -eq 0 ]; then
  echo "[DONE] Repo baseline complete."
else
  echo "[WARN] Repo baseline incomplete."
fi

exit "$fail"
