#!/usr/bin/env bash
# install.sh — Symlink public agent-skills, CLI bridges, and global rules on macOS/Linux

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
AGY_SKILLS_DIR="$HOME/.gemini/config/skills"
AGY_SKILLS_JSON="$HOME/.gemini/config/skills.json"
CLAUDE_SKILLS_DIR="$HOME/.claude/skills"

mkdir -p "$BIN_DIR" "$AGY_SKILLS_DIR" "$CLAUDE_SKILLS_DIR" "$HOME/.gemini"

# 1. Make CLI scripts executable and link into ~/.local/bin
chmod +x "$REPO_DIR/skills/codex-sol/bin/codex" "$REPO_DIR/skills/codex-sol/bin/ask-codex"
ln -sfn "$REPO_DIR/skills/codex-sol/bin/codex" "$BIN_DIR/codex"
ln -sfn "$REPO_DIR/skills/codex-sol/bin/ask-codex" "$BIN_DIR/ask-codex"
ln -sfn "$REPO_DIR/skills/codex-sol/bin/ask-codex" "$BIN_DIR/ask-sol"
ln -sfn "$REPO_DIR/skills/codex-sol/bin/ask-codex" "$BIN_DIR/ask-terra"

# 2. Link all skills in skills/* to Antigravity and Claude Code
for skill_path in "$REPO_DIR"/skills/*; do
    if [ -d "$skill_path" ]; then
        skill_name="$(basename "$skill_path")"
        rm -rf "$AGY_SKILLS_DIR/$skill_name"
        ln -sfn "$skill_path" "$AGY_SKILLS_DIR/$skill_name"
        rm -rf "$CLAUDE_SKILLS_DIR/$skill_name"
        ln -sfn "$skill_path" "$CLAUDE_SKILLS_DIR/$skill_name"
        echo "Linked skill: $skill_name"
    fi
done

# 3. Ensure ~/.gemini/config/skills.json exists for Antigravity
if [ ! -f "$AGY_SKILLS_JSON" ]; then
    cat > "$AGY_SKILLS_JSON" << 'EOF'
{
  "entries": [
    {
      "path": "~/.gemini/config/skills"
    }
  ]
}
EOF
fi

# 4. Link global GEMINI.md rules
if [ -f "$REPO_DIR/rules/GEMINI.md" ]; then
    ln -sfn "$REPO_DIR/rules/GEMINI.md" "$HOME/.gemini/GEMINI.md"
    echo "Linked global rules: ~/.gemini/GEMINI.md"
fi

echo "Done! Public agent-skills installed successfully."
