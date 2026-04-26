#!/bin/bash
# Merge Claude hook config into ~/.claude/settings.json
# Run after `stow claude` to register the hooks

SETTINGS="$HOME/.claude/settings.json"

# Create settings file if it doesn't exist
if [ ! -f "$SETTINGS" ]; then
  echo '{}' > "$SETTINGS"
fi

# Check if hooks are already configured
if jq -e '.hooks.Stop' "$SETTINGS" > /dev/null 2>&1; then
  echo "Claude hooks already configured in $SETTINGS"
  exit 0
fi

# Add hooks config
jq '.hooks = {
  "Stop": [
    {
      "hooks": [
        {
          "type": "command",
          "command": "bash ~/.claude/hooks/auto_stop.sh",
          "timeout": 10
        },
        {
          "type": "command",
          "command": "[ -n \"$TMUX\" ] && tmux display-message -d 2500 '"'"'Claude finished'"'"' 2>/dev/null; exit 0",
          "timeout": 5
        }
      ]
    }
  ]
}' "$SETTINGS" > "${SETTINGS}.tmp" && mv "${SETTINGS}.tmp" "$SETTINGS"

echo "Claude hooks configured in $SETTINGS"
