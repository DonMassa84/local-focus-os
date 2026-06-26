# Install Release Package

## Zweck

Local Focus OS kann aus einem Release-Paket installiert werden.

## Release bauen

    make build

## Artefakte

    dist/local-focus-os-0.2.0.tar.gz
    dist/local-focus-os-0.2.0.tar.gz.sha256
    dist/local-focus-os-0.2.0.manifest.txt
    dist/local-focus-os-0.2.0.sbom.txt

## Prüfsumme prüfen

    sha256sum -c dist/local-focus-os-0.2.0.tar.gz.sha256

## Paket entpacken

    mkdir -p /tmp/local-focus-os-install
    tar -xzf dist/local-focus-os-0.2.0.tar.gz -C /tmp/local-focus-os-install
    cd /tmp/local-focus-os-install/local-focus-os-0.2.0
    ./install.sh

## Test

    local-focus-os doctor
