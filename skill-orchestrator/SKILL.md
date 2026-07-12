---
name: skill-orchestrator
description: Route complex governance work through the smallest applicable skill chain. Use for cross-system workflows, authorization and responsibility questions, sensitive-data flows, formal rule promotion, or recurring exceptions; do not trigger for ordinary code changes already governed by AGENTS and development skills.
---

# Skill Orchestrator

Select only the governance skills required by the scenario. Do not turn every
task into a full pipeline.

## Always-loaded boundaries

AGENTS already governs task scope, command permission, local file safety, and
verification before completion. Do not re-run those rules as separate skills.
If the task adds a persistent component or creates a durable factual claim,
apply `scope-safety` before the scenario path below.

## Workflow path

Use for RPA, ERP/CRM/BI integration, approval flows, customer-facing
automation, or agent workflows with durable state.

```text
workflow-decomposition
→ authorization-map
→ side-effect-safety        (only when external writes exist)
→ data-contract-and-lineage (only when data changes state or authority)
```

## Rule and promotion path

Use when prompts, rules, thresholds, configs, fixtures, datasets, or workflow
behavior may become official.

```text
judgment-ownership    (only for strategic or value-laden choices)
→ rule-state-hygiene
→ rollout-and-promotion (only when a promotion path exists)
```

## Recurring-exception path

Use when the same workaround, skipped check, weakened assertion, lower
threshold, or special case recurs.

```text
incremental-erosion
→ rule-state-hygiene
```

## Sensitive-data path

Apply `privacy-and-sensitive-data-boundary` alongside any path that handles
PII, credentials, user content, screenshots, logs, training data, or external
data egress.

## Output

State the selected path, why each skill applies, which skills were skipped, and
the remaining authorization or verification boundary. Use the severity and
output formats in `references/` without repeating their full contents.

## Success signal

A reader can see the minimum governance chain and why each boundary exists,
without ordinary engineering work being routed through unrelated skills.
