---
name: independent-testing-dispatch
description: Use only after independent testing is already authorized by the user or an applicable mandatory repository or lifecycle rule. Prepare the bounded handoff and decide whether later repairs invalidate the established testing basis. Do not create testing authority from complexity alone.
---

# Independent Testing Dispatch

Use this skill only in the implementing or parent agent after independent testing is already authorized. This skill governs the handoff and reuse boundary; it does not decide that testing is warranted.

## Prepare a testable candidate

After authorization, complete one coherent implementation phase before dispatching independent testing. Do not dispatch an independent-testing subagent after each small implementation step.

Treat the candidate as ready when the bounded change is coherent enough to test as a whole. Candidate size, complexity, risk, or importance does not independently authorize testing.

## Prepare the handoff

The outbound prompt must contain the exact sentence `你是独立测试子智能体。` and identify:

- the bounded candidate and testing scope;
- the authoritative acceptance basis or repository contract;
- any material environment or dependency constraints;
- the current authorization boundary.

State that the task is independent testing rather than code review. The independent-testing subagent owns the smallest sufficient correctness-testing strategy within the authorized scope.

Include local executable checks, GitHub CI, or required status checks only when they are part of the authoritative acceptance basis or an applicable mandatory repository workflow. Do not broaden authorization merely to create more testing evidence.

## Wait for the testing outcome

After dispatch, wait for the independent-testing subagent to return a terminal outcome. Multiple consecutive wait or poll cycles can be normal and do not by themselves indicate a stall.

Stop waiting only when the subagent returns, the runtime reports a terminal failure or cancellation, the user intervenes, or there is concrete evidence that the delegated run can no longer complete.

## Reuse or renew the testing basis

Reuse an established testing basis until a specific assumption or covered obligation has been materially invalidated.

For a later repair that remains within the established basis, rerun only the minimum previously established check whose evidence was invalidated by that repair. Do not automatically rerun the full local suite, corresponding GitHub CI, or independent testing merely because implementation changed.

Redispatch independent testing only when independent testing is still authorized and later changes materially invalidate or escape the established basis, such as a material change to behavior, contract, architecture, integration boundary, dependency assumption, state or migration semantics, concurrency, authorization, recovery behavior, or the acceptance basis itself.

If no specific invalidation can be identified, reuse the existing qualified basis.
