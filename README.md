---
document_type: skill-index
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
| `interaction` | Resolve scope or authorization ambiguity before acting |
| `authorization-map` | Map approval, veto, responsibility, and affected parties |
| `judgment-ownership` | Keep the user's frame and judgment visible |
| `data-contract-and-lineage` | Keep field provenance, state, and version traceable |
| `rollout-and-promotion` | Govern candidate-to-official transitions |
| `rule-state-hygiene` | Keep candidate, official, and deprecated rules separate |
| `side-effect-safety` | Control consequential state changes and replacement ordering |
| `privacy-and-sensitive-data-boundary` | Enforce privacy and sensitive-data boundaries |
| `workflow-decomposition` | Decompose durable multi-actor workflows |
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
