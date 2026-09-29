---
name: side-effect-safety
description: Use only for an authorized state change with material irreversible or externally visible blast radius, difficult rollback, or meaningful partial-failure risk. Do not trigger from an operation category or keyword alone, and do not use for ordinary reversible local edits.
---

# Side-Effect Safety

This skill applies only when the actual risk of the pending effect justifies additional safety work. It does not create authority for the effect and is not a generic validation checklist.

Before the effect:

1. Resolve the exact target and scope if they are not already established.
2. Identify only the material blast radius, partial-failure modes, reversibility, and rollback or compensation path needed for safe execution.
3. When retry is a real possibility, keep transport or request idempotency separate from external effect idempotence. Redispatch is safe only when the effect contract or authoritative reconciliation establishes that repetition is safe.
4. Split work only when doing so materially improves recovery or prevents irreversible partial failure.

When retiring an old resource would make recovery materially harder, establish that the replacement or backup needed for recovery is usable before retirement.

After dispatch, distinguish transport outcome from external effect. A timeout, connection interruption, lost acknowledgement, or provider result of `unknown` does not establish that the effect did not occur.

If an effect may already have crossed the external boundary, do not automatically redispatch. Reconcile the original attempt through an authoritative read-back, provider reconciliation capability, or other qualified observation that can establish the effect state. If reconciliation is unavailable, unsafe to repeat, or remains ambiguous, preserve the result as unknown and require manual resolution rather than manufacturing failure or a fresh invoke.

When the operation result is deterministic and the pending decision depends only on the operation it reports, accept that result without an extra state check. Perform additional observation only when the next action depends on an external effect or postcondition that the operation result does not establish.

Do not add safety steps, checks, backups, or retries merely because they are customary for that class of operation.

## Success signal

The consequential effect was bounded, recoverable where required, ambiguous effects were reconciled without unsafe redispatch, and any extra safety work was limited to what the actual risk required.
