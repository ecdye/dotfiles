---
name: begin-ticket
description: Start work on a Jira ticket - set up a git worktree and branch, move the ticket to Coding, research the ticket against the codebase with subagents, and propose an implementation plan. Use whenever the user says "begin work on ticket DEV-1234", "start ticket DEV-1234", "pick up DEV-1234", "work on DEV-1234", or names a DEV-#### ticket as the thing to start. Also covers the follow-on commit/push discipline (rebase before first push, merge after) for that ticket's branch.
---

# Begin work on a Jira ticket

Ticket key comes from the user's message (pattern `DEV-\d+`). If no key is present, ask for it before doing anything.

## 1. Worktree and branch

- Worktrees live in `../worktrees` relative to the repo root. Create the directory if missing.
- Base branch: `staging` if it exists on the origin, else `main`. Fetch and pull the base before branching.
- Branch name: `DEV-XXXX/few-word-summary` — summary derived from the ticket title, kebab-case, a few words.
- Create the worktree for the new branch inside `../worktrees`, then work there (i.e. `../worktrees/DEV-XXXX`).

## 2. Jira

- Read the ticket (`getJiraIssue`) plus comments and linked issues for context.
- Transition the ticket to **Coding** (`getTransitionsForJiraIssue`, then `transitionJiraIssue`) to show work has begun.

## 3. Research and plan

Delegate the research. Prefer `sonnet` subagents, `opus` when the work warrants it. You are coordinating, not doing the work yourself. Make use of planning mode in your work.

- Fan out subagents to relate the ticket's context to the codebase: where the affected code lives, callers, existing patterns, tests, docs.
- Make no assumptions about scope. Ask clarifying questions before presenting the plan.
- The plan covers every aspect: implementation, tests, formatting, linting, docs, migrations/config if relevant.
- Present the plan for approval / refinement. Do not edit code before approval.

## 4. Implementation (after approval)

- Use the `ticket-implementer` agent to write the code — one per independent slice of the plan, launched concurrently where slices don't overlap files prefer `sonnet` subagents, `opus` when the work warrants it. Hand each one its slice, the files it touches, and the acceptance criteria.
- You keep work on track, review their reports, and integrate.
- After edits: autoformat, then lint, build, test. Fix failures before reporting back.

### Comments

- Minimal. Clear code gets no comment.
- When a comment is justified, state the **why**, not prose. One line.
- Evergreen — never reference ticket numbers.

## 5. Commit and push discipline

Never commit or push without explicit approval.

- Before committing, **check** whether the branch has ever been pushed (`git rev-parse --verify @{u}` / `git ls-remote origin <branch>`). Never assume — the user may have pushed manually.
- Never pushed: **rebase** onto the latest upstream base.
- Already pushed: **merge** the upstream base in. Never rebase, so a force push is never needed.
- When asked to push: bring in the latest base first (rebase or merge per the rule above), then push. Staying current with origin is required to merge.
