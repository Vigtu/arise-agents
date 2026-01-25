#!/bin/bash
# Shadow Monarch XP Tracker
# Usage: xp-tracker.sh <action>
# Actions: commit, pr

set -e

# Use project directory for per-project XP tracking
STATE_FILE="${CLAUDE_PROJECT_DIR:-.}/.claude/shadow-level.json"
ACTION="$1"

# XP values
XP_COMMIT=50
XP_PR=200

# Rank thresholds (rebalanced for better progression)
declare -A RANKS=(
  [200]="D:Dungeon Crawler"
  [600]="C:Raid Member"
  [1500]="B:Guild Elite"
  [3500]="A:Hunter of Renown"
  [8000]="S:Strongest Hunter"
  [15000]="SS:National Level"
  [25000]="SSS:Shadow Monarch"
)

# Ensure .claude directory exists
mkdir -p "$(dirname "$STATE_FILE")"

# Initialize if file doesn't exist
if [[ ! -f "$STATE_FILE" ]]; then
  echo '{"xp":0,"level":1,"rank":"E","title":"Shadow Initiate","commits":0,"prs":0}' > "$STATE_FILE"
fi

# Read current state
current_xp=$(jq -r '.xp' "$STATE_FILE")
current_level=$(jq -r '.level' "$STATE_FILE")
commits=$(jq -r '.commits' "$STATE_FILE")
prs=$(jq -r '.prs' "$STATE_FILE")

# Calculate XP gain
case "$ACTION" in
  commit)
    xp_gain=$XP_COMMIT
    commits=$((commits + 1))
    action_text="Commit recorded"
    ;;
  pr)
    xp_gain=$XP_PR
    prs=$((prs + 1))
    action_text="Pull Request created"
    ;;
  *)
    exit 0
    ;;
esac

# Update XP
new_xp=$((current_xp + xp_gain))

# Calculate new level (1 level per 100 XP)
new_level=$(( (new_xp / 100) + 1 ))

# Determine rank and title
new_rank="E"
new_title="Weakest Hunter"
for threshold in $(echo "${!RANKS[@]}" | tr ' ' '\n' | sort -n); do
  if [[ $new_xp -ge $threshold ]]; then
    IFS=':' read -r new_rank new_title <<< "${RANKS[$threshold]}"
  fi
done

# Check for level up
leveled_up=""
if [[ $new_level -gt $current_level ]]; then
  leveled_up="true"
fi

# Check for rank up
old_rank=$(jq -r '.rank' "$STATE_FILE")
ranked_up=""
if [[ "$new_rank" != "$old_rank" ]]; then
  ranked_up="true"
fi

# Save state
jq --argjson xp "$new_xp" \
   --argjson level "$new_level" \
   --arg rank "$new_rank" \
   --arg title "$new_title" \
   --argjson commits "$commits" \
   --argjson prs "$prs" \
   '.xp=$xp | .level=$level | .rank=$rank | .title=$title | .commits=$commits | .prs=$prs' \
   "$STATE_FILE" > "${STATE_FILE}.tmp" && mv "${STATE_FILE}.tmp" "$STATE_FILE"

# Calculate progress bar (20 chars)
next_threshold=500
for threshold in $(echo "${!RANKS[@]}" | tr ' ' '\n' | sort -n); do
  if [[ $new_xp -lt $threshold ]]; then
    next_threshold=$threshold
    break
  fi
done

# Find previous threshold
prev_threshold=0
for threshold in $(echo "${!RANKS[@]}" | tr ' ' '\n' | sort -n); do
  if [[ $threshold -lt $next_threshold && $new_xp -ge $threshold ]]; then
    prev_threshold=$threshold
  fi
done

range=$((next_threshold - prev_threshold))
progress=$((new_xp - prev_threshold))
if [[ $range -gt 0 ]]; then
  filled=$(( (progress * 20) / range ))
else
  filled=20
fi
empty=$((20 - filled))

bar=$(printf '%0.s█' $(seq 1 $filled 2>/dev/null) || echo "")
bar+=$(printf '%0.s░' $(seq 1 $empty 2>/dev/null) || echo "")

# Output
echo ""
echo "[+${xp_gain} XP] ${action_text}"

# Rank-up animation (epic with custom messages per rank)
if [[ -n "$ranked_up" ]]; then
  echo ""
  sleep 0.3
  echo -e "\x1b[35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━\x1b[0m"
  sleep 0.2
  echo -e "\x1b[1;33m「 RANK UP 」\x1b[0m"
  sleep 0.2

  # Custom rank colors
  case "$old_rank" in
    E) old_color="\x1b[90m" ;;
    D) old_color="\x1b[32m" ;;
    C) old_color="\x1b[36m" ;;
    B) old_color="\x1b[34m" ;;
    A) old_color="\x1b[31m" ;;
    S) old_color="\x1b[33m" ;;
    SS) old_color="\x1b[93m" ;;
  esac

  case "$new_rank" in
    D) new_color="\x1b[32m" ;;
    C) new_color="\x1b[36m" ;;
    B) new_color="\x1b[34m" ;;
    A) new_color="\x1b[31m" ;;
    S) new_color="\x1b[33m" ;;
    SS) new_color="\x1b[93m" ;;
    SSS) new_color="\x1b[38;2;164;128;242m" ;;
  esac

  echo -e "   ${old_color}[${old_rank}]\x1b[0m ➜ ${new_color}[${new_rank}]\x1b[0m"
  sleep 0.2
  echo -e "\x1b[35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━\x1b[0m"
  sleep 0.2

  # Custom messages per rank
  case "$new_rank" in
    D) echo -e "  \x1b[1m${new_title}\x1b[0m" ;;
    C) echo -e "  \x1b[1m${new_title}\x1b[0m - You're getting stronger" ;;
    B) echo -e "  \x1b[1m${new_title}\x1b[0m - Advanced hunter acquired" ;;
    A) echo -e "  \x1b[1;31m${new_title}\x1b[0m - Elite status achieved" ;;
    S) echo -e "  \x1b[1;33m${new_title}\x1b[0m - You've become a legend" ;;
    SS) echo -e "  \x1b[1;93m${new_title}\x1b[0m - National Level Hunter" ;;
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

# Level-up animation (simple flash)
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
