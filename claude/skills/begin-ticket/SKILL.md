---
name: begin-ticket
description: Start work on a Jira ticket - set up a git worktree and branch, read the ticket, and move it to Coding, then hand off to plan-work for research and planning. Use whenever the user says "begin work on ticket DEV-1234", "start ticket DEV-1234", "pick up DEV-1234", "work on DEV-1234", or names a DEV-#### ticket as the thing to start. Also covers the Jira transitions for the rest of that ticket's life.
---

# Begin work on a Jira ticket

Ticket key comes from the user's message (pattern `DEV-\d+`). If no key is
present, ask for it before doing anything.

This skill owns only the ticket-specific setup. Research, planning,
implementation, and pushing are the general skills: `plan-work`,
`implement-plan`, `commit-push`.

## 1. Read the ticket

- Read the ticket (`getJiraIssue`) plus comments and linked issues for context.
- Derive a few-word kebab-case summary from the title for the branch name.

## 2. Worktree and branch

- Worktrees live in `../worktrees` relative to the repo root. Create the
  directory if missing.
- Base branch: `staging` if it exists on the origin, else `main`. Fetch and pull
  the base before branching.
- Branch name: `DEV-XXXX/few-word-summary`.
- Worktree path: `../worktrees/DEV-XXXX`. Work there for the rest of the ticket.

## 3. Transition to Coding

`getTransitionsForJiraIssue`, then `transitionJiraIssue` to **Coding**, to show
work has begun.

## 4. Hand off

Run `plan-work` with the ticket as the task source. Everything after that is the
general workflow — nothing about it is ticket-specific.
