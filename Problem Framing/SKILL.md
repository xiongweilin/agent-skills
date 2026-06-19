---
name: problem-framing
description: Before writing or changing code, pin down what is actually being built and bounded — the concrete object, what is explicitly in and out of scope, what you are deliberately not solving and the cost of that omission, why this approach rather than the obvious alternatives, and what signal will tell you it worked — instead of jumping straight into implementation. Covers resolving ambiguous or multi-interpretation requests before coding, avoiding solving the wrong problem precisely, not building the maximal interpretation when a narrow one was asked for, and not letting abstraction inflate past the actual task. Use this at the very start of a task, the moment a request could be read more than one way, before picking an approach or a library, whenever you catch yourself about to write code without having stated the scope, and especially when a loose instruction like "add caching", "make it configurable", "handle errors", "support webhooks", or "clean this up" could expand without limit. This runs before implementation; scope-honesty-and-stopping runs after. When in doubt, frame first — a few sentences of scope up front prevents building the wrong thing fast.
---

# Problem Framing

A coding assistant's most expensive failures often happen before a single line is written. The request gets read in the most expansive way available, or in the first plausible way, and then the implementation is clean, tested, and aimed at the wrong target. Solving the wrong problem precisely is worse than solving the right one roughly, because the polish hides the miss. The back-end hygiene skills all act after the code exists — verifying it, reporting it honestly, keeping temporary work contained, handling irreversible effects. This one acts before: deciding what the task actually is before committing to it. A paragraph of framing up front is the cheapest leverage available, because every later step inherits the target it sets.

## Frame before you build

Before implementing, state — to yourself, in the PR description, or back to the user — these things. They take a paragraph, not a document.

- **The object.** The concrete thing that changes: which function, endpoint, table, behavior, or bug. "Make the dashboard faster" is not an object; "reduce the /reports page initial load by caching the three slow aggregate queries" is. Without a concrete object, the work spreads to fill whatever space the words allow.

- **In scope and out of scope.** What this task covers and what it explicitly does not. Naming the out-of-scope items is the point — it is where silent expansion and silent gaps both hide. An out-of-scope list is also a promise you can be held to.

- **What you are deliberately not solving, and the cost of not solving it.** Every bounded task punts something. Say what you are punting — cache invalidation, the auth-varying case, migrating the old rows — and whether the punt is safe or a known risk someone needs to accept. An unnamed omission reads as a bug later; a named one reads as a decision.

- **Why this approach, not the obvious alternative.** When more than one reasonable implementation exists — and tools now generate several in seconds — the choice matters more than the generation. State the one-line reason you picked in-memory over Redis, a new column over a join table, a wrapper over a rewrite. If you cannot name why, you have not chosen yet; you have defaulted.

- **The inputs and contract that actually matter.** The variables, scale, boundaries, and interface the solution must respect: expected input shapes, volume, the cases that must not break. Frame these now so verification later has something concrete to check against instead of a vague "does it work."

- **The success signal.** The observable result that tells you it worked — a measured latency drop, a specific test going green, a behavior you can demonstrate. Define it before building, so you are not left asserting "it works" against nothing.

## Resolve ambiguity before implementing, not after

If a request admits more than one genuinely different reading, and those readings would produce different code, that fork is the first thing to settle — not something to discover after you have already built one branch of it. "Add rate limiting" could mean per-user or per-IP, per-endpoint or global, fail-open or fail-closed; these are not details, they are different features.

Do not default to the maximal interpretation to be safe. Building more than was asked is its own failure — the one that scope-honesty and the over-engineering warnings exist to stop — and "I covered every case" is not a defense when none of them was wanted. Surface the fork, pick the reading the context best supports, and say which one you took. When the cost of guessing wrong is high and the user is reachable, ask; when it is low, choose explicitly and record the assumption so it is cheap to correct.

## Don't let the frame inflate

A narrow task gets a narrow frame. The pull is to turn "fix this one validation bug" into "design a general validation layer," or "read this file" into "build a configurable ingestion pipeline." Without a frame, abstraction inflates to fill the available space; the frame is what holds it to size. Match the breadth of the framing to the breadth of the request. If a larger design is genuinely warranted, name it as a separate, larger piece of work rather than smuggling it in under a small task — that keeps the current task honest and lets the bigger decision be made on purpose.

## Worked example

Request: "Add caching to the API."

- **Unframed:** introduce a caching layer across all endpoints, add a cache-invalidation system, make the backend configurable, wire in Redis. Clean, substantial, and very likely not what was needed — and now there is an invalidation system to maintain and stale-data bugs to chase, all in service of a problem no one stated.

- **Framed:** *Object* — cache the three read-only aggregate endpoints that dominate the latency graph. *Out of scope* — write endpoints, anything user-specific. *Deliberately not solving* — invalidation beyond a 60-second TTL; the cost is up-to-60-second staleness on these reports, acceptable for this data (confirm if unsure). *Approach* — in-process TTL cache, not Redis, because there is one instance and no cross-instance consistency need yet. *Contract* — must bypass the cache when a `fresh=true` param is present. *Success signal* — p95 on those endpoints drops below 200ms, measured the same way as the current graph.

The framed version is smaller, riskier exactly where it says so, and aimed at the real problem. The work it does not do is visible, which is what makes not doing it safe.

## When to skip

Framing scales with ambiguity and stakes, not with every edit. A rename, a formatting pass, or a one-line fix with one obvious meaning needs no ceremony — the object and scope are self-evident, so just do it. Genuine exploration, where the user wants breadth and is feeling out the space, is the wrong place for tight scoping; that is the point of exploring. Apply this when a task could plausibly be built more than one way, when an instruction is vague enough to expand without limit, or when getting the target wrong would cost real rework — not as a mandatory preamble to trivial work.
