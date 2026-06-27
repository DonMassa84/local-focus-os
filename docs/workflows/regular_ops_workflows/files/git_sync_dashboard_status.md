# Status: Git Sync Dashboard

## Aktueller Stand (2026-05-30)

Das Git Sync Dashboard ist als Kontrollzentrale definiert, dokumentiert und operativ vorhanden.

## Vorhanden

```text
dashboard/git-sync-dashboard.html        OK (38 KB, V1)
dashboard/git-sync-dashboard-v2.html     OK (38 KB, Referenz-Design)
dashboard/workflow_dashboard.html        OK (generiert, workflow_dashboard.sh)
dashboard/data/repos.json                OK (5 Repos)
dashboard/data/hooks.json                OK (15 Hook-Einträge)
dashboard/data/remotes.json              OK
dashboard/data/timers.json               OK
dashboard/data/security.json             OK (14 Patterns, 0 missing)
dashboard/data/git_status_summary.json   OK
```

## Technische Einordnung

| | |
|---|---|
| Daten-Quelle V1 | statische Inline-Daten (const repos = ...) |
| Daten-Quelle V2-Ziel | dashboard/data/*.json per fetch() |
| JSON-Backend | vorhanden und befüllt |
| HTML-Anbindung | noch statisch — V2 offen |

## Offen

```text
install_hooks_all_repos.sh     — 12 von 15 Hooks fehlen noch
pre-push Secret-Blocker        — nur im openclaw_training-Repo aktiv
commit-msg Hook                — nur im openclaw_training-Repo aktiv
Dashboard V2 JSON-Anbindung    — HTML noch statisch
API-Status-Panel               — api_status.json vorhanden, Panel fehlt
```

## Entscheidung

Das Dashboard wird als **WF-DASH-01** im produktiven Workflow-Index geführt.
Die V2-Anbindung an echte JSON-Daten ist der nächste Ausbauschritt nach Run13-Eval.
