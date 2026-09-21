---
name: chezmoi-management
description: "Manage dotfiles through chezmoi source files. Use when a change touches chezmoi-managed files, including AGENTS.md: edit the source first, apply to the runtime copy, perform one canonical synchronization check, then commit and push when that managed-file workflow authorizes it."
---

# Chezmoi Management

chezmoi-managed files (including the global AGENTS.md) have one fact owner: the source file in the chezmoi source directory. Editing the runtime copy directly creates a competing owner.

The synchronization and repository steps below are managed-file closure, not optional general self-review. They remain required when this skill applies, but do not justify duplicate checks of the same synchronization fact.

## Use when

Use when a change touches a chezmoi-managed file (e.g. `.codex/AGENTS.md`), or when you need to locate how a managed runtime file is sourced. For read-only source-location requests, do not apply, commit, or push.

## Method

1. **Edit the source.** Locate the managed path under the source root (e.g. `.codex/AGENTS.md` → `dot_codex/AGENTS.md`) and edit the source file only.
2. **Apply to the runtime copy.** Run `chezmoi apply` so the runtime copy is regenerated from the source. Non-interactive runs may block on the prompt "…has changed since chezmoi last wrote it?" — use `chezmoi apply --force` when the authorized workflow requires overwriting the managed destination.
3. **Check synchronization once.** Use one canonical check that directly establishes that the managed destination now matches the intended source state. Do not stack hash, diff, and managed-list checks to reconfirm the same fact.
4. **Commit and push when required by the applicable managed-file workflow.** Do not infer repository publication authority from a read-only request.

## Success signal

The runtime copy was regenerated from its authoritative source, one synchronization check established the intended state, and any required repository publication step was completed.
