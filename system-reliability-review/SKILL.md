---
name: system-reliability-review
description: Use only when a persistent or long-lived system, workflow, standard, or infrastructure dependency needs review for common-mode failure, recovery independence, lock-in, reauthorization, or loss of future maneuverability. Do not trigger for one-off changes, routine debugging, ordinary observability, or single-component resilience checks.
---

# System Reliability Review

Use this skill to review whether a system that remains in operation can still detect important failures, stop harmful propagation, recover control, and change direction over time. Do not collapse reliability into one score.

## Review profile

1. **Correction loop**: identify observation, dissent, verification, correction, and memory paths. Check whether nominally separate paths share the same data, model, operator, incentive, authority, or technical root.
2. **Fault containment**: distinguish normal-operation dependencies, failure-propagation dependencies, and recovery dependencies. Identify common causes that can defeat both primary and recovery paths.
3. **Rate compatibility**: compare detection, judgment, stopping, recovery, and reauthorization latency with damage accumulation, propagation, and lock-in speed.
4. **Effective reversibility**: check separately whether state, control, and the knowledge needed to form and execute alternatives can actually be recovered.
5. **Reauthorization**: find temporary, emergency, elevated, or long-lived permissions and confirm expiry, review, takeover, and termination paths remain real.
6. **Maneuverability**: check whether alternative suppliers, implementations, models, operators, migration paths, control entry points, and prerequisite knowledge or resources remain realistically obtainable.

## Minimum rules

- Multiple validators do not provide independence when they share the same failure source.
- Operational redundancy does not prove recovery redundancy.
- A rollback mechanism does not prove effective reversibility.
- Once authorized does not mean still authorized.
- More options are not automatically better; the review asks whether meaningful alternatives remain available when the current path fails.

This skill does not replace `side-effect-safety` for a specific mutation or `change-closure` for post-change verification. It does not replace security threat modeling or observability design; it reviews cross-time failure structure and recovery capacity.

## Output

Return a reliability profile by dimension, the important common causes or lock-in paths, any missing independent stop or recovery capability, and the concrete review, reauthorization, diversification, containment, or recovery actions required.
