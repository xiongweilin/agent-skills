---
name: problem-framing
description: "Before writing or changing code, pin down what is actually being built and bounded: object, scope, deliberate omissions, approach choice, contract, and success signal. Use before implementation when a request could be read more than one way or when solving the wrong problem would cause real rework."
---

# Problem Framing

Many coding failures happen before implementation: the assistant solves the wrong problem precisely. This skill sets the target before code exists.

## Use when

Use before coding, changing architecture, adding caching, configuration, error handling, webhooks, validation, cleanup, data ingestion, or any task that can expand beyond the user's actual request.

Skip trivial renames, formatting, one-line fixes with one obvious meaning, and genuine open-ended exploration.

## Frame

Before building, state:

- **Object:** the concrete function, endpoint, table, behavior, or bug being changed.
- **In scope / out of scope:** what the task covers and explicitly does not cover.
- **Deliberate omission:** what is not being solved and the cost or risk of leaving it out.
- **Approach choice:** why this approach rather than obvious alternatives.
- **Inputs and contract:** input shapes, scale, boundaries, invariants, and cases that must not break.
- **Success signal:** the observable result that proves the work met the stated target.

## Rule

Do not default to the maximal interpretation. If two readings would produce different code, surface the fork. Ask when the cost of guessing wrong is high; otherwise choose explicitly and record the assumption.

A narrow task gets a narrow frame. If a larger design is warranted, name it as separate work instead of smuggling it into the current task.
