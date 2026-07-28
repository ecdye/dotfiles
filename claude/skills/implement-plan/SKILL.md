---
name: implement-plan
description: Execute an approved implementation plan by delegating each independent slice to an implementer agent, then reviewing and integrating their work and running the verification chain. Use after a plan has been approved, whether or not a ticket is involved ("go ahead", "implement the plan", "build it"). Do NOT use before approval, or for research and planning - that is plan-work.
---

# Implement an approved plan

The plan is settled. This step executes it; it does not redesign it.

## 1. Slice

- One `implementer` agent per independent slice, launched concurrently where
  slices do not touch the same files. Overlapping slices run in sequence.
- Prefer `sonnet` agents, `opus` when the slice warrants it.
- Hand each agent: its slice, the files it touches, the acceptance criteria, and
  the verification commands this repo provides. Nothing beyond its slice.
- Small enough to do yourself in one or two files? Do it yourself.

## 2. Coordinate

- You keep the work on track: read every report, check the diff against the
  plan, and integrate.
- An agent reporting the plan is wrong or impossible: stop, bring it back to the
  user, re-plan. Do not improvise a redesign.
- An agent flagging something out of scope: record it, do not fix it now.

## 3. Comments

- Minimal. Clear code gets no comment.
- When a comment is justified, state the **why**, not prose. One line.
- Evergreen — never reference ticket numbers, dates, or "changed from".

## 4. Verify

Run whatever the repo actually provides, in this order — check `package.json`
scripts, Makefile, or config; do not invent commands:

1. autoformat
2. lint
3. build
4. tests

Fix failures before reporting back. A failure that predates the change: say so
and leave it.

## 5. Report

Tell the user what changed, what was verified with what result, and anything
deferred or left out. Then stop — committing is `commit-push`, and needs its own
approval.
