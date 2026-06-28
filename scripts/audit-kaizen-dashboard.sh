#!/usr/bin/env bash
set -Eeuo pipefail

echo "==== Local Focus OS Kaizen Dashboard Audit ===="
echo

echo "== Kaizen-related files =="
find . -type f \
  \( -iname "*kaizen*" -o -iname "*dashboard*" -o -iname "*status*" \) \
  -not -path "./.git/*" \
  -not -path "./node_modules/*" \
  | sort

echo
echo "== Candidate dashboard files =="
find . -type f \
  \( -iname "*.md" -o -iname "*.ts" -o -iname "*.tsx" -o -iname "*.js" -o -iname "*.jsx" -o -iname "*.html" \) \
  -not -path "./.git/*" \
  -not -path "./node_modules/*" \
  | grep -Ei 'dashboard|kaizen|status|report' || true

echo
echo "Review candidates and integrate only non-private status summaries."
