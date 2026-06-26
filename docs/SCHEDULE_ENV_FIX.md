
Schedule Env Fix
Problem

In ~/.config/local-focus-os/schedule.env dürfen Werte mit Leerzeichen nicht ungequotet stehen.

Falsch:

LF_WEEKLY_AUDIT_TIME=Sun 10:30:00
LF_MONTHLY_SNAPSHOT_TIME=*-*-01 09:30:00

Das führt zu Shell-Fehlern wie:

10:30:00: Befehl nicht gefunden
09:30:00: Befehl nicht gefunden
Lösung

Richtig:

LF_WEEKLY_AUDIT_TIME="Sun 10:30:00"
LF_MONTHLY_SNAPSHOT_TIME="*-*-01 09:30:00"
Status

Der lokale Config-Stand und das Template in bin/lf-schedule wurden korrigiert.

Prüfung
lf-schedule run status
lf-schedule logs

