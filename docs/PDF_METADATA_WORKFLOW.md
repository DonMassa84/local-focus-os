
PDF Metadata Workflow
Zweck

Der PDF-Metadata-Workflow prüft lokal und read-only Metadaten von PDF-Dateien.

Er verändert keine PDF-Dateien.

Befehl
lf-pdf-meta-scan ~/Downloads 10
Parameter
lf-pdf-meta-scan [ordner] [limit]

Beispiele:

lf-pdf-meta-scan ~/Downloads 10
lf-pdf-meta-scan ~/Dokumente 20
Ausgabe

Reports werden erzeugt unter:

~/.local/share/local-focus-os/reports/
Geprüfte Felder
Dateiname
Größe
Seitenzahl
Author
Creator
Warnhinweis
Sicherheitsgrenze

Der Workflow ist read-only.

Er löscht keine Dateien und verändert keine PDFs.

Sanitizing muss als separater Workflow mit Kopien umgesetzt werden.
