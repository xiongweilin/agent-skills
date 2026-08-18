---
name: privacy-and-sensitive-data-boundary
description: Use only when the task may read, log, screenshot, transmit, retain, or delete secrets, PII, user content, or business-sensitive data. Do not trigger for ordinary non-sensitive API calls, local files, or generic security discussion.
---

# Privacy and Sensitive Data Boundary

AGENTS.md owns the approval gate for secret values. This skill handles the additional checks for sensitive-data classification and movement.

## Checks

- Classify data before it crosses a log, screenshot, error report, API, or retained store.
- Send or retain the minimum necessary fields.
- Redact secrets, tokens, full PII, request bodies, and environment values from logs, screenshots, and errors.
- Record the owner and retention/deletion condition for new retained data.

## Success signal

A reviewer can see what sensitive data moved, why it moved, what was redacted, and when retained copies can be deleted.
