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

# Rank thresholds
declare -A RANKS=(
  [500]="D:Dungeon Crawler"
  [2000]="C:Raid Member"
  [5000]="B:Guild Elite"
  [10000]="A:Hunter of Renown"
  [25000]="S:Strongest Hunter"
  [50000]="SS:National Level"
  [100000]="SSS:Shadow Monarch"
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

if [[ -n "$ranked_up" ]]; then
  echo ""
  echo "「 RANK UP 」"
  echo "[${old_rank} → ${new_rank}]"
  echo "Title: ${new_title}"
fi

if [[ -n "$leveled_up" && -z "$ranked_up" ]]; then
  echo "[Level Up: ${current_level} → ${new_level}]"
fi

echo "[${bar}] ${new_xp}/${next_threshold} XP"
echo "[Rank ${new_rank} - Lv.${new_level}] ${new_title}"
echo ""
