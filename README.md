---
document_type: skill-index
document_status: active
knowledge_scope: skill-governance
---

# Operational Judgment Skills

This repository holds a set of judgment-type skills for agents, automation, business processes, and engineering delivery. They do not cover every coding task; they only handle boundaries that models, process tooling, or a local engineering perspective tend to underestimate: authorization, responsibility, data lineage, rule state, external side effects, candidate promotion, privacy, and the ownership of user judgment.

Always-applicable task scope, context sufficiency, durable-change gates, command permissions, and completion verification are owned by the deployed global AGENTS.md (the always-loaded runtime rules) and are not repeated in this repository.

## Current skills

| Skill | Coverage | Trigger | Boundary |
| --- | --- | --- | --- |
| `authorization-map` | Authorization, approval, veto, responsibility, compensation, affected parties | Actions that cross actors and change state or produce external consequences, where approval/veto/accountability ownership is unclear | Not for ordinary code review, read-only analysis, private drafts, or reversible local edits with a single clear owner |
| `data-contract-and-lineage` | Field contracts, provenance, state, version, evidence, usage limits | Persistent or decision-relevant data across models, rules, people, and systems that must keep provenance/state/evidence/version | Not for throwaway drafts, ordinary in-memory structures, or simple schema work with no lineage ambiguity |
| `judgment-ownership` | User judgment frames, evidence seams, remaining decision points | Strategy, architecture, positioning, naming, taste, route, or priority tradeoffs that facts and tests cannot decide | Not for factual lookup, formatting, low-risk edits, or implementation with clear acceptance criteria |
| `rollout-and-promotion` | Candidate-to-official promotion, freeze, scoring, deprecation, public claims | A persisted candidate is being frozen, scored, promoted, rejected, deprecated, or prepared to support a production/public claim | Not for ordinary implementation, local experiments, routine deployment, or config changes with no candidate/official decision |
| `rule-state-hygiene` | Separation of candidate / official / deprecated rules | Mocks, fixtures, experiments, temporary workarounds, or one-off observations could be mistaken for official rules | Not for ordinary code, tests, config, or doc changes with no rule-state ambiguity |
| `side-effect-safety` | State-change side effects, idempotency, compensation, rollback, explicit failure | DB writes, sends, publishes, deletes, migrations, external API writes, queue publishes, infrastructure changes | Not for pure reads, pure computation, or reversible local edits |
| `workflow-decomposition` | Business/agent workflow inputs, state machines, human nodes, guards, side effects, exceptions, evidence, metrics | Cross-system flows with persistent state, multiple actors, authorization, retries, human review, or external side effects | Not for ordinary functions, single-service request flows, simple reads, or one-off scripts |
| `privacy-and-sensitive-data-boundary` | PII, log redaction, screenshot privacy, third-party egress, training-data isolation, minimal necessary access, retention | Tasks that may read, record, screenshot, transmit, or retain secrets, PII, user content, or business-sensitive values | Not triggered by ordinary external APIs, non-sensitive screenshots, or system-metric reads |
| `interaction` | Confirmation before understanding/execution; restate and confirm when scope, meaning, or authorization is uncertain | Non-execution verbs (think/propose/discuss) yet about to change state; self-narrowing or self-expanding of qualifiers the user did not state; durable/cross-workspace/external/hard-to-reverse consequences | Not for tasks with explicit instructions, low risk, reversibility, and unambiguous scope; do not bounce every decision back to the user |

## Composition

### General execution gate

Pre-modification context checks, durable-addition ownership and retirement judgment, command permissions, and completion verification follow the deployed global AGENTS.md directly. Those rules are always loaded and are not re-injected through separate skills. `interaction` does not re-inject that gate; it carries the trigger conditions and output checklist explicitly referenced by the interaction prompt (prompt text: "Trigger conditions and checklist: see the interaction skill", moved from AGENTS.md to the fifth-mode anchored-minimal persona on 2026-08-15), a division of "prompt = principle, skill = operational detail".

### Privacy / sensitive data

Use `privacy-and-sensitive-data-boundary` only when external APIs, screenshots, logs, error reports, or data processing may expose secrets, PII, user content, or business-sensitive values. It can run in parallel with any other path.

### External closed-loop capabilities

The following capabilities come from higher-priority reserved or on-demand skills and are not copied into this repository:

- `api-and-interface-design`: public interface compatibility and deprecation.
- `observability-and-instrumentation`: production runtime evidence.
- `security-best-practices` / `security-threat-model`: secure coding and threat modeling.
- `documentation-and-adrs`: decision records.

### Business or agent flows

1. Use `workflow-decomposition` only when the flow has persistent state, multiple actors, authorization, retries, human review, or external side effects.
2. Layer `authorization-map` only when an action changes state or has external consequences and approval/veto/affected-party/accountability ownership is unclear.
3. Layer `data-contract-and-lineage` only when persistent or decision-relevant fields cross models, rules, people, and systems and need provenance, state, evidence, or version.
4. Layer `side-effect-safety` only when the flow writes, sends, publishes, deletes, migrates, or changes external state.
5. Layer `rollout-and-promotion` only when a persisted candidate is being frozen, scored, promoted, rejected, deprecated, or prepared to support an official claim.

### Rule, policy, fixture, prompt, or documentation changes

1. Use `judgment-ownership` only when facts and tests cannot decide strategy, taste, architecture, positioning, or priority tradeoffs.
2. Use `rule-state-hygiene` only when temporary, experimental, mock, fixture, or one-off material could be mistaken for official rules.
3. Use `data-contract-and-lineage` only when official claims need traceable evidence, datasets, prompts, thresholds, offsets, or versioned artifacts.
4. Use `rollout-and-promotion` only when a candidate is becoming official behavior or supporting a production/public claim.

### Repeated small exceptions

1. When the same kind of workaround, weak assertion, skipped check, special branch, lowered threshold, or deferred fix recurs, record it as a candidate observation.
2. Use `rule-state-hygiene` so the workaround is not silently treated as an official rule.
3. If lowering the bar affects quality claims, use `rollout-and-promotion`.

## Quality bar

A skill should stay in this repository only if it satisfies all of the following:

- The boundary it protects repeatedly causes real risk, rework, false claims, wrong writes, wrong authorization, or responsibility confusion.
- Its triggers are specific enough not to drag low-risk tasks into heavy process.
- Its body provides executable checks and turns abstract value into operational conditions.
- Its boundary with current agent-runtime built-ins, plugins, and external high-priority skills is clear.
- It does not duplicate higher-priority skills; unless it has a narrower operational-judgment angle the other does not cover.
- It has `agents/openai.yaml` metadata matching `SKILL.md`.

## Maintenance rules

- When coverage overlaps, prefer deletion or narrowing to stacking more.
- If a new external skill replaces one here, delete the local skill and update this README.
- If a skill overlaps but must stay, document the boundary in the README and the skill description.
- Keep `SKILL.md` short; move long material into `references/` when reusable.
- With this repository as the install source, sync changes to the current agent runtime's skills install directory.
- After modifying a skill, check git status and confirm the installed copy matches the source.
- Third-party skills keep their upstream origin and are not copied here; local generic increments go into AGENTS or an owned skill.
- The deployed global AGENTS.md is separately maintained, always-loaded runtime rules; this repository no longer keeps a versioned copy of it. It is not a skill and does not count toward the skill count.

## Directory structure

Each skill uses a standard skill directory layout:

~~~text
<skill-name>/
├── SKILL.md
└── agents/
    └── openai.yaml
~~~

The repository README only explains how this set of operational-judgment skills fits into the current larger local skill system; it carries no skill trigger content.
