**Languages:** **English** | [Русский](i18n/README.ru.md)

# Agent Skills — Production Workflows for Senior AI Engineering

A curated collection of battle-tested agent skills, multi-model bridges, and architectural guardrails for **Antigravity**, **Claude Code**, and **Cursor**.

Built from real production troubleshooting across 270+ engineering projects, fintech/Web3 protocols, and high-leverage agentic workflows.

---

## Included Skills

### 1. [`codex-sol`](skills/codex-sol/README.md) — Codex Frontier Reasoning Bridge & Grounding Protocol
Pairs your fast daily-driver IDE agent with OpenAI's heaviest reasoning models (`gpt-6.1-terra`, `gpt-6.1-sol`, `gpt-6-astra`) via the native CLI bundled inside macOS `ChatGPT.app`:
* **Zero Copy-Paste:** Headless CLI bridge (`ask-codex`) using your existing desktop ChatGPT login.
* **The "Spherical Cow" Filter:** Forces your primary agent to strip academic over-engineering and excessive hedging from the reasoning model before touching production code.
* **Instant Model Switcher:** Live discovery (`ask-codex --models`) and fuzzy switching (`ask-codex --set terra`) directly from `~/.codex/models_cache.json`—no prompt rewrites when new models drop.

👉 **[Read full documentation (EN)](skills/codex-sol/README.md)** · **[Документация на русском (RU)](skills/codex-sol/i18n/README.ru.md)**

---

## 5-Second Installation (macOS / Linux)

Clone the repository and run the idempotent installer to symlink all skills, CLI helpers, and global agent rules:

```bash
git clone https://github.com/dmatora/agent-skills.git ~/Developer/agent-skills
cd ~/Developer/agent-skills
./install.sh
```

What `./install.sh` sets up:
1. Links `codex` and `ask-codex` (plus compatibility aliases `ask-sol`, `ask-terra`) into `~/.local/bin/`.
2. Symlinks skills into `~/.gemini/config/skills/` (Antigravity) and `~/.claude/skills/` (Claude Code).
3. Links global collaboration rules into `~/.gemini/GEMINI.md`.

---

## Custom Engineering & B2B Agent Systems

These open-source skills represent the foundational architecture layer of my daily workflow. For custom multi-agent B2B pipelines, automated market intelligence, high-reliability scrapers, or rescue/troubleshooting of critical Web3 & fintech systems — reach out directly via GitHub or LinkedIn.
