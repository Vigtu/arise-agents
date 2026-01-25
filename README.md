# arise-agents

Shadow army of specialized subagents for Claude Code, inspired by Solo Leveling.

> "ARISE!"

## Installation

### Option 1: Clone and load

```bash
git clone https://github.com/victorfernandesraton/arise-agents.git
cd your-project
claude --plugin-dir /path/to/arise-agents
```

### Option 2: Add to settings

Add to your `.claude/settings.json`:

```json
{
  "plugins": ["/path/to/arise-agents"]
}
```

### Option 3: Development mode

```bash
cd arise-agents
claude --plugin-dir .
```

### Activate output style

```
/output-style arise-agents:shadow-monarch
```

## Shadows

| Shadow | Role | Specialty |
|--------|------|-----------|
| **Igris** | Knight Commander | Code review, quality enforcement |
| **Beru** | Ant King | Aggressive research, deep exploration |
| **Tusk** | High Orc Tank | Heavy lifting, large refactors |
| **Soldiers** | Infantry | Parallel reconnaissance |

## Usage

### Summon shadows

```
ARISE review my auth code        → Igris reviews
ARISE explore the payment system → Beru investigates
ARISE refactor the user module   → Tusk transforms
```

### Multiply elites

```
3 beru para explorar auth, cache e logging
igris x5 review all modules
```

### Deploy army

```
5 soldiers to analyze the codebase
```

## Commands

| Command | Description |
|---------|-------------|
| `/arise` | Summon shadows based on natural language |
| `/shadows` | Display shadow army roster |
| `/domain` | Toggle Monarch's Domain (opus mode) |
| `/extract` | Create new shadow from patterns |

## Adding new shadows

Create `.claude/agents/shadow-name.md`:

```yaml
---
name: shadow-name
description: When to use this shadow
tools: Read, Grep, Glob
model: sonnet
role: knight | researcher | tank | infantry
---

System prompt here...
```

## License

MIT
