# Installation

## Standard Installation

    git clone https://github.com/DonMassa84/local-focus-os.git
    cd local-focus-os
    chmod +x setup.sh
    ./setup.sh
    source ~/.bashrc
    lf-status

## One-Line Installation

    git clone https://github.com/DonMassa84/local-focus-os.git && cd local-focus-os && chmod +x setup.sh && ./setup.sh

## Usage

    lf-status
    lf-run
    echo "housing, authority documents, project documentation, exam drill" | lf-run custom
    lf-evening

## Optional Ollama

Local Focus OS works without Ollama for deterministic task routing.

For local AI features, install Ollama separately and pull a model:

    ollama pull llama3.2

Then test:

    lf-ai "Answer with OK"

## Timers

The setup installs two systemd user timers:

    systemctl --user list-timers 'lf-*' --no-pager

Default schedule:

- morning workflow: 08:05
- evening review: 19:30

Disable timers:

    systemctl --user disable --now lf-morning.timer lf-evening.timer

Enable timers:

    systemctl --user enable --now lf-morning.timer lf-evening.timer

## Uninstall

    ./uninstall.sh

Data is kept by default.

Manual data deletion:

    rm -rf ~/.local/share/local-focus-os ~/.config/local-focus-os
