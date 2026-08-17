---
name: side-effect-safety
description: Control consequential state changes — writes, sends, publishes, deletions, migrations, infrastructure changes, and file/config replacement. Use when an operation can duplicate, partially apply, affect external systems, or be hard to reverse, and needs idempotency, rollback, compensation, backup ordering, or deterministic guards. Do not trigger for pure reads, pure computation, or reversible local edits.
---

# Side-Effect Safety

Irreversible side effects are where ordinary bugs become real damage: double charges, duplicate emails, lost records, corrupted state, half-applied workflows, or a retired backup that was never verified. This skill is the method for any external or persistent state change; the always-loaded gate that says when to enter it lives in AGENTS.md.

## Use when

Use when code sends email/SMS/push, performs database writes or deletes, runs migrations, deletes files or records, calls external APIs that change state, retries an effect, publishes to a queue, writes to ERP/CRM/BI, changes infrastructure, or replaces or retires backups and recovery points.

Skip pure reads, pure computation, and local reversible edits.

## Main rule

Separate the decision from the effect. Non-deterministic steps such as LLM output, heuristic classification, or best guesses may propose irreversible actions, but must not execute them directly. A deterministic guard validates the proposal, enforces idempotency, and only then performs the side effect.

## Before the change

- **Read-only preflight.** Before a state-changing command, check resolved targets, scope, quoting, and the worst credible outcome with a read-only preflight or dry run. Intended non-destructiveness is not evidence of safety.
- **Blast-radius decomposition.** Identify affected resources, expected resulting state, reversibility, and material partial-failure modes. Split irreversible work into the smallest independently verifiable steps.
- **Baseline and rollback.** Before replacement, upgrade, migration, cleanup, or maintenance that may affect user data or configuration, capture the minimal current-state baseline and create a usable rollback backup where feasible. Keep only the minimum set the recovery plan needs.

## Replacement and retirement ordering

New backups and rollback copies replace old ones in a fixed order — never reverse it:

1. Create the new backup and pass readability/consistency verification.
2. Update the ledger or index.
3. Delete the old version.

Never delete an old backup or rollback copy before the new one is confirmed in effect. The ordering invariant itself stays in AGENTS.md; this is the procedure.

## Checklist

**Idempotency:** every irreversible operation has an idempotency key. If the exact call fires twice, the second call must be a no-op or return the original result.

**Explicit failure path:** timeouts, 5xx, malformed responses, and validation failures must leave visible states. Never silently record failure as success.

**Compensation:** if step N fails after step N-1 had an effect, define what cleans up or neutralizes N-1.

**Atomic transitions:** use conditional updates or compare-and-set state moves. Avoid read-then-write races.

**Bounded retry and fallback:** do not repeat an unchanged failed call. Use only bounded, materially different, read-only fallbacks that can distinguish transport, authentication, endpoint, and input failures. Stop once the remaining uncertainty is clear enough to report.

**Correct enforcement layer:** transactionality belongs in the database, idempotency may belong in the provider or service layer, atomic counters belong in stores that enforce atomicity. Do not attribute guarantees to orchestration, workflow tools, or LLMs unless they actually enforce them.
