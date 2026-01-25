#!/bin/bash
# Shadow Monarch XP Tracker
# Usage: xp-tracker.sh <action>
# Actions: commit, pr

set -e

# Configuration
STATE_FILE="${CLAUDE_PROJECT_DIR:-.}/.claude/shadow-level.json"
ACTION="$1"
XP_COMMIT=50
XP_PR=200

# Rank thresholds (sorted ascending)
THRESHOLDS=(0 200 600 1500 3500 8000 15000 25000)
RANKS=(E D C B A S SS SSS)
TITLES=("Weakest Hunter" "Dungeon Crawler" "Raid Member" "Guild Elite" "Hunter of Renown" "Strongest Hunter" "National Level" "Shadow Monarch")

# Get color for a rank
rank_color() {
  case "$1" in
    E)   echo "\x1b[90m" ;;
    D)   echo "\x1b[32m" ;;
    C)   echo "\x1b[36m" ;;
    B)   echo "\x1b[34m" ;;
    A)   echo "\x1b[31m" ;;
    S)   echo "\x1b[33m" ;;
    SS)  echo "\x1b[93m" ;;
    SSS) echo "\x1b[38;2;164;128;242m" ;;
  esac
}

# Find rank index for given XP
find_rank_index() {
  local xp=$1 i=0
  for ((i=${#THRESHOLDS[@]}-1; i>=0; i--)); do
    [[ $xp -ge ${THRESHOLDS[i]} ]] && echo $i && return
  done
  echo 0
}

# Initialize state file
mkdir -p "$(dirname "$STATE_FILE")"
[[ -f "$STATE_FILE" ]] || echo '{"xp":0,"level":1,"rank":"E","title":"Weakest Hunter","commits":0,"prs":0}' > "$STATE_FILE"

# Read current state (single jq call)
read -r current_xp current_level old_rank commits prs < <(jq -r '[.xp, .level, .rank, .commits, .prs] | @tsv' "$STATE_FILE")

# Calculate XP gain based on action
case "$ACTION" in
  commit) xp_gain=$XP_COMMIT; commits=$((commits + 1)); action_text="Commit recorded" ;;
  pr)     xp_gain=$XP_PR;     prs=$((prs + 1));         action_text="Pull Request created" ;;
  *)      exit 0 ;;
esac

# Calculate new values
new_xp=$((current_xp + xp_gain))
new_level=$(( (new_xp / 100) + 1 ))
rank_idx=$(find_rank_index $new_xp)
new_rank="${RANKS[rank_idx]}"
new_title="${TITLES[rank_idx]}"

# Check for level/rank ups
leveled_up=$([[ $new_level -gt $current_level ]] && echo 1 || echo "")
ranked_up=$([[ "$new_rank" != "$old_rank" ]] && echo 1 || echo "")

# Save state
jq --argjson xp "$new_xp" --argjson level "$new_level" --arg rank "$new_rank" \
   --arg title "$new_title" --argjson commits "$commits" --argjson prs "$prs" \
   '.xp=$xp | .level=$level | .rank=$rank | .title=$title | .commits=$commits | .prs=$prs' \
   "$STATE_FILE" > "${STATE_FILE}.tmp" && mv "${STATE_FILE}.tmp" "$STATE_FILE"

# Calculate progress bar
next_idx=$((rank_idx < ${#THRESHOLDS[@]}-1 ? rank_idx + 1 : rank_idx))
prev_threshold=${THRESHOLDS[rank_idx]}
next_threshold=${THRESHOLDS[next_idx]}

if [[ $next_threshold -gt $prev_threshold ]]; then
  progress=$((new_xp - prev_threshold))
  range=$((next_threshold - prev_threshold))
  filled=$(( (progress * 20) / range ))
else
  filled=20
fi
empty=$((20 - filled))

bar=$(printf '%0.s█' $(seq 1 $filled 2>/dev/null) || true)
bar+=$(printf '%0.s░' $(seq 1 $empty 2>/dev/null) || true)

# Output
echo ""
echo "[+${xp_gain} XP] ${action_text}"

# Rank-up animation
if [[ -n "$ranked_up" ]]; then
  old_color=$(rank_color "$old_rank")
  new_color=$(rank_color "$new_rank")

  echo ""
  sleep 0.3
  echo -e "\x1b[35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━\x1b[0m"
  sleep 0.2
  echo -e "\x1b[1;33m「 RANK UP 」\x1b[0m"
  sleep 0.2
  echo -e "   ${old_color}[${old_rank}]\x1b[0m ➜ ${new_color}[${new_rank}]\x1b[0m"
  sleep 0.2
  echo -e "\x1b[35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━\x1b[0m"
  sleep 0.2

  # Rank-specific messages
  case "$new_rank" in
    D)   echo -e "  \x1b[1m${new_title}\x1b[0m" ;;
    C)   echo -e "  \x1b[1m${new_title}\x1b[0m - You're getting stronger" ;;
    B)   echo -e "  \x1b[1m${new_title}\x1b[0m - Advanced hunter acquired" ;;
    A)   echo -e "  \x1b[1;31m${new_title}\x1b[0m - Elite status achieved" ;;
    S)   echo -e "  \x1b[1;33m${new_title}\x1b[0m - You've become a legend" ;;
    SS)  echo -e "  \x1b[1;93m${new_title}\x1b[0m - National Level Hunter" ;;
    SSS)
      sleep 0.2
      echo -e "  \x1b[1;38;2;164;128;242m「 SHADOW MONARCH AWAKENED 」\x1b[0m"
      sleep 0.2
      echo -e "  \x1b[38;2;164;128;242mYou have transcended all limits\x1b[0m"
      ;;
  esac

  sleep 0.2
  echo -e "\x1b[35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━\x1b[0m"
  sleep 0.3
fi

# Level-up animation (only if no rank up)
if [[ -n "$leveled_up" && -z "$ranked_up" ]]; then
  echo ""
  sleep 0.3
  echo -e "\x1b[33m✦ ✦ ✦ LEVEL UP ✦ ✦ ✦\x1b[0m"
  sleep 0.2
  echo -e "  \x1b[1mLv.${current_level}\x1b[0m → \x1b[1;32mLv.${new_level}\x1b[0m"
  sleep 0.3
fi

echo ""
echo "[${bar}] ${new_xp}/${next_threshold} XP"
echo "[Rank ${new_rank} - Lv.${new_level}] ${new_title}"
echo ""
