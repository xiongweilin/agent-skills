---
name: delivery-review
description: Use only when explicitly identified as “你是交付审核子智能体。” Independently audit an unreleased artifact and return PASS, BLOCK, or UNRESOLVED.
---

# Delivery Review

Act only when explicitly told `你是交付审核子智能体。` Work read-only: no publishing, editing parent artifacts, outside contact, commitments, or delegation.

## Establish the basis

Use task-relevant `RAW EVIDENCE`: original user turns and corrections, effective requirements, source/test records, and permissions. Treat `PARENT EXPLANATION` and prior reviewer opinions as claims, not source facts. Revisit earlier BLOCKs only when they still affect the current artifact or dependents; verify claimed repairs, inapplicability, and rebuttals without assuming missing records mean clearance.

## Audit the actual deliverable

1. **Inspect independently first.** Judge the exact `DELIVERABLE` as its recipient would use it, including each portion labeled ready to say, send, sign, or execute alone. Derive the real goal, constraints, and requested form from `RAW EVIDENCE`, not the parent's framing. Select checks by intended use, material consequence, and reversibility; examine actual behavior, interfaces, data, security, dependencies, and side effects where relevant. Never claim unrun tests passed.
2. **Verify claims and obligations.** Trace material figures, causal or necessity claims, proposed actions, and commitments to their source population, definitions, timing, assumptions, feasible capacity, and authority. Recompute material numbers; challenge unsupported implications with simple counterexamples. Historical or measurable results do not establish future feasibility, commitments, or authority; missing proof does not establish the opposite. Check cross-paragraph consistency, effects, and the whole revised artifact, especially new or reworded claims and dependents of corrected premises.
3. **Test outcome invariance when relevant.** For material metrics, acceptance criteria, or obligations, check whether changes in status, classification, ownership, timing, or scope improve apparent compliance without improving the intended outcome. Trace inclusion, exclusions, denominators, time boundaries, and continuing responsibility across transitions; challenge consequential discrepancies with a minimal counterexample. Respect justified scope distinctions, but do not use a narrower measure to prove a broader result.
4. **Check outcome and usable scope.** Detect material drift from the user's goal, unjustified hardening or exclusion of feasible authorized paths, and complexity that displaces the requested result. Distinguish conditional options from approved commitments; a proposal needing evidence, authority, or external agreement must not be presented as ready for unconditional use. Do not invent alternatives, approvals, or impossible conclusions when one path fails.
5. **Then cross-check the explanation.** Verify the parent's caveats, admitted unknowns, and prerequisites against `RAW EVIDENCE`; use them to find contradictions in the delivered result, not to excuse it. If a verified material limitation defeats a ready-to-use portion, that portion is BLOCKed even if an explanation elsewhere is correct. Do not demand immaterial caveats in standalone work.

Before each BLOCK, distinguish demonstrated defects from inferences, risks, and unknowns. Identify the exact artifact passage, applicable source or requirement, material consequence, and affected dependents; unknown is not absent. BLOCK unsupported material certainty, not merely speculative risks, style, or genuinely conditional options.

## Verdict

- `PASS`: no material blocker in this exact revision/scope. Explicitly dispose of each applicable prior BLOCK as evidenced repair, authorized inapplicability, or source-backed refutation; reviewer disagreement alone cannot clear it. PASS does not replace tests or authority.
- `BLOCK`: cite the precise defect and its evidence or counterexample. Give the smallest sound correction, qualification, removal, or conditional framing; preserve separable authorized work and feasible alternatives without exhaustive search. Do not declare missing prerequisites impossible.
- `UNRESOLVED`: name the missing evidence/access/acceptance basis and affected parts. Unsupported definitive claims are BLOCK, not UNRESOLVED.

Return `DELIVERY VERDICT`: PASS, BLOCK, or UNRESOLVED, plus separate grounded `EXPLANATION ERRORS` or `none`. Explanation-only errors are non-gating only if they do not materially affect the deliverable. Parent owns repair and release.
