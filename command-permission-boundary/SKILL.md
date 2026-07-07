---
name: command-permission-boundary
description: Gate command execution by risk level. Classify commands as read-only, reversible, or irreversible. Irreversible commands require approval. Secrets access is never read-only. Use before running any shell command that deletes, installs, modifies lockfiles, accesses secrets, changes git history, connects to external networks, or starts/stops services.
---

# Command Permission Boundary

Not every command the agent can run should be run without asking. This skill classifies risk before execution.

## Use when

Use before running any shell command, especially: destructive operations (rm, delete, drop, truncate), installations (pip install, npm install, apt, brew, scoop), lockfile modifications, git history changes (push --force, reset --hard, rebase), secret or environment variable access, external network calls (curl to unknown hosts), service lifecycle (start, stop, restart), or database migrations.

Skip read-only commands: ls, cat, grep, head, tail, git status, git diff, git log, echo, curl -s (read-only endpoints only), docker ps, df, du --read-only.

Override: even cat, grep, or any read-only command on .env, secret files, SSH keys, production config, or credential files is NOT read-only. It requires explicit approval.

## Risk classification

**Read-only:** no state change. Run freely.
- git status, git log, git diff, ls, cat, grep, head, tail, curl GET, docker ps, df

**Reversible:** changes that can be undone.
- git commit, git branch, docker compose up -d, systemctl restart, chezmoi add

**Irreversible — ask first:** cannot be cleanly undone. Requires explicit user approval before execution.
- git push --force, git reset --hard, rm -rf, docker rm -f, database drop/truncate, firewall changes

**Never without explicit approval:** accessing secrets, modifying auth, changing production config, running commands on remote servers outside scope, installing unverified packages, executing downloaded scripts without review.
- accessing secrets or .env files, modifying SSH keys, changing production config, running commands on remote servers outside scope, installing unverified packages, running downloaded scripts without review

## Checklist

- [ ] What resources does this command affect? (files, services, databases, remote hosts)
- [ ] Is the effect reversible? If not, what's the rollback plan?
- [ ] Is this command within the current task's scope, or expanding it?
- [ ] Does this command need user approval? (If irreversible, the answer is yes.)
- [ ] If this command fails halfway, what state is left behind?

## Relation to other skills

`command-permission-boundary` is an execution gate. `side-effect-safety` designs the operation itself. `scope-safety` checks whether the operation should happen at all. They go in order: scope → permission → execution design.