# Install from Repository

## Zweck

Dieses Dokument beschreibt die Installation von Local Focus OS direkt aus dem GitHub-Repository.

## Standardinstallation

    git clone https://github.com/DonMassa84/local-focus-os.git
    cd local-focus-os
    ./install.sh

## Einzeiler

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/DonMassa84/local-focus-os/main/install.sh)"

## Alternative mit wget

    bash -c "$(wget -qO- https://raw.githubusercontent.com/DonMassa84/local-focus-os/main/install.sh)"

## Installation über Makefile

    git clone https://github.com/DonMassa84/local-focus-os.git
    cd local-focus-os
    make install

## Nach der Installation

    source ~/.bashrc
    local-focus-os help
    local-focus-os status
    local-focus-os doctor

## Installationspfad

Standardmäßig wird installiert nach:

    ~/.local/share/local-focus-os/source

Befehle werden verlinkt nach:

    ~/.local/bin

## Konfiguration

    ~/.config/local-focus-os/

## Daten, Reports und Logs

    ~/.local/share/local-focus-os/
    ~/.local/share/local-focus-os/reports/
    ~/.local/share/local-focus-os/logs/
    ~/.local/share/local-focus-os/library/

## Sicherheitsgrenzen

Der Installer führt keine externen Aktionen wie E-Mail-Versand, Behördenkommunikation oder Datei-Löschung aus.

GitHub wird nur zum Klonen oder Aktualisieren des Repositories genutzt.
