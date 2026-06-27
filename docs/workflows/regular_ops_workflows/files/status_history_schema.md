# status_history.json — Schema v1.0

**Datei:** `~/openclaw_training/mission_control/pipeline_dashboard/status_history.json`
**Schema-Version:** 1.0
**Last validated:** 2026-05-30

---

## Ziel des Schemas

Das Schema trennt eine kleine, stabile Top-Level-Metadaten-Schicht von einer Liste einzelner Pipeline-Runs. Dadurch bleibt die Datei leicht zu parsen, gut versionierbar und später ohne Breaking Changes erweiterbar.

---

## Empfohlene Struktur

```json
{
  "version": "1.0",
  "generated_at": "2026-05-30T09:50:00Z",
  "pipeline_name": "openclaw_ml_pipeline",
  "runs": [
    {
      "run_id": "run13",
      "type": "train",
      "component": "lora_qwen_v13",
      "status": "succeeded",
      "start_time": "2026-05-30T01:12:34Z",
      "end_time": "2026-05-30T09:10:00Z",
      "duration_seconds": 28646,
      "trigger": {
        "source": "manual",
        "actor": "schattenmacher",
        "reason": "LoRA v13 full training"
      },
      "metrics": {
        "train_loss": 0.1234,
        "eval_score": 0.88,
        "tokens_processed": 1234567
      },
      "artifacts": {
        "model_path": "modules/usb-llm-data-pipeline/lora-output-qwen-v13-7b/adapter_model.safetensors",
        "log_path": "logs/run13/train_run13_20260530.log"
      },
      "tags": {
        "dataset": "thunderbird_run13_final_training_data.jsonl",
        "environment": "local",
        "gpu": "RTX-3060"
      }
    }
  ]
}
```

---

## Pflichtfelder

| Feld | Ebene | Typ | Zweck |
|------|-------|-----|-------|
| `version` | Top-Level | String | Schema-Version für kontrollierte Migrationen |
| `generated_at` | Top-Level | String (ISO 8601) | Zeitpunkt der letzten Aktualisierung der Datei |
| `pipeline_name` | Top-Level | String | Eindeutiger Name des Pipelinesystems |
| `runs` | Top-Level | Array | Liste aller einzelnen Run-Einträge |
| `run_id` | Run | String | Eindeutige ID, z.B. `run13`, `run13_eval` |
| `type` | Run | String | Typ des Laufs (s. Typwerte) |
| `status` | Run | String | Laufstatus (s. Statuswerte) |
| `start_time` | Run | String (ISO 8601) | Startzeit des Laufs |
| `end_time` | Run | String / null | Endzeit; `null` bei laufenden Jobs |

---

## Optionale Felder

| Feld | Ebene | Typ | Zweck |
|------|-------|-----|-------|
| `component` | Run | String | Konkrete Komponente, z.B. `lora_qwen_v13` |
| `duration_seconds` | Run | Integer | Laufdauer für Auswertungen und Trends |
| `trigger` | Run | Objekt | Quelle, Actor und Grund des Runs |
| `metrics` | Run | Objekt | KPIs: `eval_score`, `train_loss`, `violations`, `tokens_processed` |
| `artifacts` | Run | Objekt | Pfade zu Logs, Reports, Modellen |
| `tags` | Run | Objekt | Labels: Dataset, GPU, Umgebung, Flags |
| `notes` | Run | String | Freitext für Besonderheiten oder Zwischenfälle |
| `error` | Run | Objekt | Strukturierte Fehlerdetails bei fehlgeschlagenen Läufen |

---

## Statuswerte (kontrolliertes Vokabular)

Kein freies Schreiben — nur diese Werte, damit Dashboards und Parser nicht mit `ok`, `done`, `finished`, `success` gleichzeitig umgehen müssen:

- `queued`
- `running`
- `succeeded`
- `failed`
- `cancelled`
- `partial`

---

## Typwerte (kontrolliertes Vokabular)

- `train`
- `eval`
- `rag_update`
- `data_prep`
- `index_rebuild`
- `service_check`
- `watcher`

---

## Fehlereintrag

Wenn ein Run fehlschlägt, strukturiertes Fehlerobjekt verwenden:

```json
{
  "run_id": "run12",
  "type": "train",
  "status": "failed",
  "start_time": "2026-05-29T22:10:00Z",
  "end_time": "2026-05-29T22:42:00Z",
  "error": {
    "code": "OOM",
    "message": "CUDA out of memory during step 412",
    "retryable": true
  }
}
```

---

## Eval-Kriterien (PASS) — OpenClaw-spezifisch

```json
"metrics": {
  "eval_score": 0.88,       // >= 0.85 = PASS
  "violations": 0,           // = 0
  "forbidden_terms": 0,      // = 0
  "required_terms_hit": 7,   // >= 7/9
  "structure_score": 10,     // >= 10/11
  "kpi_count": 3             // >= 3
}
```

---

## Parser-Regeln

Parser für Tagesstatus oder Dashboards müssen defensiv gebaut sein:

- fehlende optionale Felder tolerieren
- unbekannte zusätzliche Felder ignorieren
- nur auf Pflichtfelder hart angewiesen sein
- bei ungültigem JSON klaren Fallback oder Fehlerhinweis erzeugen

---

## Minimalvariante

Für einfache Tabellen und erste Auswertungen reicht diese Form:

```json
{
  "version": "1.0",
  "generated_at": "2026-05-30T09:50:00Z",
  "pipeline_name": "openclaw_ml_pipeline",
  "runs": [
    {
      "run_id": "run13",
      "type": "train",
      "status": "succeeded",
      "start_time": "2026-05-30T01:12:34Z",
      "end_time": "2026-05-30T09:10:00Z",
      "metrics": {
        "eval_score": 0.88
      }
    }
  ]
}
```

---

## Designprinzipien

1. **Stabiler Kern** — wenige Pflichtfelder, damit bestehende Tools nicht brechen.
2. **Erweiterbare Ränder** — neue Metriken oder Artefakte können ergänzt werden, ohne Parser umzubauen.
3. **Maschinenlesbar und menschenverständlich** — die Datei soll von Skripten wie auch manuell gut lesbar sein.

---

## Upgrade-Pfad

- v1.0 → v1.1: `tags.gpu` → `tags.gpu_model` (rückwärtskompatibel, alter Key wird toleriert)
- Parser prüft immer `version`-Feld — bei unbekannter Version: Warnung loggen, kein Crash

---

*Standard: `~/workflow-knowledge/standards/` | OpenClaw Pipeline | 2026-05-30*
