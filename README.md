# arise-agents

**Claude Code plugin for multi-agent orchestration inspired by Solo Leveling**

Transform Claude into a Shadow Monarch commanding specialized AI agents for parallel development tasks.

> "ARISE!"

## What is this?

Instead of one monolithic assistant, summon **focused shadow agents** for different coding tasks:
- **Igris** reviews code quality
- **Beru** explores complex systems
- **Tusk** handles heavy refactors
- **Soldiers** run parallel reconnaissance

Deploy multiple shadows simultaneously, each optimized for their role. Solo Leveling meets agentic workflows.

## Key Features

- **Shadow multiplication**: `3 beru` or `igris x5` for parallel task execution
- **Monarch's Domain**: Toggle `/domain` to upgrade shadows from Sonnet → Opus
- **Shadow extraction**: `/extract` creates custom agents from your git history patterns
- **Natural language**: Just say what you need - the system routes to the right shadow
- **Thematic output**: Solo Leveling-style notifications `「 System 」`
- **XP System**: Earn XP from commits (+50) and PRs (+200), level up your hunter rank

## XP Statusline (Optional)

Track your progress with a custom statusline showing XP, level, and rank:

```
「Lv.8」C-Rank ██████░░░░ 900/1,500 XP │ 15 commits │ 2 PRs
```

**Quick setup:**

```bash
npx arise-agents
```

This configures the statusline automatically. Restart Claude Code to see it.

## Installation

### Option 1: Clone and load

```bash
git clone https://github.com/Vigtu/arise-agents.git
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
