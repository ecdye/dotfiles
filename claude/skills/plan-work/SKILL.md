---
name: plan-work
description: Research a task against the codebase with subagents and propose an implementation plan for approval. Task source can be anything - a Jira ticket, a bug report, a pasted stack trace, or a plain request. Use whenever the user asks to plan, scope, investigate, or research a change before it is written ("plan X", "how would we do X", "figure out what X touches", "scope this"), and as the research step of begin-ticket. Do NOT use for one-line mechanical edits.
---

# Research and plan

Works from any task source: a Jira ticket, a bug report, a stack trace, a Slack
paste, or the user's own words. Nothing here assumes a ticket exists.

**Enter the built-in plan mode before doing anything else** — call
`EnterPlanMode` at the top of this skill, not after the research is done. Plan
mode is what enforces the no-edits-before-approval rule; do not hand-roll it.
Every step below happens inside plan mode, and the plan leaves it only via
`ExitPlanMode`, which is the approval gate (step 4).

## 1. Establish the task

- Restate the task in one or two lines: the observable problem or desired
  behavior, not the guessed solution.
- Gather whatever context the source offers before searching — ticket comments
  and linked issues, the full error, the reproduction steps, prior discussion.
- Missing something load-bearing? Ask now, not after the plan is written.

## 2. Research

Delegate. You are coordinating, not doing the work yourself. Prefer `sonnet`
subagents, `opus` when the work warrants it.

Fan out concurrently to relate the task to the codebase:

- where the affected code lives, and its entry points
- callers of anything likely to change — the fix belongs at the shared root all
  callers route through, not per-caller
- existing patterns, helpers, and types to reuse instead of writing new ones
- tests covering the area, and how this repo writes tests
- docs, config, migrations touched by the change

Bugs: find the root cause, not the symptom the report names. Do not plan around
a symptom.

## 3. Plan

- Make no assumptions about scope. Ask clarifying questions before presenting
  the plan — a wrong scope assumption is more expensive than a question.
- Cover every aspect: implementation, tests, formatting, linting, docs,
  migrations and config if relevant.
- Slice the plan into independent units where possible, and say which slices
  overlap files — `implement-plan` parallelizes on those boundaries.
- State the acceptance criteria per slice, and the verification commands the
  repo actually provides.
- Name what you deliberately left out and why.

## 4. Approval

Present the plan via `ExitPlanMode` — that is the approval gate, not a message
asking "look good?". **Do not edit code before approval.**

- Rejected or refined: stay in plan mode, revise, call `ExitPlanMode` again.
- Approved: hand off to `implement-plan`.
