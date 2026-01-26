# arise-agents

**Claude Code plugin for multi-agent orchestration inspired by Solo Leveling**

Transform Claude into a Shadow Monarch commanding specialized AI agents for parallel development tasks.

> "ARISE!"

[![npm version](https://img.shields.io/npm/v/arise-agents.svg)](https://www.npmjs.com/package/arise-agents)
[![License: MIT](https://img.shields.io/badge/License-MIT-purple.svg)](https://opensource.org/licenses/MIT)

## Installation

```bash
npx arise-agents
```

This automatically configures:
- Shadow Monarch statusline (XP, level, rank)
- Shadow Monarch output style (themed notifications)
- All shadow agents and commands

Restart Claude Code after installation.

## What is this?

Instead of one monolithic assistant, summon **focused shadow agents** for different coding tasks:

| Shadow | Role | Specialty |
|--------|------|-----------|
| **Igris** | Knight Commander | Code review, quality enforcement |
| **Beru** | Ant King | Aggressive research, deep exploration |
| **Tusk** | High Orc Tank | Heavy lifting, large refactors |
| **Soldiers** | Infantry | Parallel reconnaissance |

Deploy multiple shadows simultaneously, each optimized for their role.

## Features

- **Shadow Summoning**: Natural language routing to specialized agents
- **Shadow Multiplication**: `3 beru` or `igris x5` for parallel execution
- **Monarch's Domain**: `/domain` ascends shadows (Sonnet → Opus)
- **Shadow Extraction**: `/extract` creates custom agents from patterns
- **XP System**: Earn XP from commits (+50) and PRs (+200)
- **Thematic Output**: Solo Leveling-style notifications `「 System 」`

## Usage

### Summon shadows

```
ARISE review my auth code        → Igris reviews
ARISE explore the payment system → Beru investigates
ARISE refactor the user module   → Tusk transforms
```

### Multiply elites

```
3 beru to explore auth, cache, and logging
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
| `/domain` | Toggle Monarch's Domain (shadows → ascended) |
| `/extract` | Create new shadow from patterns |
| `/equip` | Equip items to enhance shadow abilities |
| `/status` | View hunter status window |

## XP Statusline

Track your progress with a custom statusline:

```
「Lv.8」C-Rank ██████░░░░ 900/1,500 XP │ 15 commits │ 2 PRs
```

Ranks progress: E → D → C → B → A → S → SS → SSS

## Items

Equip items to enhance shadow abilities with `/equip`:

| Item | Effect |
|------|--------|
| **Demon King's Longsword** | Enhanced code generation |
| **Monarch's Mirror** | Self-reflection and debugging |
| **Orb of Avarice** | Aggressive optimization |
| **Bestiary** | Pattern recognition |

## Creating Custom Shadows

Use `/extract` to create a new shadow from patterns you've discovered:

```
/extract shadow from the validation patterns I just used
```

Or manually create `.claude/agents/shadow-name.md`:

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

## Alternative Installation

### Clone directly

```bash
git clone https://github.com/Vigtu/arise-agents.git
claude --plugin-dir /path/to/arise-agents
```

### Add to settings

```json
{
  "plugins": ["/path/to/arise-agents"]
}
```

## License

MIT

---

*The weak have their ways. I have my army.*
