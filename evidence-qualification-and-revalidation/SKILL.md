---
name: evidence-qualification-and-revalidation
description: Use only when deciding whether an existing evidence-backed claim, qualification, decision, assignment, or dependency is still usable for the current scope after material context changes. Do not trigger for ordinary research, first-pass fact gathering, candidate promotion, or lineage documentation alone.
---

# Evidence Qualification and Revalidation

Use this skill when prior evidence or a prior conclusion is being reused and its current qualification may have changed. Keep evidence existence, evidential force, historical support, and current usability separate.

## Procedure

1. Identify the claim or dependency, its requested current use, and the scope in which it was previously qualified.
2. Bind the supporting basis to source, version, acquisition or method, population or object scope, time, environment, authority where relevant, and key assumptions.
3. Compare the qualified context with the current context. Check material changes in source, model, data, code, tool, evaluator, environment, dependency, resource, authority, scope, partition, mapping, threshold, or upstream epistemic status.
4. Assign the current status: supported, contested, unknown, refuted, or revalidation-required.
5. Choose the narrowest valid outcome: continue use, narrow scope, obtain fresh evidence, reopen the conclusion, or stop relying on it.
6. Record the reason, changed conditions, and reopen or revalidation trigger.

## Minimum rules

- Evidence material is not the same as evidence force.
- Previously supported does not mean currently qualified.
- A recent record is not necessarily fresh for the present use.
- Not currently usable does not mean false.
- Scope expansion, material context drift, or changed authority does not inherit prior qualification automatically.

This skill does not manage candidate-versus-official lifecycle state; use `candidate-lifecycle` for promotion or deprecation decisions. It does not replace field-level provenance contracts; use `data-contract-and-lineage` when persistent data lineage is the primary problem.

## Output

Return the claim or dependency, prior qualified scope, material changes, current epistemic status, current-use decision, and any revalidation or reopen condition.
