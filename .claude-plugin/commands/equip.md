---
description: Equip or unequip items to shadows. Items are plugins that enhance shadow capabilities.
---

# EQUIP

**System messages:**
@./authority/system-messages.md

**CRITICAL:** All system messages MUST use backticks for terminal highlighting.

## Usage

```bash
/arise:equip {shadow} {item}
/arise:unequip {shadow}
/arise:inventory
```

## Available Items

Read from `./items/` directory:
- `orb-of-avarice` (S-Rank) → code-review plugin
- `monarchs-mirror` (S-Rank) → elite multiplication
- `bestiary` (A-Rank) → knowledge artifact

**Items with plugins** require installation before use.

## Equip Flow

**1. Parse Arguments**
```
/arise:equip tusk orb-of-avarice
               ↓         ↓
            shadow    item
```

**2. Validate**
- Shadow exists in `./agents/`
- Item exists in `./items/`
- Item is eligible for shadow (check item's "Eligible" section)

If shadow is ineligible:
```
*{shadow} reaches for {item}...*

`[Warning: Specialization mismatch]`
`[System: Equipment rejected]`

See items/{item}.md for compatible shadows.
```

**3. Check Plugin**
If item has `plugin` field:
```bash
# Check if plugin installed
/plugin list | grep {plugin-name}
```

If not installed:
```
⚠️  {item} requires plugin: {plugin-name}

Install with:
  /plugin install {plugin-spec}

Equip canceled.
```

**4. Register Equipment**

Read `.claude/domain-state`, update equipment section:
```yaml
equipment:
  tusk: orb-of-avarice
  igris: null
  beru: null
```

Use Read → Edit pattern on `.claude/domain-state`.

**5. Announce**

Follow item's protocol (e.g., `.claude/authority/orb-protocol.md`):
```
「 {Item Name} 」
[System: Equipped to {shadow}]

*flavor text from item lore*

Enhanced capabilities:
  → capability 1
  → capability 2
```

## Unequip Flow

**1. Parse**
```bash
/arise:unequip tusk
```

**2. Update State**
Set `equipment.{shadow}: null` in `.claude/domain-state`.

**3. Announce**
```
`[System: {shadow} unequipped {item}]`

*the artifact returns to inventory*
```

## Inventory

Show all items and their status:

```
`「 Inventory 」`

S-RANK
  Monarch's Mirror    - Always active (elite multiplication)
  Orb of Avarice      - {equipped status} (complexity destruction)

A-RANK
  Bestiary            - Keeper: Igris (threat cataloging)

Equipment Status:
  Igris: {item or none}
  Beru:  {item or none}
  Tusk:  {item or none}
```

## Rules

- **Fast** — minimal file operations
- **Validate** — check eligibility before equipping
- **Persist** — always update `.claude/domain-state`
- **Announce** — use dramatic item protocol messages
