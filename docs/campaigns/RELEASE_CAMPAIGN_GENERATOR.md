# Release Campaign Generator

## Zweck

Wenn keine Exportdaten aus OpenClaw LinkedIn Generator oder Telegram Bot vorhanden sind, erzeugt dieser Generator Kampagnenposts direkt aus den GitHub Releases des Projekts.

Quelle:

```text
git tag --list "v0.*"
Ausgabe:

docs/campaigns/local_linkedin_campaigns.js

Diese Datei bleibt lokal und wird nicht versioniert.

Workflow
GitHub Releases prüfen
pro Release einen LinkedIn-Post-Entwurf als Kampagnenpost erzeugen
Campaign Tracker im Dashboard öffnen
Posts nach Status steuern:
to_post
review
scheduled
posted
parked
Befehl
bash scripts/generate_release_campaign_data.sh
Sicherheit

Die generierte lokale Kampagnen-Datei wird ignoriert und nicht ins öffentliche Repository gepusht.
