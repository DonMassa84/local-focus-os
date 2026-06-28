PREFIX ?= $(HOME)/.local
BINDIR ?= $(PREFIX)/bin
REPO := $(shell pwd)
VERSION := $(shell cat VERSION)

.PHONY: help install uninstall test repro inventory library build package clean status doctor release-info

help:
	@echo "Local Focus OS $(VERSION)"
	@echo
	@echo "Targets:"
	@echo "  make install       install commands to ~/.local/bin"
	@echo "  make uninstall     run uninstall.sh"
	@echo "  make test          run test suite"
	@echo "  make repro         run lf-repro-check"
	@echo "  make inventory     refresh workflow/document inventory"
	@echo "  make library       refresh system library"
	@echo "  make build         create reproducible release package"
	@echo "  make status        show local status"
	@echo "  make doctor        full diagnostic"
	@echo "  make clean         clean dist artifacts"

install:
	@./setup.sh
	@ln -sf "$(REPO)/bin/local-focus-os" "$(BINDIR)/local-focus-os"
	@echo "[OK] Installed Local Focus OS"

uninstall:
	@./uninstall.sh || true
	@rm -f "$(BINDIR)/local-focus-os"

test:
	@./tests/test_commands.sh "$(REPO)"

repro:
	@lf-repro-check

inventory:
	@lf-inventory refresh

library:
	@lf-library refresh

build:
	@./tools/build_release.sh "$(REPO)"

package: build

status:
	@lf-status
	@lf-autonomy status
	@lf-schedule status
	@lf-inventory status
	@lf-library status
	@git status

doctor:
	@local-focus-os doctor

release-info:
	@echo "Version: $(VERSION)"
	@git rev-parse HEAD
	@git status --short

clean:
	@rm -rf dist/*.tar.gz dist/*.sha256 dist/*.manifest.txt dist/*.sbom.txt
	@echo "[OK] dist cleaned"

.PHONY: install-from-repo

install-from-repo:
	@./install.sh

.PHONY: agent-doctor
agent-doctor:
	@bash scripts/agent-doctor.sh
