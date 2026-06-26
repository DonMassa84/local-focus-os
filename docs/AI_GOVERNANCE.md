
AI Governance
Purpose

Local Focus OS uses local AI only for text transformation, summarization and wording support. Critical workflow decisions remain deterministic or require human review.

Architecture
Input: brain dump, rough email, local notes
Processing: Bash routing and optional Ollama calls
Output: Markdown tasks, sessions, reports
Storage: local filesystem
Risks
Local models may hallucinate.
AI-generated emails may contain factual errors.
Sensitive data may accidentally be copied into public repositories.
Generated tasks are not verified facts.
Human Review

Required before:

sending emails
publishing to GitHub
submitting documents
making legal, financial, medical or employment decisions
Secret Rules

Never publish:

.env
tokens
private PDFs
raw email archives
medical records
court records
authority documents
financial data
Sanitized Workflow Example
echo "authority document follow-up, project documentation" | lf-run custom
lf-secret-scan .
git status


## ELIZA-Effekt

Der ELIZA-Effekt ist ein relevantes Risiko für Local Focus OS.

KI-Ausgaben dürfen nicht als geprüfte Wahrheit, menschliches Verständnis oder autonome Entscheidungsgrundlage behandelt werden.

Schutzmaßnahmen:

- deterministische Regeln für Aufgabenrouting
- lokale Reports statt direkter externer Aktionen
- Secret Scan vor Veröffentlichung
- Human Review bei E-Mails, Behördenkommunikation, Bewerbungen, GitHub-Pushes und sensiblen Dokumenten
- keine automatischen Bestätigungen, Fristannahmen oder externen Behauptungen

Siehe auch: docs/ELIZA_EFFECT.md
