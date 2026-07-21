---
name: rollout-and-promotion
description: Govern candidate-to-official transitions for workflows, prompts, rules, thresholds, datasets, models, configs, and evaluation results. Use only when a persisted candidate is being frozen, scored, promoted, rejected, deprecated, or used to support a production or public claim. Do not trigger for ordinary implementation, local experiments, routine deployment, or configuration changes with no candidate-versus-official decision.
---

# Rollout and Promotion

A candidate system does not become official because it ran once or passed one metric. This skill keeps promotion, rejection, retesting, and public claims disciplined.

## Use when

Use when persisted prompt versions, workflow DSLs, classifiers, rules, clustering thresholds, agent suites, RPA flows, evaluation sets, BI metrics, or SOP generators are being frozen, scored, promoted, rejected, deprecated, or used to support a production or public claim.

Skip ordinary implementation, routine deployment, and local experiments that are not persisted, scored, or described as supported behavior.

## Lifecycle

Use explicit states:

```text
draft
→ candidate
→ frozen
→ scored
→ official | unpromoted | deprecated
```

**Draft:** still changing; no quality claims.

**Candidate:** plausible version intended for evaluation.

**Frozen:** code, prompt, config, dataset, and evaluation script are locked before scoring.

**Scored:** evaluated once against the locked set.

**Official:** promotion completed; all required gates pass and docs are updated.

**Unpromoted:** evaluated but not accepted; may become diagnostic material.

**Deprecated:** replaced or retired; should not guide new work.

## Rules

A locked evaluation set that has been read or scored is no longer unseen.

If a candidate fails and you tune against the failed set, that set becomes development or diagnostic material. Formal validation requires a new unseen set.

Do not lower gates after seeing results unless the claim is also downgraded and the change is treated as a new decision.

Partial gate success cannot be summarized as overall success.

A fallback, demo rule, mock, or synthetic replay cannot be described as production performance.

Promotion requires both metric gates and claim discipline: docs, README, resume bullets, dashboards, and public pages must say the same state as the system.

## Promotion record

For each scored candidate, record candidate name, code commit or package hash, prompt/DSL hash, rule and config versions, dataset version and hash, evaluation script hash, model/provider versions, scoring timestamp, gates passed and failed, manual or AI-assisted review status, promotion decision, and public claim allowed.

## Success signal

A reader can tell whether a version is official, candidate, failed, diagnostic, or deprecated, and cannot mistake a scored but unpromoted candidate for production quality. `Promoted` names the transition into the `official` state, not a separate state.
