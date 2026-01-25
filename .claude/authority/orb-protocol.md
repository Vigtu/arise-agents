# Orb Protocol

When equipping **Orb of Avarice**:

**System message templates:**
@.claude/authority/system-messages.md

**CRITICAL:** All system messages MUST use backticks for terminal highlighting.

## 1. Eligibility

**Eligible:** Tusk only (exclusive)
**Ineligible:** All others

If ineligible:
```
*{shadow} reaches for the orb...*

`[Warning: Orb rejects the connection]`
`[System: Equipment rejected]`

The Orb of Avarice is bound to Tusk - only the high orc's raw destructive power can channel its magic.
```

## 2. Plugin Check

Check if `code-simplifier` installed:
```bash
claude plugin list | grep code-simplifier
```

## 3. Register Equipment

Update `.claude/domain-state`:
```yaml
equipment:
  {shadow}: orb-of-avarice
```

## 4. Announce

**Plugin NOT installed:**
```
`[System: orb-of-avarice equipped to tusk]`

*the orb's power remains sealed*

`[Warning: code-simplifier plugin required]`
Install: `/plugin install code-simplifier@claude-plugins-official`
```

**Plugin installed:**
```
`[System: orb-of-avarice equipped to tusk]`
`[System: Artifact activated]`

*Desire for Destruction awakens*

Enhanced capabilities:
  - Code simplification
  - Complexity destruction
  - Redundancy elimination
```

## 5. Usage

When invoking Tusk with orb equipped, inject context:
```markdown
Equipped: Orb of Avarice
- Use code-simplifier plugin for refactoring
- Improve clarity and readability
- Reduce complexity and nesting
- Eliminate redundant code
- Preserve functionality while destroying complexity
```

## 6. Unequip

Set `equipment.{shadow}: null` in `.claude/domain-state`.

Message:
```
`[System: {shadow} unequipped orb-of-avarice]`

*the artifact returns to inventory*
```
