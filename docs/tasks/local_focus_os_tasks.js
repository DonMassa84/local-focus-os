window.LOCAL_FOCUS_OS_TASKS = [
  {
    "id": "task_generate_release_campaign_posts",
    "title": "LinkedIn-Kampagne aus GitHub Releases erzeugen",
    "priority": "P1",
    "status": "open",
    "area": "Career Automation",
    "kaizenStep": "Proof",
    "nextAction": "scripts/generate_release_campaign_data.sh ausführen und Campaign Tracker prüfen",
    "estimatedMinutes": 10,
    "output": "Dashboard zeigt LinkedIn-Posts aus GitHub Releases"
  },
  {
    "id": "task_import_generator_telegram_campaign_data",
    "title": "Generator-/Telegram-Daten in Campaign Tracker importieren",
    "priority": "P1",
    "status": "open",
    "area": "Career Automation",
    "kaizenStep": "Regular Ops",
    "nextAction": "Exportdateien in docs/imports/local_linkedin_sources ablegen und scripts/import_linkedin_campaign_data.sh ausführen",
    "estimatedMinutes": 20,
    "output": "Campaign Tracker zeigt importierte Posts nach Kampagne und Stage"
  },
  {
    "id": "task_linkedin_campaign_status_review",
    "title": "LinkedIn Campaign Status prüfen",
    "priority": "P1",
    "status": "open",
    "area": "Career Automation",
    "kaizenStep": "Weekly Review",
    "nextAction": "Campaign Tracker öffnen und Posts nach posted, review, scheduled und to_post sortieren",
    "estimatedMinutes": 20,
    "output": "klarer Status: was gepostet wurde und was noch gepostet werden muss"
  },
  {
    "id": "task_repo_status_control",
    "title": "Repo-Status prüfen und sauber halten",
    "priority": "P0",
    "status": "open",
    "area": "Control",
    "kaizenStep": "Daily Control",
    "nextAction": "git status -sb und letzte Releases prüfen",
    "estimatedMinutes": 10,
    "output": "sauberer Git-Status ohne untracked Chaos"
  },
  {
    "id": "task_dashboard_review",
    "title": "Dashboard prüfen und als Steuerzentrale nutzen",
    "priority": "P0",
    "status": "open",
    "area": "Dashboard",
    "kaizenStep": "Review",
    "nextAction": "Dashboard öffnen und Module/Tasks prüfen",
    "estimatedMinutes": 10,
    "output": "Dashboard geöffnet und Taskboard sichtbar"
  },
  {
    "id": "task_daily_kaizen",
    "title": "Daily Kaizen Control ausführen",
    "priority": "P1",
    "status": "open",
    "area": "Kaizen",
    "kaizenStep": "Daily Highlight",
    "nextAction": "eine Tagespriorität setzen und Micro-Commitment starten",
    "estimatedMinutes": 15,
    "output": "Daily Highlight + nächster Schritt dokumentiert"
  },
  {
    "id": "task_regular_ops_weekly_review",
    "title": "Regular Ops Weekly Review durchführen",
    "priority": "P1",
    "status": "open",
    "area": "Operations",
    "kaizenStep": "Weekly Review",
    "nextAction": "Regular-Ops-Modul öffnen und wichtigste Betriebsroutine auswählen",
    "estimatedMinutes": 20,
    "output": "eine wiederholbare Ops-Routine für diese Woche ausgewählt"
  },
  {
    "id": "task_readme_executive_summary",
    "title": "README Executive Summary verbessern",
    "priority": "P2",
    "status": "open",
    "area": "Portfolio",
    "kaizenStep": "Sprint",
    "nextAction": "oben im README eine klare Projektzusammenfassung ergänzen",
    "estimatedMinutes": 25,
    "output": "GitHub-Besucher verstehen Projekt in 30 Sekunden"
  },
  {
    "id": "task_dashboard_screenshot_proof",
    "title": "Dashboard-Screenshot als Portfolio-Nachweis erstellen",
    "priority": "P2",
    "status": "open",
    "area": "Evidence",
    "kaizenStep": "Proof",
    "nextAction": "Dashboard öffnen und Screenshot im Portfolio-Kontext sichern",
    "estimatedMinutes": 15,
    "output": "visueller Nachweis für LinkedIn/Bewerbungen"
  },
  {
    "id": "task_v030_release_note",
    "title": "v0.3.0 Release als Taskboard/Kaizen-Meilenstein prüfen",
    "priority": "P2",
    "status": "open",
    "area": "Release",
    "kaizenStep": "Control",
    "nextAction": "Release-Notiz prüfen und Dashboard öffnen",
    "estimatedMinutes": 10,
    "output": "v0.3.0 als Steuerungs-Release validiert"
  }
];
