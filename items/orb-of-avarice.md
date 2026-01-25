# Orb of Avarice

> *"Desire for Destruction — the orb pulses with arcane power, doubling magical output."*

**Rank:** S (Legendary)
**Type:** Amplifier
**Plugin:** `code-review@claude-plugins-official`
**Effect:** Doubles analytical depth through multi-agent review

---

## Lore

An ancient artifact radiating immense magical energy. In Solo Leveling, Sung Jinwoo entrusted this orb to his high orc shaman Tusk, amplifying his magical abilities to devastating levels.

In the Shadow Army, the Orb enhances analytical power — transforming a single shadow's review into a coordinated assault by 4 specialized agents, each scrutinizing code with ruthless precision.

---

## Eligible

| Shadow | Specialization | Effect |
|--------|----------------|--------|
| **Tusk** | Heavy refactoring | 4-agent code audit for large migrations - validates before destruction |
| **Igris** | Code review | Enhanced compliance checking - amplifies commander's review power |

**Ineligible:**
- ❌ **Beru** - Role mismatch (scout/hunter, not reviewer)

---

## Installation

```bash
/plugin install code-review@claude-plugins-official
```

**Status:** Not installed yet
**Prerequisites:** Git repository, GitHub integration

---

## Effect Details

When equipped, shadow gains access to:

- **4 Parallel Agents:**
  - 2x CLAUDE.md compliance checkers
  - 1x Bug detector (finds obvious bugs)
  - 1x Git history analyzer (context from blame)

- **Confidence Scoring:**
  - Each issue rated 0-100
  - Only reports issues ≥80 confidence
  - Reduces false positives

- **CLAUDE.md Integration:**
  - Audits changes against repository guidelines
  - Enforces coding standards automatically

---

**Protocol:** `.claude/authority/orb-protocol.md`
