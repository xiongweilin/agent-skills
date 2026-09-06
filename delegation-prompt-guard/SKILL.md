---
name: delegation-prompt-guard
description: Use immediately before dispatching a delegated agent to decide whether delegation is authorized and prepare the outbound prompt. Do not use for ordinary local work or prompts received from another agent.
---

# Delegation Prompt Guard

Use this skill only in the agent that is about to invoke a delegation tool.

## Dispatch gate

- Dispatch a delegated agent only when it is necessary to satisfy the current request or when the user or an applicable repository rule explicitly requests delegation.
- Before invoking a delegation tool, ensure that the outbound prompt contains the exact sentence “不要派发智能体，由你执行”.
- This skill governs the dispatcher’s outbound prompt. The receiving agent does not need to know or infer that it is a delegated agent, and this skill does not impose a requirement on prompts it receives.
- Do not pass this skill to the receiving agent unless the task explicitly requires that agent to dispatch another agent.
