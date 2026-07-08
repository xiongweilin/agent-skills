---
name: skill-orchestrator
description: Route complex tasks through the correct governance skill chain.
  Use when facing a multi-step task involving state changes, external effects,
  authorization questions, or persistent additions — any situation where
  multiple operational-judgment skills should fire in order. Classifies the
  scenario and activates the appropriate path.
---

# Skill Orchestrator

Governance skills each protect one boundary. This skill routes a complex task
through the right sequence of boundaries, in the right order, with the right
skip conditions.

## Use when

The task involves any of: persistent additions (new deps, services, configs,
automations), state changes with external effects, authorization or
responsibility questions, multi-step workflows across system boundaries, or
decisions where the wrong sequence would skip a necessary gate.

Skip for: pure reads, formatting, one-line fixes with no side effects, simple
questions, and tasks fully covered by a single skill.

## Preliminary gate: scope-safety

scope-safety fires FIRST on every path. Before any other skill activates,
answer:

- Capacity (能不能): does the system have headroom? What does this displace?
  What ongoing cost does it impose? What is the retirement condition?
- Warrant (好不好): is the evidence measured or inferred? Is the claim marked
  candidate or official? Who bears the consequence if wrong?

Any failing item: downgrade to candidate, add evidence, set rollback/retirement
condition, or block.

## Scenario routing

### Path A: Code modification

Triggers: editing source code, changing configuration, modifying schemas,
adding dependencies.

```
scope-safety (gate)
  → context-sufficiency (have we read enough?)
  → command-permission-boundary (risk-classify every shell command)
  → verification-before-completion (fresh evidence before claiming done)
```

Skip conditions:
- Pure formatting, comment-only changes → skip context-sufficiency
- Read-only queries with no shell commands → skip command-permission-boundary

### Path B: Business / agent workflow

Triggers: designing or modifying RPA, ERP, CRM, BI, approval flows, agentic
operations, customer-facing automation, or any workflow with durable state.

```
scope-safety (gate)
  → workflow-decomposition (states, actors, guards, side effects, exceptions)
  → authorization-map (who proposes, validates, approves, executes, vetoes)
  → side-effect-safety (idempotency, compensation, atomic transitions)
  → data-contract-and-lineage (field source, state, lineage, use-limit)
```

Skip conditions:
- No external writes → skip side-effect-safety
- No data transformation → skip data-contract-and-lineage

### Path C: Rules / policy / config change

Triggers: business rules, validation rules, prompts, feature flags, configs,
fixtures, mock behavior, documentation that describes supported behavior.

```
scope-safety (gate)
  → judgment-ownership (ONLY if strategic, architectural, or value-laden)
  → rule-state-hygiene (candidate / official / deprecated)
  → rollout-and-promotion (draft → candidate → frozen → scored → promoted)
```

Skip conditions:
- Pure implementation of an already-decided rule → skip judgment-ownership
- Local-only config with no promotion path → skip rollout-and-promotion

### Path D: Recurring small exceptions

Triggers: the Nth instance of the same pattern — another skipped test, loosened
assertion, lowered threshold, special-case branch, or "fix later" on the same
theme.

```
scope-safety (gate)
  → incremental-erosion (name the pattern, decide: fix now or track)
  → rule-state-hygiene (mark temporary rules, set exit conditions)
```

### Path E: Privacy / sensitive data

Triggers: any task touching user-submitted text, PII, secrets, external API
calls carrying data, screenshots, or error reports. Can combine with any other
path.

```
privacy-and-sensitive-data-boundary (evaluate data classification at each boundary)
```

This path runs alongside A, B, C, or D when data sensitivity is present.

## Output

For each skill in the activated path, record the result at the level dictated
by `references/output-format.md`:

- L0/L1: one line in commentary
- L2: affected_resources, approval_required, rollback/verification
- L3/L4: full structured record

Classify severity per `references/severity-matrix.md`. The severity label
applies to the specific action, not the whole task.

## Success signal

At the end of a routed task, a reader can see which path was taken, which
skills fired, what each found, and what severity each action carried — without
needing to re-read the full conversation.
