---
description: Activate or deactivate Monarch's Domain. Empowers shadows (sonnet → opus). Args: on/off or empty for status.
---

# Monarch's Domain

## Files (EXACT PATHS - DO NOT SEARCH)

- `agents/igris.md`
- `agents/beru.md`
- `agents/tusk.md`
- `agents/soldier.md`

## Parse Arguments

- `on`, `activate`, `ativar`, `expand` → Activate
- `off`, `deactivate`, `desativar`, `collapse` → Deactivate
- Empty → Status

## Activate (on)

Edit these files directly (NO searching):
1. `agents/igris.md`: change `model: sonnet` to `model: opus`, `color: blue` to `color: purple`
2. `agents/beru.md`: change `model: sonnet` to `model: opus`, `color: blue` to `color: purple`
3. `agents/soldier.md`: change `model: sonnet` to `model: opus`, `color: blue` to `color: purple`
4. `agents/tusk.md`: already opus, just ensure `color: purple`

Output:
```
[Domain: ACTIVE]
igris: opus
beru: opus
tusk: opus
soldier: opus
```

## Deactivate (off)

Edit these files directly (NO searching):
1. `agents/igris.md`: change `model: opus` to `model: sonnet`, `color: purple` to `color: blue`
2. `agents/beru.md`: change `model: opus` to `model: sonnet`, `color: purple` to `color: blue`
3. `agents/soldier.md`: change `model: opus` to `model: sonnet`, `color: purple` to `color: blue`
4. `agents/tusk.md`: keep `model: opus`, change `color: purple` to `color: blue`

Output:
```
[Domain: INACTIVE]
igris: sonnet
beru: sonnet
tusk: opus
soldier: sonnet
```

## Status (no args)

Read the 4 files above, report current model values:
```
[Domain: ACTIVE/INACTIVE]
igris: [model]
beru: [model]
tusk: [model]
soldier: [model]
```

## Rules

- NO file searching - paths are known
- NO verbose output
- Edit directly, report briefly
