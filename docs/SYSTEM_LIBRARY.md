# Systembibliothek

## Zweck

Die Local-Focus-OS-Systembibliothek ist der lokale Ablageort für stabile Dokumentation, Runbooks, Betriebsnachweise und Sicherheitsregeln.

Sie dient als lokale Wissensbasis für:

- Installation
- Autonomy Mode
- Scheduled Workflows
- Reproducibility Checks
- PDF Metadata Workflow
- ELIZA-Effekt
- AI Governance
- Portfolio- und Recruiter-Dokumentation
- Validierungsnachweise

## Pfade

```text
~/.local/share/local-focus-os/library/
~/openclaw_training/system_library/local-focus-os/
Befehl
lf-library status
lf-library refresh
lf-library index
lf-library open
lf-library reports
lf-library logs
Struktur
library/
├── INDEX.md
├── README.md
├── README_DE.md
├── ROADMAP.md
├── SECURITY.md
├── CONTRIBUTING.md
├── LICENSE
└── docs/
    ├── INSTALL.md
    ├── AUTONOMY.md
    ├── SCHEDULED_WORKFLOWS.md
    ├── REPRODUCIBLE_WORKFLOWS.md
    ├── PDF_METADATA_WORKFLOW.md
    ├── ELIZA_EFFECT.md
    ├── AI_GOVERNANCE.md
    ├── RECRUITER_SUMMARY.md
    ├── PROFILE_ANALYSIS_DANIEL_MASSA.md
    └── VALIDATION_v0.1.0.md
Workflow
Dokumentation im Repo unter docs/ pflegen.
lf-library refresh ausführen.
Lokale Bibliothek prüfen mit lf-library index.
Reports prüfen mit lf-library reports.
Sicherheitsgrenze

Die Systembibliothek ist lokal.

Sie sendet nichts automatisch, pusht nichts automatisch und verändert keine externen Systeme.

Merksatz

Repo ist die Quelle.
Systembibliothek ist der lokale Wissensspeicher.
Reports sind der Betriebsnachweis.

## Workflow- und Dokumentenregister

Die Systembibliothek nimmt alle Workflows und Dokumente automatisch auf.

Befehle:

    lf-inventory refresh
    lf-library refresh

Erzeugte Register:

- docs/WORKFLOW_REGISTRY.md
- docs/DOCUMENT_REGISTRY.md
- docs/OPERATIONS_INDEX.md
