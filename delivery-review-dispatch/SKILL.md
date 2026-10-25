---
name: delivery-review-dispatch
description: When the global AGENTS.md requires independent pre-release review, hand off the exact artifact and enforce PASS/BLOCK/UNRESOLVED without extending delegation authority.
---

# Delivery Review Dispatch

For the delivering parent only, after the global review gate is triggered. Review subagents use `delivery-review` instead. This skill neither authorizes other delegation nor makes routine low-risk work reviewable.

## Handoff before release

First frame the whole task from original records—context, goal, structure, priorities, relationships, and tradeoffs—separating evidence, provisional whole-task synthesis, and local deductions. Review one coherent, unreleased candidate; retrospective critique cannot retract prior delivery. Send distinct sections:

- `RAW EVIDENCE`: every task-relevant user turn verbatim and in order, including corrections and superseded facts, plus original source, test, and authorization records. Do not curate excerpts; if too long, provide direct access to the full original record. Label redactions and unavailable material. Include only relevant prior BLOCKs with their defect, reviewed revision, and evidence-linked disposition; flag uncertain relevance or missing records. Exclude unrelated history, unapproved secrets, and unnecessary private data.
- `DELIVERABLE`: complete actual artifact(s), exact proposed final revision/diff, and any explanation intended for the recipient.
- `PARENT EXPLANATION`: separate reasoning, assumptions, and claimed approvals, or `none`; never represent it or a reviewer opinion as original evidence.

Include `你是交付审核子智能体。` and require read-only `delivery-review`: no edits, external contacts, commitments, or delegation. Ask for independent review of the artifact at its point of use, source-grounded counterexamples and alternatives, and separate delivery verdict and explanation errors.

## Parent repair and release

- **Repair from evidence.** Check reviewer defects and suggested repair paths against original records and the exact artifact; neither trust a reviewer blindly nor self-clear a BLOCK. Correct root premises and dependents while retaining evidence-backed ways to advance the user's goal, not merely deleting flagged content. Before review or release, test final material claims and actions for unsupported increases in scope, certainty, specificity, or commitment. Contest a mistaken BLOCK only with a specific evidence-backed rebuttal for independent re-review.
- **Deliver for use.** Preserve the effective goal, requested form, and decision or use point. Explore relevant evidence-backed paths before narrowing; exclude from recommendations means shown to rely on material misrepresentation, violated constraints, or missing authority, not legitimate options merely carrying disclosed risk. Among supportable paths, weigh value and consequences, propose a proportionate next action, and leave user-owned trade-offs to the user. Lead with the smallest authorized, usable result, decisive facts, and unmet conditions rather than substituting analysis or future plans. Keep unapproved options conditional, check standalone readiness against caveats, and report incomplete work without inventing commitments.
- **Respect review scope.** At most five dispatches per user turn, including retries; splitting, repair, or assistant continuation never resets the count. A new user turn renews quota, not a prior BLOCK or a PASS for an old revision. Never re-sample an unchanged BLOCKed draft for a different opinion.
- **Apply the result.** `PASS` permits only unchanged reviewed work, after explicit independent disposition of each still-applicable earlier BLOCK (evidenced repair, authorized inapplicability, or grounded rebuttal); it substitutes neither tests nor authority. `BLOCK` requires substantive repair/removal, new relevant evidence/authority, or a specific rebuttal before re-review. `UNRESOLVED` withholds affected parts and dependents. Consequential separable portions still require their own current PASS. At the five-dispatch limit, stop and report noncompletion or deliver only already-cleared portions; never claim review or validation that did not occur.
