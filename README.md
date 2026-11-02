**Languages:** **English** | [Русский](i18n/README.ru.md)

# Agent Skills

A collection of skills and small tools from my work with AI coding agents. This repository is a work in progress.

## Skills

[ask-codex](skills/ask-codex/README.md) lets an agent consult Codex CLI and assess its answer against the project context. It also provides a small command for selecting a model and sending non-interactive requests.

## Installation

```bash
git clone https://github.com/dmatora/agent-skills.git ~/Developer/agent-skills
cd ~/Developer/agent-skills
./install.sh
```

The installer links `ask-codex` into `~/.local/bin` and the skill into the Antigravity and Claude skill directories. It removes links from this repository's previous `codex-sol` installation; other existing paths are left untouched and reported. Ensure `~/.local/bin` is in your `PATH`, and set up and authenticate Codex CLI separately. On macOS, the helper also checks for the Codex binary bundled with ChatGPT.app.

See the [skill documentation](skills/ask-codex/README.md) for usage and limitations.
