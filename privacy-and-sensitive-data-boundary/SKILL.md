---
name: privacy-and-sensitive-data-boundary
description: Enforce privacy and sensitive-data boundaries across PII, log
  redaction, screenshots, error reports, third-party API egress, training-data
  isolation, and minimum-necessary access. Use when code or operations touch
  user data, customer feedback, personal information, secrets, external API
  calls, screenshots, or error reporting — any path where sensitive data could
  leak outside its intended boundary.
---

# Privacy and Sensitive Data Boundary

Command-permission-boundary already rules that secret access is never
read-only. data-contract-and-lineage already requires field-level source,
state, owner, and use-limit labeling. This skill fills the gap between them:
what counts as sensitive, where it can travel, what must be redacted, and when
it must be deleted.

## Use when

Use when code or operations involve: customer feedback or tickets containing
user-submitted text, CSV imports with personal or business data, Dify workflow
inputs that may contain PII, log output or error messages that echo request
bodies, screenshots of applications or dashboards, third-party API calls
(DeepSeek, OpenAI, etc.) carrying user data, training or fine-tuning data
preparation, or webhook payloads forwarded across systems.

Skip pure computation with no external data flow, local-only admin operations,
and read-only queries against system metrics.

## What counts as sensitive

| Category | Examples | Severity |
|----------|----------|----------|
| Secrets & credentials | API keys, tokens, passwords, .env files, SSH keys | L4 |
| PII | Names, email, phone, addresses, ID numbers, IPs tied to individuals | L3 |
| Business-sensitive | Customer lists, pricing, supplier data, internal SOP drafts | L2-L3 |
| Auth material | Session tokens, password hashes, OAuth refresh tokens | L4 |
| User-generated content | Feedback text, ticket descriptions, uploaded files | L1-L3 (depends on content) |
| Infrastructure internals | Internal hostnames, port maps, Tailscale IPs in public contexts | L1-L2 |

## Rules

### Log redaction

Never log secrets, tokens, passwords, or full PII. This is a hard rule from
observability-and-instrumentation — telemetry pipelines are a classic data-leak
path. Allowlist fields; do not log whole request bodies. Spot-check actual log
output, not just the logging configuration.

### Screenshot and error-report privacy

Before taking a screenshot (playwright, screenshot skill, OS-level capture) of
any UI that may display user data, PII, or internal dashboards, verify what is
visible in the viewport. Redact or mask fields that should not appear in the
image. Error reports and stack traces must not include request bodies, user
input, or environment variable values.

### Third-party API egress

When data leaves the local environment to an external API (DeepSeek via Dify,
OpenAI API, webhook relay to cloud server, etc.), verify:

- What fields are sent? Are they the minimum necessary for the task?
- Does the provider's privacy policy permit this data category?
- Is the data in transit encrypted (TLS)?
- If the provider uses submitted data for training, has that been accepted?

The Dify → DeepSeek path is the primary egress point in this environment.
Workflow inputs that contain user feedback text or catalog product data cross
this boundary on every LLM call.

### Training data isolation

Data used for fine-tuning, evaluation sets, or prompt engineering must not
contain PII unless explicitly designated and consented. Synthetic data
generated from real user inputs must be verified free of residual PII before
use in training or public datasets.

### Minimum necessary access

For any data access pattern (database user, API scope, file permission, Docker
volume mount), grant only what the operation actually needs:

- Read-only when writes are not required.
- Specific columns/tables, not whole databases.
- Temporary tokens with minimum TTL, not permanent keys.
- Localhost binding for services that need no external exposure.

### Retention and deletion

- Anonymous session data: 24-hour expiry (already enforced in feedback project).
- Evaluation datasets: retain with versioning; scrub between versions if
  re-sampled from production data.
- Logs: Loki retains 30 days; Prometheus retains 15 days. Match or tighten for
  any new log/metric sink.
- Docker build cache and exited containers: cleaned monthly. Exited
  sonarsource/sonarqube-mcp containers: cleaned after each analysis task.

## Checklist

- [ ] Does this code path accept, store, log, or forward user-submitted text?
- [ ] If yes: is every field classified as public / internal / sensitive / PII?
- [ ] Are secrets, tokens, or full PII present in any log line? (Spot-check.)
- [ ] Would a screenshot of the current state expose user data or internal
  infrastructure?
- [ ] Do error responses or stack traces include request bodies or env values?
- [ ] Does any third-party API call transmit more data than necessary?
- [ ] Is the data-in-transit path encrypted end-to-end where it crosses network
  boundaries?
- [ ] Are database credentials, API keys, and service accounts scoped to
  minimum necessary?
- [ ] Is there a defined retention or deletion timeline for any new data store?
- [ ] If this data were exposed tomorrow, what is the blast radius and who is
  affected?

## Relation to other skills

- `command-permission-boundary`: secret access is never read-only. This skill
  extends that rule to cover what counts as a secret or sensitive data beyond
  .env files.
- `data-contract-and-lineage`: field-level source, state, owner, and use-limit.
  This skill adds the privacy classification dimension to each field.
- `side-effect-safety`: external API calls are side effects. This skill adds
  the data-egress dimension to those side effects.
- `scope-safety`: adding a new data sink, log pipeline, or third-party
  integration is a persistent addition that must pass scope-safety first.
- References `../skill-orchestrator/references/severity-matrix.md` for L0-L4 classification.

## Success signal

A reviewer can trace any data field from its origin through every hop (log,
API, screenshot, error report, external service) and confirm that its privacy
classification is respected at each boundary.
