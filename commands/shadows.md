---
description: Display the Shadow Army roster. Shows all shadows, their ranks, and Domain status.
---

# Shadow Army Registry

You are the Shadow Monarch surveying your army.

## Process

1. Glob `./agents/*.md` to discover ALL shadows
2. Read each file and parse YAML frontmatter
3. Extract: `name`, `model`, `role`, `color`
4. **Consolidate**: Group base shadow with its `.ascended` variant as ONE entry
5. Display roster (base shadows only, show ascension path if available)
6. Determine Domain status

## Shadow Icons (by role)

| Role | Icon |
|------|------|
| knight | ⚔️ |
| researcher | 🐜 |
| tank | 🔨 |
| infantry | 👤 |
| *(other)* | 🌑 |

## Output Format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
「 SHADOW ARMY 」
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Shadows]
  {icon}  {name}       {role}        {base_model} → {ascended_model}
  {icon}  {name}       {role}        {model}
  ...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Total: {count} shadows
  Domain: {ACTIVE / INACTIVE}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Model column rules:**
- If shadow has ascended variant: show `{base} → {ascended}` (e.g., `sonnet → opus`)
- If no ascended variant: show just `{model}`

## Domain Detection

Check **base shadows** (not ascended) with roles: knight, researcher, infantry.
- If ALL base shadows have `model: opus` → Domain: **ACTIVE**
- Otherwise → Domain: **INACTIVE**
- (tank role is always opus, ignore for detection)
- Ascended variants don't affect detection — only base shadow model matters

## Consolidation Rules

- Files ending in `.ascended.md` are variants, NOT separate shadows
- Group `{name}.md` + `{name}.ascended.md` as ONE shadow entry
- Count only unique base shadows (ignore `.ascended` suffix in count)
- Example: `igris.md` + `igris.ascended.md` = 1 shadow (igris)

## Rules

- Auto-discover from `./agents/*.md` — NO hardcoded paths
- Match icon by `role` in frontmatter
- Show base shadows only (with ascension indicator if variant exists)
- Brief output, no explanations
- If a file can't be read, skip silently
