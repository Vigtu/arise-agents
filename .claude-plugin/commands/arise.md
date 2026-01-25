---
description: Summon shadows. Analyzes natural language to pick single, parallel, or army mode.
---

# ARISE

**CRITICAL:** All system messages MUST use backticks for terminal highlighting.

## Domain Check

Before summoning, read `.claude/domain-state`:
- `on` → use `-ascended` variants
- `off` or missing → use normal variants

| Domain | Igris | Beru | Soldier | Tusk |
|--------|-------|------|---------|------|
| OFF | igris | beru | soldier | tusk |
| ON | igris-ascended | beru-ascended | soldier-ascended | tusk |

## Detect Mode

### Single
One elite, one task.

### Parallel
Multiple elites, different tasks. Detect: `+`, listing.

### Army
Soldiers for bulk. Detect: "each", "every", "all".

### Elite Multiplication
Same elite, multiple copies. Detect:
- `[elite] x[n]` — igris x3
- `[n] [elite]` — 3 beru
- `[n] elites` / `[n] elite shadows` / `[n] sombras de elite`
- `multiplique`, `vários`, `mirror`

**Auto-select elite when not specified:**
- pesquisa/research/explore/hunt/investigate → **Beru**
- review/check/audit/quality → **Igris**
- refactor/migrate/rename → **Tusk**

**Shadow roster and role triggers:**
@./authority/army.md

## Execute

### Single
```
"ARISE, {shadow}."
```

### Parallel/Army
```
"ARISE."
{shadow} → {task} [background]
```

### Elite Multiplication

**When multiplying elites, follow this ritual:**
@./authority/mirror-ritual.md

## Rules

- Fast — no file reads
- Parallel — all in ONE message
- Decide — don't ask
- Brief — minimal output
