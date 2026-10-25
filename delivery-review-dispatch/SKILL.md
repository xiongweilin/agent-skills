---
name: delivery-review-dispatch
description: When the global AGENTS.md requires independent pre-release review, hand off the exact artifact and enforce PASS/BLOCK/UNRESOLVED without extending delegation authority.
---

# Delivery Review Dispatch

For the delivering parent only, after the global review gate is triggered. Review subagents use `delivery-review` instead. This skill neither authorizes other delegation nor makes routine low-risk work reviewable.

## Handoff before release

Review one coherent, unreleased candidate before delivery; retrospective critique cannot retract prior delivery. Send distinct sections:

- `RAW EVIDENCE`: every task-relevant user turn verbatim and in order, including corrections and superseded facts, plus original source, test, and authorization records. Do not curate excerpts; if too long, provide direct access to the full original record. Label redactions and unavailable material. Include only relevant prior BLOCKs with their defect, reviewed revision, and evidence-linked disposition; flag uncertain relevance or missing records. Exclude unrelated history, unapproved secrets, and unnecessary private data.
- `DELIVERABLE`: complete actual artifact(s), exact proposed final revision/diff, and any explanation intended for the recipient.
- `PARENT EXPLANATION`: separate reasoning, assumptions, and claimed approvals, or `none`; never represent it or a reviewer opinion as original evidence.

Include `你是交付审核子智能体。` and require read-only `delivery-review`: no edits, outside contact, commitments, or delegation. Request independent point-of-use review, material counterexamples, grounded repair directions, a delivery verdict, and separate explanation errors.

## Parent repair and release

- **Repair from evidence.** Validate reviewer findings and proposed repairs against original records and the exact artifact; neither blindly accept a reviewer nor self-clear a BLOCK. Correct root causes and affected dependents while preserving supported paths. Recheck changed claims and actions for unsupported increases in scope, certainty, specificity, or commitment. Contest a mistaken BLOCK only through a specific evidence-backed rebuttal and independent re-review.
- **Deliver for use.** Prioritize an evidence-backed, authorized result usable at the user's decision or use point, with decisive facts, feasible next actions, and unmet conditions. Where needed, compare supported candidates without claiming exhaustive coverage absent evidence; reject evidenced improper means, not merely disclosed risks. Keep unapproved options conditional and user-reserved trade-offs with the user. Check standalone readiness against material caveats; report noncompletion rather than invent commitments.
- **Respect review scope.** At most five dispatches per user turn, including retries; splitting, repair, or continuation never resets the count. A new user turn renews quota, not a prior BLOCK or a PASS for an old revision. Never re-sample an unchanged BLOCKed draft for another opinion.
- **Apply the result.** `PASS` permits release of only unchanged reviewed work after independent disposition of every applicable prior BLOCK by evidenced repair, authorized inapplicability, or source-backed refutation; it replaces neither tests nor authority. `BLOCK` requires substantive repair, relevant evidence/authority, or grounded rebuttal before re-review. `UNRESOLVED` withholds affected parts and dependents; consequential separable work still needs its own current PASS. At the five-dispatch limit, report noncompletion or release only cleared work; never claim unperformed review or validation.
