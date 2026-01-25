---
description: Activate or deactivate Monarch's Domain. Empowers shadows (sonnet → opus). Args: on/off or empty for status.
---

# Monarch's Domain

## Parse Arguments

Detect intent from user's language:
- `on`, `activate`, `expand` → Activate
- `off`, `deactivate`, `collapse` → Deactivate
- Empty → Status

## State File

Domain state persists in `.claude/domain-state`:
- Format: `domain: on` or `domain: off`
- Also tracks equipment for each shadow
- Read by ARISE to select shadow variants

## Activate (on)

1. Update `.claude/domain-state` - change `domain: off` to `domain: on` (preserve equipment section)
2. Output:
```
「 DOMAIN EXPANSION 」

*dark aura erupts*

[Domain: ACTIVE]
  igris     → igris-ascended (opus)
  beru      → beru-ascended (opus)
  soldier   → soldier-ascended (opus)
  tusk      → tusk (opus) ← always ascended

All shadows empowered.
```

## Deactivate (off)

1. Update `.claude/domain-state` - change `domain: on` to `domain: off` (preserve equipment section)
2. Output:
```
[Domain: INACTIVE]
  igris     → igris (sonnet)
  beru      → beru (sonnet)
  soldier   → soldier (sonnet)
  tusk      → tusk (opus) ← always ascended

Shadows return to normal state.
```

## Status (no args)

1. Read `.claude/domain-state` (default: `off` if missing)
2. Output:
```
[Domain: ACTIVE/INACTIVE]
  Shadows will use: {normal/ascended} variants
```

## How It Works

| Domain | Shadow Selected |
|--------|-----------------|
| `off` | `igris`, `beru`, `soldier` |
| `on` | `igris-ascended`, `beru-ascended`, `soldier-ascended` |

Tusk is always `opus` — the tank knows no limits.

## Rules

- Brief output
- Persist state to `.claude/domain-state`
