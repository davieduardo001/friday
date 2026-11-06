#!/bin/bash
# dotfiles_ai installer

set -e

DOTFILES_AI_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_DIR="${HOME}"

CLAUDE_DIR="$HOME_DIR/.claude"
GEMINI_DIR="$HOME_DIR/.gemini"
AGENTS_SKILLS_DIR="$HOME_DIR/.agents/skills"
AGENTS_DIR="$HOME_DIR/.agents"

INSTALL_ARGS=()
REMOVE=false
FORCE=false

for arg in "$@"; do
  case "$arg" in
    --remover) REMOVE=true ;;
    --force) FORCE=true ;;
    --init-project) INSTALL_ARGS+=("--init-project") ;;
    *) echo "Unknown argument: $arg"; exit 1 ;;
  esac
done

if [ "$REMOVE" = true ]; then
  echo "Removing dotfiles_ai..."

  # Remove skills
  if [ -d "$CLAUDE_DIR/skills" ]; then
    find "$CLAUDE_DIR/skills" -maxdepth 1 -mindepth 1 -type d -name '*' ! -name '.' ! -name '..' -exec rm -rf {} + 2>/dev/null || true
  fi

  if [ -d "$GEMINI_DIR/skills" ]; then
    find "$GEMINI_DIR/skills" -maxdepth 1 -mindepth 1 -type d -exec rm -rf {} + 2>/dev/null || true
  fi

  if [ -d "$AGENTS_SKILLS_DIR" ]; then
    find "$AGENTS_SKILLS_DIR" -maxdepth 1 -mindepth 1 -type d ! -name '.' ! -name '..' -exec rm -rf {} + 2>/dev/null || true
  fi

  # Remove agents
  if [ -d "$CLAUDE_DIR/agents" ]; then
    find "$CLAUDE_DIR/agents" -maxdepth 1 -mindepth 1 -type f -exec rm -f {} + 2>/dev/null || true
  fi

  if [ -d "$GEMINI_DIR/agents" ]; then
    find "$GEMINI_DIR/agents" -maxdepth 1 -mindepth 1 -type f -exec rm -f {} + 2>/dev/null || true
  fi

  echo "Removed dotfiles_ai skills and agents."
  exit 0
fi

mkdir -p "$CLAUDE_DIR/skills" "$CLAUDE_DIR/agents" "$GEMINI_DIR/skills" "$GEMINI_DIR/agents" "$AGENTS_SKILLS_DIR"

# Function to create symlink
create_link() {
  local source="$1"
  local target="$2"
  local link_name="$3"

  if [ -L "$target" ]; then
    rm "$target"
  fi

  if [ -e "$target" ]; then
    if [ "$FORCE" = true ]; then
      rm -rf "$target"
      ln -s "$source" "$target"
      echo "Replaced $target -> $source"
    else
      echo "SKIPPED: $target already exists. Use --force to overwrite."
    fi
  else
    ln -s "$source" "$target"
    echo "Created symlink: $target -> $source"
  fi
}

# Claude Code
for skill_dir in "$DOTFILES_AI_DIR"/skills/*/; do
  skill_name="$(basename "$skill_dir")"
  create_link "$DOTFILES_AI_DIR/skills/$skill_name" "$CLAUDE_DIR/skills/$skill_name" "$skill_name"
done

for agent_file in "$DOTFILES_AI_DIR"/agents/*.md; do
  agent_name="$(basename "$agent_file" .md)"
  create_link "$agent_file" "$CLAUDE_DIR/agents/$agent_name.md" "$agent_name.md"
done

# Gemini
for skill_dir in "$DOTFILES_AI_DIR"/skills/*/; do
  skill_name="$(basename "$skill_dir")"
  create_link "$DOTFILES_AI_DIR/skills/$skill_name" "$GEMINI_DIR/skills/$skill_name" "$skill_name"
done

for agent_file in "$DOTFILES_AI_DIR"/agents/*.md; do
  agent_name="$(basename "$agent_file" .md)"
  create_link "$agent_file" "$GEMINI_DIR/agents/$agent_name.md" "$agent_name.md"
done

# Agent Skills directory (for Pi and others)
for skill_dir in "$DOTFILES_AI_DIR"/skills/*/; do
  skill_name="$(basename "$skill_dir")"
  create_link "$DOTFILES_AI_DIR/skills/$skill_name" "$AGENTS_SKILLS_DIR/$skill_name" "$skill_name"
done

echo "Done."
