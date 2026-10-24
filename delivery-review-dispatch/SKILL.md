---
name: delivery-review-dispatch
description: When the global AGENTS.md requires independent pre-release review, hand off the actual consequential artifact, apply PASS/BLOCK/UNRESOLVED, and gate final release; do not extend delegation authority.
---

# Delivery Review Dispatch

Use only after the global delivery-review trigger is met. This skill prepares the handoff and controls reuse; it does not authorize unrelated delegation or turn every routine answer into a review task.

## Prepare the unreleased artifact

Review one coherent candidate before release. Retrospective critique cannot retract a delivered artifact; only still-unreleased content can be gated.

Provide the actual candidate and evidence, not the parent's description alone:

- relevant user turns, later facts and corrections, active constraints and delivery form; quote originals;
- complete relevant artifact(s) and exact revision or diff, including design, code, configuration, or final text as applicable;
- source evidence, material assumptions and unknowns, separately from parent inferences or asserted gaps, plus commitment authority;
- applicable acceptance criteria, authority, and required verification evidence, identifying unrun or unavailable checks.

Include the exact sentence `你是交付审核子智能体。` in the delegated task and require `delivery-review`. Keep the assignment read-only. The reviewer cannot rewrite the final artifact, contact third parties, dispatch another agent, or create obligations. Parent explanations are assertions to check, not independent evidence.

## Enforce the release result

Wait for one terminal review verdict for the identified artifact/revision:

- `PASS`: no material blocker found for this artifact/revision and scope; not approval of later changes, a substitute for required tests, or external authorization.
- `BLOCK`: repair or remove the underlying defect, not just its wording. Do not release affected work until the corrected version passes independent review.
- `UNRESOLVED`: required evidence or review basis is missing. Do not release affected work as final; report limits or deliver separately safe, ungated partials.

Only PASS for the materially unchanged final artifact satisfies this review gate. Material revisions after PASS or BLOCK (including new claims, design, behavior, interfaces, or effects) need focused independent re-review to PASS. Neither a parent repair nor an unavailable reviewer may self-clear BLOCK/UNRESOLVED. Reuse unaffected findings, avoid routine loops, and never claim an unrun review.
