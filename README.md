---
document_type: skill-index

[![CI](https://github.com/ratiolin/agent-skills/actions/workflows/ci.yml/badge.svg)](https://github.com/ratiolin/agent-skills/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

document_status: active
knowledge_scope: skill-governance
---

# Agent Skills

A general-purpose skill repository: reusable, selectively loaded procedures and decision protocols for agent work.

Boundaries:

- **Always-applicable scope, authorization, evidence, safety gates, and completion requirements remain in the deployed global AGENTS.md** (the always-loaded runtime rules).
- **Skills may implement the procedures triggered by those global rules, but must not be the sole owner of an always-applicable gate.**
- **Volatile machine-, workspace-, service-, and environment-specific facts remain in their authoritative fact owners and are not duplicated into skills.**

## Current skills

| Skill | Purpose |
| --- | --- |
| `workflow-authority` | Map durable workflow states, actors, approvals, and handoffs |
| `data-contract-and-lineage` | Keep field provenance, state, and version traceable |
| `candidate-lifecycle` | Keep candidate, official, and deprecated versions separate |
| `side-effect-safety` | Control consequential state changes and replacement ordering |
| `privacy-and-sensitive-data-boundary` | Enforce privacy and sensitive-data boundaries |
| `change-closure` | Close durable changes with fresh verification and consistency |
| `pwsh-execution` | Execute robust PowerShell workflows on Windows |
| `chezmoi-management` | Manage dotfiles through chezmoi source files |

## Layout

Each skill is a flat directory with `SKILL.md` and `agents/openai.yaml`:

```text
<skill-name>/
├── SKILL.md
└── agents/
    └── openai.yaml
```

`SKILL.md` frontmatter `name` must match the directory. Catalog descriptions only identify applicability; checklists live in `SKILL.md`.

See `CONTRIBUTING.md` for the admission criteria and the install-copy sync procedure.
