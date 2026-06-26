# Reproducible Workflows

## Ziel

Alle Local-Focus-OS-Workflows sollen reproduzierbar, testbar und dokumentiert sein.

Ein Workflow gilt als reproduzierbar, wenn er:

- als Befehl unter `bin/lf-*` liegt
- ausführbar ist
- über `setup.sh` automatisch nach `~/.local/bin` verlinkt wird
- einen lokalen Report erzeugt
- keine externen Aktionen ohne Human Review ausführt
- mit `bash -n` prüfbar ist
- in `docs/` dokumentiert ist

## Standardstruktur

```text
bin/lf-name
docs/NAME_WORKFLOW.md
~/.local/share/local-focus-os/reports/
Sicherheitsregel

Keine langen Wegwerfskripte in /tmp als dauerhafte Lösung.

Temporäre Skripte dürfen nur benutzt werden, um einen reproduzierbaren Repo-Befehl zu erzeugen.

Pflichtprüfung

Vor Commit und Push:

git status
bash -n bin/lf-name
lf-secret-scan .
lf-repro-check
Human Review

Automatisch erlaubt:

lokale Reports
lokale Logs
lokale Healthchecks
lokale Metadatenprüfung
Tages- und Abendworkflow

Nicht automatisch erlaubt:

E-Mail senden
GitHub pushen ohne Prüfung
Behörden anschreiben
Dateien löschen
sensible PDFs veröffentlichen
Fristen verbindlich bestätigen
Merksatz

Ein Workflow ist erst dann fertig, wenn er als Befehl, Dokumentation, Test und Report existiert.
