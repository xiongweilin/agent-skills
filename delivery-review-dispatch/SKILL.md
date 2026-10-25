---
name: delivery-review-dispatch
description: When the global AGENTS.md requires independent pre-release review, hand off the exact artifact and enforce PASS/BLOCK/UNRESOLVED without extending delegation authority.
---

# Delivery Review Dispatch

For the delivering parent only, after the global review gate is triggered. Review subagents use `delivery-review` instead. This skill neither authorizes other delegation nor makes routine low-risk work reviewable.

## Handoff before release

For consequential work, before deciding each new answer or revision, reread all task-relevant original evidence and the entire prior candidate/BLOCK history. First reassess the whole goal, effective constraints and authority, dependencies, viable options, and material effects on the final result; do not assume the prior plan is sound or fix only the latest BLOCK. In a writable task workspace, keep one append-only `.delivery-review-history.md` across turns (outside delivery and commits) as the review handoff. Append new evidence as received, each complete candidate before review, and afterward the verbatim verdict, defects, repairs and release status. Never overwrite or repeat unchanged evidence; exclude unrelated history, unapproved secrets and needless private data.

Review one coherent, unreleased candidate before delivery; retrospective critique cannot retract prior delivery. In the log, label these distinct entries with their turn/revision and source references:

- `RAW EVIDENCE`: every task-relevant user turn verbatim and in order, including corrections and superseded facts, plus original source, test, and authorization records. Do not curate excerpts; if too long, give direct access to the full originals. Label redactions and unavailable material; append subsequent evidence without rewriting history.
- `DELIVERABLE`: each complete candidate (full text, or an accessible immutable artifact version and diff), the exact proposed final revision/diff, and any explanation intended for the recipient. Identify the current candidate.
- `PARENT EXPLANATION`: separate reasoning, assumptions, and claimed approvals for each candidate, or `none`; never represent it or reviewer opinions as original evidence.
- `REVIEW HISTORY`: each verbatim verdict, evidenced BLOCK defects, claimed repairs/rebuttals, applicable prior BLOCK dispositions and release status; not source facts.

Dispatch with `你是交付审核子智能体。` and the current candidate revision. Supply the log location instead of repeating sections only if the reviewer can read the complete log and referenced evidence/artifacts; otherwise supply the same distinct sections directly and flag gaps. Never claim inaccessible records were stored or reviewed. Require read-only `delivery-review`: no edits, outside contact, commitments, or delegation. Request independent point-of-use review, material counterexamples, grounded repair directions, a delivery verdict, and separate explanation errors.

## Parent repair and release

- **Repair from evidence.** Validate reviewer findings and proposed repairs against original records and the exact artifact; neither blindly accept a reviewer nor self-clear a BLOCK. Correct root causes and affected dependents while preserving supported paths. Before review or release, recheck final material claims and actions against evidence and authority for unsupported increases in scope, certainty, specificity, or commitment. Contest a mistaken BLOCK only through a specific evidence-backed rebuttal and independent re-review.
- **Deliver for use.** Prioritize an evidence-backed, authorized result usable at the user's decision or use point, with decisive facts, proportionate next actions, and unmet conditions; do not substitute extra analysis or future plans for present completion. Where needed, explore and compare supported candidates by value and consequence; reject evidenced improper means, not merely disclosed risks. Keep unapproved options conditional and user-reserved trade-offs with the user. Check standalone readiness against material caveats; report noncompletion rather than invent commitments.
- **Respect review scope.** At most five dispatches per user turn, including retries; splitting, repair, or continuation never resets the count. A new user turn renews quota, not a prior BLOCK or a PASS for an old revision. Never re-sample an unchanged BLOCKed draft for another opinion.
- **Apply the result.** `PASS` permits release of only unchanged reviewed work after independent disposition of every applicable prior BLOCK by evidenced repair, authorized inapplicability, or source-backed refutation; it replaces neither tests nor authority. `BLOCK` requires substantive repair/removal, new relevant evidence/authority, or a specific grounded rebuttal before re-review. `UNRESOLVED` withholds affected parts and dependents; consequential separable work still needs its own current PASS. At the five-dispatch limit, stop and report noncompletion or release only cleared work; never claim unperformed review or validation.
