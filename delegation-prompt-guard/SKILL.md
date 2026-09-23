---
name: delegation-prompt-guard
description: Use immediately before an already-authorized non-testing delegated dispatch to prepare the smallest sufficient outbound task and preserve authority boundaries. Do not use for ordinary local work, independent testing, or prompts received from another agent.
---

# Delegation Prompt Guard

Use this skill only in the agent that is about to invoke a non-testing delegation tool after delegation authority already exists from the user or an applicable repository instruction. This skill prepares the dispatch; it does not create authority to delegate.

## Dispatch gate

- Dispatch only the bounded objective already authorized.
- Before invoking a delegation tool, ensure that the outbound prompt contains the exact sentence “不要派发智能体，由你执行”.
- Give the receiving agent only the context and authority needed for that objective.
- Do not pass this skill to the receiving agent unless that agent is itself explicitly authorized to dispatch another agent.
- For ordering dependencies, dispatch only the current objective; form a dependent follow-up after the current result returns.
- When the delegated agent is no longer needed, close it promptly.

## Independent search delegation

When independent search delegation is already authorized and substantial search is the bounded objective:

- Dispatch exactly one search agent for the episode.
- Include the exact sentence `你是独立搜索子智能体。` and require `independent-search`.
- State the bounded search question and scope, and keep the task read-only.
- Do not bundle downstream design, implementation, repair, testing, or decision work into the search prompt.

## Parallel simple work

When parallel delegation is already authorized and several simple units are genuinely independent:

- Partition them into bounded, non-overlapping units.
- Parallelize only units without ordering dependencies, shared mutable state, or overlapping write scope.
- Give each agent only its assigned unit and necessary context.
