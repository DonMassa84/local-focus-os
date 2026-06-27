# Local Focus OS

Privacy-first workflow automation for Linux.

Local Focus OS is a local-first, open-source execution system for brain dumps, task routing, daily control, evening review, optional local AI usage and Markdown-based documentation.

## Features

- Brain dump to structured tasks
- Deterministic routing instead of hallucinated task lists
- Daily workflow sessions
- Morning and evening review
- Local AI wrapper through Ollama
- Email draft cleanup with local models
- Markdown-based local archive
- systemd user timer automation
- Basic secret scan before publishing

## Requirements

- Linux Mint / Ubuntu
- Bash
- systemd user services
- Optional: Ollama

## Quick Setup

    git clone https://github.com/DonMassa84/local-focus-os.git
    cd local-focus-os
    chmod +x setup.sh
    ./setup.sh
    source ~/.bashrc
    lf-status

## One-Line Setup

    git clone https://github.com/DonMassa84/local-focus-os.git && cd local-focus-os && chmod +x setup.sh && ./setup.sh

## Usage

    lf-run
    echo "housing, authority documents, project documentation, exam drill" | lf-run custom
    lf-evening
    lf-status

## Commands

| Command | Purpose |
|---|---|
| lf-task | Convert brain dump into deterministic task list |
| lf-run | Create full workflow session |
| lf-ai | Local Ollama wrapper |
| lf-email | Clean rough email draft locally |
| lf-morning | Morning workflow |
| lf-evening | Evening review |
| lf-status | Status check |
| lf-secret-scan | Basic secret/privacy scan |

## Safety

Local Focus OS does not send emails automatically, does not push to GitHub automatically, and does not verify facts by itself.

Human review is required before publishing, sending, submitting or sharing anything.

## Documentation

- German README: README_DE.md
- Installation guide: docs/INSTALL.md
- AI Governance: docs/AI_GOVERNANCE.md
- Architecture: docs/ARCHITECTURE.md

## License

MIT

## Quick Setup


## Autonomy Mode

Controlled local autonomy is available:

    lf-autonomy on
    lf-autonomy status
    lf-autonomy off

Documentation: docs/AUTONOMY.md

## Why this project matters

Local Focus OS demonstrates practical Linux automation with a clear operational purpose.

It is not just a script collection. It shows how local-first tools can be combined into a small workflow operating system with:

- Bash-based automation
- systemd user timers
- Markdown-based reporting
- local AI integration through Ollama
- deterministic task routing
- human review boundaries
- privacy-first design
- reproducible installation

The project is useful as a portfolio proof-of-work for IT Operations, Linux Administration, IT Service Management, workflow automation and local AI operations.

## Professional Signal

This project shows the ability to:

- identify operational friction
- design a repeatable workflow
- implement automation locally
- document setup and usage
- add safety boundaries
- publish a clean open-source repository
- operate the workflow through systemd timers

## Positioning

Built by Daniel Massa as proof-of-work for the role profile:

AI-assisted IT Operations and Automation Specialist

Focus areas:

- Linux automation
- local-first AI
- IT operations workflows
- documentation engineering
- human-in-the-loop automation
- privacy-aware tooling

## ELIZA Effect Awareness

Local Focus OS explicitly documents the ELIZA effect as a workflow safety risk.

The system does not treat AI output as verified truth or autonomous authority.

Documentation: docs/ELIZA_EFFECT.md

Reproducible Workflows

Local Focus OS keeps workflows reproducible by storing executable commands in bin/lf-*, documenting them in docs/, and writing local reports.

Documentation:

docs/REPRODUCIBLE_WORKFLOWS.md
docs/PDF_METADATA_WORKFLOW.md

## Scheduled Workflows

Local Focus OS includes scheduled local workflows through systemd user timers.

Documentation: docs/SCHEDULED_WORKFLOWS.md

Control:

    lf-schedule on
    lf-schedule status
    lf-schedule off

System Library

Local Focus OS keeps a local system library for stable documentation, runbooks and validation evidence.

Documentation: docs/SYSTEM_LIBRARY.md

Commands:

lf-library refresh
lf-library status
lf-library index


## Workflow and Document Registry

Local Focus OS maintains a generated registry of all workflows and documentation.

Documentation:

- docs/WORKFLOW_REGISTRY.md
- docs/DOCUMENT_REGISTRY.md
- docs/OPERATIONS_INDEX.md

Commands:

    lf-inventory refresh
    lf-inventory status

Reproducible Software Release

Local Focus OS can be built as a reproducible local software package.

make install
make test
make build

Release artifacts are written to:

dist/

Documentation:

docs/SOFTWARE_SPEC.md
docs/REPRODUCIBLE_BUILD.md
docs/RELEASE_ENGINEERING.md

## Install from GitHub Repository

    git clone https://github.com/DonMassa84/local-focus-os.git
    cd local-focus-os
    ./install.sh

Recommended one-liner:

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/DonMassa84/local-focus-os/main/bootstrap.sh)"

After installation:

    local-focus-os help
    local-focus-os doctor

Documentation:

- docs/INSTALL_FROM_REPO.md
- docs/INSTALL_RELEASE.md

## Case Study

A portfolio case study is available here:

docs/CASE_STUDY_LOCAL_FOCUS_OS.md

## Portfolio Summary

Eine kompakte Projektbeschreibung für Bewerbungen, GitHub und technische Gespräche liegt hier:

[Local Focus OS Portfolio Summary](docs/portfolio/LOCAL_FOCUS_OS_PORTFOLIO_SUMMARY.md)

## Release Proof

Nachweis zur veröffentlichten Version:

[Local Focus OS Release Proof v0.2.2](docs/proofs/LOCAL_FOCUS_OS_RELEASE_PROOF_v0.2.2.md)

## Kaizen Workflow System

Wiederverwendbare Workflows für Daily Control, Micro-Commitments, Fokus-Sprints und Weekly Review:

[Kaizen Workflow System](docs/workflows/kaizen_system/README.md)

Project Management

Priorisierte Aufgabenliste für die nächsten Local-Focus-OS-Ausbaustufen:

Local Focus OS Priority Tasklist

## Project Management

Priorisierte Aufgabenliste für die nächsten Local-Focus-OS-Ausbaustufen:

[Local Focus OS Priority Tasklist](docs/project_management/LOCAL_FOCUS_OS_PRIORITY_TASKLIST.md)

## Local Focus OS Dashboard

Grafische Übersicht über Portfolio-Bausteine, Workflow-Module, Release-Nachweise und nächste Integrationsschritte:

[Local Focus OS Dashboard](docs/ui/local-focus-os-dashboard/index.html)

## Regular Operations Workflows

Kuratierte Workflows für Daily Reports, Guardrail Checks, Reviews, Statuskontrolle und wiederholbare IT-Operations-Routinen:

[Regular Operations Workflows](docs/workflows/regular_ops_workflows/README.md)

## Taskboard + Kaizen Cockpit

Das Dashboard enthält ein lokales Taskboard mit Kaizen-Steuerung für Daily Highlight, Micro-Commitments, Fokus-Sprints und Markdown-Export:

[Local Focus OS Dashboard](docs/ui/local-focus-os-dashboard/index.html)
