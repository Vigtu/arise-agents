#!/bin/bash
# Shadow Monarch Statusline for Claude Code
# Part of arise-agents plugin
#
# Install via: npx arise-agents
# Or copy this file to ~/.claude/ and configure settings.json

# Find the shadow-level.json (check project first, then global)
PROJECT_STATE="${CLAUDE_PROJECT_DIR:-.}/.claude/shadow-level.json"
GLOBAL_STATE="${HOME}/.claude/shadow-level.json"

if [[ -f "$PROJECT_STATE" ]]; then
  STATE_FILE="$PROJECT_STATE"
elif [[ -f "$GLOBAL_STATE" ]]; then
  STATE_FILE="$GLOBAL_STATE"
else
  # No XP data yet - show default
  echo "「Lv.1」E-Rank ░░░░░░░░░░ 0/200 XP"
  exit 0
fi

# Read state
xp=$(jq -r '.xp // 0' "$STATE_FILE" 2>/dev/null || echo "0")
level=$(jq -r '.level // 1' "$STATE_FILE" 2>/dev/null || echo "1")
rank=$(jq -r '.rank // "E"' "$STATE_FILE" 2>/dev/null || echo "E")
title=$(jq -r '.title // "Shadow Initiate"' "$STATE_FILE" 2>/dev/null || echo "Shadow Initiate")
commits=$(jq -r '.commits // 0' "$STATE_FILE" 2>/dev/null || echo "0")
prs=$(jq -r '.prs // 0' "$STATE_FILE" 2>/dev/null || echo "0")

# Rank thresholds (rebalanced)
declare -A THRESHOLDS=(
  [E]=200 [D]=600 [C]=1500 [B]=3500 [A]=8000 [S]=15000 [SS]=25000 [SSS]=999999
)

next_threshold=${THRESHOLDS[$rank]:-500}

# Progress bar (10 chars)
if [[ $next_threshold -gt 0 ]]; then
  progress=$(( (xp * 10) / next_threshold ))
  [[ $progress -gt 10 ]] && progress=10
else
  progress=10
fi

bar=""
for ((i=0; i<progress; i++)); do bar+="█"; done
for ((i=progress; i<10; i++)); do bar+="░"; done

# Rank colors (Shadow Monarch theme)
case "$rank" in
  E) rank_color="\x1b[90m" ;;                    # Gray - Weakest Hunter
  D) rank_color="\x1b[32m" ;;                    # Green - Beginner
  C) rank_color="\x1b[36m" ;;                    # Cyan - Intermediate
  B) rank_color="\x1b[34m" ;;                    # Blue - Advanced
  A) rank_color="\x1b[31m" ;;                    # Red - Elite
  S) rank_color="\x1b[33m" ;;                    # Gold - Top Hunter
  SS) rank_color="\x1b[93m" ;;                   # Bright Gold - National Level
  SSS) rank_color="\x1b[38;2;164;128;242m" ;;    # Shadow Monarch Purple (#A480F2)
  *) rank_color="\x1b[0m" ;;
esac
reset="\x1b[0m"

# Output
printf "「Lv.%d」${rank_color}%s-Rank${reset} %s %d/%d XP │ %d commits │ %d PRs" \
  "$level" "$rank" "$bar" "$xp" "$next_threshold" "$commits" "$prs"
