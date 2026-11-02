**Languages:** **English** | [Русский](i18n/README.ru.md)

# Ask Codex

A small bridge for consulting Codex CLI from another coding agent. The skill guides the agent to provide project context and check the response before using it.

Install from the [repository root](../../README.md). Codex CLI must be installed and authenticated. The helper checks the ChatGPT.app bundled binary on macOS first, then looks for `codex` in `PATH`. Which models and authentication methods work depends on your Codex setup.

```bash
ask-codex "Review this state machine invariant"
ask-codex < prompt.txt
ask-codex --models             # Read the local Codex model cache
ask-codex --set gpt-6.1-terra          # Select a model for future requests
ask-codex -m gpt-6.1-sol "Review this race condition"  # One request
ask-codex --current
```

Without an explicit selection, Codex uses its own default model. `--set` stores the selection in `~/.codex/active_partner_model`; `ASK_CODEX_MODEL` overrides it. `CODEX_HOME` changes the directory used for both the cache and selection. A partial model name must match exactly one cached model. If the cache is missing, the name is passed as provided. The cache may be stale and does not guarantee model access.

Requests run with Codex in read-only mode, without retaining a Codex session. Review the response and verify claims against the project before applying changes.
