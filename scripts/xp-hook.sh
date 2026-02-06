#!/bin/bash
# Shadow Monarch PostToolUse Hook
# Detects events from Bash commands and routes to xp-tracker
# Receives JSON via stdin: { tool_name, tool_input, tool_output }
#
# Events detected:
#   git commit        → +50 XP
#   gh pr create      → +200 XP
#   tests pass        → +30 XP
#   tests fail        → Red Alert (0 XP)
#   git push          → +30 XP
#   git push fail     → Red Alert (0 XP)
#   new branch        → +10 XP
#   build pass        → +20 XP
#   build fail        → Red Alert (0 XP)

XP_TRACKER="${CLAUDE_PLUGIN_ROOT}/scripts/xp-tracker.sh"

# Read JSON from stdin
input=$(cat)

# Extract tool name and command (printf avoids shell escape interpretation)
tool_name=$(printf '%s' "$input" | jq -r '.tool_name // empty')
tool_input=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')

# Only process Bash tool
[[ "$tool_name" != "Bash" ]] && exit 0

# Lazy helper: extract tool output only when needed for pass/fail detection
get_output() {
  printf '%s' "$input" | jq -r '
    if (.tool_output | type) == "string" then .tool_output
    elif (.tool_output | type) == "object" then ((.tool_output.stdout // "") + " " + (.tool_output.stderr // ""))
    else ""
    end
  ' 2>/dev/null || echo ""
}

# --- Detections (most specific first) ---

# 1. Git commit
if printf '%s' "$tool_input" | grep -qE 'git\s+commit'; then
  "$XP_TRACKER" commit
  exit 0
fi

# 2. PR creation
if printf '%s' "$tool_input" | grep -qE 'gh\s+pr\s+create'; then
  "$XP_TRACKER" pr
  exit 0
fi

# 3. Tests (npm test, npx vitest/jest, pytest, cargo test, go test, make test)
if printf '%s' "$tool_input" | grep -qEi '(npm\s+test|npx\s+(vitest|jest)|pytest|cargo\s+test|go\s+test|make\s+test)'; then
  output=$(get_output)
  # Detect failure: "N failed" (N>0), FAIL/FAILED at line start, non-zero exit, panic
  if printf '%s' "$output" | grep -qEi '([1-9][0-9]*\s*fail|^FAIL|FAILURES|exit code:?\s*[1-9]|AssertionError|panic|ERRORS?)'; then
    "$XP_TRACKER" test_fail
  else
    "$XP_TRACKER" test_pass
  fi
  exit 0
fi

# 4. Git push
if printf '%s' "$tool_input" | grep -qE 'git\s+push'; then
  output=$(get_output)
  if printf '%s' "$output" | grep -qEi '(reject|error|fatal|failed|non-fast-forward)'; then
    "$XP_TRACKER" push_fail
  else
    "$XP_TRACKER" push
  fi
  exit 0
fi

# 5. New branch (checkout -b or switch -c)
if printf '%s' "$tool_input" | grep -qE 'git\s+(checkout\s+-b|switch\s+-c)'; then
  "$XP_TRACKER" branch
  exit 0
fi

# 6. Build (npm run build, cargo build, go build, tsc, make)
if printf '%s' "$tool_input" | grep -qEi '(npm\s+run\s+build|cargo\s+build|go\s+build|npx?\s+tsc|make\s*(build|all)?\s*$)'; then
  output=$(get_output)
  if printf '%s' "$output" | grep -qEi '(error[:\[]|ERR!|FAILED|failed to compile|exit code:?\s*[1-9])'; then
    "$XP_TRACKER" build_fail
  else
    "$XP_TRACKER" build_pass
  fi
  exit 0
fi

exit 0
