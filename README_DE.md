# Local Focus OS

Lokales, datenschutzfreundliches Workflow-System für Linux.

Local Focus OS wandelt Brain Dumps in strukturierte Aufgaben um, erzeugt Tages- und Abendkontrollen und nutzt optional lokale KI über Ollama.

## Ziel

Weniger Reibung.  
Mehr Ausführung.  
Keine Cloud-Pflicht.  
Keine Halluzination bei kritischen Aufgaben.

## Funktionen

- Brain Dump zu Aufgabenliste
- deterministisches Aufgabenrouting
- Tagesworkflow
- Abendkontrolle
- lokale Markdown-Reports
- optionale Ollama-Integration
- Secret-Scan vor Veröffentlichung
- systemd User Timer

## Installation

    git clone https://github.com/DonMassa84/local-focus-os.git
    cd local-focus-os
    chmod +x setup.sh
    ./setup.sh
    source ~/.bashrc
    lf-status

## Beispiel

    echo "housing, authority documents, project documentation, exam drill" | lf-run custom

## Sicherheitsprinzip

KI unterstützt Sprache.  
Regeln steuern Ausführung.  
Private Daten bleiben lokal.

## Warum lokal?

- keine Pflicht zur Cloud-Nutzung
- keine versteckte Telemetrie
- bessere Kontrolle über sensible Daten
- nachvollziehbare Bash- und Markdown-Struktur
- geeignet für Linux Mint und Ubuntu

## Status

Veröffentlicht als Open-Source-Projekt unter MIT-Lizenz.

## Warum dieses Projekt relevant ist

Local Focus OS zeigt praktische Linux-Automatisierung mit klarem operativem Zweck.

Es ist keine reine Skript-Sammlung, sondern ein kleines lokales Workflow-Betriebssystem mit:

- Bash-Automatisierung
- systemd User Timern
- Markdown-Reports
- lokaler KI-Integration über Ollama
- deterministischem Aufgabenrouting
- Human-Review-Grenzen
- datenschutzfreundlicher Architektur
- reproduzierbarer Installation

Das Projekt eignet sich als Proof-of-Work für IT Operations, Linux Administration, IT Service Management, Workflow-Automatisierung und lokale KI-Operations.

## Berufliches Signal

Das Projekt zeigt die Fähigkeit:

- operative Reibung zu erkennen
- wiederholbare Workflows zu entwerfen
- lokale Automatisierung umzusetzen
- Setup und Nutzung zu dokumentieren
- Sicherheitsgrenzen einzubauen
- ein sauberes Open-Source-Repository zu veröffentlichen
- Workflows über systemd Timer zu betreiben

## Positionierung

Erstellt von Daniel Massa als Proof-of-Work für das Rollenprofil:

KI-gestützter IT Operations & Automation Specialist

Schwerpunkte:

- Linux-Automatisierung
- Local-first AI
- IT-Operations-Workflows
- technische Dokumentation
- Human-in-the-loop Automation
- datenschutzbewusste Toolentwicklung

## ELIZA-Effekt

Local Focus OS dokumentiert den ELIZA-Effekt als Sicherheitsrisiko in KI-gestützten Workflows.

Das System behandelt KI-Ausgaben nicht als geprüfte Wahrheit und nicht als autonome Entscheidungsinstanz.

Dokumentation: docs/ELIZA_EFFECT.md

Reproduzierbare Workflows

Local Focus OS macht Workflows reproduzierbar, indem Befehle unter bin/lf-* gespeichert, unter docs/ dokumentiert und durch lokale Reports nachvollziehbar gemacht werden.

Dokumentation:

docs/REPRODUCIBLE_WORKFLOWS.md
docs/PDF_METADATA_WORKFLOW.md

## Regelmäßige automatische Workflows

Local Focus OS kann regelmäßige lokale Workflows über systemd User Timer ausführen.

Dokumentation: docs/SCHEDULED_WORKFLOWS.md

Steuerung:

    lf-schedule on
    lf-schedule status
    lf-schedule off
