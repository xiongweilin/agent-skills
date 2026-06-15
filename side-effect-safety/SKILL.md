---
name: side-effect-safety
description: Enforce safe handling of irreversible and external side effects when writing or editing code. Covers idempotency keys, compensation and rollback paths, explicit failure handling, atomic (compare-and-set) state transitions, and keeping non-deterministic or LLM-driven steps from directly executing irreversible actions. Use this whenever code touches payments or money, sends email/SMS/push notifications, performs database inserts/updates/deletes, runs schema migrations, deletes files or records, calls external APIs that change state, retries an operation, publishes to a queue or event bus, or changes infrastructure — even when the user only says things like "add a refund endpoint", "wire up the webhook", "run this migration", "send the confirmation email", or "retry on failure" without ever mentioning safety, idempotency, or rollback. If an operation cannot be safely repeated or cleanly undone, this skill applies.
---

# Side-Effect Safety

Irreversible side effects are where ordinary bugs turn into real damage: double charges, duplicate emails, lost records, half-applied state that no test caught. A logic error you can fix; a customer charged twice you have to refund, apologize for, and reconcile. Catching these at write-time costs minutes; finding them in production costs far more. This skill is the set of checks to run whenever the code you're writing reaches out and changes something that can't be quietly undone.

## The one rule that matters most

Separate the decision from the effect. Anything non-deterministic — an LLM's output, a heuristic, a classifier, a "best guess" — may *propose* an irreversible action, but must not be the thing that *executes* it. A deterministic guard sits in between: it validates the proposal, enforces idempotency, and only then performs the side effect. The reason is simple: non-deterministic steps aren't reproducible and can't be reasoned about for correctness, so they're the worst possible owner of an action you can't take back.

## Checklist before shipping any irreversible or external operation

Run through these for each side-effecting call. Most real incidents trace back to skipping one.

**Idempotency.** Give every irreversible operation an idempotency key (order id, request id, a hash of the inputs) so running it twice has the same effect as running it once. Networks retry, queues redeliver, users double-click. Without a key, a retry becomes a second charge or a duplicate row. *Check:* if this exact call fired twice, would the second one be a no-op?

**Explicit failure path.** Every external call (network, payment, third-party API) needs a branch for timeout, 5xx, and malformed response. The failure branch should degrade or escalate visibly — never a silent default that records the failure as success. A swallowed error that lets the flow continue as if everything worked is worse than a loud crash, because it corrupts state quietly. *Check:* when this dependency errors or times out, what state are we left in, and does anyone find out?

**Compensation for multi-step flows.** If a sequence performs an irreversible step and a later step can still fail, define the compensating action up front and make failure trigger it. The canonical bug: a payment succeeds, a downstream step fails, and the record is still marked "completed" with reserved resources never released. On failure you must undo or neutralize what already happened — refund, release the hold, revert the status — and record the real outcome, not the hoped-for one. *Check:* if step N fails after step N-1 already had an effect, what cleans up N-1?

**Atomic state transitions.** Use compare-and-set or conditional updates for state-machine moves, not read-then-write. Read-modify-write races let two requests both read "pending" and both transition, double-applying the effect. *Check:* can two concurrent requests both pass this transition?

**Put the guarantee where it lives.** Don't ask an orchestration layer, a workflow tool, or an LLM to provide transactionality, atomic counting, or exactly-once delivery — they can't. Delegate each guarantee to the component that actually offers it: a database transaction for atomicity, the payment provider's idempotency support, an atomic Redis operation for a counter. Placing the requirement on a layer that can't enforce it is how systems look correct and aren't.

## Worked example: the compensation gap

A claim is approved, payment is attempted, then a fast-lane quota counter is decremented and the state machine is set to completed.

- **Wrong:** payment fails, but the code still sets status = completed and never returns the reserved quota. The system now believes a paid-out claim exists and has leaked a quota slot.
- **Right:** payment failure sets status = failed, releases the reserved quota (the compensating action), and routes the case to manual handling. The recorded outcome matches what actually happened, and no resource is leaked.

The fix isn't more code in the happy path — it's making the failure path do the cleanup the happy path would otherwise skip.

## When to skip

Don't add this ceremony where nothing is irreversible. Pure reads, pure computation, and local reversible edits (formatting a file, refactoring in-memory logic) don't need idempotency keys or compensation — adding them is just overhead that obscures the code. Scale the rigor to the blast radius: a throwaway analysis script and a production refund path do not deserve the same treatment.
