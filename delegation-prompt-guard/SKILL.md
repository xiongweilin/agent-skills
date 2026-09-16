---
name: delegation-prompt-guard
description: Use immediately before dispatching a delegated agent to decide whether delegation is authorized and prepare the outbound prompt. Do not use for ordinary local work or prompts received from another agent.
---

# Delegation Prompt Guard

Use this skill only in the agent that is about to invoke a delegation tool.

## Dispatch gate

- Dispatch a delegated agent only when it is necessary to satisfy the current request or when the user or an applicable repository rule explicitly requests delegation.
- When a delegated agent has completed its task and is confirmed to be no longer needed, close it promptly.
- Before invoking a delegation tool, ensure that the outbound prompt contains the exact sentence “不要派发智能体，由你执行”.
- This skill governs the dispatcher’s outbound prompt. The receiving agent does not need to know or infer that it is a delegated agent, and this skill does not impose a requirement on prompts it receives.
- Do not pass this skill to the receiving agent unless the task explicitly requires that agent to dispatch another agent.
- For work with ordering dependencies, dispatch only the current bounded objective; form any dependent follow-up objective after the current delegated result returns.

## Independent search delegation

When substantial search is required before a useful next objective can be formed:

- Dispatch exactly one delegated agent for the search episode.
- Include the exact sentence `你是独立搜索子智能体。` and require the receiving agent to use `independent-search`.
- State the bounded search question and search scope, and keep the delegated task read-only.
- Do not bundle downstream design, implementation, repair, testing, or decision work into the search prompt.

## Parallel simple work

When many independent simple tasks can be processed separately:

- Partition the work into bounded, non-overlapping units.
- Dispatch multiple delegated agents in parallel when the runtime permits.
- Give each delegated agent only its assigned unit and the context necessary to complete it.
- Do not parallelize units with ordering dependencies, shared mutable state, or overlapping write scope.
