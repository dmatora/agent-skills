---
name: ask-codex
description: Consult Codex CLI for a second perspective on difficult reasoning, code, or architecture questions.
---

# Consult Codex

Use `ask-codex` when the user asks for Codex input or an independent perspective would help with a difficult problem. Give Codex the relevant code, constraints, and a specific question. Avoid sending unnecessary sensitive context.

```bash
ask-codex "Your question and relevant context"
ask-codex < prompt.txt
```

Evaluate the response against the actual project and user request. Check assumptions and potentially relevant risks rather than discarding them merely because they are inconvenient. Explain uncertainty and verify claims as appropriate. Implement changes or run tests only when the user's request calls for them.
