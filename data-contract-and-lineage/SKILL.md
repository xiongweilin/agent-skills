---
name: data-contract-and-lineage
description: Use only when transformed or persisted fields must remain traceable to source, owner, version, validation, and allowed use, or when an output supports an official claim. Do not trigger for ephemeral values, ordinary schemas, or simple in-memory transformations.
---

# Data Contract and Lineage

Use this compact contract only when persistence, cross-boundary transformation, or an official or decision-relevant claim makes provenance material.

## Contract for each material field

Specify:

- source;
- state;
- owner;
- validation;
- lineage and version binding;
- allowed use.

## Minimum rules

- Generated explanations remain candidate or pending until tied to evidence.
- A score or report without its producing version is not a stable claim.
- Keep field ownership and permitted use explicit when multiple layers can write or consume the value.

## Success signal

A reader can identify where the value came from, who may change it, which version produced it, how it was checked, and where it may be used.
