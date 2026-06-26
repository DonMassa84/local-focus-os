
Architecture
Components
lf-task: deterministic brain dump parser
lf-run: workflow session generator
lf-ai: local Ollama wrapper
lf-email: local email cleanup
lf-morning: default morning workflow
lf-evening: evening review
lf-status: system status
lf-secret-scan: basic privacy scan
Data Flow
Brain dump
-> lf-task
-> Markdown task file
-> lf-run session
-> review
-> local archive
Principle

Use AI for language.
Use deterministic logic for execution.
