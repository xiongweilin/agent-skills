---
name: chezmoi-management
description: "Use for files actually tracked by chezmoi or to locate the source of a tracked runtime file. The deployed global AGENTS.md is not tracked by chezmoi."
---

# Chezmoi Management

Chezmoi owns only files it actually tracks. The deployed global Codex `AGENTS.md` is not tracked by chezmoi; its source is `codex-agents-md/AGENTS.md`, and `codex-agents-md/sync-codex-agents.ps1` synchronizes the runtime copy. Do not treat global `AGENTS.md` as a chezmoi-managed file or run `chezmoi apply` for it.

The synchronization and repository steps below are managed-file closure, not optional general self-review. They remain required when this skill applies, but do not justify duplicate checks of the same synchronization fact.

## Use when

Use when a change touches a file known to be tracked by chezmoi, or when you need to locate the source of a tracked runtime file. The deployed global Codex `AGENTS.md` is outside the scope of this skill. For read-only source-location requests, do not apply, commit, or push.

## Method

1. **Edit the source.** Locate the exact tracked path under the chezmoi source root and edit its source file only; do not guess the source path or edit the runtime copy.
2. **Apply to the runtime copy.** Run `chezmoi apply` so the runtime copy is regenerated from the source. Non-interactive runs may block on the prompt "…has changed since chezmoi last wrote it?" — use `chezmoi apply --force` when the authorized workflow requires overwriting the managed destination.
3. **Check synchronization once.** Use one canonical check that directly establishes that the managed destination now matches the intended source state. Do not stack hash, diff, and managed-list checks to reconfirm the same fact.
4. **Commit and push when required by the applicable managed-file workflow.** Do not infer repository publication authority from a read-only request.

## Success signal

The runtime copy was regenerated from its authoritative source, one synchronization check established the intended state, and any required repository publication step was completed.
