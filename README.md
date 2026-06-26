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
