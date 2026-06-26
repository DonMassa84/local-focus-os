# Software Specification

## Name

Local Focus OS

## Type

Local-first Linux workflow automation software.

## Target System

- Linux Mint
- Ubuntu-based desktop Linux
- bash
- systemd user services
- local user installation under `~/.local/bin`

## Purpose

Local Focus OS turns local operational workflows into reproducible command-line tools with documentation, reports, timer automation and safety boundaries.

## Core Components

- CLI entrypoint: `local-focus-os`
- Workflow commands: `bin/lf-*`
- Installer: `setup.sh`
- Uninstaller: `uninstall.sh`
- Tests: `tests/test_commands.sh`
- Build system: `Makefile`
- Release builder: `tools/build_release.sh`
- Documentation: `docs/`
- System library: `~/.local/share/local-focus-os/library`
- Reports: `~/.local/share/local-focus-os/reports`
- Logs: `~/.local/share/local-focus-os/logs`

## Runtime Commands

```bash id="plv1gz"
local-focus-os status
local-focus-os doctor
lf-status
lf-autonomy status
lf-schedule status
lf-inventory status
lf-library status
lf-repro-check
Safety Boundary

The software does not automatically perform external actions.

Blocked by design unless manually reviewed:

sending email
GitHub push
deleting files
changing PDFs
authority communication
publishing private data
Current Status

Release-grade local reproducible software.
