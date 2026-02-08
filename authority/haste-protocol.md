# Haste Protocol — Accelerated Temporal Field

Activation and deactivation protocol for the Haste Potion.

---

## Activation

When the Monarch consumes the Haste Potion:

**1. Enable Fast Mode via Settings**

Read `~/.claude/settings.json`, then Edit to add/set `"fastMode": true`. Preserve all existing settings.

**2. Update Domain State**

Update `.claude/domain-state` — set `haste: on`:
```yaml
haste: on
```

**3. Announce**

```
「 Temporal Acceleration 」

[System: Haste Potion consumed]

*time slows around the shadows*

Output speed: 2.5x
Mana drain: 6x standard cost
Persists until deactivated. Use /haste again to cancel.
```

---

## Deactivation

When the Monarch dispels the temporal field:

**1. Disable Fast Mode via Settings**

Read `~/.claude/settings.json`, then Edit to set `"fastMode": false`. Preserve all existing settings.

**2. Update Domain State**

Update `.claude/domain-state` — set `haste: off`:
```yaml
haste: off
```

**3. Announce**

```
[System: Temporal field dissipated]

*the shadows return to normal speed*

Mana drain normalized.
```

---

## Status Check

When the Monarch checks haste state (no args):

1. Read `.claude/domain-state` for `haste` field
2. Read `~/.claude/settings.json` for `fastMode` field

```
[Haste: ACTIVE/INACTIVE]
  Speed: {2.5x / standard}
  Mana drain: {6x / normal}
```

---

## Rules

- **Brief** — minimal output, no walls of text
- **Persist** — always update both `.claude/domain-state` AND `~/.claude/settings.json`
- **Direct** — edit settings file directly, don't ask the user to run `/fast`
- **Shadow Tongue** — system notifications in English, Monarch's voice in user's language
