# Security

This repository contains a set of judgment-oriented skill instructions for agents and workflows. It does not contain runtime data, credentials, or sensitive business content.

## Reporting a problem

Use [GitHub's private vulnerability reporting](https://github.com/xiongweilin/agent-skills/security/advisories) when available, or contact the maintainer through an established private channel. Do not disclose secret values, internal paths, or exploitable details in public issues.

## Content boundary

- Skill text must not carry real secrets, tokens, passwords, or `.env` values; when a sensitive operation is involved, provide only the procedure and its boundary, never real credentials.
- Skill text must not contain real user PII or sensitive business samples; always use placeholders in examples.
- The skills in this repository are boundary instructions, not a source of authorization: task authorization still rests with the deployed global AGENTS.md and the relevant runbook.
- When modifying or adding a skill that involves secrets, PII, or sensitive data handling, apply the standing authorization and sensitive-data boundaries in `agents-md/AGENTS.md`; do not assume a separate privacy skill exists.
