# arise-agents

Shadow army of specialized subagents for Claude Code, inspired by Solo Leveling.

> "ARISE!"

## Installation

### From GitHub (recommended)

```bash
claude plugin add victorfernandesraton/arise-agents
```

### Local development

```bash
claude --plugin-dir ./arise-agents
```

## Shadows

| Shadow | Role | Specialty |
|--------|------|-----------|
| **Igris** | Knight Commander | Code review, quality enforcement |
| **Beru** | Ant King | Aggressive research, deep exploration |
| **Tusk** | High Orc Tank | Heavy lifting, large refactors |

## Usage

Claude automatically delegates to shadows based on task context. You can also request explicitly:

```
Use igris to review my authentication changes
Have beru explore how the payment system works
Ask tusk to refactor the legacy module
```

## Adding new shadows

Create a markdown file in `agents/` with YAML frontmatter:

```markdown
---
name: shadow-name
description: When Claude should use this shadow
tools: Read, Grep, Glob
model: sonnet
---

System prompt here...
```

## License

MIT
