---
name: workflow-authority
description: Use only before designing or materially changing a durable workflow with multiple actors, human approval, delegated authority, retries, or external side effects. Do not trigger for ordinary functions, single-owner edits, simple reads, or routine API changes.
---

# Workflow Authority

Use this skill to produce a compact workflow map when state, authority, and responsibility cross actor or system boundaries. Do not turn ordinary implementation into a governance exercise.

## Procedure

1. Identify the trigger, inputs, states, terminal states, retryable states, and invalid transitions.
2. Map proposal, validation, approval, execution, veto, affected subjects, compensation, accountability, and audit ownership.
3. Mark human nodes, automated nodes, deterministic guards, external effects, and exception paths.
4. Name the evidence and metrics needed to prove each important transition.

Models and rules may propose, classify, validate, and route. They do not grant authority or own irreversible transitions.

## Output

Return one compact state/actor map and list the owner of each transition. Do not add general governance theory or redesign unrelated parts of the system.
