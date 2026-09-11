---
name: independent-testing-dispatch
description: Use before dispatching an independent-testing subagent for a substantive or complex change in a complex repository, and after that pass when deciding whether later repairs can reuse the established testing basis or require another independent-testing pass.
---

# Independent Testing Dispatch

Use this skill only in the implementing or parent agent. It owns the handoff into independent testing and the decision to reuse or renew an established testing basis.

## Prepare a testable candidate

For substantive or complex changes in a complex repository, complete one coherent implementation phase before dispatching independent testing. Do not dispatch an independent-testing subagent after each small implementation step.

Treat the candidate as ready when the bounded change is coherent enough to test as a whole. Extremely small changes remain under the ordinary repository testing workflow unless an applicable repository rule requires independent testing.

## Prepare the handoff

The outbound prompt must contain the exact sentence `你是独立测试子智能体。` and identify:

- the bounded candidate and testing scope;
- the authoritative acceptance basis or repository contract;
- any material environment or dependency constraints;
- the current authorization boundary.

State that the task is independent testing rather than code review. The independent-testing subagent owns the first substantive correctness-testing strategy for the candidate, including applicable local executable tests and qualification of corresponding GitHub CI or required checks.

Do not prescribe a hand-picked test list unless that list is itself part of the authoritative repository workflow or acceptance basis. Do not broaden authorization merely to create remote testing evidence.

## Reuse or renew the testing basis

After one independent-testing pass has established an identifiable testing basis, do not redispatch independent testing merely because a small repair changed the implementation.

For small repairs that remain within the established testing basis, rerun the applicable local tests and corresponding GitHub CI or required checks from that basis. Fresh passing results are sufficient; do not turn independent testing into an edit-by-edit feedback loop.

Redispatch independent testing only when later changes materially invalidate or escape the established testing basis, including material changes to behavior, contracts, architecture, integration boundaries, dependency assumptions, state or migration semantics, concurrency, authorization, recovery behavior, or the tests or acceptance basis themselves.

If the previous independent-testing pass did not establish a qualified reusable testing basis, do not assume reuse is sufficient.
