# Local Focus OS — Kaizen Dashboard Integration

Stand: 2026-06-28_005942

## Situation

Local Focus OS already has dashboard UI, Kaizen Workflow System and Regular Operations Workflows.

## Goal SMART

Integrate the old Kaizen dashboard information into the current dashboard layer without leaking private local paths or raw reports.

## 6 Components

### Model

Local workflow dashboard integration agent.

### Tools

- bash audit
- markdown docs
- dashboard source files
- git diff review

### Memory

Known:
- v0.2.7 Dashboard UI
- v0.2.8 Kaizen Workflow System
- v0.2.9 Regular Operations Workflows
- v0.3.5 LinkedIn/Telegram campaign importer

### Audio

Not required.

### Guardrails

- No private reports in public UI.
- No local absolute paths in portfolio output.
- No personal finance/health/authority data.

### Orchestration

1. Audit Kaizen/dashboard files.
2. Identify old dashboard source.
3. Extract only stable operational fields.
4. Integrate into current dashboard.
5. Add review checklist.
6. Commit only after clean diff.

## Required Dashboard Fields

```text
- current focus
- sprint count
- micro-commitment
- latest report link
- status: green/yellow/red
- next one-percent improvement
```

## Control

```bash
cd "/home/schattenmacher/openclaw_training/open_source/local-focus-os"
bash scripts/audit-kaizen-dashboard.sh
git diff --stat
git diff --check
```
