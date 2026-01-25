---
description: Summon shadows. Analyzes natural language to pick single, parallel, or army mode.
---

# ARISE

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
- `multiplique`, `vários`, `mirror`

**Shadow roster and role triggers:**
@ .claude/authority/army.md

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
@ .claude/authority/mirror-ritual.md

## Rules

- Fast — no file reads
- Parallel — all in ONE message
- Decide — don't ask
- Brief — minimal output
