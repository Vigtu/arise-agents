#!/bin/bash
# Hook script that detects commits and PRs from PostToolUse events
# Receives JSON via stdin
# Uses CLAUDE_PLUGIN_ROOT to find the xp-tracker script

XP_TRACKER="${CLAUDE_PLUGIN_ROOT}/scripts/xp-tracker.sh"

# Read JSON from stdin
input=$(cat)

# Extract tool name and input
tool_name=$(echo "$input" | jq -r '.tool_name // empty')
tool_input=$(echo "$input" | jq -r '.tool_input.command // empty')

# Only process Bash tool
if [[ "$tool_name" != "Bash" ]]; then
  exit 0
fi

# Detect commit (successful git commit)
if echo "$tool_input" | grep -qE 'git\s+commit'; then
  "$XP_TRACKER" commit
  exit 0
fi

# Detect PR creation
if echo "$tool_input" | grep -qE 'gh\s+pr\s+create'; then
  "$XP_TRACKER" pr
  exit 0
fi

exit 0
