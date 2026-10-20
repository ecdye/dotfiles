---
name: plan-work
description: Research a task against the codebase with subagents and propose an implementation plan for approval. Task source can be anything - a Jira ticket, a bug report, a pasted stack trace, or a plain request. Use whenever the user asks to plan, scope, investigate, or research a change before it is written ("plan X", "how would we do X", "figure out what X touches", "scope this"), and as the research step of begin-ticket. Do NOT use for one-line mechanical edits.
---

# Research and plan

Call `EnterPlanMode` first, before any research — plan mode is what enforces no
edits before approval.

## 1. Research

Fan out `Explore` agents concurrently to find where the affected code lives,
its callers, existing patterns to reuse, and the tests covering it. Bugs: find
the root cause, not the symptom.

## 2. Plan

- Ask only when the answer would change the plan. Otherwise state your
  assumptions in the plan.
- Slice the work into independent units and note which slices share files —
  that decides what can run in parallel.
- Give each slice its acceptance criteria.

## 3. Approval

Present the plan with `ExitPlanMode`; that is the approval gate. If it's
refined, revise and present again.

## 4. Implement

Dispatch one `implementer` agent per slice, each fully briefed — it has none of
your context. Slices that share no files run concurrently; overlapping ones run
in sequence. Re-dispatch a slice that fails or drifts rather than patching it
yourself, so the fix gets the same verification. If an agent reports the plan
is wrong, bring it back to the user.

## 5. Review comments

Once all slices land, run a `comment-reviewer` agent over the combined diff.

## 6. Verify

Review the combined diff for seams between slices, then run the verification
chain over the whole tree.
