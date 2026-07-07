---
name: rule-state-hygiene
description: Keep candidate, official, and deprecated rules separate when writing or editing code, tests, fixtures, configuration, comments, or documentation. Prevent mocks, fixtures, temporary workarounds, one-off observations, debug assumptions, and experiment-specific behavior from leaking into production logic or official docs.
---

# Rule State Hygiene

Codebases decay when temporary material is allowed to look official. A mock response becomes the assumed API contract. A fixture edge case becomes a business rule. A workaround becomes architecture. This skill keeps rule state explicit.

## Use when

Use when adding or modifying business rules, validation rules, prompts, policies, configs, feature flags, test fixtures, mock behavior, seed data, comments, README claims, migration notes, troubleshooting docs, or temporary rules that might later be mistaken for supported behavior.

Skip pure refactors, formatting, local variable renames, and behavior-preserving cleanup.

## Rule states

**Candidate:** plausible but not accepted. It may come from a bug, red-team case, customer example, local workaround, mock fixture, experiment, or assistant suggestion. Candidate rules must not drive production behavior unless guarded as experimental.

**Official:** intended to govern current behavior. It has a clear source, scope, owner or rationale, and tests that exercise the behavior it claims.

**Deprecated:** used to matter but should no longer guide new behavior. It may remain for migration, compatibility, audit, or history, but must be labeled obsolete and kept from new dependencies.

If you cannot classify the rule, treat it as candidate.

## Checks

Before promoting a rule, identify scope, source, evidence, owner or rationale, and exit condition if temporary.

Mocks and fixtures are not contracts by default. A single incident is not a general rule. Temporary work needs a removal condition. Documentation must match the same rule state as the code.
