---
name: change-closure
description: Use only after a user-authorized durable change has been made or when completion verification is requested. Check fresh verification, affected contract surfaces, stale identifiers, authoritative records, and intentional leftovers. Do not trigger for read-only analysis or drafts.
---

# Change Closure

Use this checklist only after an authorized durable change or an explicit request to verify completion. Do not reopen the whole design unless a check fails.

## Closure checks

- **Fresh proof:** run the smallest relevant test, diff, exit-status, endpoint, or file check.
- **Contract sync:** update only the README, API/config docs, schemas, tests, or records affected by the change.
- **Stale-reference sweep:** search active code, configuration, and documentation for removed or renamed identifiers.
- **Authoritative record:** update the owning fact source; do not create a competing mutable copy.
- **Leftovers:** list any unresolved decision or external/manual step.

## Success signal

A reviewer can see the fresh checks, affected surfaces, stale-reference result, and intentional leftovers without reading a general risk essay.
