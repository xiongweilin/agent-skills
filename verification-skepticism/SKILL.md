---
name: verification-skepticism
description: Before claiming that code works, a bug is fixed, a task is done, or a change is better than before, actively try to disprove the claim. Check test coverage of changed code, tautological mocks, assertion strength, evidence independence, relevant baselines, and break inputs.
---

# Verification Skepticism

A passing test suite can mean the code is correct, or that tests do not run the changed path, mocks return exactly what assertions expect, or assertions are too weak to fail. Treat passing tests as a question, not as an all-clear.

## Use when

Use before saying works, fixed, done, ready, more robust, safer, faster, better, or similar. Use when finishing implementation, debugging, or reviewing whether a claim is correct.

Skip trivial one-liners, throwaway scripts, and exploratory spikes where the user explicitly wants speed and the stakes are low.

## Checks

**Changed path:** would the test fail if the fix were reverted?

**Mocks:** is the test validating real code behavior, or just the mock's chosen response?

**Assertions:** would the assertion catch the actual regression, or only prove no exception or 200 OK?

**Evidence source:** is evidence independent, or did the same hand shape code, mock, and expected value?

**Baseline:** if claiming better, faster, safer, or more robust, better than what?

**Break input:** what boundary value, malformed data, concurrency case, empty input, timeout, or unhappy path would break this?

## Reporting

Distinguish verified from assumed. Say what was tested, what was not tested, what was mocked, and what comparison supports any comparative claim.
