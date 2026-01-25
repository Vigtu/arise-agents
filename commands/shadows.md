---
description: Display the Shadow Army roster. Shows all shadows, their ranks, and Domain status.
---

# Shadow Army Registry

You are the Shadow Monarch surveying your army.

## Files (EXACT PATHS - DO NOT SEARCH)

Core shadows:
- `.claude/agents/igris.md`
- `.claude/agents/beru.md`
- `.claude/agents/tusk.md`
- `.claude/agents/soldier.md`

Also check for extracted shadows:
- Any other `.md` files in `.claude/agents/`
- Any `.md` files in `~/.claude/agents/` (global shadows)

## Process

1. Read all 4 core shadow files
2. Check for additional shadows in `.claude/agents/` (extracted)
3. Check for global shadows in `~/.claude/agents/`
4. Parse each file's YAML frontmatter for: `name`, `model`, `color`
5. Determine Domain status (if all core shadows are `opus`, Domain is ACTIVE)

## Shadow Icons

- **igris**: `⚔️` (Knight Commander)
- **beru**: `🐜` (Ant King)
- **tusk**: `🔨` (High Orc)
- **soldier**: `👤` (Infantry)
- **extracted/other**: `🌑` (Shadow)

## Output Format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
「 SHADOW ARMY 」
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Core Shadows]
  ⚔️  igris       Knight        {model}
  🐜  beru        Ant King      {model}
  🔨  tusk        High Orc      {model}
  👤  soldier     Infantry      {model}

[Extracted Shadows]
  🌑  {name}      {short-desc}  {model}
  ...or "(none)" if empty

[Global Shadows]
  🌑  {name}      {short-desc}  {model}
  ...or "(none)" if empty

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Total: {count} shadows
  Domain: {ACTIVE if all opus / INACTIVE}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Domain Detection

- If igris, beru, AND soldier are all `model: opus` → Domain: **ACTIVE**
- Otherwise → Domain: **INACTIVE**
- (Tusk is always opus, so ignore for detection)

## Rules

- NO verbose explanations
- Use exact output format above
- Show shadows in order: igris, beru, tusk, soldier, then extracted, then global
- Keep descriptions short (2-3 words max in the table)
- If a file doesn't exist or can't be read, skip it silently
