#!/bin/bash
# Shadow Monarch XP Tracker
# Usage: xp-tracker.sh <action>
# Actions: commit, pr, test_pass, test_fail, push, push_fail, branch, build_pass, build_fail

set -e

# Configuration
STATE_FILE="${CLAUDE_PROJECT_DIR:-.}/.claude/shadow-level.json"
ACTION="$1"

# XP values
XP_COMMIT=50
XP_PR=200
XP_TEST=30
XP_PUSH=30
XP_BRANCH=10
XP_BUILD=20

# ANSI colors
RED="\x1b[31m"
RED_BOLD="\x1b[1;31m"
GREEN="\x1b[32m"
GREEN_BOLD="\x1b[1;32m"
CYAN="\x1b[36m"
CYAN_BOLD="\x1b[1;36m"
YELLOW="\x1b[33m"
PURPLE="\x1b[35m"
DIM="\x1b[2m"
BOLD="\x1b[1m"
RESET="\x1b[0m"

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

# ══════════════════════════════════════════
# FAILURE EVENTS — Red Alert, no XP
# ══════════════════════════════════════════

case "$ACTION" in
  test_fail)
    echo ""
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${RED_BOLD}  「 TESTS FAILED 」${RESET}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "  ${RED}The dungeon fights back.${RESET}"
    echo -e "  ${DIM}Shadows cannot advance through broken ground.${RESET}"
    echo -e "  ${DIM}No XP awarded.${RESET}"
    echo ""
    exit 0
    ;;
  push_fail)
    echo ""
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${RED_BOLD}  「 PUSH REJECTED 」${RESET}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "  ${RED}The remote realm rejects your shadows.${RESET}"
    echo -e "  ${DIM}Resolve conflicts before deploying.${RESET}"
    echo ""
    exit 0
    ;;
  build_fail)
    echo ""
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${RED_BOLD}  「 BUILD COLLAPSED 」${RESET}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "  ${RED}The fortress crumbles under its own weight.${RESET}"
    echo -e "  ${DIM}No XP awarded.${RESET}"
    echo ""
    exit 0
    ;;
esac

# ══════════════════════════════════════════
# SUCCESS EVENTS — Award XP
# ══════════════════════════════════════════

# Initialize state file
mkdir -p "$(dirname "$STATE_FILE")"
[[ -f "$STATE_FILE" ]] || echo '{"xp":0,"level":1,"rank":"E","title":"Weakest Hunter","commits":0,"prs":0}' > "$STATE_FILE"

# Read current state
read -r current_xp current_level old_rank commits prs < <(jq -r '[.xp, .level, .rank, .commits, .prs] | @tsv' "$STATE_FILE")

# Calculate XP gain and update counters
case "$ACTION" in
  commit)
    xp_gain=$XP_COMMIT
    commits=$((commits + 1))
    action_text="Commit recorded"
    flavor=""
    ;;
  pr)
    xp_gain=$XP_PR
    prs=$((prs + 1))
    action_text="Pull Request created"
    flavor=""
    ;;
  test_pass)
    xp_gain=$XP_TEST
    action_text="Tests conquered"
    flavor="${GREEN}⚔${RESET} ${GREEN}All tests pass — no survivors.${RESET}"
    ;;
  push)
    xp_gain=$XP_PUSH
    action_text="Shadows deployed"
    flavor="${CYAN}↑${RESET} ${CYAN}Shadows deployed to the remote realm.${RESET}"
    ;;
  branch)
    xp_gain=$XP_BRANCH
    action_text="New dungeon gate"
    flavor="${CYAN}◆${RESET} ${CYAN}A new dungeon gate has been opened.${RESET}"
    ;;
  build_pass)
    xp_gain=$XP_BUILD
    action_text="Fortress constructed"
    flavor="${GREEN}⚒${RESET}  ${GREEN}The fortress stands strong.${RESET}"
    ;;
  *)
    exit 0
    ;;
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

# Flavor text first (thematic message for the event)
if [[ -n "$flavor" ]]; then
  echo -e "  $flavor"
fi

echo -e "  ${DIM}[+${xp_gain} XP]${RESET} ${action_text}"

# Rank-up animation
if [[ -n "$ranked_up" ]]; then
  old_color=$(rank_color "$old_rank")
  new_color=$(rank_color "$new_rank")

  echo ""
  sleep 0.3
  echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  sleep 0.2
  echo -e "${BOLD}${YELLOW}「 RANK UP 」${RESET}"
  sleep 0.2
  echo -e "   ${old_color}[${old_rank}]${RESET} ➜ ${new_color}[${new_rank}]${RESET}"
  sleep 0.2
  echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  sleep 0.2

  # Rank-specific messages
  case "$new_rank" in
    D)   echo -e "  ${BOLD}${new_title}${RESET}" ;;
    C)   echo -e "  ${BOLD}${new_title}${RESET} — You're getting stronger" ;;
    B)   echo -e "  ${BOLD}${new_title}${RESET} — Advanced hunter acquired" ;;
    A)   echo -e "  ${RED_BOLD}${new_title}${RESET} — Elite status achieved" ;;
    S)   echo -e "  ${BOLD}${YELLOW}${new_title}${RESET} — You've become a legend" ;;
    SS)  echo -e "  \x1b[1;93m${new_title}\x1b[0m — National Level Hunter" ;;
    SSS)
      sleep 0.2
      echo -e "  \x1b[1;38;2;164;128;242m「 SHADOW MONARCH AWAKENED 」\x1b[0m"
      sleep 0.2
      echo -e "  \x1b[38;2;164;128;242mYou have transcended all limits\x1b[0m"
      ;;
  esac

  sleep 0.2
  echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
  sleep 0.3
fi

# Level-up animation (only if no rank up)
if [[ -n "$leveled_up" && -z "$ranked_up" ]]; then
  echo ""
  sleep 0.3
  echo -e "${YELLOW}✦ ✦ ✦ LEVEL UP ✦ ✦ ✦${RESET}"
  sleep 0.2
  echo -e "  ${BOLD}Lv.${current_level}${RESET} → ${GREEN_BOLD}Lv.${new_level}${RESET}"
  sleep 0.3
fi

echo ""
echo "  [${bar}] ${new_xp}/${next_threshold} XP"
echo -e "  [Rank ${new_rank} — Lv.${new_level}] ${DIM}${new_title}${RESET}"
echo ""
