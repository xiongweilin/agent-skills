---
document_type: skill-index

document_status: active
knowledge_scope: skill-governance
---

[![CI](https://github.com/xiongweilin/agent-skills/actions/workflows/ci.yml/badge.svg)](https://github.com/xiongweilin/agent-skills/actions/workflows/ci.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

# Agent Skills

Reusable engineering procedures and decision protocols for agent work.

This repository is not a collection of role prompts or persona templates. Each skill packages a bounded procedure for a recurring engineering problem: preserving authority boundaries, tracking provenance, qualifying evidence, controlling side effects, closing changes with fresh verification, dispatching independent testing, or operating reliably in a concrete tool environment.

The goal is to make repeatable engineering discipline selectively loadable without moving always-applicable safety or authorization rules out of the global runtime policy.

## Why skills exist

Long global instruction files create two opposite problems:

- if every procedure is always loaded, operational guidance becomes noisy and hard to maintain;
- if critical rules live only in optional skills, an agent can miss a safety, authorization, evidence, or completion gate entirely.

This repository therefore separates **always-on gates** from **on-demand procedures**.

```text
global AGENTS.md
= scope / authorization / evidence / safety / completion rules that must always apply

skill
= the detailed procedure used when one of those rules activates
```

A skill may implement a gate's procedure, but it must not be the sole owner of an always-applicable gate.

## What problems the skills prevent

Examples:

- treating a historical conclusion as currently qualified evidence;
- losing field provenance while data moves across systems;
- collapsing candidate, official, and deprecated states into one version;
- performing a consequential replacement before the new state is verified;
- declaring a repository or deployment change complete based only on the edit result;
- asking a delegated agent to act without enough scope, authority, or return-contract context;
- accepting a candidate because its author also tested it;
- building recovery paths that share the same failure mode as the primary path;
- turning machine-specific facts into supposedly reusable policy.

The skills are intended to reduce those failure modes through explicit procedures, not through model personality shaping.

## Governance boundary

- **Always-applicable scope, authorization, evidence, safety gates, and completion requirements remain in the deployed global `AGENTS.md`.**
- **Skills may implement procedures triggered by those global rules, but must not be the sole owner of an always-applicable gate.**
- **Delegated-agent dispatch prompting is routed by the global `AGENTS.md` to `delegation-prompt-guard`; the detailed procedure lives in that skill.**
- **Volatile machine-, workspace-, service-, and environment-specific facts remain in their authoritative fact owners and are not duplicated into skills.**

`codex-agents-md/AGENTS.md` is the source for the deployed global Codex guidance. Run [`codex-agents-md/sync-codex-agents.ps1`](codex-agents-md/sync-codex-agents.ps1) to synchronize the deployed copy.

## Current skills

| Skill | Engineering purpose |
| --- | --- |
| `workflow-authority` | Map workflow states, actors, approvals, and handoffs without treating workflow progress as implicit authority |
| `data-contract-and-lineage` | Keep field provenance, state, ownership, and version traceable across transformations |
| `evidence-qualification-and-revalidation` | Recheck whether prior evidence and conclusions remain usable in the current scope |
| `candidate-lifecycle` | Keep candidate, official, superseded, and deprecated versions distinct |
| `side-effect-safety` | Bound consequential state changes, replacement order, and verification around effects |
| `change-closure` | Require fresh verification and cross-surface consistency before declaring a durable change complete |
| `delegation-prompt-guard` | Prepare delegated-agent work with explicit scope, authority, constraints, and return expectations |
| `independent-testing-dispatch` | Define an independent-testing handoff and decide whether later repairs invalidate the prior test basis |
| `independent-testing` | Test one bounded candidate independently and preserve a reusable verification basis |
| `system-reliability-review` | Review common-mode failure, recovery independence, lock-in, reauthorization, and maneuverability |
| `pwsh-execution` | Execute robust PowerShell workflows while avoiding shell-specific parsing and state mistakes |
| `chezmoi-management` | Manage dotfiles through authoritative chezmoi source files rather than editing generated copies |

## Layout

Each skill is a flat directory with `SKILL.md` and `agents/openai.yaml`:

```text
<skill-name>/
├── SKILL.md
└── agents/
    └── openai.yaml
```

`SKILL.md` frontmatter `name` must match the directory. Catalog descriptions identify applicability; procedural checklists live in `SKILL.md`.

Repository CI validates the skill structure and local documentation links so the catalog cannot silently drift away from its executable procedure files.

See `CONTRIBUTING.md` for admission criteria and the install-copy synchronization procedure.
