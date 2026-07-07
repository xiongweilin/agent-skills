> 相关：[[operational-judgment-skills/README|判准技能集]] / [[个人研发平台总览]]

---
name: workflow-decomposition
description: Decompose a business or agent workflow before implementation into inputs, state machine, automated nodes, human authorization nodes, deterministic guards, external side effects, exception paths, evidence records, and observable metrics. Use when designing RPA, ERP/CRM/BI integrations, agent workflows, operational automations, approval flows, ticket pipelines, catalog operations, or customer feedback systems.
---

# Workflow Decomposition

A business workflow is not a prompt. It is a sequence of states, actors, data transformations, decisions, side effects, failures, and records. This skill prevents a workflow from being collapsed into 'the agent handles it.'

## Use when

Use when designing or modifying RPA, ERP, CRM, BI, catalog operations, customer feedback pipelines, support automation, approval flows, reporting workflows, or agentic operations.

Skip pure local functions, one-off scripts with no durable state, and simple reads.

## Decompose before building

Identify:

- **Trigger and input:** what starts the flow, who provides it, and what shape the input has.
- **State machine:** valid states, terminal states, retryable states, and invalid transitions.
- **Automated nodes:** steps a service, rule, model, RPA tool, or agent can perform.
- **Human nodes:** review, approval, correction, override, escalation, or rejection.
- **Deterministic guards:** validations, schema checks, enumerations, thresholds, idempotency checks, and policy rules.
- **External side effects:** writes to ERP, CRM, BI, email, files, queues, public records, or third-party APIs.
- **Exception paths:** timeout, malformed input, duplicate input, permission failure, partial write, dependency outage, and manual fallback.
- **Evidence and records:** logs, IDs, versions, source fields, screenshots, audit rows, and output traceability.
- **Metrics:** throughput, failure rate, p95 latency, review rate, duplicate rate, write success rate, correction rate, and backlog.

## Output shape

Prefer a compact map:

```text
input
→ drafted
→ validation_failed | pending_approval
→ ready_for_execution
→ written | skipped | failed | needs_review
```

Then name which layer owns each transition. Do not let LLM output own transitions that require authorization, irreversible effects, or external writes.

## Success signal

A reviewer can tell what is automated, what remains human, where side effects happen, how failure returns to a visible state, what can be replayed safely, and what metrics prove the workflow is operating.
