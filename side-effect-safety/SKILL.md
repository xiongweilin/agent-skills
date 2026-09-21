---
name: side-effect-safety
description: Use only for an authorized irreversible, destructive, externally visible, ambiguous, or materially high-blast-radius state change, including consequential replacement, migration, cleanup, retry, publish, or external effects. Do not trigger for reads, planning, or ordinary reversible local edits.
---

# Side-Effect Safety

The controls below are mandatory only when this skill's narrow trigger applies. They are safety controls for consequential side effects, not a general exception that authorizes post-implementation validation for ordinary writes.

Before the effect:

1. Resolve the exact target and scope when they are not already established by authoritative state.
2. Identify material blast radius, partial-failure modes, reversibility, and a rollback or compensation path.
3. Make retries idempotent or explicitly bounded.
4. Split destructive work only when necessary to preserve recovery or prevent irreversible partial failure.

For replacement or cleanup, establish that the replacement or backup is usable before retiring the old resource when retirement would make recovery materially harder.

After the effect, perform one direct state check only when the operation result is ambiguous, the effect is externally asynchronous, or a subsequent irreversible action depends on the resulting state. Otherwise, accept a deterministic successful operation result as evidence for the operation it reports.

Do not add independent checks merely for reassurance or higher confidence.

## Success signal

The consequential effect was bounded, recoverable where required, and any state check was limited to the minimum needed for safe continuation or resolution of an ambiguous effect.
