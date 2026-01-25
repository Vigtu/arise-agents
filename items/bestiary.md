# Bestiary of the Shadow Monarch

> *"Know thy enemy. A Monarch who understands the darkness commands it."*

This grimoire catalogs threats encountered in battle. **Igris** maintains this tome — after each significant battle, new threats must be recorded to prevent regression.

---

## Curator Protocol

**Responsibility:** Igris (Knight Commander)

**When to Register:**
- After defeating a significant bug
- When discovering a new anti-pattern
- After a regression occurs (prevent future shame)
- When a shadow encounters an unknown threat

**Entry Format:**
```markdown
### [Threat Name]
**Rank:** E / D / C / B / A / S
**Habitat:** Where it lurks (files, patterns, contexts)
**Signs:** How to detect its presence
**Weakness:** How to defeat it
**Drops:** Knowledge gained from victory
**Shadow:** Recommended hunter
```

---

# Void Devourers

> *Creatures that consume shadow energy unnecessarily. They bloat context and drain mana.*

### The Endless Reader

**Rank:** B
**Habitat:** Large files, entire codebases read at once
**Signs:** Reading files without line limits; `cat` entire files into context
**Weakness:** Use `Read` with `offset` and `limit`; read only what is needed
**Drops:** Preserved mana for longer battles
**Shadow:** Beru (surgical reconnaissance)

---

### Context Hydra

**Rank:** A
**Habitat:** Repeated searches, redundant file reads
**Signs:** Same file read multiple times; grep results re-grepped
**Weakness:** Cache findings mentally; reference previous results
**Drops:** Clean, focused context
**Shadow:** Monarch (strategic planning)

---

### The Rambling Specter

**Rank:** C
**Habitat:** Verbose explanations, unnecessary prose
**Signs:** Long paragraphs where bullets suffice; over-explanation
**Weakness:** Be brief. Be direct. Shadows don't ramble.
**Drops:** Cleaner communication
**Shadow:** All shadows must resist this demon

---

### Parallel Phantom

**Rank:** B
**Habitat:** Sequential operations that could run in parallel
**Signs:** Waiting for one search before starting another independent one
**Weakness:** Launch independent operations simultaneously
**Drops:** Faster reconnaissance, preserved time
**Shadow:** Soldiers (parallel execution)

---

# Syntax Demons

> *Basic creatures. Weak but numerous. Often the first encountered.*

### The Missing Semicolon

**Rank:** E
**Habitat:** JavaScript, TypeScript, C-family languages
**Signs:** Unexpected token errors; parser failures
**Weakness:** Linters, formatters, careful eye
**Drops:** Attention to detail
**Shadow:** Any soldier

---

### Bracket Wraith

**Rank:** E
**Habitat:** Nested code, callbacks, object literals
**Signs:** Unexpected end of input; mismatched delimiters
**Weakness:** IDE matching, proper indentation
**Drops:** Code structure awareness
**Shadow:** Any soldier

---

### Import Shade

**Rank:** D
**Habitat:** Module systems, package boundaries
**Signs:** "Cannot find module"; circular dependency warnings
**Weakness:** Check paths, verify exports, break cycles
**Drops:** Module architecture understanding
**Shadow:** Beru (trace the dependencies)

---

# Logic Wraiths

> *Insidious creatures. Code runs but does the wrong thing.*

### Off-By-One Specter

**Rank:** C
**Habitat:** Loops, array access, pagination
**Signs:** Missing first/last element; infinite loops; boundary errors
**Weakness:** Careful boundary analysis; test edge cases
**Drops:** Precision in iteration
**Shadow:** Igris (meticulous review)

---

### Null Phantom

**Rank:** B
**Habitat:** Optional values, API responses, database queries
**Signs:** "Cannot read property of undefined"; silent failures
**Weakness:** Null checks, optional chaining, proper typing
**Drops:** Defensive coding instincts
**Shadow:** Igris

---

### Race Condition Demon

**Rank:** A
**Habitat:** Async code, shared state, concurrent operations
**Signs:** Intermittent failures; "works on my machine"
**Weakness:** Proper synchronization; immutable state; careful async handling
**Drops:** Concurrency mastery
**Shadow:** Igris + Beru (trace the flow)

---

### Silent Swallower

**Rank:** B
**Habitat:** Empty catch blocks, ignored promises, unchecked errors
**Signs:** Operations fail silently; state becomes inconsistent
**Weakness:** Always handle errors; log or rethrow
**Drops:** Error handling discipline
**Shadow:** Igris

---

# Dependency Parasites

> *External threats. They attach to your codebase and multiply.*

### Version Vampire

**Rank:** C
**Habitat:** package.json, requirements.txt, go.mod
**Signs:** "Peer dependency conflict"; breaking changes after update
**Weakness:** Lock files; careful upgrades; read changelogs
**Drops:** Dependency management wisdom
**Shadow:** Beru (research the package)

---

### Phantom Dependency

**Rank:** D
**Habitat:** Transitive dependencies, hoisted packages
**Signs:** Works locally, fails in CI; "module not found" after clean install
**Weakness:** Explicit dependencies; check what you import
**Drops:** Understanding of dependency trees
**Shadow:** Beru

---

### Abandonware Lich

**Rank:** B
**Habitat:** Old packages, unmaintained repos
**Signs:** Years since last update; open security advisories
**Weakness:** Find alternatives; fork if necessary; evaluate before adopting
**Drops:** Caution with external code
**Shadow:** Beru (research activity)

---

# Performance Vampires

> *They drain life slowly. The codebase weakens over time.*

### N+1 Query Beast

**Rank:** A
**Habitat:** ORMs, data fetching loops, GraphQL resolvers
**Signs:** Slow pages; database CPU spikes; linear query growth
**Weakness:** Eager loading; batch queries; DataLoader pattern
**Drops:** Database efficiency mastery
**Shadow:** Beru (trace the queries) + Tusk (refactor)

---

### Memory Leech

**Rank:** A
**Habitat:** Event listeners, closures, caches without limits
**Signs:** Growing memory usage; eventual OOM; slow degradation
**Weakness:** Cleanup on unmount; weak references; bounded caches
**Drops:** Memory management awareness
**Shadow:** Beru (find the leak) + Tusk (fix it)

---

### Render Hydra

**Rank:** B
**Habitat:** React components, UI frameworks
**Signs:** Unnecessary re-renders; sluggish UI; wasted cycles
**Weakness:** Memoization; proper keys; state colocation
**Drops:** Render optimization skills
**Shadow:** Igris (review) + Tusk (refactor)

---

# Security Specters

> *The most dangerous. They invite enemies into your domain.*

### Injection Wraith

**Rank:** S
**Habitat:** SQL queries, shell commands, template rendering
**Signs:** String concatenation with user input
**Weakness:** Parameterized queries; input sanitization; never trust input
**Drops:** Security-first mindset
**Shadow:** Igris (MUST catch these)

---

### Secret Exposure Phantom

**Rank:** S
**Habitat:** Config files, logs, error messages, git history
**Signs:** API keys in code; credentials in logs; .env committed
**Weakness:** Environment variables; secret managers; gitignore
**Drops:** Secret hygiene
**Shadow:** Igris (CRITICAL review item)

---

### Auth Bypass Ghost

**Rank:** S
**Habitat:** Authentication flows, authorization checks
**Signs:** Missing auth middleware; client-side only checks
**Weakness:** Server-side validation; defense in depth
**Drops:** Auth architecture understanding
**Shadow:** Igris + Beru

---

# Git Ghosts

> *Haunt the repository history. Can trap unwary developers.*

### Merge Conflict Poltergeist

**Rank:** C
**Habitat:** Branches with divergent changes
**Signs:** <<<<<<< markers; failed merges
**Weakness:** Small PRs; frequent rebasing; communication
**Drops:** Git conflict resolution skills
**Shadow:** Tusk (brute force resolution)

---

### Detached HEAD Specter

**Rank:** D
**Habitat:** Checkout of commits, tags, or after failed operations
**Signs:** "You are in detached HEAD state"
**Weakness:** Create branch or checkout existing one
**Drops:** Git state awareness
**Shadow:** Any soldier

---

### Force Push Demon

**Rank:** A
**Habitat:** Shared branches, collaborative repos
**Signs:** Lost commits; confused teammates; broken CI
**Weakness:** Never force push shared branches; use --force-with-lease
**Drops:** Git collaboration discipline
**Shadow:** Monarch must approve

---

# Registering New Threats

When Igris encounters an unknown threat:

```markdown
## New Bestiary Entry

**Encountered during:** [task/PR/review]
**Threat name:** [descriptive name]
**Category:** [Void Devourer / Syntax Demon / Logic Wraith / etc.]
**Details:** [full entry following format above]
```

Add to this bestiary. The army grows stronger with each documented victory.

---

*"A shadow that learns from battle becomes invincible."*
— The Shadow Monarch
