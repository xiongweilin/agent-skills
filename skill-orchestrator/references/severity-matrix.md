# Severity Matrix

Operational risk classification for actions, commands, and state changes.
Complements the judgment framework in 个人平台总览: the framework answers
"what kind of question is this?", while the severity matrix answers
"how dangerous is this specific action?"

A single change can carry both a governance concern and a severity level. For
example, a production config change is a lifecycle-governance concern and an
L3 action.

## Levels

| Level | Label | Default Action | Triggers |
|-------|-------|---------------|----------|
| L0 | Informational | Allow, log only | Pure reads, local computation, temporary local files |
| L1 | Low | Allow, note in commentary | New dev dependency, local config change, reversible file edit |
| L2 | Medium | Confirm + record | Database migration, external API write, git history rewrite, service restart |
| L3 | High | Require approval + audit trail | Production config, PII access, customer-facing communication, permission changes, new persistent infrastructure |
| L4 | Critical | Block, escalate | Secrets exposure, production data deletion, auth bypass, cross-tenant data leak, sandbox escape |

## Usage

Referenced by: skill-orchestrator, privacy-and-sensitive-data-boundary, and
side-effect-safety. Command authorization remains governed by AGENTS.

A skill that classifies an action should label it with both the severity level
and the relevant platform-loop concern. The orchestrator uses the severity
level to decide the output format (see output-format.md).

## Boundary Cases

- An action that is normally L1 becomes L2 when performed on production
  infrastructure.
- An action that is normally L2 becomes L3 when it touches PII or secrets.
- "Read-only" is not automatically L0 when the target is a secret file; apply
  the AGENTS credential-access gate and classify it as L3+.
