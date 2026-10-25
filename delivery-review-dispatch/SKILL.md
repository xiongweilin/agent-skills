---
name: delivery-review-dispatch
description: When the global AGENTS.md requires independent pre-release review, hand off the exact artifact and enforce PASS/BLOCK/UNRESOLVED without extending delegation authority.
---

# Delivery Review Dispatch

For the delivering parent only, after the global review gate is triggered. Review subagents use `delivery-review` instead. This skill neither authorizes other delegation nor makes routine low-risk work reviewable.

## Handoff before release

Review one coherent, unreleased candidate; retrospective critique cannot retract prior delivery. Send distinct sections:

- `RAW EVIDENCE`: every task-relevant user turn verbatim and in order, including corrections and superseded facts, plus original source, test, and authorization records. Do not curate excerpts; if too long, provide direct access to the full original record. Label redactions and unavailable material. Include only relevant prior BLOCKs with their defect, reviewed revision, and evidence-linked disposition; flag uncertain relevance or missing records. Exclude unrelated history and unnecessary private data.
- `DELIVERABLE`: complete actual artifact(s), exact proposed final revision/diff, and any explanation intended for the recipient.
- `PARENT EXPLANATION`: separate reasoning, assumptions, and claimed approvals, or `none`; never represent it or a reviewer opinion as original evidence.

Include `你是交付审核子智能体。` and require read-only `delivery-review`: no edits, external contacts, commitments, or delegation. Ask for independent review of the artifact at its point of use, source-grounded counterexamples and alternatives, and separate delivery verdict and explanation errors.

## Parent repair and release

- **Repair from evidence.** Check reviewer findings against original records and the exact artifact; neither trust a reviewer blindly nor self-clear a BLOCK. Correct the root premise and all material dependent/reworded claims, then independently ground each new or strengthened conclusion. Contest a mistaken BLOCK only with a specific evidence-backed rebuttal for independent re-review.
- **Deliver a usable core.** Preserve the effective user goal, permitted alternatives, and requested form. Lead with sufficient evidence-backed, authorized standalone work; keep stronger options requiring evidence, approval, or external agreement expressly conditional and separate. Compare acknowledged caveats with every ready-to-use portion: repair conflicts, state essential conditions, or withdraw the readiness claim. If no valid standalone core exists, report incomplete work rather than inventing certainty or expanding scope.
- **Respect review scope.** At most five dispatches per user turn, including retries; splitting, repair, or assistant continuation never resets the count. A new user turn renews quota, not a prior BLOCK or a PASS for an old revision. Never re-sample an unchanged BLOCKed draft for a different opinion.
- **Apply the result.** `PASS` permits only unchanged reviewed work, after explicit independent disposition of each still-applicable earlier BLOCK (evidenced repair, authorized inapplicability, or grounded rebuttal); it substitutes neither tests nor authority. `BLOCK` requires substantive repair/removal, new relevant evidence/authority, or a specific rebuttal before re-review. `UNRESOLVED` withholds affected parts and dependents. Consequential separable portions still require their own current PASS. At the five-dispatch limit, stop and report noncompletion or deliver only already-cleared portions; never claim review or validation that did not occur.
