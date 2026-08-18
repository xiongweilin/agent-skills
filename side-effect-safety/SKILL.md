---
name: side-effect-safety
description: Use immediately before an authorized write, delete, publish, migration, replacement, retry, or external side effect. Verify target, blast radius, rollback, idempotency, and post-change state. Do not trigger for reads, planning, or reversible local edits.
---

# Side-Effect Safety

Before the effect:

1. Resolve the exact target and scope with a read-only check.
2. Identify blast radius, partial-failure modes, reversibility, and a rollback or compensation path.
3. Make retries idempotent or explicitly bounded.
4. Split destructive work into independently verifiable steps.

For replacement or cleanup, verify the new backup or replacement before retiring the old one.

After the effect, verify the resulting state and leave failures visible. Do not treat a model's completion claim as evidence.

## Success signal

A reviewer can identify the target, blast radius, rollback or compensation path, idempotency guard, and fresh post-change verification.
