#!/bin/bash
# Auto-name the active tmux window for this Claude session.
#
# Behavior:
#   - On SessionStart, rename the current tmux window to 'claude:<project>'
#     (basename of $CLAUDE_PROJECT_DIR) so parallel Claude tabs are
#     identifiable at a glance.
#   - Inject a hint via additionalContext asking Claude to refine the label
#     with a short task summary using `tmux rename-window` once it knows
#     what the user is working on.
#
# Disable per-host by creating ~/.claude/hooks/tmux_rename_disabled.

set -e

[ -f "$HOME/.claude/hooks/tmux_rename_disabled" ] && exit 0
[ -z "$TMUX" ] && exit 0
command -v tmux >/dev/null 2>&1 || exit 0

project="${CLAUDE_PROJECT_DIR:-$PWD}"
project_name=$(basename "$project")

# Truncate to keep tmux status line readable.
short_name="claude:${project_name:0:24}"

tmux rename-window "$short_name" 2>/dev/null || true
# Don't let tmux rewrite the name from the active command.
tmux set-window-option -t "$(tmux display-message -p '#I')" automatic-rename off 2>/dev/null || true

# Emit additionalContext so Claude sees the suggestion. Only on SessionStart;
# UserPromptSubmit gets too noisy if we re-inject every prompt.
event="${1:-SessionStart}"
if [ "$event" = "SessionStart" ] && command -v jq >/dev/null 2>&1; then
  jq -n --arg msg "This Claude session is running inside tmux. The active window has been labeled '$short_name'. When you understand the user's task, run \`tmux rename-window 'claude:<short-task>'\` (≤25 chars) so this tab is easy to spot among parallel sessions. Update the label whenever the task changes." '{
    hookSpecificOutput: {
      hookEventName: "SessionStart",
      additionalContext: $msg
    }
  }'
fi

exit 0
