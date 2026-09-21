---
name: change-closure
description: Use only after an explicit request to verify completion or when an applicable safety, contract, or lifecycle gate explicitly requires closure. Perform only the closure checks required by that request or gate. Do not trigger for ordinary authorized implementation changes, read-only analysis, drafts, or merely durable changes.
---

# Change Closure

Use this checklist only after an explicit request to verify completion or when an applicable safety, contract, or lifecycle gate explicitly requires closure. The existence, size, durability, or importance of a change does not by itself authorize closure validation.

## Closure checks

Perform only checks material to the authorized closure scope:

- **Required proof:** run the smallest test, diff, endpoint, file check, or other observation that directly establishes the requested or mandatory closure condition.
- **Contract sync:** update only contract surfaces that the authorized change actually makes stale.
- **Stale-reference check:** search for removed or renamed identifiers only when the change actually removes or renames an identifier whose active references matter to closure.
- **Authoritative record:** update an owning fact source only when the authorized workflow requires that record to change.
- **Leftovers:** report unresolved external or manual steps that remain part of the requested closure.

Do not turn this checklist into a generic second review, repository-wide sweep, or confidence pass. A successful check need not be independently reconfirmed.

## Success signal

The explicitly requested or mandatory closure conditions are established with the minimum necessary evidence, and no extra closure work was added merely for completeness.
