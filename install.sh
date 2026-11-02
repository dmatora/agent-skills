#!/usr/bin/env bash
# Install links without replacing existing files or configuration.
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skill="$repo_dir/skills/ask-codex"

link_if_available() {
    local source="$1" target="$2"
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo "Already linked: $target"
    elif [ -e "$target" ] || [ -L "$target" ]; then
        echo "Skipped existing path: $target" >&2
    else
        ln -s "$source" "$target"
        echo "Linked: $target"
    fi
}

mkdir -p "$HOME/.local/bin" "$HOME/.gemini/config/skills" "$HOME/.claude/skills"
chmod +x "$skill/bin/ask-codex"
link_if_available "$skill/bin/ask-codex" "$HOME/.local/bin/ask-codex"
link_if_available "$skill" "$HOME/.gemini/config/skills/ask-codex"
link_if_available "$skill" "$HOME/.claude/skills/ask-codex"

echo 'Make sure ~/.local/bin is in PATH and Codex CLI is authenticated.'
