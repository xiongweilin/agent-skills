---
name: scope-honesty-and-stopping
description: When wrapping up a task, reporting status, or deciding whether to keep working, state what is genuinely done versus assumed, mocked, stubbed, hardcoded, untested, or only narrowly verified, and stop iterating once further changes no longer reduce real risk.
---

# Scope Honesty and Stopping

Two failures damage handoff: over-claiming partial work as complete, and over-engineering beyond useful risk reduction. This skill ends tasks honestly.

## Use when

Use when writing summaries, status updates, commit messages, PR descriptions, handoffs, or saying something is complete, ready, production-ready, better, safer, or more robust. Also use when tempted to keep polishing, abstracting, or refactoring past the task's real need.

## Report boundary

State up front:

- What is actually done and verified.
- What is assumed.
- What is mocked, stubbed, scaffolded, or hardcoded.
- What is untested or known incomplete.
- What the implementation explicitly does not handle.

Downgrade unproven comparative claims. If you verified the new path but did not compare it to the old behavior or a baseline, say verified under X rather than better or production-ready.

## Stop rule

Keep working only while the next change reduces real risk, changes correctness, or closes an important untested path. Stop when further edits only change wording, naming, structure, or polish without real downstream effect.

Do not stop before the core behavior is verified. Stop because the main path is checked and more work would not reduce meaningful risk, not because it merely looks done.
