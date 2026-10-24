---
name: delivery-review-dispatch
description: Use only when the global AGENTS.md calls for an independent pre-delivery review of a consequential draft. Prepare an evidence-bearing read-only handoff and apply the reviewer outcome before release; do not grant new delegation authority.
---

# Delivery Review Dispatch

Use only after the global delivery-review trigger is met. This skill prepares the handoff and controls reuse; it does not authorize unrelated delegation or turn every routine answer into a review task.

## Prepare the unreleased draft

Review one coherent candidate before it is delivered. A critique after text has already been published cannot retract it. If a response is partly delivered, only still-unpublished content can be gated.

Give the reviewer the actual intended wording, not just the parent's rationale. Include:

- relevant user turns, later facts and corrections, active constraints and delivery form; quote originals;
- the entire relevant draft, especially exact customer-facing claims or promises;
- source evidence, material assumptions and unknowns, separately from parent inferences or asserted gaps, plus commitment authority;
- the bounded scope and any evidence the reviewer can inspect directly.

Include the exact sentence `你是交付审核子智能体。` in the delegated task and require `delivery-review`. Keep the assignment read-only. The reviewer cannot rewrite the final artifact, contact third parties, dispatch another agent, or create obligations. Parent explanations are assertions to check, not independent evidence.

## Enforce the release result

Wait for one terminal review outcome for the candidate:

- `PASS`: no material blocker found in the reviewed draft and scope; this does not approve later changes, guarantee feasibility, or grant authority.
- `BLOCK`: do not release the flagged defect in any wording, including disguised deadlines or substituted thresholds. Correct or remove the underlying unsupported claim, commitment, or advice; preserve viable conditional alternatives and useful partial work.
- `UNRESOLVED`: necessary material evidence or access is missing. Do not promote the unverified statement into a fact or commitment. Deliver a grounded conditional or partial result, or seek an owner decision if authority is reserved.

Bind each verdict to the actual reviewed draft. After repair, check the underlying defect, not wording. New or materially changed targets, contract terms, metrics, or authority claims cannot inherit PASS; seek focused re-review when available, otherwise remove or qualify unsupported new claims before release. Reuse unaffected findings, avoid routine loops, and never claim an unrun review.
