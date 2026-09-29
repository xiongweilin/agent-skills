---
name: candidate-lifecycle
description: Use only when a candidate, experimental, official, deprecated, or promoted rule, prompt, model, dataset, threshold, workflow, or configuration is being evaluated or transitioned. Do not trigger for ordinary implementation, testing, deployment, or configuration edits.
---

# Candidate Lifecycle

Use this skill only when an artifact has a candidate-versus-authoritative lifecycle decision. Keep lifecycle state separate from evidence state and from ordinary implementation status.

## Procedure

1. Read the artifact's authoritative domain lifecycle and identify only the state distinctions that materially affect the current use or transition. Do not impose a universal lifecycle taxonomy. Where those distinctions exist, do not silently collapse candidate, currently authoritative, superseded, or deprecated states.
2. Bind the decision to the relevant version, scope, evaluation evidence, owner, deadline, budget, and stop conditions.
3. Choose only a transition supported by the authoritative lifecycle, such as promotion, narrowing, rejection, archival, deprecation, or escalation where those transitions actually exist.
4. Update the affected documentation and prevent a no-longer-authoritative state from silently guiding new work.

Evidence that is merely insufficient does not make a candidate authoritative, and a single successful run does not prove promotion.

## Output

Return the current domain-defined state, evidence and scope, chosen transition, owner, and any remaining revalidation or migration condition.
