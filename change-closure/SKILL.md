---
name: change-closure
description: Close durable changes across code, configuration, documentation, and verification surfaces. Use after state-changing work that alters durable behavior, interfaces, identifiers, configuration, runtime state, or documented contracts, when the work must end with fresh verification and consistency closure rather than self-reported completion.
---

# Change Closure

Durable state-changing work is not complete when the edit lands. It is complete when the change is verified, its contract surfaces agree, and nothing stale remains. This skill is the procedure behind the always-loaded AGENTS.md completion gate: the gate stays in AGENTS.md, this skill carries the checklist.

## Use when

Use after work that changes durable code, configuration, interfaces, identifiers, runtime state, documentation contracts, or externally visible behavior.

Skip read-only analysis, discussions, and reversible local edits with no durable surface.

## Closure checks

- **Verified, not claimed.** Run the smallest fresh checks that prove the outcome — tests, diffs, exit statuses, endpoint checks — and inspect their failures. A completion claim is not evidence; neither is a single success or a retry that masked a failure.
- **Contract surfaces agree.** When behavior, interfaces, commands, config fields, environment variables, or scheduling change, update the affected README, API docs, config examples, CLI help, schemas, tests, and decision records.
- **Identifier sweep.** After a durable add, rename, or removal, search active code, configuration, and documentation for stale references and update or remove them.
- **Authoritative records updated.** Environment and service changes update the closest authoritative fact owner. Derived views may link to it but must not become competing mutable owners.
- **Intentional leftovers named.** Anything left for the user — a decision, an external console, credentials — is named, with the reason.

## Conditional referrals

Do not load these unless the situation actually appears; the checks above cover the common case:

- Data ownership, provenance, or version binding becomes ambiguous → `data-contract-and-lineage`
- Temporary work could be mistaken for an official rule → `rule-state-hygiene`
- A persisted candidate is promoted to official behavior → `rollout-and-promotion`
- Cross-actor approval or accountability becomes unclear → `authorization-map`
- An external or irreversible effect needs idempotency or compensation → `side-effect-safety`

## Success signal

A reviewer can tell exactly what was verified, which documents and code were updated (or that the sweep found nothing), and what was intentionally left for the user, from the smallest fresh evidence.
