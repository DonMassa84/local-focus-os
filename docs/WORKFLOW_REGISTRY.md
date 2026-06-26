# Workflow Registry

## Zweck

Dieses Dokument listet alle ausführbaren Local-Focus-OS-Workflows.

## Sicherheitsprinzip

- lokale Reports erlaubt
- lokale Logs erlaubt
- systemd Timer erlaubt
- keine automatischen E-Mails
- keine automatischen GitHub-Pushes
- keine automatische Datei-Löschung
- externe Aktionen nur nach Human Review

## Workflows

| Befehl | Repo-Datei | Installierter Pfad | Status |
|---|---|---|---|
| `lf-ai` | `bin/lf-ai` | `/home/schattenmacher/.local/bin/lf-ai` | executable |
| `lf-autonomy` | `bin/lf-autonomy` | `/home/schattenmacher/.local/bin/lf-autonomy` | executable |
| `lf-autonomy-run` | `bin/lf-autonomy-run` | `/home/schattenmacher/.local/bin/lf-autonomy-run` | executable |
| `lf-email` | `bin/lf-email` | `/home/schattenmacher/.local/bin/lf-email` | executable |
| `lf-evening` | `bin/lf-evening` | `/home/schattenmacher/.local/bin/lf-evening` | executable |
| `lf-inventory` | `bin/lf-inventory` | `/home/schattenmacher/.local/bin/lf-inventory` | executable |
| `lf-library` | `bin/lf-library` | `/home/schattenmacher/.local/bin/lf-library` | executable |
| `lf-morning` | `bin/lf-morning` | `/home/schattenmacher/.local/bin/lf-morning` | executable |
| `lf-pdf-meta-scan` | `bin/lf-pdf-meta-scan` | `/home/schattenmacher/.local/bin/lf-pdf-meta-scan` | executable |
| `lf-repro-check` | `bin/lf-repro-check` | `/home/schattenmacher/.local/bin/lf-repro-check` | executable |
| `lf-run` | `bin/lf-run` | `/home/schattenmacher/.local/bin/lf-run` | executable |
| `lf-schedule` | `bin/lf-schedule` | `/home/schattenmacher/.local/bin/lf-schedule` | executable |
| `lf-scheduled-run` | `bin/lf-scheduled-run` | `/home/schattenmacher/.local/bin/lf-scheduled-run` | executable |
| `lf-secret-scan` | `bin/lf-secret-scan` | `/home/schattenmacher/.local/bin/lf-secret-scan` | executable |
| `lf-status` | `bin/lf-status` | `/home/schattenmacher/.local/bin/lf-status` | executable |
| `lf-task` | `bin/lf-task` | `/home/schattenmacher/.local/bin/lf-task` | executable |

## Systemd Timer

| Unit | Zweck |
|---|---|
| `lf-autonomy-healthcheck.timer` | stündlicher Autonomy Healthcheck |
| `lf-autonomy-morning.timer` | täglicher Morgenworkflow |
| `lf-autonomy-evening.timer` | tägliche Abendkontrolle |
| `lf-scheduled-repro.timer` | täglicher Repro-Check |
| `lf-scheduled-pdf.timer` | täglicher PDF-Metadaten-Scan |
| `lf-scheduled-weekly.timer` | wöchentlicher Audit |
| `lf-scheduled-monthly.timer` | monatlicher Snapshot |

## Prüfung

```bash
lf-repro-check
lf-schedule status
lf-autonomy status
lf-library index
```
