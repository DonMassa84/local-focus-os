# LinkedIn Campaign Tracker

## Zweck

Der LinkedIn Campaign Tracker zeigt pro Kampagne:

- was bereits gepostet wurde
- was im Review ist
- was geplant ist
- was noch gepostet werden muss

## Datenmodell

Öffentliche Beispieldaten:

    docs/campaigns/linkedin_campaigns.example.js

Private lokale Kampagnenstände:

    docs/campaigns/local_linkedin_campaigns.js

Die lokale Datei wird per `.gitignore` ausgeschlossen.

## Stages

| Stage | Bedeutung |
|---|---|
| `posted` | bereits veröffentlicht |
| `review` | Entwurf vorhanden, muss geprüft werden |
| `scheduled` | geplant / terminiert |
| `to_post` | muss noch erstellt oder gepostet werden |
| `parked` | geparkt |

## Sicherheitsregel

Der Tracker darf keine privaten Rohdaten, keine Zugangsdaten, keine internen sensiblen Pfade und keine fremden personenbezogenen Daten veröffentlichen.

## Kaizen-Nutzung

1. Kampagne auswählen
2. offenen Post wählen
3. `Review` oder `Posted` setzen
4. Ergebnis als Markdown exportieren
5. wöchentlich prüfen
