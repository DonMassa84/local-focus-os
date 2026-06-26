# ELIZA-Effekt im Local-Focus-OS-Kontext

## Beschreibung

Der ELIZA-Effekt beschreibt die Tendenz, Chatbots oder KI-Systemen menschliches Verständnis, Absicht, Empathie oder Bewusstsein zuzuschreiben, obwohl technisch nur Musterverarbeitung, Sprachmodellierung und Wahrscheinlichkeitsausgabe stattfinden.

Benannt ist der Effekt nach ELIZA, einem frühen Chatbot aus den 1960er-Jahren.

## Bedeutung für Local Focus OS

Local Focus OS nutzt lokale KI nicht als autonome Entscheidungsinstanz, sondern als unterstützendes Werkzeug für Sprache, Strukturierung und Reflexion.

Das System folgt daher dem Grundsatz:

KI unterstützt Sprache.  
Regeln steuern Ausführung.  
Externe Aktionen brauchen Human Review.

## Risiko

In KI-gestützten Workflows kann der ELIZA-Effekt dazu führen, dass Nutzer KI-Ausgaben zu stark vertrauen.

Besonders kritisch ist das bei:

- E-Mails
- Bewerbungen
- Behördenkommunikation
- Fristen
- medizinischen Themen
- rechtlichen Einschätzungen
- finanziellen Entscheidungen
- GitHub-Veröffentlichungen
- Datei-Löschung
- angeblichen Bestätigungen oder Rückmeldungen

## Typische Fehlannahmen

Beispiele für riskante Fehlannahmen:

- Die KI hat verstanden, was rechtlich korrekt ist.
- Die KI weiß, dass eine Frist stimmt.
- Die KI hat erkannt, dass jemand geantwortet hat.
- Die KI kann entscheiden, ob eine E-Mail gesendet werden soll.
- Die KI kann beurteilen, ob sensible Daten veröffentlicht werden dürfen.
- Die KI weiß, ob ein Dokument vollständig oder verbindlich ist.

Diese Annahmen sind gefährlich, weil Sprachmodelle plausibel formulieren können, ohne die reale Welt zuverlässig zu prüfen.

## Schutzprinzip

Local Focus OS reduziert dieses Risiko durch klare technische Grenzen:

- deterministisches Aufgabenrouting
- lokale Reports
- lokale Logs
- systemd Timer statt freier Cloud-Agenten
- keine automatischen E-Mails
- keine automatischen GitHub-Pushes
- keine automatischen Löschaktionen
- keine erfundenen Bestätigungen
- Secret Scan vor Veröffentlichung
- Human Review vor externen Aktionen

## Umsetzung im Workflow

Der sichere Ablauf lautet:

1. Brain Dump erfassen
2. Aufgabe deterministisch routen
3. lokalen Report erzeugen
4. Timer oder Review einplanen
5. Ergebnis prüfen
6. externe Aktion manuell freigeben

## Sicherheitsgrenzen

Local Focus OS darf autonom:

- lokale Healthchecks ausführen
- lokale Reports erzeugen
- lokale Logs schreiben
- lokale Workflows starten
- Tages- und Abendkontrollen einplanen

Local Focus OS darf nicht autonom:

- E-Mails senden
- Bewerbungen verschicken
- Behörden anschreiben
- GitHub-Pushes ausführen
- Dateien löschen
- Fristen verbindlich bestätigen
- medizinische, rechtliche oder finanzielle Entscheidungen treffen

## Human Review

Human Review bedeutet:

Der Mensch prüft den Inhalt, Kontext, Empfänger, Datenschutz, Fristen und Konsequenzen, bevor eine externe Handlung ausgeführt wird.

Das gilt besonders für:

- Kommunikation nach außen
- Veröffentlichung im Internet
- Dokumente mit personenbezogenen Daten
- Behördenkommunikation
- rechtliche oder finanzielle Vorgänge

## Merksatz

Nicht die KI entscheidet.  
Das System strukturiert.  
Der Mensch gibt frei.

## Kurzform für AI Governance

Der ELIZA-Effekt ist ein zentrales Risiko in KI-gestützten Workflows. Local Focus OS begrenzt dieses Risiko durch lokale Ausführung, deterministische Regeln, nachvollziehbare Reports und Human-Review-Grenzen vor externen Aktionen.
