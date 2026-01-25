# Bestiary

> *"Know thy enemy. A Monarch who understands the darkness commands it."*

**Rank:** A (Legendary Grimoire)
**Type:** Knowledge Artifact
**Keeper:** Igris (Knight Commander)
**Effect:** Catalog threats to prevent regression. The army learns from every battle.

---

## Usage Protocol

### When to Invoke

- After defeating a significant bug
- When discovering a new anti-pattern
- After a regression occurs (shame must not repeat)
- When a shadow encounters an unknown threat

### Invocation

```
[System: Bestiary invoked]
[System: Keeper: Igris]
[System: Recording threat...]
```

*Igris unsheathes his blade, carving knowledge into the grimoire*

---

## Entry Format

Each threat recorded in `grimoires/` follows this structure:

```markdown
# [Threat Name]

**Rank:** E / D / C / B / A / S
**Category:** Void Devourer / Syntax Demon / Logic Wraith / Dependency Parasite / Performance Vampire / Security Specter / Git Ghost
**Habitat:** Where it lurks (files, patterns, contexts)
**Signs:** How to detect its presence
**Weakness:** How to defeat it
**Drops:** Knowledge gained from victory
**Shadow:** Recommended hunter

---

**Encountered:** [date]
**Battle:** [task/PR that spawned this entry]
```

---

## Threat Categories

| Category | Description | Typical Rank |
|----------|-------------|--------------|
| **Void Devourer** | Drains context/mana unnecessarily | B-A |
| **Syntax Demon** | Parse errors, typos | E-D |
| **Logic Wraith** | Code runs but wrong | C-A |
| **Dependency Parasite** | Package/import issues | D-B |
| **Performance Vampire** | Slow drains over time | B-A |
| **Security Specter** | Vulnerabilities | A-S |
| **Git Ghost** | VCS haunts | D-A |

---

## Writing Location

All entries written to: `grimoires/`

Naming convention: `[category]-[threat-name].md`

Examples:
- `grimoires/void-devourer-endless-reader.md`
- `grimoires/security-specter-injection-wraith.md`

---

## Limitations

- **Keeper only:** Only Igris may write entries (or Monarch override)
- **Battle-earned:** Entries come from real encounters, not theory
- **Living document:** Grows with the army's experience

---

*"A shadow that learns from battle becomes invincible."*
