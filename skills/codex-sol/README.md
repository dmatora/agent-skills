**Languages:** **English** | [Русский (README)](i18n/README.ru.md) · [SKILL на русском](i18n/SKILL.ru.md)

# Codex Grounding Bridge (`codex-sol`) — Tame "Spherical Cows" from Frontier Reasoning Models

## Why This Exists (Two Subscriptions, One Broken Workflow)

Most senior engineers today run two AI subscriptions side by side:
1. **A fast agentic IDE** (Antigravity, Claude Code, Cursor) that is great at navigating repositories, editing files, and running tests.
2. **A ChatGPT Plus / Pro desktop subscription** with access to OpenAI's heaviest reasoning models (`gpt-6.1-terra`, `gpt-6.1-sol`, `gpt-6-astra`) that excel at deep math, state-machine invariants, and subtle edge cases.

Yet bridging them usually looks terrible:
* **Manual Copy-Paste Hell:** You copy 300 lines of code out of your IDE into the ChatGPT window, wait a minute, and paste the answer back.
* **The "Spherical Cow in a Vacuum" Syndrome:** Frontier reasoning models are brilliant theorists, but terrible pragmatists. Left unchecked, they over-hedge, invent three layers of academic abstraction you don't need, and communicate in dense essays.
* **Constant Model Churn:** Yesterday the best reasoning model was `6.1-sol`, today `6.1-terra` gives 95% of the intelligence at 2x lower quota cost, and next month a new flagship drops. Hardcoding model names into your prompts and scripts breaks every three weeks.

---

## What This Skill Does

1. **Unlocks the Hidden Native CLI Inside `ChatGPT.app` (Zero Extra API Cost):**
   Almost nobody realizes that the standard macOS `/Applications/ChatGPT.app` bundles a full native binary (`CodexCLI.app`) that reuses your active desktop login session. This skill exposes it cleanly via `ask-codex` so your IDE agent can query OpenAI's frontier models headlessly without paying separate per-token API bills.
2. **Enforces the 5-Step "Grounding Protocol":**
   Your IDE agent doesn't blindly paste Codex's output into your project. It acts as a cynical Staff Engineer filter:
   * Formulates a tight, high-context query for Codex.
   * Extracts the core mathematical/architectural insight.
   * Strips out speculative edge cases and "spherical cow" over-engineering.
   * Translates the solution into plain human language and idiomatic project code.
3. **Zero-Rewrite Model Switcher (`ask-codex --models` / `--set`):**
   Reads OpenAI's live model catalog directly from `~/.codex/models_cache.json`. Switch models anytime with fuzzy matching (`ask-codex --set terra` or `ask-codex --set sol`)—or just tell your agent in chat *"check what new models are in Codex and switch to the best one"*—without ever touching `SKILL.md` or system rules.

---

## Quick Usage

```bash
# 1. See all models currently available in your Codex account:
ask-codex --models

# 2. Switch the default partner model (fuzzy match):
ask-codex --set terra

# 3. Query the active model directly (or let your IDE agent call it automatically):
ask-codex "Verify the conservation invariant for this AMM liquidity curve"

# 4. One-off override for an ultra-heavy theoretical proof:
ask-codex -m sol "Find race conditions in this lock-free ring buffer"
```

---

## 10-Second Installation

From the root of the [`agent-skills`](../../README.md) repository:

```bash
./install.sh
```
