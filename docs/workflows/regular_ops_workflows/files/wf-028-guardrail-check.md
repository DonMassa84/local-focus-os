# WF-028 — Guardrail Check

**Kategorie:** Security  
**Status:** Konzept  
**Owner:** Schattenmacher  
**Letzter Review:** 2026-05-08

## 1 Situation
Riskante Aktionen vor Ausführung auf Secrets, PII, Löschung und Veröffentlichung prüfen.

## 2 Goal SMART
Bis zur Freigabe ist dieser Workflow dokumentiert, lokal ausführbar, versionierbar und in Discord sowie Wikimemo referenzierbar.

## 3 Stakeholders
- Operator / Owner
- OpenClaw Core
- Lokale Datenquellen
- Automatisierungs- oder RAG-Schicht
- Security / Compliance

## 4 Causes
### Human
Manuelle Arbeit soll reduziert und operatives Wissen schneller verfügbar gemacht werden.

### Organization
Wissen, Skripte und Abläufe liegen verteilt und müssen standardisiert werden.

### Process
Der Ablauf benötigt klare Trigger, Inputs, Outputs, Kontrollpunkte und Fehlerbehandlung.

## 5 Alternatives
### A — Manuell ausführen
Einfach, aber fehleranfällig und nicht skalierbar.

### B — Dokumentierter lokaler Workflow
Auditierbar, wiederholbar und lokal kontrollierbar.

### C — Vollautomatisierter Agentenworkflow
Hoher Nutzen, aber höheres Risiko und mehr Guardrails erforderlich.

## 6 Evaluation
### Economic
Reduziert Such-, Wiederholungs- und Fehlerkosten.

### Human
Entlastet den Operator und erhöht Entscheidungsgeschwindigkeit.

### Organizational
Macht Wissen anschlussfähig für RAG, Agenten und Automatisierung.

## 7 Decision + Justification
Standardentscheidung: Variante B als stabile Basis, Variante C erst nach erfolgreichem Test und Guardrail-Check.

## 8 Implementation
### Trigger
- Manuell
- Cron
- Telegram / Discord Command
- OpenClaw Command
- Webhook

### Inputs
- Dokumente
- E-Mails
- Logs
- Skripte
- Konfigurationen

### Steps
1. Quelle prüfen
2. Daten extrahieren
3. Daten normalisieren
4. Output speichern
5. Index oder Zielsystem aktualisieren
6. Ergebnis kontrollieren
7. Log schreiben

### Outputs
- Markdown-Dokumentation
- JSONL / CSV / Log
- RAG-Chunks
- Statusmeldung
- Discord-Update
- Wikimemo-Seite

## 9 Control
### KPIs
- Ausführung erfolgreich: ja/nein
- Fehleranzahl
- Anzahl verarbeiteter Items
- Laufzeit
- Output-Dateien vorhanden
- Testquery erfolgreich
- Review-Datum gesetzt

### Correction
Bei Fehlern: Log prüfen, Input validieren, Script isoliert ausführen, Recovery dokumentieren.

## 10 Sustainability & Communication
- Versionierung über Git
- Lokale Backups
- Keine Secrets in Logs
- Regelmäßiger Review
- Discord-Kurzstatus
- Wikimemo als dauerhafte Wissenskarte
- Rechtliches Risiko prüfen, sobald personenbezogene Daten verarbeitet werden

