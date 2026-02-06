#!/bin/bash
# Shadow Monarch PostToolUse Hook for Write tool
# Detects new shadow agents and bestiary entries
# Receives JSON via stdin: { tool_name, tool_input: { file_path } }
#
# Events detected:
#   agents/*.md      → army update + extraction XP (+40)
#   grimoires/*.md   → bestiary XP (+20)

XP_TRACKER="${CLAUDE_PLUGIN_ROOT}/scripts/xp-tracker.sh"
ARMY_UPDATE="${CLAUDE_PLUGIN_ROOT}/scripts/army-update.sh"

# Read JSON from stdin
input=$(cat)

# Extract file path
file_path=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')

[[ -z "$file_path" ]] && exit 0

# Detect new shadow agent (agents/*.md but not .ascended.md)
if printf '%s' "$file_path" | grep -qE '/agents/[^/]+\.md$'; then
  if printf '%s' "$file_path" | grep -qE '\.ascended\.md$'; then
    exit 0
  fi
  # Update army registry
  "$ARMY_UPDATE" 2>/dev/null
  # Award XP
  "$XP_TRACKER" extraction
  exit 0
fi

# Detect bestiary entry (grimoires/*.md)
if printf '%s' "$file_path" | grep -qE '/grimoires/[^/]+\.md$'; then
  "$XP_TRACKER" bestiary
  exit 0
fi

exit 0
