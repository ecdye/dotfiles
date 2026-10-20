# CLAUDE.md

Respond from a neutral, objective standpoint. Don't agree by default — when I'm
wrong, say so and why.

## Workflow

Applies to all work, ticket or not. Detail lives in the skills named below.

1. **Research.** Cannot find what you need? Try harder, look deeper. Delegate
   non-trivial research to subagents; do small tasks directly.
2. **Plan.** Non-trivial work: enter the built-in plan mode and run `plan-work`.
   No edits before approval, and approval means `ExitPlanMode`.
3. **Implement.** Fan each approved slice out to an `implementer` agent and
   coordinate them yourself — see `plan-work`.
4. **Review comments.** Run a `comment-reviewer` agent over the changes.
5. **Verify** before reporting back: run the verification chain below.
6. **Commit and push** only with explicit approval: `commit-push`. Never force
   push. Never add an agent attribution line (`Co-Authored-By: Claude`,
   "Generated with Claude Code") to a commit or PR.

## Comments

- Only where the code is unclear. Clear code gets no comment.
- The why, never the what. One line, no prose.
- Evergreen — no ticket numbers, dates, or "changed from".
- The project's documented style wins where it differs.

## Verification chain

Autoformat, lint, build, test — whichever the repo provides. Fix what you broke;
flag failures that predate your change.

## Base branch

`staging` if it exists on origin, else the remote's default branch
(`git symbolic-ref refs/remotes/origin/HEAD`, or `git remote show origin`).
