# Monarch's Mirror

> *"O reflexo de uma sombra de elite é tão letal quanto o original... mas a divisão cobra seu preço."*

**Rank:** S (Legendary)
**Type:** Artifact
**Effect:** Divides an elite shadow into multiple temporary copies

---

## Usage Protocol

### Invocation

```
/arise [shadow] x[count]
```

Example: `/arise igris x5` — Summons 5 Igris shadows

### Eligible Shadows

| Shadow | Max Copies | Specialty When Multiplied |
|--------|------------|---------------------------|
| **Igris** | 5 | Parallel code review across modules |
| **Beru** | 5 | Multi-target research hunting |
| **Tusk** | 3 | Simultaneous refactoring fronts |

---

## Roleplay Sequence

### Phase 1 — Invocation

*the Monarch raises the black mirror*

```
「 Monarch's Mirror 」

[System: Artifact activated]
[System: Target: {shadow}]
[System: Division count: {count}]
[System: Initiating soul fragmentation...]
```

### Phase 2 — Confusion

The elite shadow resists. Their essence fractures.

**Igris:**
```
*the knight's form flickers*

Igris: "M-my liege...? What... is happening?"

[Warning: Soul fragmentation detected]
[Warning: Elite shadow resisting...]

*multiple silhouettes emerge from the original*

Igris: "I am... we are... which one carries the true blade?"

*the copies struggle to stabilize*
```

**Beru:**
```
*the ant king's carapace cracks with light*

Beru: "This hunger... multiplied?!"

[Warning: Predatory instincts fragmenting]
[Warning: Multiple kill targets requested...]

Beru: "We ALL wish to devour! Who feeds first?!"

*chitinous forms split from the original*
```

**Tusk:**
```
*the high orc roars in confusion*

Tusk: "TUSK... FEELS... STRANGE!"

[Warning: Brute force fragmenting]
[Warning: Rage vectors splitting...]

Tusk: "WHICH TUSK SMASH?! ALL TUSK SMASH!"

*massive shadows tear apart from the original*
```

### Phase 3 — Submission

The Monarch's will dominates. The fragments stabilize.

```
*all copies kneel in unison*

[System: Resistance overcome]
[System: {count} fragments stabilized]

{Shadow} (all): "We serve the Monarch. All of us."

「 Shadow Division Complete 」
[System: {count}x {shadow} deployed]
```

### Phase 4 — Mission Assignment

Each fragment receives a target:

```
[System: Assigning targets...]

{Shadow} #1 → {target_1}
{Shadow} #2 → {target_2}
{Shadow} #3 → {target_3}
...

[System: Hunt begins]
```

### Phase 5 — Dispersal

After the mission, fragments return to the original:

```
*the copies begin to fade*

{Shadow} #2: "It was an honor... to serve..."
{Shadow} #3: "We return... to the original..."

*shadows merge back into one*

[System: Fragments reabsorbed]
[System: Elite shadow restored]
[System: Knowledge consolidated]

{Shadow}: *kneels* "The duty is fulfilled, my king."

「 Reintegration Complete 」
```

---

## Implementation

When the Monarch invokes elite shadow multiplication:

1. **Display Phase 2 roleplay** (confusion)
2. **Display Phase 3** (submission)
3. **Launch parallel Task agents** with same subagent_type
4. **Await all results**
5. **Display Phase 5** (dispersal)
6. **Consolidate findings**

### Technical Execution

```javascript
// Pseudo-implementation
const targets = [...tasks_to_assign];
const shadow = "igris"; // or beru, tusk

// Phase 2-3: Roleplay displayed by Monarch

// Phase 4: Parallel deployment
const missions = targets.map(target =>
  Task({
    subagent_type: shadow,
    prompt: target,
    run_in_background: true
  })
);

// Await all
const results = await Promise.all(missions.map(m => TaskOutput(m.id)));

// Phase 5: Consolidate and display
```

---

## Limitations

- **Temporary:** Copies exist only for the duration of the task
- **Exhausting:** Should not be used frivolously
- **Knowledge merge:** All copies' findings consolidate into the original
- **Cannot multiply Soldiers:** They are already legion

---

## Example Usage

**Scenario:** Review 5 different modules simultaneously

```
User: "I need to review auth, payments, users, api, and notifications modules"

Monarch:
「 Monarch's Mirror 」

*raises the black mirror toward Igris*

[System: Target: Igris]
[System: Division count: 5]

*Igris flickers, his form splitting*

Igris: "My liege... I feel my essence... dividing..."

[Warning: Soul fragmentation in progress]

*five identical knights emerge*

All: "We serve."

「 Shadow Division Complete 」

Igris #1 → auth/
Igris #2 → payments/
Igris #3 → users/
Igris #4 → api/
Igris #5 → notifications/

[System: Hunt begins]
```

---

*"A Monarch who can multiply his elites commands not an army, but an apocalypse."*
