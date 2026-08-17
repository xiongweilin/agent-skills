---
name: chezmoi-management
description: Manage dotfiles through chezmoi source files. Use when a change touches chezmoi-managed files, including AGENTS.md: edit the source first, apply to the runtime copy, verify no diff, then commit and push.
---

# Chezmoi Management

chezmoi-managed files (including the global AGENTS.md) have one fact owner: the source file in the chezmoi source directory. Editing the runtime copy directly creates a competing owner.

## Use when

Use when a change touches a chezmoi-managed file (e.g. `.dsh/AGENTS.md`), or when you need to locate how a managed runtime file is sourced.

## Method

1. **Edit the source.** Locate the managed path under the source root (e.g. `.dsh/AGENTS.md` → `dot_dsh/AGENTS.md`) and edit the source file only.
2. **Apply to the runtime copy.** Run `chezmoi apply` so the runtime copy is regenerated from the source.
3. **Verify no diff.** Confirm the runtime copy matches the source (identical hashes) and `chezmoi managed` agrees.
4. **Commit and push.** The source directory is its own git repository; commit and push the change there.

## Success signal

The runtime copy was regenerated from the source, matches it exactly, and the source repository carries the committed change.
