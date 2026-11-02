---
name: ask-codex
description: Consult Codex CLI for a second perspective on difficult reasoning, code, or architecture questions, or select the model used by the ask-codex helper.
---

# Consult Codex

Use `ask-codex` when the user asks for Codex input or an independent perspective would help with a difficult problem. Give Codex the relevant code, constraints, and a specific question. Avoid sending unnecessary sensitive context.

```bash
ask-codex "Your question and relevant context"
ask-codex < prompt.txt
ask-codex --models
ask-codex --set gpt-6.1-terra
ask-codex -m gpt-6.1-sol "Your question"
```

The model list comes from a local cache and may be stale. A partial name must match one cached model. Without a selected model, Codex uses its own default.

Evaluate the response against the actual project and user request. Check assumptions and potentially relevant risks rather than discarding them merely because they are inconvenient. Explain uncertainty and verify claims as appropriate. Implement changes or run tests only when the user's request calls for them.
