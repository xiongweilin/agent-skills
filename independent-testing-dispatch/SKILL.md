---
name: independent-testing-dispatch
description: Use only after independent testing is already justified and authorized under the active policy, whether explicitly requested, required by an applicable rule, or autonomously permitted by the high-threshold independent-testing gate. Prepare the bounded handoff and decide whether later changes invalidate the established testing basis.
---

# Independent Testing Dispatch

Use this skill only in the implementing or parent agent after independent testing authority already exists. This skill governs the handoff and reuse boundary; it does not decide that independent testing is warranted.

## Prepare a testable candidate

Complete one coherent implementation phase before dispatching. Do not dispatch after each small implementation step.

Treat the candidate as ready when the bounded change is coherent enough to test as a whole. Candidate size, complexity, risk, or importance does not independently justify testing.

## Prepare the handoff

The outbound prompt must contain the exact sentence `你是独立测试子智能体。` and identify:

- the bounded candidate and testing scope;
- the authoritative acceptance basis or repository contract;
- any material environment or dependency constraints;
- the current authorization boundary.

State that the task is independent testing rather than code review. The independent-testing subagent owns the smallest sufficient correctness-testing strategy within that boundary.

Include local executable checks, GitHub CI, or required status checks only when they are part of the authoritative acceptance basis or an applicable mandatory workflow. Do not broaden authority merely to create more evidence.

## Wait for the outcome

After dispatch, wait for one terminal testing outcome. Repeated wait or poll cycles may be normal and do not by themselves justify another dispatch or a broader check.

Stop waiting only when the subagent returns, the runtime reports terminal failure or cancellation, the user intervenes, or concrete evidence shows the delegated run can no longer complete.

## Reuse or renew the testing basis

Reuse an established testing basis until a specific covered assumption or obligation is materially invalidated.

For a later repair within that basis, rerun only the minimum established check whose evidence the repair invalidated. Do not automatically rerun the full local suite, corresponding GitHub CI, or independent testing merely because implementation changed.

Redispatch independent testing only when authority still exists and later changes materially invalidate or escape the established basis, such as a material change to behavior, contract, architecture, integration boundary, dependency assumption, state or migration semantics, concurrency, authorization, recovery behavior, or the acceptance basis itself.

If no specific invalidation can be identified, reuse the existing qualified basis.
