**Languages:** **English** | [Русский](i18n/README.ru.md)

# Ask Codex

**Give Claude Code, Antigravity, or your terminal a direct read-only line to OpenAI's deepest reasoning models—without copy-pasting code between windows.**

---

## The Problem It Solves

Fast daily-driver coding agents excel at navigating repositories, editing files, and running tests—until they hit a subtle concurrency bug, tricky state-machine invariant, or high-stakes architecture trade-off and start spinning in circles.

Getting an outside perspective usually means:
1. Manually copying files out of your IDE into another app and pasting the answer back.
2. Receiving theoretical advice detached from your actual repository constraints.
3. Rewriting hardcoded model names in custom scripts every few weeks when new models ship.

**Ask Codex** turns that workflow into a clean, single-step skill and CLI bridge:

- **Headless & read-only by construction:** Runs `codex exec --skip-git-repo-check --ephemeral -s read-only`, so Codex can inspect the project directory you run it in, leaves no session clutter behind, **cannot modify files**, and emits clean output to `stdout`.
- **Grounded verification, not blind obedience:** The companion [`SKILL.md`](SKILL.md) instructs your primary agent to send focused context (without leaking unnecessary secrets) and critically test Codex's claims and risks against the actual codebase before changing anything.
- **Instant fuzzy model switching:** Inspect locally cached models (`--models`), persist your preferred partner model (`--set`), or escalate a single hard prompt (`-m`) without editing prompts or skills.
- **macOS `ChatGPT.app` binary detection:** Checks `/Applications/ChatGPT.app/Contents/Resources/codex-cli/CodexCLI.app/Contents/MacOS/codex` first on macOS, then falls back to `codex` in `PATH`.

---

## Two Ways to Use It

### 1. Inside Your Coding Agent (Claude Code, Antigravity, Codex)

Once installed from the [repository root](../../README.md), just ask your agent naturally when you want an independent check:

> *"We've tried two fixes for this race condition and neither held up. Ask Codex for an independent diagnosis before editing anything."*

> *"Before we change the fee rounding logic, consult Codex on edge cases for zero-liquidity and dust amounts."*

Your agent formulates a tight prompt with the relevant code and constraints, calls `ask-codex` behind the scenes, verifies the response against your repository, and explains any trade-offs or uncertainty clearly.

### 2. Directly from Your Terminal

Inspect locally cached models and check your active selection:

```bash
ask-codex --models
ask-codex --current
```

Choose a default partner model using its full slug or a unique substring (like `terra` or `sol`):

```bash
ask-codex --set gpt-6.1-terra
ask-codex --current
```

Or switch to Sol as your default:

```bash
ask-codex --set gpt-6.1-sol
ask-codex --current
```

Run a read-only review from inside any project directory:

```bash
ask-codex "Review this project and point out the three most important issues. Do not change files."
```

Override the model for a single tough request without changing your saved default:

```bash
ask-codex -m gpt-6.1-sol "Verify whether cancel_order can violate balance invariants under concurrent fills."
```

Pipe a longer prompt from a file via `stdin`:

```bash
ask-codex < prompt.txt
ask-codex -m gpt-6.1-sol < prompt.txt
```

*(Model names above are examples; pick a model listed by `ask-codex --models` for your account.)*

---

## Configuration & How Model Resolution Works

| Setting / Flag | Behavior |
| :--- | :--- |
| `-m <model>` / `--model <model>` | Highest priority: overrides the model for a single invocation. |
| `ASK_CODEX_MODEL` | Environment variable override; takes precedence over the saved file. |
| `ask-codex --set <model>` | Saves your persistent choice in `~/.codex/active_partner_model`. |
| *(No explicit selection)* | Falls back to Codex CLI's own configured default model. |
| `CODEX_HOME` | Customizes the Codex directory (default `~/.codex`) for both `models_cache.json` and `active_partner_model`. |

### Good to Know

- **Prerequisites:** Install via `./install.sh` from the [repository root](../../README.md). Codex CLI must be installed and authenticated; supported auth methods and accessible models depend on your Codex setup and account.
- **Fuzzy matching:** Partial names (e.g., `terra`, `sol`) match when they uniquely identify one model in `models_cache.json`. Ambiguous substrings fail fast and print the matching candidates. If `models_cache.json` does not exist yet, the model name is passed through to Codex as-is.
- **Cache freshness:** `models_cache.json` reflects your local Codex cache, which may lag behind current account entitlements.
- **Always verify:** Treat Codex output as a strong second opinion—verify claims against your code before applying changes.
