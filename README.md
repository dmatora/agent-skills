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

The installer links `ask-codex` into `~/.local/bin` and the skill into the Antigravity and Claude skill directories. Existing paths are left untouched and reported. Ensure `~/.local/bin` is in your `PATH`, and set up and authenticate Codex CLI separately. On macOS, the helper also checks for the Codex binary bundled with ChatGPT.app.

## Quick start

List locally cached models:

```bash
ask-codex --models
```

Choose a model for future requests, then check the selection:

```bash
ask-codex --set gpt-6.1-terra
ask-codex --current
```

From a project directory, ask Codex to review it:

```bash
ask-codex "Review this project and point out the three most important issues. Do not change files."
```

Model availability depends on your Codex account. Use a full model name from `--models` if the example model is unavailable.

See the [skill documentation](skills/ask-codex/README.md) for usage and limitations.
