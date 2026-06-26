
Reproducible Build
Purpose

This document describes how to build Local Focus OS as a reproducible local software package.

Build Command
make build
Output
dist/local-focus-os-<version>.tar.gz
dist/local-focus-os-<version>.tar.gz.sha256
dist/local-focus-os-<version>.manifest.txt
dist/local-focus-os-<version>.sbom.txt
Reproducibility Controls

The build process uses:

clean Git working tree requirement
test execution before packaging
sorted tar order
fixed owner and group
fixed mtime
SHA256 checksum
manifest with file checksums
simple SBOM
Validation
make test
make build
sha256sum -c dist/local-focus-os-*.sha256
Install from Source
make install
Doctor Check
local-focus-os doctor

