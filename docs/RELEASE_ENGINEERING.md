
Release Engineering
Purpose

Release Engineering turns Local Focus OS from a script collection into reproducible software.

Release Steps
git status
make test
make inventory
make library
make build
Tagging

Patch release example:

git tag -a v0.2.0 -m "Local Focus OS v0.2.0 - reproducible software release"
git push origin v0.2.0
Release Artifacts
source repository
tar.gz package
SHA256 checksum
manifest
SBOM
documentation
validation report
Human Review

Before external release:

inspect Git status
inspect diff
run secret scan
run reproducibility check
verify package checksum
verify no private files are included
