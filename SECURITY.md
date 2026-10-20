# Security

This repository contains a set of judgment-oriented skill instructions for agents and workflows. It does not contain runtime data, credentials, or sensitive business content.

## Reporting a problem

Submit a private report through [Security Advisories](https://github.com/xiongweilin/agent-skills/security/advisories), or contact the maintainer through a private GitHub issue; do not disclose secret values, internal paths, or exploitable details in a public issue in this repository.

## Content boundary

- Skill text must not carry real secrets, tokens, passwords, or `.env` values; when a sensitive operation is involved, provide only the procedure and its boundary, never real credentials.
- Skill text must not contain real user PII or sensitive business samples; always use placeholders in examples.
- The skills in this repository are boundary instructions, not a source of authorization: task authorization still rests with the deployed global AGENTS.md and the relevant runbook.
- When modifying or adding a skill that involves secrets, PII, or sensitive data handling, reference the boundary in `privacy-and-sensitive-data-boundary` instead of embedding sensitive content in the skill.
