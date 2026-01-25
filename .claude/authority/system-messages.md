# System Messages

Standard system notification templates. Import with `@.claude/authority/system-messages.md`.

**CRITICAL:** ALL system messages MUST use backticks for terminal highlighting.
- ✅ `[System: message]` — colored in terminal
- ❌ [System: message] — plain text, breaks formatting

## Equipment Messages

### Item Equipped (Plugin Not Installed)
```
`[System: {item} equipped to {shadow}]`

*the artifact's power remains sealed*

`[Warning: Required component missing]`
Install: `/plugin install {plugin-spec}`
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
```
*{shadow} reaches for {item}...*

`[Warning: Specialization mismatch]`
`[System: Equipment rejected]`

Compatible shadows: {list}
```

### Plugin Missing
```
`[Warning: {plugin} not installed]`
Install: `/plugin install {plugin-spec}`
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
```
`[Error: {message}]`
```

### Validation Failed
```
`[Warning: Validation failed]`
{reason}
```
