---
name: scope-honesty-and-stopping
description: When wrapping up a task, reporting status, or deciding whether to keep working, state plainly what is genuinely done versus assumed, mocked, stubbed, hardcoded, or untested — and stop iterating once further changes no longer reduce real risk. Covers listing assumptions and unhandled cases, not presenting partial or scaffolded work as complete, avoiding gold-plating and needless refactoring, and not stopping before the core behavior is actually verified. Use this whenever you finish or hand off a task, write a summary, status update, commit message, or PR description, say something is "complete", "ready", or "production-ready", or feel the pull to keep polishing, abstracting, or refactoring beyond what the task needs. It applies both when you are tempted to over-claim completion and when you are tempted to over-engineer.
---

# Scope Honesty and Stopping

Two opposite failures wreck a handoff, and both come from not naming the boundary clearly. Over-claiming presents work as more finished than it is, sending the next person — often your future self — into a trap they didn't know was there. Over-engineering keeps polishing past the point of real value, burning time and adding surface area (and new bugs) for no payoff. This skill is about ending a task honestly and stopping at the right moment.

## Be honest about scope when you finish or report

State these explicitly, and put them up front rather than burying them under a confident summary:

- **What is actually done and verified** — the parts you've checked work.
- **What is assumed** — config, environment, credentials, or inputs you relied on without validating.
- **What is mocked, stubbed, or hardcoded** — anything standing in for the real thing that isn't real yet.
- **What is untested or known-incomplete** — paths you didn't exercise, and an explicit list of what this does *not* yet handle.

A precise "here's what's real and here's what's scaffold" is far more useful than "done," because it tells the reader exactly where to look before they trust it. The honesty also protects you: undisclosed gaps read as mistakes later, while disclosed ones read as judgment.

## Know when to stop iterating

Keep working only while a change reduces real risk or changes actual behavior or correctness. Stop when:

- Further edits only change wording, naming, or structure without changing behavior or lowering risk. That's polishing, and polishing feels productive while adding nothing.
- The remaining work is below the stakes of the task. A one-off script doesn't need retries, caching, a config system, and three layers of abstraction. Match the engineering to what the thing is for.
- You've found the smallest change that fixes the actual problem. Ship that, not the maximal refactor you noticed along the way — note the refactor separately if it's worth doing later.

But do not stop *before* the core behavior is verified. "I stopped because it looks done" is not a stopping condition; "I stopped because the main path is verified and further changes wouldn't reduce risk" is. Premature stopping and endless polishing are both failures of the same judgment, and this is the line between them.

## A quick test for "should I keep going?"

Name the concrete downstream difference the next change would make. If you can name one — it closes a real failure mode, covers an untested path that matters, fixes a wrong result — continue. If you can't, and the change only makes the code "nicer," stop. The inability to name a real downstream effect is the signal that you've crossed from finishing into gold-plating.

## When this is lighter-touch

Read the user's actual goal. In genuine prototyping or exploration where they want breadth and speed, heavy scope-accounting is friction. And when polishing *is* the task — a cleanup PR, a refactor, a performance pass — "it only changes structure" is the point, not a reason to stop. Apply the stopping rule against the task's real purpose, not mechanically.
