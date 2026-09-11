---
document_type: skill-index


document_status: active
knowledge_scope: skill-governance
---

[![CI](https://github.com/xiongweilin/agent-skills/actions/workflows/ci.yml/badge.svg)](https://github.com/xiongweilin/agent-skills/actions/workflows/ci.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
# Agent Skills

A general-purpose skill repository: reusable, selectively loaded procedures and decision protocols for agent work.

Boundaries:

- **Always-applicable scope, authorization, evidence, safety gates, and completion requirements remain in the deployed global AGENTS.md** (the always-loaded runtime rules).
- **Skills may implement the procedures triggered by those global rules, but must not be the sole owner of an always-applicable gate.**
- **Delegated-agent dispatch prompting is routed by the global AGENTS.md to `delegation-prompt-guard`; the detailed procedure lives in that skill.**
- **Volatile machine-, workspace-, service-, and environment-specific facts remain in their authoritative fact owners and are not duplicated into skills.**

## Current skills

| Skill | Purpose |
| --- | --- |
| `workflow-authority` | Map durable workflow states, actors, approvals, and handoffs |
| `data-contract-and-lineage` | Keep field provenance, state, and version traceable |
| `evidence-qualification-and-revalidation` | Recheck whether prior evidence and conclusions remain usable in the current scope |
| `candidate-lifecycle` | Keep candidate, official, and deprecated versions separate |
| `side-effect-safety` | Control consequential state changes and replacement ordering |
| `change-closure` | Close durable changes with fresh verification and consistency |
| `delegation-prompt-guard` | Prepare and guard delegated-agent dispatch prompts |
| `development-verification` | Independently verify one complex development episode and return PASS, FAIL, or REOPEN |
| `system-reliability-review` | Review common-mode failure, recovery independence, lock-in, reauthorization, and maneuverability |
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

