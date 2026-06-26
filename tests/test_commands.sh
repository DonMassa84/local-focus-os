#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== TEST: COMMANDS ===="
date
echo

export PATH="$HOME/.local/bin:$PATH"

REPO="${1:-$HOME/openclaw_training/open_source/local-focus-os}"

cd "$REPO"

PASS=0
FAIL=0

ok() {
  echo "[OK] $*"
  PASS=$((PASS+1))
}

fail() {
  echo "[FAIL] $*"
  FAIL=$((FAIL+1))
}

check_file() {
  local f="$1"
  if [[ -f "$f" ]]; then
    ok "file exists: $f"
  else
    fail "file missing: $f"
  fi
}

check_exec() {
  local f="$1"
  if [[ -x "$f" ]]; then
    ok "executable: $f"
  else
    fail "not executable: $f"
  fi
}

check_command() {
  local c="$1"
  if command -v "$c" >/dev/null 2>&1; then
    ok "command found: $c"
  else
    fail "command missing: $c"
  fi
}

echo "== Files =="
check_file VERSION
check_file README.md
check_file README_DE.md
check_file PROJECT_STATUS.md
check_file docs/WORKFLOW_REGISTRY.md
check_file docs/DOCUMENT_REGISTRY.md
check_file docs/OPERATIONS_INDEX.md
check_file docs/SOFTWARE_SPEC.md
check_file docs/REPRODUCIBLE_BUILD.md
check_file docs/RELEASE_ENGINEERING.md

echo
echo "== Executables =="

for f in bin/local-focus-os bin/lf-*; do
  [[ -f "$f" ]] || continue
  check_exec "$f"
  bash -n "$f" && ok "syntax: $f" || fail "syntax: $f"
done

echo
echo "== Installed Commands =="

for c in local-focus-os lf-status lf-autonomy lf-schedule lf-inventory lf-library lf-repro-check lf-secret-scan; do
  check_command "$c"
done

echo
echo "== Functional Smoke Tests =="

if local-focus-os version >/tmp/lfo_test_version.log 2>&1; then
  ok "local-focus-os version"
else
  fail "local-focus-os version"
fi

if local-focus-os status >/tmp/lfo_test_status.log 2>&1; then
  ok "local-focus-os status"
else
  fail "local-focus-os status"
fi

if lf-inventory status >/tmp/lfo_test_inventory.log 2>&1; then
  ok "lf-inventory status"
else
  fail "lf-inventory status"
fi

echo
echo "==== TEST RESULT ===="
echo "PASS=$PASS"
echo "FAIL=$FAIL"

if [[ "$FAIL" -eq 0 ]]; then
  echo "GESAMTSTATUS: OK"
  exit 0
else
  echo "GESAMTSTATUS: FEHLER"
  exit 1
fi
