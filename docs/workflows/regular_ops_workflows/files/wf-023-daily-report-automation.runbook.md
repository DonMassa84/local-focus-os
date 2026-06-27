# Runbook — WF-023 — Daily Report Automation

## Zweck
Tagesberichte aus Logs, Git, Status und Systemereignissen erzeugen.

## Vorbedingungen
- Lokales OpenClaw-Verzeichnis vorhanden
- Benötigte Datenquelle erreichbar
- Keine Secrets im Klartext in Logs oder Discord

## Ausführung
```bash
echo "START WF-023 — Daily Report Automation"
# TODO: konkreten Befehl eintragen
echo "DONE WF-023"
```

## Validierung
```bash
# TODO: Output-Dateien, Logs oder Status prüfen
```

## Fehlerbehandlung
1. Letzten Log prüfen
2. Inputpfad prüfen
3. Berechtigungen prüfen
4. Script isoliert ausführen
5. Fehler in Event Logging eintragen

## Rollback
- Geänderte Dateien aus Backup wiederherstellen
- Index neu bauen
- Statusmeldung korrigieren

## Abschlussmeldung
`WF-023 abgeschlossen: Output geprüft, Log geschrieben, Review gesetzt.`
