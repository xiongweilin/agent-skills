---
name: side-effect-safety
description: Design safe execution for state-changing actions that can duplicate, partially apply, affect external systems, or be hard to reverse. Use only for writes, sends, publishes, deletions, migrations, retries, infrastructure changes, or other effects requiring idempotency, rollback, compensation, atomic transitions, or deterministic guards. Do not trigger for pure reads, pure computation, or reversible local edits.
---

# Side-Effect Safety

Irreversible side effects are where ordinary bugs become real damage: double charges, duplicate emails, lost records, corrupted state, repeated external writes, or half-applied workflows.

## Use when

Use when code sends email/SMS/push notifications, performs database inserts/updates/deletes, runs migrations, deletes files or records, calls external APIs that change state, retries an effect, publishes to a queue or event bus, writes to ERP/CRM/BI systems, changes infrastructure, or performs an operation that cannot be safely repeated or cleanly undone.

Skip pure reads, pure computation, and local reversible edits.

## Main rule

Separate the decision from the effect. Non-deterministic steps such as LLM output, heuristic classification, or best guesses may propose irreversible actions, but must not execute them directly. A deterministic guard validates the proposal, enforces idempotency, and only then performs the side effect.

## Checklist

**Idempotency:** every irreversible operation has an idempotency key. If the exact call fires twice, the second call must be a no-op or return the original result.

**Explicit failure path:** timeouts, 5xx, malformed responses, and validation failures must leave visible states. Never silently record failure as success.

**Compensation:** if step N fails after step N-1 had an effect, define what cleans up or neutralizes N-1.

**Atomic transitions:** use conditional updates or compare-and-set state moves. Avoid read-then-write races.

**Correct enforcement layer:** transactionality belongs in the database, idempotency may belong in the provider or service layer, atomic counters belong in stores that enforce atomicity. Do not attribute guarantees to orchestration, workflow tools, or LLMs unless they actually enforce them.
