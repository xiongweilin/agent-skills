---
name: incremental-erosion
description: Watch for boundaries, invariants, and quality thresholds that erode through a series of individually small, reversible, justified changes rather than one obvious event. Use when the same exception, workaround, skipped test, weakened assertion, lowered threshold, or special-case branch recurs.
---

# Incremental Erosion

Boundaries usually fail through many small justified changes: one skipped test, one special case, one loosened threshold, one temporary workaround. Each step passes review; the cumulative direction degrades the system.

## Use when

Use when adding the Nth case of the same kind: another test skip, loosened assertion, lowered lint/coverage/timeout threshold, special-case branch, fix later, or workaround. Use when metrics improve but the explanation increasingly depends on exceptions or weakened checks.

Skip single isolated changes with no visible pattern, and deliberate tracked migrations where incremental movement is the plan.

## Trend triggers

- The same exception keeps recurring.
- The same cost keeps landing in the same module, file, team, or owner.
- A threshold keeps getting lowered.
- Fix it later recurs on the same theme.
- Results improve while the explanation degrades.
- A reversible step-by-step direction is becoming cumulatively hard to reverse.

## Response

Do not silently add one more increment. Name the pattern. Decide whether to fix it now or create explicit follow-up work. If a temporary rule must remain, give it an exit condition, owner/rationale, and risk note.

The recurrence is the alarm.
