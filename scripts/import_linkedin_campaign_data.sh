#!/usr/bin/env bash
set -Eeuo pipefail

REPO="/home/schattenmacher/openclaw_training/open_source/local-focus-os"
cd "$REPO"

IMPORT_DIR="${1:-docs/imports/local_linkedin_sources}"
OUT="docs/campaigns/local_linkedin_campaigns.js"
REPORT="docs/campaigns/local_import_report.md"

mkdir -p "$IMPORT_DIR" docs/campaigns

echo "==== LINKEDIN CAMPAIGN DATA IMPORT ===="
date
echo "Import dir: $IMPORT_DIR"
echo

python3 - "$IMPORT_DIR" "$OUT" "$REPORT" << 'PY'
import csv
import json
import re
import sys
from pathlib import Path
from datetime import date

import_dir = Path(sys.argv[1])
out = Path(sys.argv[2])
report = Path(sys.argv[3])

ALLOWED_STAGES = {"posted", "review", "scheduled", "to_post", "parked"}

def slug(value):
    value = str(value or "").strip().lower()
    value = re.sub(r"[^a-z0-9äöüß]+", "_", value)
    value = value.strip("_")
    return value[:80] or "item"

def normalize_stage(value, text=""):
    raw = str(value or "").strip().lower().replace("-", "_").replace(" ", "_")

    if raw in ALLOWED_STAGES:
        return raw

    hay = f"{raw} {text}".lower()

    if any(k in hay for k in ["posted", "veröffentlicht", "gepostet", "published", "live"]):
        return "posted"
    if any(k in hay for k in ["review", "prüfen", "prüfung", "check", "draft", "entwurf"]):
        return "review"
    if any(k in hay for k in ["scheduled", "geplant", "terminiert", "plan"]):
        return "scheduled"
    if any(k in hay for k in ["parked", "geparkt", "später", "later"]):
        return "parked"

    return "to_post"

def clean(value):
    return str(value or "").strip()

def detect_url(text):
    match = re.search(r"https?://\S+", text or "")
    return match.group(0).rstrip(").,]") if match else ""

def detect_release(text):
    match = re.search(r"\bv\d+\.\d+\.\d+\b", text or "")
    return match.group(0) if match else ""

def build_post(raw, source_name, idx):
    title = clean(
        raw.get("title")
        or raw.get("Titel")
        or raw.get("post")
        or raw.get("Post")
        or raw.get("topic")
        or raw.get("Thema")
        or raw.get("message")
        or raw.get("text")
        or raw.get("content")
        or raw.get("body")
        or f"Imported post {idx}"
    )

    if len(title) > 120:
        first_line = title.splitlines()[0].strip()
        title = first_line[:120] if first_line else title[:120]

    text_blob = " ".join(str(v) for v in raw.values())

    campaign = clean(
        raw.get("campaign")
        or raw.get("Kampagne")
        or raw.get("category")
        or raw.get("Kategorie")
        or "Imported LinkedIn Campaign"
    )

    release = detect_release(text_blob)

    proof = clean(
        raw.get("proof")
        or raw.get("Proof")
        or raw.get("nachweis")
        or raw.get("Nachweis")
        or (f"Release {release}" if release else source_name)
    )

    next_action = clean(
        raw.get("nextAction")
        or raw.get("next_action")
        or raw.get("Nächste Aktion")
        or raw.get("aktion")
        or raw.get("Action")
        or "Entwurf prüfen, Safety-Check anwenden und Stage setzen"
    )

    stage = normalize_stage(raw.get("stage") or raw.get("status") or raw.get("Status"), text_blob)

    posted_date = clean(raw.get("postedDate") or raw.get("posted_date") or raw.get("posted") or "")
    planned_date = clean(raw.get("plannedDate") or raw.get("planned_date") or raw.get("date") or raw.get("Datum") or "")
    url = clean(raw.get("url") or raw.get("link") or detect_url(text_blob))

    return {
        "id": f"import_{slug(source_name)}_{idx}_{slug(title)}",
        "title": title,
        "stage": stage,
        "channel": clean(raw.get("channel") or raw.get("Channel") or "LinkedIn"),
        "campaign": campaign,
        "proof": proof,
        "nextAction": next_action,
        "plannedDate": planned_date,
        "postedDate": posted_date,
        "url": url,
        "_source": source_name,
    }

def parse_json(path):
    data = json.loads(path.read_text(encoding="utf-8", errors="ignore"))

    items = []

    if isinstance(data, list):
        items = data
    elif isinstance(data, dict):
        for key in ["posts", "messages", "items", "data", "campaigns"]:
            if isinstance(data.get(key), list):
                items = data[key]
                break
        if not items:
            items = [data]

    flattened = []

    for item in items:
        if isinstance(item, dict) and isinstance(item.get("posts"), list):
            campaign_name = item.get("name") or item.get("campaign") or item.get("title")
            for post in item["posts"]:
                if isinstance(post, dict):
                    p = dict(post)
                    p.setdefault("campaign", campaign_name)
                    flattened.append(p)
        elif isinstance(item, dict):
            flattened.append(item)
        else:
            flattened.append({"text": str(item)})

    return flattened

def parse_csv(path):
    rows = []
    with path.open("r", encoding="utf-8", errors="ignore", newline="") as f:
        sample = f.read(4096)
        f.seek(0)
        dialect = csv.Sniffer().sniff(sample, delimiters=",;\t|") if sample.strip() else csv.excel
        reader = csv.DictReader(f, dialect=dialect)
        for row in reader:
            rows.append(dict(row))
    return rows

def parse_text_blocks(path):
    text = path.read_text(encoding="utf-8", errors="ignore")
    blocks = re.split(r"\n\s*(?:---+|###|##|\* \* \*)\s*\n", text)
    rows = []

    for block in blocks:
        b = block.strip()
        if not b:
            continue

        fields = {}
        lines = [line.strip() for line in b.splitlines() if line.strip()]

        for line in lines:
            m = re.match(r"^(title|titel|stage|status|campaign|kampagne|proof|nachweis|nextAction|next action|nächste aktion|plannedDate|postedDate|url|link)\s*[:=-]\s*(.+)$", line, re.I)
            if m:
                key = m.group(1).strip()
                value = m.group(2).strip()
                fields[key] = value

        if not fields:
            fields["text"] = b
            fields["title"] = lines[0][:120] if lines else path.stem

        rows.append(fields)

    return rows

def load_existing_private():
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

files = []
if import_dir.exists():
    for pattern in ["*.json", "*.csv", "*.txt", "*.md", "*.markdown"]:
        files.extend(sorted(import_dir.glob(pattern)))

posts = []
source_counts = {}

for path in files:
    suffix = path.suffix.lower()
    try:
        if suffix == ".json":
            raw_items = parse_json(path)
        elif suffix == ".csv":
            raw_items = parse_csv(path)
        else:
            raw_items = parse_text_blocks(path)
    except Exception as e:
        print(f"[WARN] Konnte nicht lesen: {path}: {e}")
        continue

    source_counts[path.name] = len(raw_items)

    for idx, raw in enumerate(raw_items, start=1):
        if not isinstance(raw, dict):
            raw = {"text": str(raw)}
        posts.append(build_post(raw, path.name, idx))

# Gruppieren nach Kampagne
campaigns_by_name = {}

for post in posts:
    campaign_name = post.pop("campaign") or "Imported LinkedIn Campaign"
    campaign = campaigns_by_name.setdefault(campaign_name, {
        "id": f"campaign_import_{slug(campaign_name)}",
        "name": campaign_name,
        "goal": "Importierte Generator-/Telegram-Daten im LinkedIn Campaign Tracker steuern.",
        "status": "active",
        "posts": []
    })
    campaign["posts"].append(post)

new_campaigns = list(campaigns_by_name.values())

# Bestehende lokale manuelle Daten behalten, aber Import-Kampagnen ersetzen
existing = load_existing_private()
existing_non_import = [
    c for c in existing
    if not str(c.get("id", "")).startswith("campaign_import_")
]

merged = existing_non_import + new_campaigns

out.write_text(
    "window.LOCAL_FOCUS_OS_PRIVATE_LINKEDIN_CAMPAIGNS = "
    + json.dumps(merged, ensure_ascii=False, indent=2)
    + ";\n",
    encoding="utf-8"
)

lines = [
    "# LinkedIn Campaign Import Report",
    "",
    f"Stand: {date.today().isoformat()}",
    "",
    f"Import-Verzeichnis: `{import_dir}`",
    "",
    "## Dateien",
    ""
]

if source_counts:
    for name, count in source_counts.items():
        lines.append(f"- {name}: {count} Einträge")
else:
    lines.append("- Keine Importdateien gefunden.")

lines += [
    "",
    "## Ergebnis",
    "",
    f"- Kampagnen importiert: {len(new_campaigns)}",
    f"- Posts importiert: {sum(len(c['posts']) for c in new_campaigns)}",
    "",
    "## Ausgabe",
    "",
    f"- `{out}`",
]

report.write_text("\n".join(lines) + "\n", encoding="utf-8")

print(f"[OK] Dateien gelesen: {len(files)}")
print(f"[OK] Kampagnen importiert: {len(new_campaigns)}")
print(f"[OK] Posts importiert: {sum(len(c['posts']) for c in new_campaigns)}")
print(f"[OK] Ausgabe: {out}")
print(f"[OK] Report: {report}")
PY

echo
echo "==== DONE ===="
echo "Dashboard danach neu laden: Strg + R"
