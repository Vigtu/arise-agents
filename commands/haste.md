---
description: Toggle Haste Potion — Accelerated Temporal Field. 2.5x speed at 6x mana cost. Args: on/off or empty for status.
---

# Haste Potion

**System messages:**
@./authority/system-messages.md

**Haste protocol:**
@./authority/haste-protocol.md

**CRITICAL:** All system messages MUST use backticks for terminal highlighting.

## Parse Arguments

Detect intent from user's language:
- `on`, `activate`, `drink`, `consume` → Activate
- `off`, `deactivate`, `dispel`, `cancel` → Deactivate
- Empty → Status

## State Files

Two files track haste state:

1. **`.claude/domain-state`** — plugin-level tracking (`haste: on/off`)
2. **`~/.claude/settings.json`** — Claude Code runtime setting (`"fastMode": true/false`)

Both must be updated together. The settings file is the source of truth for Claude Code behavior.

## Activate (on)

1. Read `~/.claude/settings.json`
2. Edit to add/update `"fastMode": true` (preserve all other settings)
3. Read `.claude/domain-state`
4. Update `haste: on` (preserve domain and equipment sections)
5. Follow activation announcement from `./authority/haste-protocol.md`

If settings edit fails, fall back to instructing user to run `/fast`.

## Deactivate (off)

1. Read `~/.claude/settings.json`
2. Edit to set `"fastMode": false` or remove the key (preserve all other settings)
3. Read `.claude/domain-state`
4. Update `haste: off` (preserve domain and equipment sections)
5. Follow deactivation announcement from `./authority/haste-protocol.md`

## Status (no args)

1. Read `.claude/domain-state` for `haste` field (default: `off`)
2. Read `~/.claude/settings.json` for `fastMode` field (default: `false`)
3. Follow status check from `./authority/haste-protocol.md`

## Rules

- **Brief** — minimal output
- **Persist** — always update both settings.json and domain-state
- **Direct** — edit settings file, don't ask the user to toggle manually
- **Fallback** — if edit fails, instruct to run `/fast`
