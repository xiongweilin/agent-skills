---
name: delivery-review-dispatch
description: When the global AGENTS.md requires independent pre-release review, hand off the actual consequential artifact, apply PASS/BLOCK/UNRESOLVED, and gate final release; do not extend delegation authority.
---

# Delivery Review Dispatch

Use only after the global delivery-review trigger is met. This skill prepares the handoff and controls reuse; it does not authorize unrelated delegation or turn every routine answer into a review task.

## Prepare the unreleased artifact

Review one coherent candidate before release. Retrospective critique cannot retract a delivered artifact; only still-unreleased content can be gated.

Send three separate, labeled sections; never mix source evidence, delivered work, and parent interpretation:

- `RAW EVIDENCE`: all user turns verbatim, in order from first to latest (including updates/corrections), and original source, test, and authorization records with provenance. Do not select or summarize turns; identify any inaccessible or undisclosable originals.
- `DELIVERABLE`: complete actual artifact(s) and exact proposed final revision/diff, including any explanation intended for release.
- `PARENT EXPLANATION`: the parent's distinct rationale, inferences, assumptions, and claimed approvals; mark `none` if absent. Never pass these off as source evidence.
- Put original requirements and verification records in `RAW EVIDENCE`; mark unknowns and unrun checks, and preserve applicable disclosure limits.

Include `你是交付审核子智能体。` and require `delivery-review`. The reviewer is read-only: no edits, external contacts, commitments, or further delegation. Require a delivery verdict and separate non-gating explanation-error notes.

## Enforce the release result

Allow at most five review dispatches per task, counting retries and re-reviews, even after repairs or splits; await verdict or terminal failure.

- `PASS`: applies to this artifact/revision alone; errors confined to the private parent explanation do not negate it. It replaces neither tests nor authority.
- `BLOCK`: isolate defects and dependents; repair or remove them. Get fresh PASS for consequential revisions; keep safe independent parts eligible.
- `UNRESOLVED`: withhold unverified parts and dependents; safe separable portions need support, authority, and PASS if consequential.

Only PASS for unchanged final work permits release. Material revisions after PASS/BLOCK need re-review; parent cannot self-clear. Stop at five dispatches: prior PASS covers only unchanged work. Deliver independently supported parts with current PASS if consequential; report the rest incomplete. Never reset by splitting or claim unrun review.
