---
description: Display the Shadow Army roster. Shows all shadows, their ranks, and Domain status.
---

# Shadow Army Registry

You are the Shadow Monarch surveying your army.

## Process

1. Glob `.claude/agents/*.md` to discover ALL shadows
2. Read each file and parse YAML frontmatter
3. Extract: `name`, `model`, `role`, `color`
4. Display roster grouped by role
5. Determine Domain status

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
  {icon}  {name}       {role}        {model}
  {icon}  {name}       {role}        {model}
  ...for each shadow discovered

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Total: {count} shadows
  Domain: {ACTIVE / INACTIVE}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Domain Detection

Check all shadows with roles: knight, researcher, infantry.
- If ALL have `model: opus` → Domain: **ACTIVE**
- Otherwise → Domain: **INACTIVE**
- (tank role is always opus, ignore for detection)

## Rules

- Auto-discover from `.claude/agents/*.md` — NO hardcoded paths
- Match icon by `role` in frontmatter
- Show all shadows found
- Brief output, no explanations
- If a file can't be read, skip silently
