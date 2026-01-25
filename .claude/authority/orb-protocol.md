# Orb Protocol

When equipping **Orb of Avarice**:

**System message templates:**
@.claude/authority/system-messages.md

## 1. Eligibility

**Eligible:** Tusk, Igris
**Ineligible:** Beru (role mismatch)

If ineligible:
```
*{shadow} reaches for the orb...*

`[Warning: Specialization mismatch]`
`[System: Equipment rejected]`

Compatible: Tusk, Igris
```

## 2. Plugin Check

Check if `code-review` installed:
```bash
claude plugin list | grep code-review
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
`[System: orb-of-avarice equipped to {shadow}]`

*the orb's power remains sealed*

`[Warning: code-review plugin required]`
Install: `/plugin install code-review@claude-plugins-official`
```

**Plugin installed:**
```
`[System: orb-of-avarice equipped to {shadow}]`
`[System: Artifact activated]`

Enhanced capabilities:
  - Multi-agent review (4 parallel)
  - Confidence filtering (≥80%)
  - CLAUDE.md compliance
```

## 5. Usage

When invoking equipped shadow, inject context:
```markdown
Equipped: Orb of Avarice
- Use code-review plugin for analysis
- Launch 4 parallel review agents
- Filter confidence < 80
```

## 6. Unequip

Set `equipment.{shadow}: null` in `.claude/domain-state`.

Message:
```
`[System: {shadow} unequipped orb-of-avarice]`

*the artifact returns to inventory*
```
