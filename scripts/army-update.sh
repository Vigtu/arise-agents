#!/bin/bash
# Army Update - Syncs army.md when agents change
# Called by /extract or manually with --direct

set -e

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(dirname "$(dirname "$0")")}"
AGENTS_DIR="$PLUGIN_ROOT/agents"
ARMY_FILE="$PLUGIN_ROOT/authority/army.md"

# Parse frontmatter from agent file
parse_agent() {
  local file="$1"
  grep -m1 "^$2:" "$file" 2>/dev/null | sed "s/$2: *//"
}

# Build shadows table
build_table() {
  echo "| Name | Role | Model |"
  echo "|------|------|-------|"

  for file in "$AGENTS_DIR"/*.md; do
    [[ "$file" == *".ascended.md" ]] && continue
    [[ ! -f "$file" ]] && continue

    local basename=$(basename "$file" .md)
    local ascended_file="$AGENTS_DIR/${basename}.ascended.md"

    local name=$(parse_agent "$file" "name")
    local role=$(parse_agent "$file" "role")
    local model=$(parse_agent "$file" "model")

    if [[ -f "$ascended_file" ]]; then
      local ascended=$(parse_agent "$ascended_file" "model")
      echo "| $name | $role | $model → $ascended |"
    else
      echo "| $name | $role | $model |"
    fi
  done
}

# Update army.md shadows section
update_army() {
  local table=$(build_table)
  local temp_file=$(mktemp)

  awk -v table="$table" '
    /^## Shadows/ { print; getline; print table; print ""; skip=1; next }
    /^## / && skip { skip=0 }
    !skip { print }
  ' "$ARMY_FILE" > "$temp_file"

  mv "$temp_file" "$ARMY_FILE"
}

update_army
echo "[Army updated]"
