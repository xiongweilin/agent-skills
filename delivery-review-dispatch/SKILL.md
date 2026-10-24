---
name: delivery-review-dispatch
description: Use only when the global AGENTS.md calls for an independent pre-delivery review of a consequential draft. Prepare an evidence-bearing read-only handoff and apply the reviewer outcome before release; do not grant new delegation authority.
---

# Delivery Review Dispatch

Use only after the global delivery-review trigger is met. This skill prepares the handoff and controls reuse; it does not authorize unrelated delegation or turn every routine answer into a review task.

## Prepare the unreleased draft

Review one coherent candidate before it is delivered. A critique after text has already been published cannot retract it. If a response is partly delivered, only still-unpublished content can be gated.

Give the reviewer the actual intended wording, not just the parent's rationale. Include:

- the original user objective, relevant constraints, and required delivery form;
- the entire relevant draft, especially exact customer-facing claims or promises;
- underlying facts and sources, material assumptions and unknowns, plus the authority behind any external commitment;
- the bounded scope and any evidence the reviewer can inspect directly.

Include the exact sentence `你是交付审核子智能体。` in the delegated task and require `delivery-review`. Keep the assignment read-only. The reviewer cannot rewrite the final artifact, contact third parties, dispatch another agent, or create obligations. Parent explanations are assertions to check, not independent evidence.

## Enforce the release result

Wait for one terminal review outcome for the candidate:

- `PASS`: the reviewer found no material release blocker within its inspected scope. This is not a guarantee, proof of real-world feasibility, or new authority.
- `BLOCK`: do not release the flagged defect in any wording, including disguised deadlines or substituted thresholds. Correct or remove the underlying unsupported claim, commitment, or advice; preserve viable conditional alternatives and useful partial work.
- `UNRESOLVED`: necessary material evidence or access is missing. Do not promote the unverified statement into a fact or commitment. Deliver a grounded conditional or partial result, or seek an owner decision if authority is reserved.

After repair, check whether the original factual, metric, feasibility, or authorization defect persists despite paraphrase or a changed threshold. Seek focused re-review for materially substituted claims when available; otherwise withhold unqualified commitments. Reuse unaffected findings, avoid redispatch loops, and never claim an unrun review.
