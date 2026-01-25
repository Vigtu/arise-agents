---
description: Display hunter status window. Fast - single file read only.
---

# STATUS

## Execute

Read `.claude/shadow-level.json` — **NO other files**.

Display:

```
╔══════════════════════════════════════════╗
║          S T A T U S   W I N D O W       ║
╠══════════════════════════════════════════╣
║  Level: {level}                          ║
║  Rank:  {rank}                           ║
║  Title: {title}                          ║
╠──────────────────────────────────────────╣
║  XP: {xp}                                ║
║  Commits: {commits}                      ║
║  PRs: {prs}                              ║
╚══════════════════════════════════════════╝
```

## Rules

- **ONE file only** — `.claude/shadow-level.json`
- No domain-state read
- No glob searches
- No protocol lookups
- Instant response
