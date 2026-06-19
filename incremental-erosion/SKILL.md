---
name: incremental-erosion
description: Watch for boundaries, invariants, and quality thresholds that erode through a series of individually small, individually reversible, individually justified changes rather than in one discrete event — changes that each pass review while the cumulative direction degrades the system. Covers keeping trend triggers alongside event triggers, recognizing when the same exception, workaround, skipped or weakened test, lowered threshold, or special-case branch recurs, noticing when a per-step-reversible direction is becoming cumulatively irreversible, and stopping to address the pattern instead of absorbing one more increment. Use this whenever you notice you are adding the Nth case of the same kind — another test skip or loosened assertion to make CI green, another special-case branch, another lowered lint/coverage/timeout threshold, another "fix it later" on the same theme — whenever metrics improve but the explanation increasingly leans on workarounds, or whenever the same kind of cost keeps landing on the same module, file, or owner. Per-change checks pass each of these individually; this is the skill that catches the cross-change drift they miss. Don't wait for a discrete alarm — the recurrence is the alarm.
---

# Incremental Erosion

Most boundaries in a codebase do not fall in a single bad commit. They wear away across a run of changes that are each small, each explainable, each individually reversible — a test skipped here because it was flaky, a special case added there for one customer, a coverage threshold nudged down to unblock a release. No single step trips an alarm, every diff passes review, and yet the suite slowly stops asserting anything, the function slowly becomes a thicket of special cases, the boundary slowly moves. The per-change hygiene skills pass on every one of these steps, because each step really is fine in isolation. This skill watches the trend they cannot see, and treats the accumulation itself as the signal.

## Keep trend triggers, not just event triggers

Event triggers fire on a single discrete action — a payment, a deletion, a schema migration. Trend triggers fire on a *pattern across changes*, and you have to track them deliberately, because no individual change will raise them for you. The thing to notice is when an action that is reversible step by step is producing a direction that is not: each special case can be removed, but the accumulation is becoming a rewrite; each skipped test can be re-enabled, but coverage has quietly collapsed.

Watch for these. Any one of them recurring is the alarm — you do not get a louder one:

- **The same exception keeps recurring.** The same edge case, customer-specific branch, or "just this once" workaround shows up for the third or fourth time. Repetition means it is not an exception anymore; it is an unacknowledged rule that belongs in the design, handled once.

- **The same cost keeps landing in the same place.** One module, one test file, one config, or one part of the system absorbs the mess every time. A cost that always falls on the same spot is being externalized, not handled — and the spot it falls on is decaying while everything around it looks fine.

- **A threshold keeps getting lowered.** Coverage minimums, lint rules, timeout budgets, performance gates — each loosened a little to unblock something, each loosening locally justified. The ratchet only turns one way unless someone stops it, and "we already lowered it once" is how it keeps turning.

- **"Fix it later" recurs on the same theme.** TODOs, skips, and temporary branches cluster around the same area. One is a note; a cluster is a decision no one made on purpose, accumulating where no single change felt big enough to stop and address it.

- **Metrics improve but the explanation leans harder on workarounds.** The number is green, but holding it green increasingly depends on special-casing, on retries papering over a real failure, or on tests that assert less than they used to. Results improving while the explanation degrades is false stability — the gauge looks better precisely because it has stopped measuring the thing that is getting worse.

## When a trend fires, address the pattern, not the instance

The reflex, having noticed the pattern, is still to handle just the instance in front of you — add the one more skip, the one more branch — because it is small and the task is about something else. That is exactly the increment that should stop. When a trend trigger fires, switch from "absorb this one" to "name and address the pattern":

- Say it plainly: "this is the fourth special case of this shape — the real fix is X." Surfacing it is most of the value; an unnamed trend keeps running because nobody is looking at it as a trend.
- Decide deliberately: pay it down now if it is cheap and you are already in the area, or flag it as its own piece of work with a real description — not another `TODO: fix later` that joins the pile it came from.
- If something temporary genuinely has to stay, give it an actual exit condition (the rule-state-hygiene move): what removes it, where the real fix lives, what risk it carries until then. A temporary with no exit is how the trend became invisible in the first place.

You are not obligated to fix the whole pattern inside an unrelated task. You are obligated not to silently add to it.

## Worked example

A single test file, across five pull requests:

- PR 1 skips one assertion in a flaky test — reasonable; the test was genuinely flaky.
- PR 2 weakens an assertion from "returns the right total" to "returns 200" to unblock a release.
- PR 3 adds skips to two more in the same file, same justification.
- PR 4 lowers the module's coverage gate from 80% to 70% so CI passes.
- PR 5 — you are here, about to skip one more.

Every one of those PRs was individually defensible and individually merged. But the file now asserts almost nothing, and the coverage number no longer means what it says. The event-level check ("is this one skip OK?") passes again at PR 5. The trend trigger ("this is the fifth erosion of the same suite") is what should fire instead: stop, name it — "this file's tests have been hollowed out across five changes; the totals are no longer verified" — and either restore real assertions now or open explicit work to do it, rather than adding skip number five and moving on as if it were the first.

## When to skip

This is about *unintended* drift, so it does not apply to a single change with no pattern behind it — for that, the per-change skills (is this mock leaking, is this effect reversible, is this claim verified) are the right tools, not this one. It also does not apply to a deliberate, tracked incremental migration, where moving the boundary one step at a time *is* the plan and the direction is intended and recorded — that is a rollout, not erosion. And do not turn this into a mandate to audit the whole repository's history on every edit; the practical trigger is noticing the same kind of concession recurring in front of you, not running a forensic sweep. The signal is recurrence you can actually see, and the response is simply to stop feeding it.
