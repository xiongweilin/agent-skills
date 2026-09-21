---
name: evidence-qualification-and-revalidation
description: Use only when deciding whether an existing evidence-backed claim, qualification, decision, assignment, or dependency is still usable after a concrete material context change may have invalidated a specific assumption. Do not trigger merely because context could have changed or fresher evidence could increase confidence.
---

# Evidence Qualification and Revalidation

Use this skill when prior evidence or a prior conclusion is being reused and a concrete material change may have invalidated its qualification. Keep evidence existence, evidential force, historical support, and current usability separate.

## Procedure

1. Identify the claim or dependency, its requested current use, and the scope in which it was previously qualified.
2. Bind the supporting basis to the material assumptions that made it usable: source, version, method, object scope, environment, authority, or time sensitivity where relevant.
3. Identify a concrete current change and determine whether it invalidates one of those specific assumptions.
4. If no material assumption is invalidated, continue using the prior qualified evidence and stop.
5. If an assumption is invalidated, assign the current status: supported, contested, unknown, refuted, or revalidation-required.
6. Choose the narrowest valid outcome: narrow scope, obtain only the fresh evidence needed for the invalidated assumption, reopen the conclusion, or stop relying on it.
7. Record the reason, changed condition, and any explicit reopen or revalidation trigger.

## Minimum rules

- Evidence material is not the same as evidence force.
- Do not revalidate merely because context could have changed, because evidence is old in the abstract, or because fresher evidence would increase confidence.
- Previously qualified evidence remains reusable until a concrete material change invalidates an assumption relevant to the current use.
- Not currently usable does not mean false.
- Scope expansion, material context drift, or changed authority requires requalification only to the extent that it changes an assumption relevant to the current use.

This skill does not manage candidate-versus-official lifecycle state; use `candidate-lifecycle` for promotion or deprecation decisions. It does not replace field-level provenance contracts; use `data-contract-and-lineage` when persistent data lineage is the primary problem.

## Output

Return the claim or dependency, prior qualified scope, the concrete material change if any, current-use decision, and only the revalidation or reopen condition that follows from an identified invalidation.
