---
name: scope-safety
description: Distinguish capability from warrant. Before adding anything persistent or claiming anything conclusive, verify that the system can afford the expansion and that the evidence supports the claim. Use when proposing new components, dependencies, automations, rules, metrics, or factual declarations that would outlive the current task.
---

# Scope Safety

Every proposal that adds something persistent to a system — a service, a dependency, a rule, an automation, a metric, a claim — implicitly answers two questions. Most engineering processes only check the first.

## Two questions

**能不能 (capacity):** Can the system afford this? Not "is it technically possible" — is there headroom? What does this displace? What ongoing cost does it impose?

**好不好 (warrant):** Should this be treated as true? Not "does the data exist" — by what evidence? Is this a candidate or a conclusion? Who or what bears the consequence if this is wrong?

## Use when

Use whenever a proposal would add something persistent beyond the current task: a new container, service, dependency, cron job, scheduled task, alert rule, dashboard panel, configuration, metric definition, or a conclusion drawn from observed data that will be cited as fact.

Also use when transitioning from investigation to implementation, or from observation to declaration — moments where the default answer to "can we?" is conflated with the answer to "should we?".

Skip pure computation, local refactoring, formatting, and read-only queries.

## Main rule

Before accepting a persistent addition, verify capacity. Before accepting a factual claim, verify warrant. "Technically possible" and "data exists" are necessary but not sufficient.

## Checklist

**Capacity — 能不能**

- [ ] What existing resource does this consume? If none appears to be consumed, look harder.
- [ ] What does this displace or make harder to change later?
- [ ] Does this addition have a known retirement condition, review date, or expiry?
- [ ] If this fails or becomes unmaintained, what is the blast radius? Is it within an existing failure domain?

**Warrant — 好不好**

- [ ] Is the evidence for this claim measured or inferred? (Distinguish `dev_disk_root_used_pct = 21` from "disk is fine".)
- [ ] If citing a metric, has the metric itself been validated? (Watchdog log clean? Value within sane range?)
- [ ] Is this claim marked as candidate or official? (Align with `rule-state-hygiene`.)
- [ ] Is there a circular dependency: "we monitor X therefore X is important, X is important therefore we add more monitoring"?



## Change intent

Before modifying, clarify the scope of the task. Codex tends to conflate "explain this" with "fix this", and "minimal fix" with "structural rewrite".

- [ ] Is this task: diagnosis / explanation / minimal fix / refactor / feature / restructure?
- [ ] If the user asked for explanation, stop after explaining. Do not proceed to implementation unless explicitly asked.
- [ ] If the user asked for a minimal fix, do not refactor adjacent code.
- [ ] Which files are in scope? Which files are explicitly out of scope?

## Dependency supply chain

Adding a dependency is a maintenance commitment, not a convenience.

- [ ] Is this dependency necessary, or could the same be achieved with what's already available?
- [ ] Is the version pinned? Is it compatible with existing dependencies?
- [ ] What is the license, and is it acceptable for this project?
- [ ] Does this dependency introduce transitive risk (known vulnerabilities, unmaintained upstream, large dependency tree)?
- [ ] Does it change the build or runtime surface (new system library, new language runtime, new port)?
- [ ] Am I adding this dependency to avoid writing a few lines of code?

## Relation to other skills

`scope-safety` is a preliminary gate. `authorization-map` checks who decides; `scope-safety` checks whether the decision should be made at all. `side-effect-safety` checks whether an operation can be undone; `scope-safety` checks whether the commitment should be made. `incremental-erosion` detects patterns over time; `scope-safety` checks the single step before it becomes a pattern.