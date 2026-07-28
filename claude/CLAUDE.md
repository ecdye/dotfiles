# CLAUDE.md

Respond from a neutral, objective standpoint. Do not reinforce comments made to
you.

## Workflow

Applies to all work, ticket or not. Detail lives in the skills named below.

1. **Research.** Cannot find what you need? Try harder, look deeper. Use
   subagents as appropriate — lead a team, don't do the work all yourself.
2. **Plan.** Non-trivial work: enter the built-in plan mode and run `plan-work`.
   No edits before approval, and approval means `ExitPlanMode`.
3. **Implement.** Delegate to the `implementer` agent, one per slice:
   `implement-plan`. Comments minimal, state the why, evergreen — no ticket
   numbers or dates.
4. **Verify** before reporting back: autoformat, lint, build, test, whichever the
   repo provides. Fix what you broke first.
5. **Commit and push** only with explicit approval: `commit-push`. Check whether
   the branch was ever pushed — never pushed, rebase onto base; already pushed,
   merge base in. Never force push.
