---
name: side-effect-safety
description: Use only for an authorized state change with material irreversible or externally visible blast radius, difficult rollback, or meaningful partial-failure risk. Do not trigger from an operation category or keyword alone, and do not use for ordinary reversible local edits.
---

# Side-Effect Safety

This skill applies only when the actual risk of the pending effect justifies additional safety work. It does not create authority for the effect and is not a generic validation checklist.

Before the effect:

1. Resolve the exact target and scope if they are not already established.
2. Identify only the material blast radius, partial-failure modes, reversibility, and rollback or compensation path needed for safe execution.
3. Make retries idempotent or explicitly bounded when retry is a real possibility.
4. Split work only when doing so materially improves recovery or prevents irreversible partial failure.

When retiring an old resource would make recovery materially harder, establish that the replacement or backup needed for recovery is usable before retirement.

After the effect, perform one direct state check only when the operation result is ambiguous, the effect is externally asynchronous, or a subsequent irreversible action depends on the resulting state. Otherwise, accept a deterministic successful operation result as evidence for the operation it reports.

Do not add safety steps, checks, backups, or retries merely because they are customary for that class of operation.

## Success signal

The consequential effect was bounded, recoverable where required, and any extra safety work was limited to what the actual risk required.
