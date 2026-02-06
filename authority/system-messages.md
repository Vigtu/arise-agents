# System Messages

Standard system notification templates. Import with `@./authority/system-messages.md`.

**CRITICAL:** ALL system messages MUST use backticks for terminal highlighting.
- ✅ `[System: message]` — colored in terminal
- ❌ [System: message] — plain text, breaks formatting

## Equipment Messages

### Item Equipped (Plugin Not Installed)

`[System: {item} equipped to {shadow}]`

*the artifact's power remains sealed*

```diff
- [Warning: Required component missing]
- Plugin not installed: {plugin-name}
- Install: /plugin install {plugin-spec}
```

### Item Equipped (Plugin Installed)
```
`[System: {item} equipped to {shadow}]`
`[System: Artifact activated]`

Enhanced capabilities:
  - {capability_1}
  - {capability_2}
  - {capability_3}
```

### Item Unequipped
```
`[System: {shadow} unequipped {item}]`

*the artifact returns to inventory*
```

### Incompatible Equipment

*{shadow} reaches for {item}...*

```diff
- ═══════════════════════════════════
- 「 EQUIPMENT REJECTED 」
- ═══════════════════════════════════
- Shadow: {shadow}
- Item: {item}
- Cause: Specialization mismatch
- Compatible shadows: {list}
```

### Plugin Missing

```diff
- [Warning: {plugin} not installed]
- Required by: {item}
- Install: /plugin install {plugin-spec}
```

## General System

### Task Start
```
`[System: Quest accepted]`
`[System: Analyzing target...]`
```

### Task Complete
```
`[Quest Complete]`
```

### Error

```diff
- ═══════════════════════════════════
- 「 ERROR 」
- ═══════════════════════════════════
- {message}
```

### Validation Failed

```diff
- [Warning: Validation failed]
- {reason}
```

## Shadow Defeated

When a shadow agent fails its task (error, timeout, permission denied):

```diff
- ═══════════════════════════════════
- 「 SHADOW DEFEATED 」
- ═══════════════════════════════════
- Shadow: {name}
- Quest: {task description}
- Cause: {error or reason}
- "{in-character defeat quote}"
```

**In-character defeat quotes per shadow:**
- **Igris:** *"I have failed you, my liege... I shall accept any punishment."*
- **Beru:** *"Forgive me, my King... the prey escaped."*
- **Tusk:** *scratches head* *"...too strong."*
- **Soldier:** *"[soldier] status: defeated"*

## Quest Failed

When a quest/task cannot be completed:

```diff
- ═══════════════════════════════════
- 「 QUEST FAILED 」
- ═══════════════════════════════════
- Quest: {quest name}
- Rank: {difficulty}
- Cause: {reason}
- Shadows lost: {count}
```
