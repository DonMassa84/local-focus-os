# WF-56: LoRA-Training-Run mit Eval & Daily-Status-Automation

**Datum:** 2026-05-30
**Status:** dokumentiert (Training Run13 läuft noch)
**Autor:** schattenmacher

---

## Was wurde erreicht

- Vollständiger Workflow für kontrollierten LoRA-Training-Run (Run13) dokumentiert
- Phasen: Monitoring → Daily-Status-Automation → History-Schema → Warten → Eval → Security
- `status_history.json` auf Schema v1.0 migriert (Top-Level-Metadaten + `runs`-Liste)
- `create_daily_status.sh` auf Schema v1.0 angepasst, defensiver Parser
- `openclaw-daily-status.timer` aktiviert (07:05 täglich)
- `status_history_schema.md` in `workflow-knowledge/standards/` dokumentiert

## Schlüsselentscheidungen

- Eval ist **human-in-the-loop** — kein automatischer Trigger nach Training
- `status_history.json` behält `loss_series_run13` als Seitenfeld für Verlaufsdaten
- Kontrolliertes Vokabular für `status` und `type` (kein Freitext)
- Backup vor jeder Migration: `*.bak_schema_migration`

## PASS-Kriterien Eval

| Kriterium | Schwelle |
|-----------|---------|
| Score | ≥ 85 |
| Verbotene Begriffe | = 0 |
| Pflichtbegriffe | ≥ 7/9 |
| Struktur | ≥ 10/11 |
| KPIs | ≥ 3 |
| Kein pauschales Kein-Risiko | ja |

## Relevante Dateien

| Datei | Zweck |
|-------|-------|
| `WORKFLOWS.md` | WF-56 Zeile ~1802 |
| `workflow-knowledge/standards/status_history_schema.md` | Schema v1.0 Dokumentation |
| `~/openclaw_training/mission_control/pipeline_dashboard/status_history.json` | Live-History |
| `~/workflow-knowledge/projects/openclaw/create_daily_status.sh` | Tagesstatus-Generator |
| `~/.config/systemd/user/openclaw-daily-status.timer` | Tägl. 07:05 |

## Offene Punkte (bei Dokumentationserstellung)

- Run13 PID 234417 läuft noch
- Eval steht aus (wartet auf Freigabe)
- Security-Tokens (IMAP, getmail, Telegram, Discord) noch nicht rotiert
