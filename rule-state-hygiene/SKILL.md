---
name: rule-state-hygiene
description: Keep candidate, official, and deprecated rules separate when writing or editing code, tests, fixtures, configuration, comments, or documentation. Covers preventing mocks, fixtures, temporary workarounds, one-off observations, debug assumptions, and experiment-specific behavior from leaking into production logic or official docs. Use this whenever you add or modify business rules, validation rules, prompts, policies, configs, feature flags, test fixtures, mock behavior, seed data, comments, README claims, migration notes, troubleshooting docs, or any temporary rule that might later be mistaken for supported behavior.
---

# Rule State Hygiene

Codebases decay when temporary material is allowed to look official. A mock response becomes the assumed API contract. A fixture edge case becomes a business rule. A one-off workaround becomes permanent architecture. A debug assumption gets copied into the README. Later, someone relies on it because the repository did not say what state it was in.

This skill is about keeping rule state explicit. Candidate material may be useful, but it must not silently become official. Deprecated material may be historically important, but it must not keep guiding current behavior. Production logic and official docs should only contain rules that are intended, reviewed, and still valid.

## Classify the rule before you preserve it

When adding or changing a rule-like thing, put it into one of three states.

**Candidate** means plausible but not yet accepted. It may come from a single bug, a red-team case, a customer example, a local workaround, a mock fixture, an experiment, or an assistant suggestion. Candidate rules can live in tests, notes, issue comments, experiment files, or clearly marked pending-review sections, but they must not drive production behavior unless guarded as experimental.

**Official** means the rule is intended to govern current behavior. It has a clear source, scope, owner or rationale, and tests that exercise the behavior it claims. Official rules can appear in production code, stable configuration, public documentation, and user-facing claims.

**Deprecated** means the rule used to matter but should no longer guide new behavior. It may remain for migration, compatibility, audit, or historical explanation, but it must be labeled as obsolete and must not be copied forward as current guidance.

If you cannot classify the rule, treat it as candidate.

## Prevent test and mock leakage

Mocks and fixtures are not contracts by default. They are controlled inputs for a test. Do not let their behavior become production truth unless it is separately justified.

Before promoting behavior discovered in a mock, fixture, seed file, or test harness, ask:

- Is this behavior required by the real dependency, or only by our fake?
    
- Would the production system see this input shape?
    
- Is the mock compensating for work the real system would not do?
    
- Does the fixture encode a real invariant or just one convenient scenario?
    
- Is the test asserting the intended rule, or merely the mock’s chosen response?
    

If a mock exists only to make the test pass, keep it local to the test. If a fixture represents a real business rule, name the rule separately and test it outside the fixture that introduced it.

## Do not promote one incident into a general rule

A single observation is not a rule. A single production failure is not an architecture principle. A single successful workaround is not a supported path.

When a one-off case suggests a reusable rule, preserve it as candidate first. Promote it only when it has a clear scope and a reason to apply beyond the original incident. Good promotion evidence includes repeated occurrence, cross-context reproduction, a verified failure mode, an explicit product or business decision, or a test that would fail without the rule.

If the rule only fixes one narrow case, keep it narrow. Do not generalize it into broad validation, global policy, or documentation language that promises more than was verified.

## Keep temporary work visibly temporary

Temporary rules need expiration pressure. If a workaround, flag, compatibility branch, fallback, hardcoded value, or special case is not meant to be permanent, label it where future maintainers will see it.

A temporary rule should usually include:

- why it exists,
    
- what condition lets it be removed,
    
- where the real fix should live,
    
- what risk it carries if left in place.
    

Avoid vague labels like `temporary`, `hack`, or `fix later` without a removal condition. A temporary rule without an exit condition becomes unofficial architecture.

## Keep documentation in the same state as the code

Do not let docs claim official behavior when the code only has a candidate implementation. Do not let README examples depend on fixtures, mocks, local-only flags, or scaffolded behavior without saying so. Do not describe an experiment as a supported feature.

When updating docs, mark the state plainly:

- verified behavior,
    
- mock-only behavior,
    
- experimental behavior,
    
- deprecated behavior,
    
- unsupported or not-yet-connected behavior.
    

Docs are part of the system boundary. A misleading doc can promote a candidate rule just as effectively as code can.

## Promotion checklist

Before moving a candidate rule into production logic or official docs, check:

**Scope.** What exact inputs, users, environments, or workflows does this rule cover?

**Source.** Where did it come from: product decision, real dependency contract, repeated incident, security requirement, regulation, or test-only fixture?

**Evidence.** What verifies it: unit test, integration test, real dependency behavior, replay, baseline comparison, manual approval, or production observation?

**Owner or rationale.** Who or what justifies keeping it?

**Exit condition.** If this is not permanent, when should it be removed?

If these are unclear, keep the rule candidate.

## Deprecation is an active state

Do not leave obsolete rules looking alive. When replacing a rule, remove it when safe. If it must remain, mark it deprecated and prevent new code from depending on it.

A deprecated rule should say:

- what replaced it,
    
- why it is no longer preferred,
    
- whether it is still needed for compatibility,
    
- when it can be deleted.
    

Dead rules are not harmless. They confuse future changes, pollute tests, and make the system appear to support behavior it no longer intends to support.

## When to stop

Stop classifying once the state is clear enough to prevent misuse. Do not build a registry, lifecycle system, or approval process for every small conditional. The goal is not bureaucracy; the goal is to prevent candidate, mock-only, temporary, or deprecated material from being mistaken for current production truth.

For a small local test, a comment may be enough. For production validation, payment logic, user-facing docs, or cross-team behavior, the boundary must be explicit.

## When to skip

Pure internal refactors, formatting changes, local variable renames, and behavior-preserving cleanup usually do not need this skill. Use it when a change creates, changes, documents, tests, or implies a rule that someone might later rely on.