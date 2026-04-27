#!/bin/bash
# Merge Claude hook config into ~/.claude/settings.json.
# Idempotent: re-run safely after adding new hooks; existing entries
# (like joule_*) and unrelated settings are preserved.
set -e

SETTINGS="$HOME/.claude/settings.json"
[ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"

# Append a hook command to event $1 if not already present.
#   $1 = event name (Stop, SessionStart, UserPromptSubmit, ...)
#   $2 = command string
#   $3 = timeout in seconds
merge_hook() {
  local event="$1" cmd="$2" timeout="$3"
  jq --arg event "$event" --arg cmd "$cmd" --argjson timeout "$timeout" '
    .hooks //= {}
    | .hooks[$event] //= [{"hooks": []}]
    | .hooks[$event][0].hooks //= []
    | if any(.hooks[$event][0].hooks[]; .command == $cmd) then
        .
      else
        .hooks[$event][0].hooks += [{type: "command", command: $cmd, timeout: $timeout}]
      end
  ' "$SETTINGS" > "${SETTINGS}.tmp" && mv "${SETTINGS}.tmp" "$SETTINGS"
}

# Stop: review/commit loop, then "Claude finished" tmux toast.
merge_hook Stop 'bash ~/.claude/hooks/auto_stop.sh' 10
merge_hook Stop "[ -n \"\$TMUX\" ] && tmux display-message -d 2500 'Claude finished' 2>/dev/null; exit 0" 5

# SessionStart: name the tmux window after the project.
merge_hook SessionStart 'bash ~/.claude/hooks/tmux_rename.sh SessionStart' 3

echo "Claude hooks configured in $SETTINGS"
