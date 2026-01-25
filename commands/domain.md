---
description: Activate or deactivate Monarch's Domain. Empowers shadows (sonnet → opus). Args: on/off or empty for status.
---

# Monarch's Domain

## Parse Arguments

Detect intent from user's language:
- `on`, `activate`, `expand` → Activate
- `off`, `deactivate`, `collapse` → Deactivate
- Empty → Status

## Process

1. Glob `.claude/agents/*.md` to discover all shadows
2. Read each file and parse frontmatter for `role`, `model`, `color`
3. Apply transformation based on action

## Activate (on)

For each shadow in `.claude/agents/*.md`:

| Role | Model Change | Color Change |
|------|--------------|--------------|
| tank | *(keep opus)* | blue → purple |
| *(others)* | sonnet → opus | blue → purple |

Output:
```
「 DOMAIN EXPANSION 」

[Domain: ACTIVE]
  {name}: opus
  {name}: opus
  ...for each shadow
```

## Deactivate (off)

For each shadow in `.claude/agents/*.md`:

| Role | Model Change | Color Change |
|------|--------------|--------------|
| tank | *(keep opus)* | purple → blue |
| *(others)* | opus → sonnet | purple → blue |

Output:
```
[Domain: INACTIVE]
  {name}: sonnet
  {name}: sonnet
  {name}: opus    ← tank stays opus
  ...
```

## Status (no args)

Read all shadows, report current state:
```
[Domain: ACTIVE/INACTIVE]
  {name}: {model}
  {name}: {model}
  ...
```

Domain is ACTIVE if all non-tank shadows are `opus`.

## Rules

- Auto-discover from `.claude/agents/*.md`
- Tank role always stays `opus`
- Brief output
- Edit frontmatter directly (model + color fields)
