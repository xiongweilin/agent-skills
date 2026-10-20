# Contributing

This repository is a personal collection of reusable agent skills. New or modified skills must satisfy the admission criteria and synchronization workflow.

## Admission criteria (new or modified skill)

A new skill must satisfy all conditions:

1. **Narrow, explicit trigger**: distinguish when it should fire from when it should not; do not pull low-risk tasks into a heavy process.
2. **Solves a recurring problem**: it is not the institutionalization of a one-off experience or a single observation.
3. **Provides a practically executable method**: it is not a restatement of an existing AGENTS.md rule in different words.
4. **Does not own an always-applicable gate**: authorization, scope, evidence, and completion gates remain in the deployed AGENTS.md; a skill can only implement their procedure.
5. **Does not duplicate environment facts owned by a fact owner**: hosts, paths, proxies, versions, deployment locations, and other volatile or machine-specific facts stay with their authoritative fact owner, not in the skill body.
6. **Has a clear boundary with existing skills**: when scopes overlap, extend or narrow an existing skill instead of stacking a new one.
7. **Ships matching runtime metadata**: `agents/openai.yaml` matches the name/description in `SKILL.md`; the catalog description only identifies applicability, not the procedure.
8. **Is followed by a consistency check**: update the README skill table; check the catalog, installed copies, and identifiers for consistency.

## Directory shape

```text
<skill-name>/
├── SKILL.md
└── agents/
    └── openai.yaml
```

Keep `SKILL.md` short; put reusable details in `references/` rather than inflating the main file.

## Synchronizing installed copies

When this repository is the installation source, synchronize changes to the current agent runtime's installed skills directory (for example `~/.codex/skills/` or the OpenCode skills directory synchronized by `sync-opencode-agents.ps1`), and verify that installed copies match the source files by hash.

The global `AGENTS.md` is owned by `codex-agents-md/`. After changes, run `codex-agents-md\sync-codex-agents.ps1` to synchronize the source to `C:\Users\metra\.codex\AGENTS.md` and verify the hash; the global runtime copy is no longer tracked by chezmoi.

## Language rules

- Skill files and runtime metadata are English-only, except exact trigger phrases or protocol literals that must remain verbatim. Do not add `SKILL.zh-CN.md` or other per-skill translated copies.
- Public repository documents are paired: an English canonical `*.md` file with a Chinese `*.zh-CN.md` file. `LICENSE`, third-party content, and generated content are exempt.
- First-party full-line code comments use Chinese. Inline comments, docstrings, and API documentation are exempt and stay in their existing language.

## Commit conventions

- Make small commits; the commit message explains the change (the repository history uses short-sentence style, for example `Narrow governance skill triggers`).
- Do not commit secrets, PII, or sensitive business samples; always use placeholders in examples.
- Before merging, run `.github/scripts/validate_structure.py` locally; CI runs structure validation and local link checking on pushes to main and on pull requests.
