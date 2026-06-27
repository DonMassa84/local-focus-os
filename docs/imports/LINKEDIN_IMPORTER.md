# LinkedIn Campaign Importer

## Zweck

Dieser Importer liest lokale Exportdaten aus:

- OpenClaw LinkedIn Generator
- Telegram Bot Export
- Markdown-Dateien
- JSON-Dateien
- TXT-Dateien
- CSV-Dateien

und erzeugt daraus eine lokale Dashboard-Datei:

    docs/campaigns/local_linkedin_campaigns.js

Diese Datei ist privat und wird nicht committed.

## Import-Inbox

Lege lokale Exportdateien hier ab:

    docs/imports/local_linkedin_sources/

Beispiele:

    docs/imports/local_linkedin_sources/generator_export.md
    docs/imports/local_linkedin_sources/telegram_posts.json
    docs/imports/local_linkedin_sources/linkedin_campaign.csv

## Unterstützte Felder

Der Importer erkennt, soweit vorhanden:

- title
- stage
- campaign
- proof
- nextAction
- plannedDate
- postedDate
- url
- channel

## Stages

Erlaubte Werte:

- posted
- review
- scheduled
- to_post
- parked

## Sicherheitsregel

Keine Bot-Tokens, API-Keys, Zugangsdaten, privaten Rohlogs oder sensiblen persönlichen Daten importieren.
