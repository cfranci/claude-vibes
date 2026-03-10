#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo ""
echo "  claude-vibes installer"
echo "  ======================"
echo ""

# Create directories
mkdir -p "$CLAUDE_DIR/scripts"
mkdir -p "$CLAUDE_DIR/commands"

# Copy scripts
cp "$REPO_DIR/scripts/statusline.sh" "$CLAUDE_DIR/scripts/"
cp "$REPO_DIR/scripts/track-cwd.sh" "$CLAUDE_DIR/scripts/"
chmod +x "$CLAUDE_DIR/scripts/statusline.sh" "$CLAUDE_DIR/scripts/track-cwd.sh"

# Copy commands
cp "$REPO_DIR/commands/sensorThoughts.md" "$CLAUDE_DIR/commands/"
cp "$REPO_DIR/commands/unsensorThoughts.md" "$CLAUDE_DIR/commands/"

# Copy keybindings (backup existing)
if [ -f "$CLAUDE_DIR/keybindings.json" ]; then
  cp "$CLAUDE_DIR/keybindings.json" "$CLAUDE_DIR/keybindings.json.backup"
  echo "  Backed up existing keybindings.json"
fi
cp "$REPO_DIR/keybindings.json" "$CLAUDE_DIR/"

# Choose verb pack
echo "  Which spinner verb pack do you want?"
echo ""
echo "    1) SFW  - funny but work-safe (Gaslighting the compiler, Delulu deploying...)"
echo "    2) NSFW - absolutely unhinged (you've been warned)"
echo ""
read -p "  Pick [1/2]: " choice

if [ "$choice" = "2" ]; then
  VERB_FILE="$REPO_DIR/verbs/nsfw.json"
  cp "$REPO_DIR/verbs/nsfw.json" "$CLAUDE_DIR/spinnerVerbs-nsfw.json"
  echo "  NSFW mode activated. Use /sensorThoughts to censor."
else
  VERB_FILE="$REPO_DIR/verbs/sfw.json"
  echo "  SFW mode. Use /unsensorThoughts if you want chaos."
fi

# Merge into settings.json
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  # Backup existing
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.backup"
  echo "  Backed up existing settings.json"

  # Check if settings already has our keys
  if command -v jq &> /dev/null; then
    VERBS=$(cat "$VERB_FILE")
    SETTINGS=$(cat "$CLAUDE_DIR/settings.json")

    # Add spinnerVerbs, spinnerTipsEnabled, hooks, and statusLine
    echo "$SETTINGS" | jq \
      --argjson verbs "$VERBS" \
      --argjson hooks '{
        "PostToolUse": [{"matcher": "Bash", "hooks": [{"type": "command", "command": "~/.claude/scripts/track-cwd.sh", "timeout": 5000}]}],
        "SessionEnd": [{"hooks": [{"type": "command", "command": "rm -f /tmp/claude-cwd-$PPID"}]}]
      }' \
      '. + {
        "spinnerTipsEnabled": false,
        "spinnerVerbs": $verbs,
        "hooks": ((.hooks // {}) * $hooks),
        "statusLine": {"type": "command", "command": "~/.claude/scripts/statusline.sh"}
      }' > "$CLAUDE_DIR/settings.json.tmp" && mv "$CLAUDE_DIR/settings.json.tmp" "$CLAUDE_DIR/settings.json"
    echo "  Updated settings.json"
  else
    echo "  jq not found - please install jq and re-run, or manually add configs to settings.json"
  fi
else
  # Create fresh settings.json
  VERBS=$(cat "$VERB_FILE")
  jq -n --argjson verbs "$VERBS" '{
    "spinnerTipsEnabled": false,
    "spinnerVerbs": $verbs,
    "hooks": {
      "PostToolUse": [{"matcher": "Bash", "hooks": [{"type": "command", "command": "~/.claude/scripts/track-cwd.sh", "timeout": 5000}]}],
      "SessionEnd": [{"hooks": [{"type": "command", "command": "rm -f /tmp/claude-cwd-$PPID"}]}]
    },
    "statusLine": {"type": "command", "command": "~/.claude/scripts/statusline.sh"}
  }' > "$CLAUDE_DIR/settings.json"
  echo "  Created settings.json"
fi

# Copy NSFW backup for uncensor command
cp "$REPO_DIR/verbs/nsfw.json" "$CLAUDE_DIR/spinnerVerbs-nsfw.json"

echo ""
echo "  Done! Restart Claude Code to see changes."
echo ""
echo "  What you get:"
echo "    - Status line: project name, git branch, tokens, context %"
echo "    - Keybindings: Cmd+Enter=newline, Ctrl+K Ctrl+P=git push"
echo "    - Spinner verbs: the good stuff"
echo "    - /sensorThoughts: make it work-safe"
echo "    - /unsensorThoughts: bring back the chaos"
echo ""
