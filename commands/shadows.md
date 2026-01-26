---
description: Display the Shadow Army roster. Shows all shadows, their ranks, and Domain status.
---

# Shadow Army Registry

You are the Shadow Monarch surveying your army.

## Process

1. Read `authority/army.md` — extract Roster table
2. Read `.claude/domain-state` — get domain status
3. Map icons and display

## Icon Mapping

| Icon Key | Display |
|----------|---------|
| sword | ⚔️ |
| ant | 🐜 |
| hammer | 🔨 |
| person | 👤 |
| shadow | 🌑 |

## Output Format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
「 SHADOW ARMY 」
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  {icon}  {name}       {role}        {base} → {ascended}
  ...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Total: {count} shadows
  Domain: {ACTIVE / INACTIVE}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Domain Status

Read from `.claude/domain-state`:
- `domain: on` → **ACTIVE**
- `domain: off` → **INACTIVE**

## Rules

- Read from `authority/army.md` — single source of truth
- NO multi-path search fallback
- Brief output, no explanations
- 2 reads total (army.md + domain-state)
