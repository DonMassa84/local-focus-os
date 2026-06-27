# Runbook — WF-028 — Guardrail Check

## Zweck
Riskante Aktionen vor Ausführung auf Secrets, PII, Löschung und Veröffentlichung prüfen.

## Vorbedingungen
- Lokales OpenClaw-Verzeichnis vorhanden
- Benötigte Datenquelle erreichbar
- Keine Secrets im Klartext in Logs oder Discord

## Ausführung
```bash
echo "START WF-028 — Guardrail Check"
# TODO: konkreten Befehl eintragen
echo "DONE WF-028"
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
`WF-028 abgeschlossen: Output geprüft, Log geschrieben, Review gesetzt.`
