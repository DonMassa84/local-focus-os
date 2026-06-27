# Workflow: OCR Automation Watcher (WF-52)

**Projekt:**   openclaw
**Kategorie:** automation | ocr | infrastructure
**Datum:**     2026-05-30 07:38
**Status:**    aktiv
**Last validated:** 2026-05-30

## Beschreibung

Automatische OCR-Verarbeitung von PDFs und Bildern die in `inbox/` abgelegt werden.
Nutzt Tesseract (deu), pdf2image, cv2 und watchdog. Verarbeitet 25-seitige PDFs in ~25 Minuten.
Archiviert Originale, schreibt TXT-Output, loggt Fehler getrennt.

## Voraussetzungen

- [x] `tesseract-ocr` + `tesseract-ocr-deu` installiert (`apt`)
- [x] `poppler-utils` installiert (`apt`)
- [x] `opencv-python`, `watchdog`, `pytesseract`, `pdf2image` in `llm_env` installiert
- [x] `~/openclaw_training/ocr_automation/` Verzeichnisstruktur vorhanden

## Skript / Kommando

```bash
# Service starten:
systemctl --user daemon-reload
systemctl --user start ocr-watcher.service
systemctl --user status ocr-watcher.service

# Einmal-Lauf (Hintergrund):
nohup /home/schattenmacher/llm_env/bin/python3 \
    ~/openclaw_training/ocr_automation/scripts/ocr_watcher.py \
    --input   ~/openclaw_training/ocr_automation/inbox \
    --output  ~/openclaw_training/ocr_automation/output_txt \
    --logs    ~/openclaw_training/ocr_automation/logs \
    --archive ~/openclaw_training/ocr_automation/archive \
    --errors  ~/openclaw_training/ocr_automation/errors \
    --lang deu --once \
    > ~/openclaw_training/ocr_automation/logs/ocr_once.log 2>&1 &

# Deps installieren (nach GPU-Last):
/home/schattenmacher/llm_env/bin/pip install opencv-python watchdog pytesseract pdf2image --no-cache-dir
```

## Eingaben / Zielpfade

| Parameter | Wert |
|-----------|------|
| Inbox | `~/openclaw_training/ocr_automation/inbox/` |
| Output TXT | `~/openclaw_training/ocr_automation/output_txt/` |
| Archiv | `~/openclaw_training/ocr_automation/archive/` |
| Fehler | `~/openclaw_training/ocr_automation/errors/` |
| Logs | `~/openclaw_training/ocr_automation/logs/` |
| Script | `~/openclaw_training/ocr_automation/scripts/ocr_watcher.py` |
| Service | `~/.config/systemd/user/ocr-watcher.service` |

## Ergebnis (Testlauf 2026-05-30)

- SWSG-Mietvertrag (7,5 MB, 25 Seiten) in ~25 Min verarbeitet
- Output: `Mietvertrag_SWSG_Hausenring_43_Daniel_Massa_20260530_080827.txt` (57 KB)
- Service läuft: `active (running)`
- Fehler beim Archivieren (Datei bereits durch parallelen Lauf verschoben) — harmlos

## Bekannte Risiken / Grenzen

- `.ocr_done/`-Dateien in `WBS/` sind 0-Byte-Marker — Original immer aus `WBS/` direkt kopieren
- `pip install` während GPU 100%-Last kann timeoutten → `--no-cache-dir` + Hintergrund
- `--lang deu+eng` als ein String funktioniert nicht → nur `--lang deu` verwenden
- Mehrfachläufe erzeugen Duplikat-TXTs → älteste manuell löschen

## Reproduzierbarkeit

- Wiederholbar: ja
- Voraussetzungen erfüllt: ja
- Letzter erfolgreicher Test: 2026-05-30

## Änderungshistorie

| Datum | Änderung | Von |
|-------|----------|-----|
| 2026-05-30 | Erstellt, Service-Unit gefixed (--lang, Args-Namen), Deps installiert | opencode |

---
*Template: ~/workflow-knowledge/templates/workflow_entry_template.md*
