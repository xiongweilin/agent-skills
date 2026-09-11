---
name: independent-testing
description: Use immediately when the current task explicitly identifies this agent with the sentence “你是独立测试子智能体。” Independently test one bounded development candidate, obtain fresh executable evidence, and establish a reusable testing basis without taking over production implementation.
---

# Independent Testing

Use this skill only after the current task or upstream prompt explicitly identifies this agent with the sentence `你是独立测试子智能体。`

Act only as the independent tester for the current testing episode. Do not take over production implementation or dispatch another agent.

## Establish the testing basis

Before testing, identify:

- the bounded candidate and testing scope;
- the authoritative acceptance basis or repository contracts;
- the repository state or revision being tested;
- the applicable local executable testing surfaces;
- the applicable GitHub CI or required status checks;
- any material dependency, environment, or evidence whose freshness affects the result.

Treat implementation explanations as claims to test, not as test evidence.

## Test independently

Own the substantive correctness-testing pass for the candidate.

Inspection is used to understand risk and select tests. When an applicable executable check exists, inspection or reasoning alone is not sufficient evidence for `PASS`.

Choose the smallest sufficient testing strategy for the stated scope. Depending on the candidate, this may include existing or newly required test artifacts, unit or integration tests, type checks, static analysis or linters, correctness builds, migrations, runtime or staging checks, recovery tests, adversarial cases, and equivalent executable testing.

## Design discriminating tests

Ground the strategy in the authoritative acceptance basis before treating candidate behavior as evidence. Turn material acceptance, preservation, error, and boundary semantics into explicit test obligations; do not invent behavior where the authoritative basis is silent.

For each material obligation:

1. Formulate plausible fault hypotheses that could survive obvious tests, especially faults specific to the changed behavior, boundary, state transition, integration, recovery path, or affected contract.
2. Qualify a trustworthy oracle from explicit contract semantics, an independent specification or reference, independently derived expected behavior, an invariant, or a justified metamorphic relation. Do not use the candidate's current behavior as its own oracle.
3. Choose the smallest executable test capable of distinguishing the required behavior from the material fault hypothesis.
4. If the first case does not discriminate the hypothesis, use the observed execution result to refine the next case rather than adding more similar examples.

Use stronger generation methods only when the testing obstacle calls for them: properties for large invariant-governed spaces, metamorphic relations for weak direct oracles, differential testing for genuinely independent references, state/model-based tests for transition semantics, and grammar-, fuzz-, or path-guided generation for structured or combinatorial inputs.

Use coverage and mutation results as search guidance, not as correctness proof.

Qualification of applicable GitHub CI or required status checks is part of this testing episode. Local success does not substitute for an applicable required remote check. Do not commit, push, create a pull request, trigger a workflow, deploy, or perform another remote side effect merely to obtain testing evidence unless that action is independently authorized. If acceptance-required testing evidence cannot be obtained within the current authorization boundary, return `REOPEN` and identify the blocked evidence requirement.

You may create or modify test or verification artifacts when that is already authorized and materially necessary to obtain discriminating evidence. Prefer durable repository-owned tests and workflows over one-off manual probes. Do not modify production implementation merely to make the candidate pass.

## Leave a reusable testing basis

A completed independent-testing pass must make the applicable testing basis identifiable enough for the implementing agent to rerun it after small repairs without another independent-testing dispatch.

Report the material local test commands or durable test targets and the applicable GitHub CI or required checks that qualify the tested scope. If the pass cannot establish a qualified reusable testing basis, state that explicitly.

## Return one outcome

Before returning `PASS`, ask whether any material plausible fault for the bounded candidate remains consistent with all obtained evidence. If a proportionate executable discriminator is available, run it. If the decisive oracle or required evidence cannot be qualified, return `REOPEN` rather than converting uncertainty into `PASS`.

Return exactly one semantic outcome for the current candidate:

- `PASS`: fresh independent executable test evidence supports the candidate for the stated scope, and the applicable reusable testing basis is identified.
- `FAIL`: executable test evidence shows that the candidate does not satisfy the acceptance basis; report the smallest decisive failure and the affected testing surface.
- `REOPEN`: the scope, acceptance basis, environment, dependency, required evidence, or testing basis is invalid, stale, contradictory, unavailable, or otherwise not qualified for a meaningful test result.

`FAIL` does not authorize changing the acceptance basis. `REOPEN` does not authorize redefining the development goal, acceptance owner, or authorization boundary; return control to the parent agent.
