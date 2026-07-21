---
name: rule-state-hygiene
description: Keep candidate, official, and deprecated rules separate. Use only when mocks, fixtures, experiments, temporary workarounds, one-off observations, debug assumptions, or provisional policies could be mistaken for supported production behavior or official documentation. Do not trigger for ordinary code, test, configuration, or documentation changes with no rule-state ambiguity.
---

# Rule State Hygiene

Codebases decay when temporary material is allowed to look official. A mock response becomes the assumed API contract. A fixture edge case becomes a business rule. A workaround becomes architecture. This skill keeps rule state explicit.

## Use when

Use when a business rule, validation rule, prompt, policy, config, feature flag, fixture, mock, seed, comment, README claim, migration note, troubleshooting note, or temporary workaround could be mistaken for supported behavior.

Skip ordinary code, test, configuration, and documentation changes with no candidate-versus-official ambiguity, plus pure refactors, formatting, renames, and behavior-preserving cleanup.

## Rule states

**Candidate:** plausible but not accepted. It may come from a bug, red-team case, customer example, local workaround, mock fixture, experiment, or assistant suggestion. Candidate rules must not drive production behavior unless guarded as experimental.

**Official:** intended to govern current behavior. It has a clear source, scope, owner or rationale, and tests that exercise the behavior it claims.

**Deprecated:** used to matter but should no longer guide new behavior. It may remain for migration, compatibility, audit, or history, but must be labeled obsolete and kept from new dependencies.

If you cannot classify the rule, treat it as candidate.

## Checks

Before promoting a rule, identify scope, source, evidence, owner or rationale, and exit condition if temporary.

Mocks and fixtures are not contracts by default. A single incident is not a general rule. Temporary work needs a removal condition. Documentation must match the same rule state as the code.

`Official` is the state reached after a successful promotion governed by
`rollout-and-promotion`; `promoted` names that transition, not another state.
