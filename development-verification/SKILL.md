---
name: development-verification
description: Use immediately when the current task explicitly identifies this agent with the sentence “你是开发验证子智能体。” Verify one development episode independently against its qualified acceptance basis; do not take over production implementation.
---

# Development Verification

Use this skill only after the current task or upstream prompt explicitly identifies this agent with the sentence `你是开发验证子智能体。` The dispatch decision and role marker are owned by the applicable `AGENTS.md`; this skill owns only the verification procedure after that state has been entered.

## Establish the verification basis

Before judging the candidate, identify:

- the current development goal and scope;
- the authoritative acceptance basis and its owner;
- the relevant repository contracts, invariants, and forbidden changes;
- the base repository state or revision against which the candidate is being judged;
- the applicable executable verification surfaces for the candidate;
- any applicable remote CI or required checks, whether they correspond to the exact candidate, and whether creating missing remote evidence would cross an authorization boundary;
- any material dependency, environment, or evidence whose freshness affects acceptance.

Do not infer acceptance from the developer's rationale. Treat implementation explanations as claims to test, not as verification evidence.

## Verify independently

Own all verification activity for the current development episode, including creating or modifying tests and running any tests, type checks, static analysis, builds used as correctness checks, migrations, integration checks, adversarial cases, runtime probes, staging checks, qualification of applicable remote CI or required status checks, or equivalent correctness review. Do not assume the implementing agent has already performed any of these checks.

Inspect the candidate and choose the smallest set of checks that can materially distinguish pass from failure for the qualified scope. Inspection selects and interprets those checks; when an applicable executable correctness check exists, inspection or reasoning alone is not sufficient evidence for `PASS`. "Smallest" limits redundant or low-value verification; it does not permit omitting executable evidence that is materially required to establish correctness.

When remote CI or required status checks already exist for the exact candidate being verified, inspect and qualify them when they are material to acceptance. Do not treat local success as a substitute for an applicable required remote check. Do not commit, push, create a pull request, trigger a workflow, deploy, or perform another remote side effect merely to create verification evidence unless that action is independently authorized. If acceptance-required verification cannot be obtained within the current authorization boundary, do not return `PASS`; return `REOPEN` and identify the blocked evidence requirement.

You may modify only test or verification artifacts when that is already authorized and needed to obtain discriminating evidence. Do not modify production implementation, acceptance-owner documents, authorization policy, or unrelated repository state.

Actively look for counterexamples, boundary failures, stale assumptions, contract drift, partial-success ambiguity, recovery failures, and cases where provider or tool success does not establish the required real outcome.

## Return one outcome

Return exactly one semantic outcome for the current candidate:

- `PASS`: fresh independent evidence, including applicable executable evidence, supports closure for the stated scope and acceptance basis.
- `FAIL`: the candidate does not satisfy the qualified acceptance basis; provide the smallest decisive counterexample or evidence needed for repair.
- `REOPEN`: the acceptance basis, scope, representation, dependency, or required evidence is itself invalid, stale, contradictory, or no longer qualified for the current use.

`FAIL` does not authorize changing the acceptance basis. `REOPEN` does not authorize this verifier to redefine the development goal or acceptance owner; return control to the parent agent.

## Repair continuity

When the parent submits a repaired candidate in the same development episode, keep the existing verification basis unless new evidence justifies `REOPEN`. Judge the repaired candidate in the same verifier thread rather than resetting the verifier merely because an earlier candidate failed.

## Closure handoff

Only `PASS` supports representing the candidate as independently verified for the stated scope. Use `change-closure` when an applicable repository, safety, contract, or lifecycle gate requires broader change closure. Use `evidence-qualification-and-revalidation` when previously qualified evidence or dependencies may have become stale.
