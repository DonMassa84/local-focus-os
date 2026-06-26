# Case Study: Local Focus OS

## Kurzbeschreibung

Local Focus OS ist ein lokales, datenschutzfreundliches Workflow-System für Linux.  
Es verarbeitet Brain Dumps, erzeugt strukturierte Aufgaben, schreibt Markdown-Reports, nutzt systemd User Timer und kann optional lokale KI über Ollama einbinden.

## Ziel

Ziel war der Aufbau eines lokalen Betriebssystems für persönliche und operative Arbeitssteuerung:

- keine Cloud-Pflicht
- kontrollierte lokale Automatisierung
- reproduzierbare Workflows
- nachvollziehbare Reports
- Secret-Scan vor Veröffentlichung
- Human Review vor externen Aktionen
- Dokumentation von KI-Risiken wie dem ELIZA-Effekt

## Technischer Stack

| Bereich | Umsetzung |
|---|---|
| Betriebssystem | Linux Mint / Ubuntu |
| Automatisierung | Bash |
| Scheduling | systemd User Timer |
| Dokumentation | Markdown |
| KI-Integration | optional lokal über Ollama |
| Sicherheit | Secret Scan, Human Review, lokale Datenhaltung |
| Repository | Git / GitHub |
| Governance | AI_GOVERNANCE.md, ELIZA_EFFECT.md |

## Umgesetzte Funktionen

- Brain Dump zu strukturierter Aufgabenliste
- deterministisches Aufgabenrouting
- Tagesworkflow
- Abendkontrolle
- lokaler KI-Wrapper
- Secret Scan
- systemd Timer
- lokale Reports
- Workflow- und Dokumentenregister
- reproduzierbarer Build
- ELIZA-Effekt-Dokumentation
- Repo-Watch im ShadowMaker Kontrollzentrum

## Sicherheitsarchitektur

Local Focus OS führt keine externen Aktionen autonom aus.

Das System:

- sendet keine E-Mails automatisch
- pusht nicht automatisch ohne Review
- behandelt KI-Ausgaben nicht als geprüfte Wahrheit
- verlangt Human Review vor Veröffentlichung
- trennt lokale Rohdaten von veröffentlichbaren Artefakten
- nutzt Secret Checks vor GitHub-Veröffentlichungen

## ELIZA-Effekt als Governance-Risiko

Der ELIZA-Effekt beschreibt die Tendenz, KI-Systemen Verständnis, Absicht oder Autorität zuzuschreiben.  
Local Focus OS begrenzt dieses Risiko durch:

- klare Human-Review-Grenzen
- lokale Reports statt blinder Ausführung
- dokumentierte Sicherheitsregeln
- keine autonome externe Kommunikation
- explizite AI-Governance-Dokumentation

## Operativer Nutzen

Das Projekt zeigt praktische Fähigkeiten in:

- Linux-Automatisierung
- IT Operations
- lokaler Workflow-Steuerung
- systemd User Services
- Dokumentationsengineering
- AI Governance
- Privacy-first Tooling
- reproduzierbarer Installation
- Security-aware Publishing

## Karrierepositionierung

Dieses Projekt dient als Proof-of-Work für das Rollenprofil:

**KI-gestützter IT Operations & Automation Specialist**

Schwerpunkte:

- Local-first AI
- ITSM-nahe Prozesssteuerung
- Linux Automation
- Human-in-the-loop Workflows
- sichere Dokumentation
- Governance bei KI-gestützten Systemen

## Ergebnis

Local Focus OS ist nicht nur eine Skriptsammlung, sondern ein kleines lokales Workflow-Betriebssystem mit reproduzierbarer Struktur, Sicherheitsgrenzen, Dokumentation und regelmäßiger Überwachung.
