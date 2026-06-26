# Install from Repository

## Standardinstallation

    git clone https://github.com/DonMassa84/local-focus-os.git
    cd local-focus-os
    ./install.sh

## Einzeiler

    bash -c "$(curl -fsSL https://raw.githubusercontent.com/DonMassa84/local-focus-os/main/install.sh)"

## Alternative mit wget

    bash -c "$(wget -qO- https://raw.githubusercontent.com/DonMassa84/local-focus-os/main/install.sh)"

## Nach der Installation

    source ~/.bashrc
    local-focus-os help
    local-focus-os status
    local-focus-os doctor

## Installationspfad

    ~/.local/share/local-focus-os/source

## Befehle

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
