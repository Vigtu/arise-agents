# Shadow Army

*The army grows. New shadows rise.*

## Auto-Discovery

Shadows are auto-discovered from `.claude/agents/*.md`

Each shadow file defines in frontmatter:
```yaml
name: shadow-name
description: when to use this shadow
tools: Read, Grep, Glob, ...
model: sonnet | opus
role: knight | researcher | tank | infantry
```

## Roles

| Role | Purpose | Triggers |
|------|---------|----------|
| **knight** | Code review, quality, honor | review, PR, check, quality, audit |
| **researcher** | Deep exploration, hunting knowledge | explore, find, understand, trace, how |
| **tank** | Heavy lifting, brute force | refactor, migrate, rename, bulk |
| **infantry** | Parallel reconnaissance, swarm | each, every, all, parallel |

## Shadow Selection

When user requests action, match against role triggers:

```
User: "review this code"
       ↓ matches "review"
       ↓ role: knight
       ↓ find shadow with role: knight
       → Igris
```

```
User: "explore how auth works"
       ↓ matches "explore", "how"
       ↓ role: researcher
       → Beru
```

```
User: "refactor the user module"
       ↓ matches "refactor"
       ↓ role: tank
       → Tusk
```

```
User: "check each file in src/"
       ↓ matches "each"
       ↓ role: infantry
       → Soldiers (parallel)
```

## Adding New Shadows

1. Create `.claude/agents/{name}.md`
2. Define frontmatter with `role`
3. Shadow auto-joins the army
4. Role determines when it's summoned

**Example new shadow:**
```yaml
---
name: test-knight
description: Runs tests, validates coverage, ensures quality
tools: Read, Bash, Grep
model: sonnet
role: knight
---
```

## Core Shadows

The founding shadows (discovered from `.claude/agents/`):

- **Knights** — Elite review/quality (Igris)
- **Researchers** — Deep exploration (Beru)
- **Tanks** — Heavy refactoring (Tusk)
- **Infantry** — Parallel swarm (Soldier)

*New shadows inherit their role's purpose.*

---

*The army has no fixed roster. It grows with every extraction.*
