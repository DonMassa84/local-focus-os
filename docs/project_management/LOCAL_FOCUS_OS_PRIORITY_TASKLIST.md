# Local Focus OS — Priorisierte Taskliste

Stand: 2026-06-27

## Gesamtziel

Local Focus OS als verwertbaren GitHub-Portfolio-Baustein für IT Operations, Linux Automation, lokale KI-Workflows, Security Awareness, AI Governance, TALK-Kommunikation und Kaizen-Selbststeuerung ausbauen.

---

## P0 — Zustand sichern

### Ziel

Keine halbfertigen Imports, keine falschen Releases, keine Massendumps.

### Aufgaben

- [ ] Ins richtige Repo wechseln:

    cd /home/schattenmacher/openclaw_training/open_source/local-focus-os

- [ ] Git-Zustand prüfen:

    git status -sb
    git log --oneline --decorate -10
    git tag --list "v0.2.*" --sort=version:refname

- [ ] Prüfen, ob halbfertige Regular-Ops-Imports existieren:

    find docs/workflows -maxdepth 3 -type d | sort

- [ ] Keine Massendumps übernehmen.
- [ ] Keine Backup-, Log-, Report-, Cache-, Export- oder .git-Inhalte veröffentlichen.

### Kontrolle

Erwartung:

- main ist synchron mit origin/main
- keine uncommitted Chaos-Dateien
- keine 10.000+ Workflow-Kandidaten im Repo

---

## P1 — Kaizen-System integrieren

### Ziel

Kaizen als eigenes generisches Modul integrieren.

### Zielpfad

    docs/workflows/kaizen_system/

### Enthaltene Bausteine

- Daily Kaizen Control
- Kaizen Sprint
- Weekly Kaizen Review
- Kaizen Runbook
- Kaizen Checklist
- Manifest
- README-Link

### Aufgaben

- [ ] Kaizen-Dateien prüfen.
- [ ] Secret-/Rohdaten-Scan prüfen.
- [ ] Commit erstellen:

    git add docs/workflows/kaizen_system README.md
    git commit -m "Add Kaizen workflow system module"
    git push origin main

- [ ] Release erstellen:

    git tag -a v0.2.6 -m "Add Kaizen workflow system module"
    git push origin v0.2.6

    gh release create v0.2.6 \
      --title "v0.2.6 Kaizen Workflow System Module" \
      --notes "Added a Kaizen workflow system module for daily control, brain dump, daily highlight, micro-commitments, focus sprints, weekly review, correction, and operational self-management."

### Kontrolle

    find docs/workflows/kaizen_system -maxdepth 4 -type f | sort
    gh release view v0.2.6 --web

---

## P2 — v0.2.5 transparent markieren

### Situation

v0.2.5 wurde vor dem erfolgreichen Regular-Ops-Import veröffentlicht.

### Ziel

Nicht löschen, nicht umbiegen. Transparent markieren.

### Aufgabe

    gh release edit v0.2.5 \
      --notes "Premature release tag created before the regular operations workflow import completed. Superseded by v0.2.6."

### Kontrolle

    gh release view v0.2.5

---

## P3 — Regular Operations Workflows kuratiert integrieren

### Ziel

Nur starke, wiederverwendbare Workflows übernehmen. Kein Massendump.

### Zielpfad

    docs/workflows/regular_ops_workflows/

### Kandidaten

- Daily Report Automation
- Guardrail Check
- Workflow Review Checklist
- Dashboard Best Practices
- Status History Schema
- Git Sync Dashboard Status
- OCR Watcher Service
- Daily Document Updater
- LoRA Training Evaluation Daily Status
- Local AI OS System Control
- Evening Check

### Nicht übernehmen

- backup__daily_*
- workflow_hub/merged/docs/backup__*
- logs/
- reports/
- .git/
- node_modules/
- .cache/
- exports/
- .secret_quarantine*
- personenbezogene Rohdaten

### Aufgaben

- [ ] Regular-Ops-Dateien prüfen.
- [ ] Secret-/Rohdaten-Scan prüfen.
- [ ] Commit erstellen:

    git add docs/workflows/regular_ops_workflows README.md
    git commit -m "Add curated regular operations workflows"
    git push origin main

- [ ] Release erstellen:

    git tag -a v0.2.7 -m "Add curated regular operations workflows"
    git push origin v0.2.7

    gh release create v0.2.7 \
      --title "v0.2.7 Regular Operations Workflows" \
      --notes "Added curated regular operations workflows for daily reports, guardrail checks, workflow review, dashboard/status standards, OCR watcher, document updater, LoRA evaluation status, system control, and evening checks."

### Kontrolle

    find docs/workflows/regular_ops_workflows -maxdepth 4 -type f | sort
    gh release view v0.2.7 --web

---

## P4 — README-Navigation konsolidieren

### Pflichtlinks

- Portfolio Summary
- Release Proof
- TALK Communication Workflows
- Kaizen Workflow System
- Regular Operations Workflows
- Priority Tasklist

### Prüfen

    grep -nE "Portfolio|Release Proof|TALK|Kaizen|Regular|Priority" README.md

---

## P5 — Portfolio-Verwertung

### CV-Satz

Local Focus OS: Eigenes Open-Source-Projekt zur lokalen Automatisierung und Dokumentation operativer IT-Workflows mit Linux, Bash, systemd User Timers, Markdown-Reporting, Secret Hygiene, Human Review, TALK-Kommunikationsworkflows, Kaizen-Selbststeuerung und AI-Governance-Dokumentation.

### LinkedIn-Satz

Ich entwickle mit Local Focus OS ein lokales Workflow-System für IT Operations, Automatisierung und AI Governance. Das Projekt kombiniert Linux, Bash, systemd, Markdown-Dokumentation, Secret Hygiene, Human Review sowie wiederverwendbare Module für Kommunikation, Kaizen-Selbststeuerung und regelmäßige Betriebsroutinen.

---

## P6 — Qualitätskontrolle vor jedem Release

### Pflichtcheck

    git status -sb
    git log --oneline --decorate -8
    grep -RniE "token|secret|password|passwd|api_key|apikey|private_key|bearer|ghp_|github_pat_|sk-|proton|gmail|jobcenter|iban|bic|adresse|telefon|handy|geburtsdatum|kundennummer|bg-nummer|steuernummer|versicherungsnummer|smtp|imap" docs README.md 2>/dev/null | head -100

### Release-Regel

Nur releasen, wenn:

- Working Tree sauber
- Commit gepusht
- Secret-Scan sauber
- README-Link korrekt
- Zielordner vorhanden
- Manifest vorhanden
- keine privaten Logs/Rohdaten enthalten

---

## Reihenfolge kurz

1. Taskliste reparieren und committen
2. Kaizen-System prüfen und integrieren
3. v0.2.6 veröffentlichen
4. v0.2.5 als premature markieren
5. Regular Ops kuratiert prüfen und integrieren
6. v0.2.7 veröffentlichen
7. README-Navigation konsolidieren
8. CV/LinkedIn-Baustein übernehmen

---

## Nicht verhandelbar

- Keine Massendumps
- Keine Secrets
- Keine privaten Logs
- Keine Jobcenter-/Finanz-/Gesundheitsdaten
- Keine alten Backup-Wüsten
- Keine Tags nachträglich verschieben
