---
name: change-closure
description: Use when a requested or mandatory completion claim depends on a property not already established by the available execution evidence. Establish only the stronger postcondition, outcome, or residual-obligation evidence needed for closure. Do not trigger when the existing result already proves the intended claim, or for read-only analysis, drafts, or generic confidence checks.
---

# Change Closure

Use this checklist only when the completion claim to be made is stronger than what the current evidence already establishes, or when an applicable safety, contract, or lifecycle gate explicitly requires closure. The existence, size, durability, or importance of a change does not by itself authorize extra validation.

Keep these positions distinct when they materially differ:

`execution completed != external effect established != postcondition verified != requested outcome established != residual obligations completed`

Do not require a separate object or check for every position. Require only the evidence needed to support the actual closure claim.

## Closure checks

Perform only checks material to the authorized closure scope:

- **Required proof:** identify the strongest completion property that remains unestablished, then run the smallest test, diff, endpoint, file check, authoritative read-back, or other observation that directly establishes it.
- **Effect and postcondition:** when execution success does not establish the external effect or required postcondition, observe the appropriate authoritative surface rather than echoing the executor's own result.
- **Outcome and obligations:** do not declare closure merely because the planned mutations finished. Check only the requested outcome conditions and residual obligations that belong to the authorized completion basis.
- **Contract sync:** update only contract surfaces that the authorized change actually makes stale.
- **Stale-reference check:** search for removed or renamed identifiers only when the change actually removes or renames an identifier whose active references matter to closure.
- **Authoritative record:** update an owning fact source only when the authorized workflow requires that record to change.
- **Leftovers:** report unresolved external or manual steps that remain part of the requested closure.

Do not turn this checklist into a generic second review, repository-wide sweep, or confidence pass. A successful check need not be independently reconfirmed.

## Success signal

The intended completion claim and any actually required residual obligations are established with the minimum necessary evidence, without silently promoting execution success into a stronger effect, outcome, or completion claim.
