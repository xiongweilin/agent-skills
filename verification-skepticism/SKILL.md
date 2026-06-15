---
name: verification-skepticism
description: Before claiming that code works, that a bug is fixed, or that a task is done, actively try to disprove the claim rather than confirm it. Covers checking whether passing tests actually exercise the changed code, whether mocks and stubs are tautological (returning the very value the assertion checks), whether assertions are strong enough to catch a regression, whether the evidence comes from a single self-authored source, and what input would break the code. Use this whenever you are about to say "this works", "fixed", "tests pass", "done", "ready", or "looks good", whenever you finish implementing or debugging something, and whenever you are reviewing whether code or a claim is actually correct. Passing tests are the cue to start checking, not the all-clear to stop.
---

# Verification Skepticism

The most common failure of a capable coding assistant is confident completion: declaring success on evidence that doesn't actually establish it. A green test suite can mean "the code is correct" — or it can mean the tests don't run the changed path, the mock returns exactly what the assertion expects, or the assertion is too weak to ever fail. Treat a passing result as a question ("why did this pass?") rather than an answer ("it works"). The point of this skill is to spend a small, deliberate effort trying to falsify your own claim before you make it.

## Before declaring something done, check each of these

**Does the test actually run the changed code?** A test that passes whether or not your change is present proves nothing about your change. The quick check: would this test fail if you reverted the fix? If you can't say yes, the test isn't covering what you think it is.

**Are the mocks tautological?** If a mock is set up to return value X and the assertion checks that the result is X, the test validates the mock, not your code. Mocks are fine for isolating a unit, but at least one path should hit a realistic fake or the real dependency, and failure modes should be injected on purpose — timeout, 5xx, empty response, malformed payload. A suite that only ever sees the mock's happy answer has never tested the code that matters.

**Are the assertions strong enough to catch a regression?** "No exception thrown" and "returns 200" pass even when the behavior is wrong. Assert on the actual effect: the state changed to the expected value, the record was written, the number is correct, the side effect happened exactly once. If an assertion would still pass after you broke the feature, it isn't testing the feature.

**Is the evidence single-source?** If the only thing saying it works is your own mock plus your own expected values, that is "passes under controlled conditions," not "verified." Real confidence needs an independent path the author didn't hand-shape: a different input, the real dependency, an adversarial edge case, a property check, or a second observer. Same-source confirmation tends to be circular — the test agrees with the code because the same hand wrote both to match.

**What input breaks it?** Spend a moment generating the case you'd use to break your own code: boundary values, empty and null, very large input, concurrent access, the unhappy path, malformed data. If you genuinely can't think of one, that usually means the test surface is too narrow to have found problems — not that the code is bulletproof.

## When you report

Distinguish what is verified from what is assumed. Say "verified by test X" or "ran it against the real Y" for the parts you checked, and say "untested" or "assumed" plainly for the parts you didn't. Implying completeness you haven't established is the failure this skill exists to prevent. Handing over "the core path works and is tested; the error path is written but untested" is more honest and more useful than a blanket "done."

## When to skip

Match the skepticism to the stakes. Trivial one-liners, throwaway scripts, and exploratory spikes where the user explicitly wants speed don't need an interrogation. Don't turn every small edit into a falsification exercise — apply this where being wrong actually costs something: shared code, anything with side effects, anything someone will rely on.
