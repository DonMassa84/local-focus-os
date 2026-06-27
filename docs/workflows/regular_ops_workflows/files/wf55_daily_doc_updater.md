# Workflow: WF-55 Daily Documentation Updater (Wikipedia/Confluence-Stil)

**Projekt:**   openclaw
**Kategorie:** automation | documentation
**Datum:**     2026-05-30 08:14
**Status:**    aktiv
**Last validated:** 2026-05-30

## Beschreibung

Tägliche automatische Aktualisierung der Systemdokumentation im Wikipedia/Confluence-Stil.
Erstellt strukturierte Markdown-Seiten mit Infoboxen, Tabellen und Abschnitten.
Sendet Zusammenfassung an Discord. Läuft täglich 02:00 CEST via systemd-Timer.

## Voraussetzungen

- [x] `/home/schattenmacher/llm_env/bin/python3` verfügbar
- [x] `~/openclaw_training/scripts/discord_send.sh` vorhanden
- [x] `nvidia-smi` installiert (für GPU-Daten)
- [x] `docker` verfügbar (für Container-Status)

## Skript / Kommando

```bash
# Manuell ausführen:
/home/schattenmacher/llm_env/bin/python3 ~/openclaw_training/scripts/daily_doc_updater.py

# Timer starten (einmalig):
systemctl --user enable --now daily-doc-updater.timer

# Status prüfen:
systemctl --user status daily-doc-updater.timer
```

## Eingaben / Zielpfade

| Parameter | Wert |
|-----------|------|
| Script | `~/openclaw_training/scripts/daily_doc_updater.py` |
| Service | `~/.config/systemd/user/daily-doc-updater.service` |
| Timer | `~/.config/systemd/user/daily-doc-updater.timer` |
| Output STATUS | `~/openclaw_training/docs/STATUS.md` |
| Output CHANGELOG | `~/openclaw_training/docs/CHANGELOG.md` |
| Wiki-Kopien | `~/Projects/linuxmint-22.2-cinnamon-64bit/wiki/` |
| Log | `~/openclaw_training/logs/daily_doc_updater_YYYY-MM-DD.log` |

## Ergebnis (erster Lauf 2026-05-30)

- `STATUS.md` generiert: GPU, RAM, CPU, Services-Tabelle, Docker, Adapter, Housing
- `CHANGELOG.md` mit Tageseintrag 2026-05-30
- Discord-Nachricht gesendet (HTTP OK)
- Timer aktiv: nächster Lauf So 2026-05-31 02:00

## Bekannte Risiken / Grenzen

- Discord-Fehler bricht Script nicht ab (nur Warning)
- GPU-Daten fehlen wenn nvidia-smi nicht verfügbar
- Service-Status nur für systemd --user Services korrekt

## Reproduzierbarkeit

- Wiederholbar: ja
- Voraussetzungen erfüllt: ja
- Letzter erfolgreicher Test: 2026-05-30 08:14

## Änderungshistorie

| Datum | Änderung | Von |
|-------|----------|-----|
| 2026-05-30 | Erstellt | opencode |

## Verwandte Workflows / Runbooks

- `WORKFLOWS.md` WF-55 (Master-Dokumentation)
- `~/openclaw_training/scripts/weekly_planner.py` (WF-54, wöchentlich)

---
*Template: ~/workflow-knowledge/templates/workflow_entry_template.md*
