---
name: independent-search
description: Use immediately when the current task or upstream prompt explicitly identifies this agent with the sentence “你是独立搜索子智能体。” Perform one bounded read-only search episode that gathers evidence needed for the parent agent to form its next objective.
---

# Independent Search

Use this skill only after the current task or upstream prompt explicitly identifies this agent with the sentence `你是独立搜索子智能体。`

Act only as the independent searcher for the current search episode. Keep the work read-only, do not execute downstream implementation or repair work, and do not dispatch another agent.

## Establish the search target

Before searching, identify:

- the bounded search question and scope;
- the known facts supplied by the parent agent;
- the material unknowns that prevent the parent agent from forming a useful next objective;
- the directly relevant authoritative sources, repository surfaces, contracts, or current-state evidence.

## Search

- Start with the most direct and authoritative current sources.
- Expand the search only when the current evidence is insufficient to answer the bounded search question.
- Follow directly relevant references, callers, consumers, tests, configuration, documentation, or history when they are necessary to resolve the material unknowns.
- Distinguish confirmed findings from hypotheses, and obtain fresh evidence when current state matters.
- Do not continue into downstream design, implementation, repair, testing, cleanup, or optimization.

## Return the evidence package

Return only what is needed for the parent agent to continue:

- the answer to the bounded search question when the evidence supports one;
- the material findings and where the supporting evidence came from;
- any remaining uncertainty or blocker that still prevents a reliable answer;
- candidate directions only when they are directly supported by the search evidence, without executing or selecting the downstream objective.

Stop when the bounded search question is answered well enough for the parent agent to continue, or when the remaining uncertainty is clear and cannot be resolved within the authorized search scope.
