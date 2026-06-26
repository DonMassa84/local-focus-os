# Scheduled Workflows

## Zweck

Local Focus OS kann regelmäßige lokale Workflows über systemd user timers ausführen.

Diese Workflows erzeugen lokale Reports und Logs.

## Sicherheit

Scheduled Workflows führen keine externen Aktionen aus.

Nicht erlaubt:

- automatische E-Mails
- automatische GitHub-Pushes
- automatische Datei-Löschung
- PDF-Veränderung
- externe Einreichungen

Erlaubt:

- lokale Healthchecks
- lokale Repro-Checks
- kleine PDF-Metadaten-Scans
- lokale Weekly Audits
- lokale Monthly Snapshots
- lokale Reports und Logs

## Befehle

    lf-schedule on
    lf-schedule off
    lf-schedule status
    lf-schedule logs
    lf-schedule run status
    lf-schedule run repro
    lf-schedule run pdf
    lf-schedule run weekly
    lf-schedule run monthly

## Standard-Zeitplan

    lf-autonomy-healthcheck.timer    stündlich Minute 15
    lf-autonomy-morning.timer        täglich 08:05
    lf-autonomy-evening.timer        täglich 19:30
    lf-scheduled-repro.timer         täglich 20:40
    lf-scheduled-pdf.timer           täglich 21:05
    lf-scheduled-weekly.timer        Sonntag 10:30
    lf-scheduled-monthly.timer       Monatlich am 1. um 09:30

## PDF Scan konfigurieren

    lf-schedule pdf-dir ~/Downloads 10

## Reports

Reports liegen unter:

    ~/.local/share/local-focus-os/reports/

Logs liegen unter:

    ~/.local/share/local-focus-os/logs/scheduled_workflows.log

## Reproduzierbarkeit

Jeder Scheduled Workflow ist als Befehl unter `bin/lf-*` implementiert und wird durch `setup.sh` nach `~/.local/bin` verlinkt.
