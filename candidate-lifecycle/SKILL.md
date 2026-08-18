---
name: candidate-lifecycle
description: Use only when a candidate, experimental, official, deprecated, or promoted rule, prompt, model, dataset, threshold, workflow, or configuration is being evaluated or transitioned. Do not trigger for ordinary implementation, testing, deployment, or configuration edits.
---

# Candidate Lifecycle

Use this skill only when an artifact has a candidate-versus-official decision. Keep lifecycle state separate from evidence state and from ordinary implementation status.

## Procedure

1. Classify the artifact and its current state: draft, candidate, frozen, scored, official, unpromoted, deprecated, or archived.
2. Bind the decision to the relevant version, scope, evaluation evidence, owner, deadline, budget, and stop conditions.
3. Choose one transition: promote, narrow, reject, archive, deprecate, or escalate.
4. Update the affected documentation and prevent the old state from silently guiding new work.

Evidence that is merely insufficient does not make a candidate official, and a single successful run does not prove promotion.

## Output

Return the current state, evidence and scope, chosen transition, owner, and any remaining revalidation or migration condition.
