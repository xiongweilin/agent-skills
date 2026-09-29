---
name: workflow-authority
description: Use only before designing or materially changing a durable workflow with multiple actors, human approval, delegated authority, retries, or external side effects. Do not trigger for ordinary functions, single-owner edits, simple reads, or routine API changes.
---

# Workflow Authority

Use this skill to produce a compact workflow map when state, authority, and responsibility cross actor or system boundaries. Do not turn ordinary implementation into a governance exercise.

## Procedure

1. Identify the trigger, inputs, states, terminal states, retryable states, and invalid transitions.
2. When the difference materially affects control, legitimacy, or failure handling, distinguish who defines candidates, rules, or standards; who judges sufficiency; who decides; who authorizes; who executes; who verifies; and who can stop, recover, or reopen. Do not split roles that are operationally identical for the current workflow.
3. Map only the approvals, vetoes, affected subjects, handoffs, compensation, accountability, and audit ownership that materially affect those transitions.
4. Mark human nodes, automated nodes, deterministic guards, external effects, and exception paths.
5. Name the evidence and metrics needed to establish each important transition.

Models and rules may propose, classify, validate, and route. They do not grant authority or own irreversible transitions.

## Output

Return one compact state/actor map and list the owner of each materially distinct transition or control position. Do not add general governance theory or redesign unrelated parts of the system.
