---
name: delivery-review-dispatch
description: When the global AGENTS.md requires independent pre-release review, hand off the exact artifact and enforce PASS/BLOCK/UNRESOLVED without extending delegation authority.
---

# Delivery Review Dispatch

For the delivering parent only after the global review gate is triggered. Reviewer subagents use `delivery-review`. This skill grants neither extra delegation nor review obligations for routine low-risk work.

## Non-negotiable boundaries

- **Grounded truth and authorization.** Follow the user's actual goal and applicable safety, confidentiality, authority and contractual limits. Reported evidence, inference, a proposed solution and established capability are different. No unsupported commitments, deadlines, feasibility or inevitable-failure claims; a qualification, planned measurement, proposed approval or future contract rewrite does not establish currently missing facts, execution ability, permission or customer acceptance. Do not let a new approach retroactively redefine source records, existing terms or actual outcomes.
- **Recipient-use readiness.** A `DELIVERABLE` must be complete and usable **for its stated current use**, without unmet prerequisites for that use. Put versions requiring unknown facts, capacity, approvals or obligations before they can serve that use only in separately labeled `CANDIDATE`, not `DELIVERABLE` or release. Distinguish conditions for this communication/action from conditions for a later negotiation, acceptance, signature or outcome it discusses.
- **Independent gate.** No parent self-clearance of a reviewer's evidence-grounded BLOCK. An old PASS does not authorize a changed artifact; a new turn/attempt quota clears no applicable prior BLOCK. Neither an isolated passing excerpt nor completion of a plan proves a new assembled result is ready. Review replaces neither tests nor authority.

## Positive delivery duties

1. **Build the real result, not a defensive substitute.** Before each consequential answer/revision, reread task-relevant original evidence. Reassess actors, use point, goals, constraints, authority, options, decisive assumptions, counterexamples and whole effects. Compare material alternatives, including whether prominent metrics or intermediate targets are justified, rather than only optimizing the given number or draft. Think deeply even for brief deliverables; act on known authorized work and reconstruct from the goal when patches undermine coherence.
2. **Advance every supportable portion.** From the first attempt, pursue the smallest complete recipient-usable result, not an internal risk memo or plan in place of an answer. Lack of grounds for a binding outcome does **not** stop truthful communication, authorized next actions or discussion of conditional alternatives. Explore compatible combinations and user-reserved choices; preserve supported substance. Do not infer either the success or impossibility of a proposed solution from missing evidence. Check whether actions can produce claimed effects, not merely document or escalate risks, and assess legitimate informed risk acceptance without endorsing improper means.
3. **Repair independently and decisively.** Give source-grounded reviewer BLOCKs priority but independently verify their premises against original evidence; reviewers do not design solutions or grant authority. Contest a BLOCK only by pinpoint source-backed rebuttal/counterexample and independent re-review, never by another opinion on an unchanged draft. Repair affected judgments and dependents, or rebuild coherently if accumulated patches fail. Recheck final numbers, metric definitions, facts/forecasts, reported versus actual effects, deadlines, promises, prerequisites and authority at the recipient's real use point; old drafts do not authorize carried-forward commitments. Do not invent a completed outcome to avoid reporting noncompletion.

## Evidence handoff and compact history

In a writable task workspace, keep a single append-only `.delivery-review-history.md` across turns, outside delivery and commits. Before each review append the **complete** current `DELIVERABLE` (or an immutable accessible full non-text version) and any materially distinct, task-relevant full `CANDIDATE` versions. Append the reviewer's **verbatim** `PASS BAR`, verdict, material findings and release status after review. Do not append separate parent explanations, condition notes, source-pointer essays, comparative narratives, reasoning transcripts or point-by-point defenses. Preserve old records rather than rewriting them; exclude secrets and needless private data. If history is inaccessible disclose the gap and consult available chat history.

Identify all potentially applicable prior BLOCKs; consult older full versions/reviews as necessary to establish grounds and dispositions rather than restating the entire history. A brief record never lowers the evidence or checking standard.

Review one coherent, unreleased candidate before delivery; retrospective criticism cannot retract a past publication. Use one dispatch per review attempt containing only:

- `RAW EVIDENCE`: Reproduce all task-relevant user turns verbatim and chronologically, including corrections and superseded facts, plus relevant original source, tests and authorization records. Exclude parent drafts, reasoning, reviews, history and proposed verdicts. Label redactions, unavailable records and source gaps; exclude unrelated history, unapproved secrets and unnecessary private data.
- `HISTORY FILE`: Exact accessible path and current turn/revision in `.delivery-review-history.md`. It contains full artifacts and verbatim prior reviews as review material, not new original evidence. Do not paste its contents into the dispatch.

Include `你是交付审核子智能体。` and require read-only `delivery-review` without editing, contact, commitments or delegation. Instruct the reviewer to establish independent criteria/interpretations from `RAW EVIDENCE` **before** opening `HISTORY FILE`, then audit the entire current artifact and all applicable prior BLOCKs; request compact grounded findings, affected scopes and a verdict, not a rewritten solution.

## Apply the verdict and release

- **Scope and quota:** At most five dispatches per user turn, including retries; splitting, repair or continuation does not reset the count. New turns reset only the quota, never a prior BLOCK or PASS for an earlier revision. Never re-sample an unchanged BLOCKed draft for another opinion.
- **PASS:** Release only unchanged reviewed work after independent disposition of each applicable prior BLOCK through evidenced repair, authorized inapplicability or source-backed refutation. Consequential separable portions need their own current PASS; passing excerpts do not clear an assembled artifact.
- **BLOCK / UNRESOLVED:** Repair/remove unsupported parts, obtain relevant evidence/authority or seek specific independent re-review of a source-backed rebuttal. Withhold affected parts and dependents, not independently cleared work. At five attempts, stop, report noncompletion or release only cleared scopes; never claim unperformed review or validation.