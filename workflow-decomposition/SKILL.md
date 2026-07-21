---
name: workflow-decomposition
description: Decompose durable multi-actor or cross-system business and agent workflows into inputs, state machines, automated and human nodes, guards, side effects, exceptions, records, and metrics. Use only before implementing or materially changing a workflow with durable state, authorization, retries, human review, or external effects. Do not trigger for ordinary functions, single-service request flows, simple reads, or one-off scripts.
---

# Workflow Decomposition

A business workflow is not a prompt. It is a sequence of states, actors, data transformations, decisions, side effects, failures, and records. This skill prevents a workflow from being collapsed into 'the agent handles it.'

## Use when

Use before implementing or materially changing RPA, ERP, CRM, BI, catalog operations, customer feedback pipelines, support automation, approval flows, reporting workflows, or agentic operations that have durable state, multiple actors, authorization, retries, human review, or external effects.

Skip ordinary functions, single-service request flows, one-off scripts with no durable state, and simple reads.

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
