---
name: context-sufficiency
description: Verify that enough code context has been gathered before modifying. Checks whether callers, tests, configuration, schema, migrations, and runtime environment have been read before proposing changes. Use when reading code to diagnose, fix, or refactor, and whenever a proposed change is based on reading a subset of files.
---

# Context Sufficiency

Before modifying code, verify that the information gathered is sufficient to support the change. A single file rarely tells the whole story.

## Use when

Use before proposing or making any code change: fixing a bug, refactoring, adding a feature, changing configuration, modifying a schema, or updating dependencies.

Also use when a proposed change is based on reading a single file, or when moving from diagnosis to implementation.

Skip purely cosmetic changes, formatting, and read-only queries that don't propose modifications.

## Main rule

A change is only as safe as the context it was designed against. Before modifying, ask: "What haven't I read that could prove this change wrong?"

## Checklist

**Callers and consumers**

- [ ] Have I read every caller of the function/method/endpoint being changed?
- [ ] Are there consumers in other services, workers, or cron jobs?
- [ ] Does any caller pass null, empty, or edge-case values that my change would break?

**Tests**

- [ ] Have I read the existing tests for this code?
- [ ] Do the tests cover the behavior I'm about to change?
- [ ] Are there integration or end-to-end tests that exercise this path?
- [ ] Would my change make any existing test meaningless?

**Configuration and environment**

- [ ] Have I checked whether this behavior is controlled by configuration, environment variables, or feature flags?
- [ ] Are there different configurations per environment (dev/staging/prod)?
- [ ] Is the runtime environment (Python version, OS, dependencies) consistent with my assumptions?

**Schema and migrations**

- [ ] If this change touches data, have I read the schema and any pending migrations?
- [ ] Are there constraints, indexes, or triggers that my change would violate?
- [ ] Does old data need to be migrated?

**Documentation and contracts**

- [ ] Does any documented API contract, README, or ADR describe the current behavior?
- [ ] Would my change violate a documented guarantee?

## Relation to other skills

`context-sufficiency` is an information gate: it asks whether you've seen enough to act. `scope-safety` asks whether the action is warranted. `side-effect-safety` asks whether the action can be undone. They stack: read enough → decide whether to act → design the action safely.