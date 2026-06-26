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

```bash
chmod +x install.sh
./install.sh
source ~/.bashrc
lf-status
Beispiel
echo "housing, authority documents, project documentation, exam drill" | lf-run custom
Sicherheitsprinzip

KI unterstützt Sprache.
Regeln steuern Ausführung.
Private Daten bleiben lokal.

Warum lokal?
keine Pflicht zur Cloud-Nutzung
keine versteckte Telemetrie
bessere Kontrolle über sensible Daten
nachvollziehbare Bash- und Markdown-Struktur
geeignet für Linux Mint und Ubuntu
Status

Veröffentlicht als Open-Source-Projekt unter MIT-Lizenz.
