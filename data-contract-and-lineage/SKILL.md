---
name: data-contract-and-lineage
description: Define field-level data contracts and lineage across model, rule, human, database, dashboard, and external-system boundaries. Use only when transformed or persisted outputs must remain traceable, or when evidence and version binding affect decisions or official claims. Do not trigger for ephemeral drafts, ordinary in-memory structures, or simple schema work with no provenance, state, or authority ambiguity.
---

# Data Contract and Lineage

A workflow's outputs are only as trustworthy as the path from input to claim. This skill keeps facts, model guesses, rule outputs, human decisions, and derived metrics separate and traceable.

## Use when

Use for persisted or decision-relevant LLM extraction, classification, reports, BI dashboards, evaluation pipelines, audit logs, ERP/CRM synchronization, feedback analysis, SOP generation, catalog enrichment, and human review tools where data changes state or authority.

Skip ephemeral drafts, ordinary in-memory structures, and simple schema work where provenance, state, and write authority are not in question.

## Contract for each field

For every important field, specify:

- **Source:** raw input, uploaded file, database, external API, model output, deterministic rule, human review, derived metric, or fallback.
- **State:** raw, normalized, candidate, validated, accepted, rejected, deprecated, or official.
- **Owner:** which layer is allowed to write or change it.
- **Validation:** schema, enum, range, exact-match, checksum, foreign key, human approval, or replay.
- **Lineage:** input IDs, document offsets, ticket IDs, SKU IDs, prompt versions, rule versions, model versions, dataset hashes, or other support.
- **Use limit:** display, routing, automation, audit, reporting, or final action.

## Fact / hypothesis separation

Do not let generated explanation become fact. Label observations, evidence, candidate interpretation, pending cause, official conclusion, action recommendation, and executed action.

If a root cause, label, metric, or summary cannot be traced to evidence, it must remain candidate or pending review.

## Version binding

When evaluation, prompts, rules, thresholds, or datasets matter, bind outputs to model name/version, prompt or DSL hash, rule version, clustering/scoring config, dataset version, evaluation script hash, review status, and timestamp.

A score without the versioned artifact is not a stable claim.

## Success signal

A reader can pick any output and answer where it came from, who or what generated it, what validated it, what version produced it, what evidence supports it, and what it is allowed to be used for.

When a data-contract change alters a public API, CLI, schema, serialization, or
configuration format, use `api-and-interface-design` for compatibility and
deprecation decisions. This skill continues to own field state and lineage.
