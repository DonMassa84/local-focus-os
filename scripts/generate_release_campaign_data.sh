#!/usr/bin/env bash
set -Eeuo pipefail

REPO="/home/schattenmacher/openclaw_training/open_source/local-focus-os"
cd "$REPO"

OUT="docs/campaigns/local_linkedin_campaigns.js"
REPORT="docs/campaigns/local_import_report.md"

mkdir -p docs/campaigns

echo "==== GENERATE LINKEDIN CAMPAIGN FROM GIT RELEASES ===="
date
echo

python3 - "$OUT" "$REPORT" << 'PY'
import json
import re
import subprocess
import sys
from datetime import date
from pathlib import Path

out = Path(sys.argv[1])
report = Path(sys.argv[2])

REPO_URL = "https://github.com/DonMassa84/local-focus-os"

def run(cmd):
    return subprocess.check_output(cmd, text=True).strip()

def semver_tuple(tag):
    m = re.match(r"v(\d+)\.(\d+)\.(\d+)$", tag)
    if not m:
        return (0, 0, 0)
    return tuple(map(int, m.groups()))

def slug(value):
    value = str(value or "").lower()
    value = re.sub(r"[^a-z0-9]+", "_", value)
    return value.strip("_") or "item"

def load_existing():
    if not out.exists():
        return []

    text = out.read_text(encoding="utf-8", errors="ignore")
    m = re.search(r"window\.LOCAL_FOCUS_OS_PRIVATE_LINKEDIN_CAMPAIGNS\s*=\s*(\[.*\])\s*;", text, re.S)
    if not m:
        return []

    try:
        return json.loads(m.group(1))
    except Exception:
        return []

def topic_for(tag, subject):
    mapping = {
        "v0.2.7": "Dashboard UI als Steuerzentrale",
        "v0.2.8": "Kaizen Workflow System als täglicher Umsetzungsmodus",
        "v0.2.9": "Regular Operations Workflows für wiederholbare IT-Routinen",
        "v0.3.0": "Taskboard und Kaizen Cockpit im Dashboard",
        "v0.3.1": "Trigger-Farben und lernorientiertes Dashboard-Design",
        "v0.3.2": "Private Task Overlay ohne GitHub-Leak",
        "v0.3.3": "OpenClaw LinkedIn Generator als Career Automation",
        "v0.3.4": "LinkedIn Campaign Tracker nach Kampagnenstatus",
        "v0.3.5": "Generator- und Telegram-Importer für Kampagnendaten",
        "v0.3.6": "Release Campaign Generator aus GitHub Releases"
    }
    return mapping.get(tag, subject or f"Local Focus OS Release {tag}")

def next_action_for(tag):
    return (
        "LinkedIn-Entwurf erzeugen: Hook, Kontext, Proof, Takeaway und Call-to-Action formulieren; "
        "danach Safety-Check und TALK-Check durchführen."
    )

tags_raw = run(["git", "tag", "--list", "v0.*", "--sort=version:refname"])
tags = [t.strip() for t in tags_raw.splitlines() if t.strip()]

# Nur portfolio-relevante Releases ab v0.2.7 automatisch als Kampagnenposts nutzen
tags = [t for t in tags if semver_tuple(t) >= (0, 2, 7)]

posts = []

for tag in tags:
    try:
        subject = run(["git", "log", "-1", "--format=%s", tag])
    except Exception:
        subject = f"Release {tag}"

    topic = topic_for(tag, subject)
    release_url = f"{REPO_URL}/releases/tag/{tag}"

    posts.append({
        "id": f"auto_release_{slug(tag)}",
        "title": f"{tag} — {topic}",
        "stage": "to_post",
        "channel": "LinkedIn",
        "campaign": "Local Focus OS Release Campaign",
        "proof": f"GitHub Release {tag}: {release_url}",
        "nextAction": next_action_for(tag),
        "plannedDate": "",
        "postedDate": "",
        "url": "",
        "releaseUrl": release_url,
        "source": "git tag / GitHub release"
    })

campaign = {
    "id": "campaign_auto_local_focus_os_releases",
    "name": "Local Focus OS Release Campaign",
    "goal": "Aus jedem relevanten GitHub Release einen prüfbaren LinkedIn-Beitrag für Portfolio, IT Operations, Automation und AI Governance erstellen.",
    "status": "active",
    "posts": posts
}

existing = load_existing()

# Alte Auto-Release-Kampagne ersetzen, andere lokale Kampagnen behalten
existing = [
    c for c in existing
    if c.get("id") != "campaign_auto_local_focus_os_releases"
]

merged = [campaign] + existing

out.write_text(
    "window.LOCAL_FOCUS_OS_PRIVATE_LINKEDIN_CAMPAIGNS = "
    + json.dumps(merged, ensure_ascii=False, indent=2)
    + ";\n",
    encoding="utf-8"
)

lines = [
    "# Release Campaign Generator Report",
    "",
    f"Stand: {date.today().isoformat()}",
    "",
    "## Quelle",
    "",
    "- Git Tags / GitHub Release URLs",
    "",
    "## Ergebnis",
    "",
    f"- Kampagne: {campaign['name']}",
    f"- Posts erzeugt: {len(posts)}",
    "",
    "## Posts",
    ""
]

for post in posts:
    lines.append(f"- [ ] {post['title']}")
    lines.append(f"  - Proof: {post['proof']}")
    lines.append(f"  - Stage: {post['stage']}")
    lines.append("")

report.write_text("\n".join(lines), encoding="utf-8")

print(f"[OK] Posts erzeugt: {len(posts)}")
print(f"[OK] Ausgabe: {out}")
print(f"[OK] Report: {report}")
PY

echo
echo "==== DONE ===="
echo "Dashboard neu laden: Strg + R"
