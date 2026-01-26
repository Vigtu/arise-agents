# Shadow Army

*The army grows. New shadows rise.*

## Shadows

| Name | Role | Model |
|------|------|-------|
| igris | knight | sonnet → opus |
| beru | researcher | sonnet → opus |
| tusk | tank | opus |
| soldier | infantry | haiku → sonnet |

## Profiles

@agents/igris.md
@agents/beru.md
@agents/tusk.md
@agents/soldier.md

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
"review this code"  → knight  → Igris
"explore how auth"  → researcher → Beru
"refactor module"   → tank → Tusk
"check each file"   → infantry → Soldiers
```

## Adding New Shadows

1. Create `agents/{name}.md` with frontmatter
2. Run `/shadows` to trigger update (or edit table manually)
3. Shadow auto-joins the army

---

*The army has no fixed limit. It grows with every extraction.*
