---
name: scope-safety
description: Evaluate capacity, maintenance burden, retirement conditions, dependency supply-chain risk, and evidence warrant before persistent additions or durable factual claims. Use for new services, dependencies, automations, rules, metrics, configurations, or claims that outlive the task; do not trigger for ordinary local edits or read-only analysis already covered by AGENTS.
---

# Scope Safety

Apply this skill only when a change or claim will persist beyond the current
task. AGENTS already owns general change intent, command permission, and
completion verification.

## Persistent addition gate

For each proposed addition, record:

- **Resource:** compute, storage, attention, maintenance, dependency, or policy
  surface it consumes.
- **Displacement:** what becomes harder to operate, replace, or understand.
- **Owner and cost:** who maintains it and what recurring work it creates.
- **Retirement:** review date, stop condition, removal path, and evidence that
  cleanup can be completed.
- **Blast radius:** failure domain, affected users or systems, and rollback.

If any item is unknown, narrow the proposal, keep it candidate, gather evidence,
or stop.

## Durable claim gate

Before writing an observation as an official fact, identify:

- whether evidence is measured, inferred, or model-generated;
- whether the metric or fact source was itself validated;
- whether the claim is candidate or official;
- who bears the consequence if it is wrong;
- whether the justification is circular.

## Dependency supply chain

Before adding a dependency, verify necessity, existing alternatives, version and
compatibility, maintenance status, license, transitive risk, runtime surface,
and removal cost. Do not add a dependency merely to avoid a small local
implementation.

## Output

Keep the result compact: affected resource, evidence status, owner, rollback,
retirement condition, and decision (`proceed`, `narrow`, `candidate`, or
`stop`).

## Relations

Use `authorization-map` for who may decide, `side-effect-safety` for execution
design, `rule-state-hygiene` for candidate versus official rules, and
`incremental-erosion` when the same exception recurs.
