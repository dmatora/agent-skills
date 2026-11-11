#!/usr/bin/env bash
# Install links without replacing existing files or configuration.
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skills_dir="$repo_dir/skills"
codex_home="${CODEX_HOME:-$HOME/.codex}"
codex_skill_root="$codex_home/skills"
legacy_skill_roots=("$HOME/.gemini/config/skills" "$HOME/.claude/skills")

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

mkdir -p "$HOME/.local/bin"
mkdir -p "$codex_skill_root"
for skill_root in "${legacy_skill_roots[@]}"; do
    mkdir -p "$skill_root"
done

for skill_dir in "$skills_dir"/*; do
    [ -d "$skill_dir" ] || continue
    [ -f "$skill_dir/SKILL.md" ] || continue

    skill_name="$(basename "$skill_dir")"
    link_if_available "$skill_dir" "$codex_skill_root/$skill_name"

    if [ "$skill_name" = "ask-codex" ]; then
        for skill_root in "${legacy_skill_roots[@]}"; do
            link_if_available "$skill_dir" "$skill_root/$skill_name"
        done
    fi

    if [ -d "$skill_dir/bin" ]; then
        for command_file in "$skill_dir/bin"/*; do
            [ -f "$command_file" ] && [ -x "$command_file" ] || continue
            command_name="$(basename "$command_file")"
            link_if_available "$command_file" "$HOME/.local/bin/$command_name"
        done
    fi
done

echo 'Make sure ~/.local/bin is in PATH and authenticate Codex CLI if you use Ask Codex.'
