**Languages:** **English** | [Русский](i18n/README.ru.md)

# Ask Codex

A small bridge for consulting Codex CLI from another coding agent. The skill guides the agent to provide project context and check the response before using it.

Install from the [repository root](../../README.md). Codex CLI must be installed and authenticated. The helper checks the ChatGPT.app bundled binary on macOS first, then looks for `codex` in `PATH`. Which models and authentication methods work depends on your Codex setup.

## Copy-and-paste examples

List models in the local cache and see the current selection:

```bash
ask-codex --models
ask-codex --current
```

Choose Terra for future requests:

```bash
ask-codex --set gpt-6.1-terra
ask-codex --current
```

Or choose Sol:

```bash
ask-codex --set gpt-6.1-sol
ask-codex --current
```

From a project directory, ask for a review using the selected model:

```bash
ask-codex "Review this project and point out the three most important issues. Do not change files."
```

Use Sol for one request without changing the saved selection:

```bash
ask-codex -m gpt-6.1-sol "Review this project and point out the three most important issues. Do not change files."
```

These model names are examples; choose a full name from `ask-codex --models` if your setup uses different models.

Without an explicit selection, Codex uses its own default model. `--set` stores the selection in `~/.codex/active_partner_model`; `ASK_CODEX_MODEL` overrides it. `CODEX_HOME` changes the directory used for both the cache and selection. A partial model name must match exactly one cached model. If the cache is missing, the name is passed as provided. The cache may be stale and does not guarantee model access.

Requests run with Codex in read-only mode, without retaining a Codex session. Review the response and verify claims against the project before applying changes.
