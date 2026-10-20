---
name: begin-ticket
description: Start work on a Jira ticket - set up a git worktree and branch, read the ticket, and move it to Coding, then hand off to plan-work for research and planning. Use whenever the user says "begin work on ticket ABC-1234", "start ticket ABC-1234", "pick up ABC-1234", "work on ABC-1234", or names a Jira issue key (any board's prefix, e.g. DEV-1234) as the thing to start. Also covers the Jira transitions for the rest of that ticket's life.
---

# Begin work on a Jira ticket

The ticket key comes from the user's message — any board's prefix (pattern
`[A-Z][A-Z0-9]+-\d+`, e.g. `DEV-1234`). If no key is present, ask for it.

Research and pushing are `plan-work` and `commit-push`; this skill owns only the
ticket-specific setup.

## 1. Read the ticket

Read the ticket (`getJiraIssue`) plus comments and linked issues. Derive a
few-word kebab-case summary from the title.

## 2. Worktree and branch

- Branch `<KEY>/few-word-summary` off the base branch (CLAUDE.md), fetched
  first.
- Already in a linked worktree (usually, via Orca)? Use it, and rename its
  branch if it was never pushed.
- Otherwise create one at `worktrees/<KEY>`, next to the main checkout.

## 3. Transition to Coding

`getTransitionsForJiraIssue`, then `transitionJiraIssue` to **Coding**.

## 4. Hand off

Run `plan-work` with the ticket as the task source.
