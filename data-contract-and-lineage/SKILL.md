---
name: data-contract-and-lineage
description: Define data contracts and lineage for workflows that transform inputs through models, rules, human review, databases, dashboards, or external systems. Use when fields, labels, metrics, reports, evaluations, evidence quotes, offsets, IDs, prompts, rules, thresholds, datasets, or generated outputs must remain traceable and not be confused as facts, guesses, candidates, or official conclusions.
---

# Data Contract and Lineage

A workflow's outputs are only as trustworthy as the path from input to claim. This skill keeps facts, model guesses, rule outputs, human decisions, and derived metrics separate and traceable.

## Use when

Use for LLM extraction, classification, reports, BI dashboards, evaluation pipelines, audit logs, ERP/CRM synchronization, feedback analysis, SOP generation, catalog enrichment, human review tools, or any workflow where data changes state or authority.

Skip ephemeral drafts that are not persisted or used for decisions.

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
