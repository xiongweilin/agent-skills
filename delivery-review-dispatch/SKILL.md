---
name: delivery-review-dispatch
description: When the global AGENTS.md requires independent pre-release review, hand off the actual consequential artifact, apply PASS/BLOCK/UNRESOLVED, and gate final release; do not extend delegation authority.
---

# Delivery Review Dispatch

For the delivering parent agent only, use after the global delivery-review trigger is met; a review subagent uses `delivery-review` instead. This skill prepares the handoff and controls reuse; it does not authorize unrelated delegation or turn every routine answer into a review task.

## Prepare the unreleased artifact

Review one coherent candidate before release. Retrospective critique cannot retract a delivered artifact; only still-unreleased content can be gated.

Send three separate, labeled sections; never mix source evidence, delivered work, and parent interpretation:

- `RAW EVIDENCE`: all task-relevant user turns from first to latest, verbatim and in order (including corrections and superseded facts); no curated excerpts. If too long, provide reviewer direct access to the unabridged original task record, not a parent summary. Label inaccessible or redacted spans.
- `DELIVERABLE`: complete actual artifact(s) and exact proposed final revision/diff, including any explanation intended for release.
- `PARENT EXPLANATION`: the parent's distinct rationale, inferences, assumptions, and claimed approvals; mark `none` if absent. Never pass these off as source evidence.
- In `RAW EVIDENCE`, include original source/test/authorization records and only prior BLOCKs relevant to the current artifact or its dependents: cited defect, reviewed revision, disposition, and grounds. For a formerly applicable BLOCK now repaired, removed, refuted, or inapplicable, give a brief evidence-linked closure note only when needed; omit unrelated or settled history. Mark uncertain relevance and missing records; treat reviewer opinions as claims, not facts. Exclude unrelated history, unapproved secrets and unnecessary private data.

Include `你是交付审核子智能体。` and require read-only `delivery-review` (no edits, contacts, commitments, or delegation). Require the reviewer to judge the artifact as received, run or acted upon in its intended context, rather than treating the parent's draft-stage framing as the use context. Require separate delivery verdict and explanation-error notes; ask for counterexamples, internal-consistency checks, and feasible authorized alternatives without invented promises.

## Enforce the release result

At most five review dispatches per user turn, including retries and re-reviews; repairs, splits and assistant continuations cannot reset quota. New user turns renew five attempts, not eligibility: an unchanged BLOCKed draft with no new specific grounds cannot be re-sampled for a different verdict.

Parent: test both your own assumptions and reviewer findings or repair suggestions against original evidence and the actual artifact; neither self-trust nor treat a review opinion as fact. For an evidenced defect, find its root premise and correct all material repeats and dependent claims across the full revised artifact, not just the cited sentence. Challenge a mistaken BLOCK only with a specific evidence-backed rebuttal for independent re-review; never silently ignore, self-clear or re-sample it. Preserve feasible authorized alternatives and honest partial delivery without inventing commitments.

- `PASS`: applies to this revision alone; explanation errors are non-gating only if they do not materially affect the deliverable. It replaces neither tests nor authority.
- `BLOCK`: carry only still-applicable defects across revisions and turns, not unrelated or resolved ones. Re-review requires substantive repair/removal, relevant new evidence/authority/requirements, or a concrete falsifiable rebuttal. Do not repeat rejected grounds.
- `UNRESOLVED`: withhold unverified parts and dependents; safe separable portions need support, authority, and PASS if consequential.

Only PASS for unchanged final work permits release. Before clearing prior BLOCK, focused independent review must explicitly verify repair, changed applicability or grounded rebuttal for each applicable blocker; a generic new PASS is insufficient. Re-review material changes; parent cannot self-clear. At five dispatches this turn stop; report incomplete or deliver independent supported parts with current PASS if consequential. New turn renews quota, not BLOCK or old PASS scope. Never claim unrun review.
