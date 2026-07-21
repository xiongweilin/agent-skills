---
name: authorization-map
description: Map authorization, responsibility, veto, execution, compensation, and affected-party boundaries. Use only when a proposed state-changing or externally consequential action crosses actors and valid approval, veto, accountability, compensation, or affected-party authority is unclear. Do not trigger for ordinary code review, private drafts, read-only analysis, or reversible local edits with one clear owner.
---

# Authorization Map

A workflow can be technically correct and still have no valid authority to act. This skill separates proposal, review, approval, execution, consequence, compensation, and accountability.

## Use when

Use when one actor proposes a state-changing or externally consequential action and another actor approves, executes, bears the consequence, or must repair harm. Typical cases include RPA, SOP publication, catalog listing, refunds, account changes, compliance decisions, public reporting, ERP/CRM writes, and customer-facing communication.

Skip ordinary code review, read-only analysis, low-risk private drafts, and reversible local changes with one clear owner.

## Map roles

For the action under consideration, identify:

- **Proposal:** who or what generates the candidate action.
- **Validation:** who or what checks schema, evidence, policy, and feasibility.
- **Approval:** who has authority to let the action proceed.
- **Execution:** who or what performs the actual state change.
- **Veto:** who can stop or downgrade the action.
- **Affected subjects:** who bears cost, risk, inconvenience, exposure, or loss of options.
- **Compensation:** who repairs harm, reverts state, refunds, corrects records, or communicates failure.
- **Accountability:** who explains the action externally or internally.
- **Audit:** where the authorization and rationale are recorded.

## Rules

Models may propose, summarize, classify, draft, compare, and flag. They do not grant authority.

Rules may validate and route. They do not replace ownership when the consequence is high.

Humans may approve, but approval is weak when the person lacks information, authority, independence, or ability to bear the consequence.

Organizations may delegate execution, but not responsibility.

## Red flags

The proposer self-approves a high-impact action; the party benefiting most defines the risk alone; the affected subject cannot understand, refuse, exit, or correct the result; a workflow tool or model is treated as if it owns responsibility; approval exists only as a checkbox; failure creates work or damage for someone absent from the design.

## Success signal

The handoff makes clear who generates the candidate, who validates it, who approves it, who executes it, who can stop it, who is affected, and who is responsible if it goes wrong.
