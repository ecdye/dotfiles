---
name: commit-push
description: Commit and push a branch safely - check whether the branch was ever pushed, then rebase (never pushed) or merge (already pushed) the upstream base before pushing, so a force push is never needed. Use whenever the user asks to commit, push, update a branch against its base, or open a PR, on any branch, ticket or not. Applies before the first push of a branch and every push after.
---

# Commit and push

**Never commit or push without explicit approval.** Approval for one commit is
not approval for the next.

## 1. Check the branch state

Never assume — the user may have pushed manually.

```
git rev-parse --verify @{u}          # is there an upstream?
git ls-remote origin <branch>        # does the remote branch exist?
```

## 2. Bring the base current

Base branch: `staging` if it exists on the origin, else `main`. Fetch first.

- **Never pushed:** rebase onto the latest upstream base.
- **Already pushed:** merge the upstream base in. Never rebase, so a force push
  is never needed.

Conflicts: stop and surface them. Do not guess at a resolution in someone else's
code.

## 3. Commit

- Verify first: autoformat, lint, build, test. Do not commit a broken tree.
- Review the staged diff before writing the message — never `git add -A` blind.
- Message states the why. No ticket numbers in the body; the branch carries the
  key.

## 4. Push

Bring in the latest base first (rebase or merge per the rule above), then push.
Staying current with origin is required to merge.

Never force push. If a force push looks necessary, the rule in step 2 was
skipped — stop and say so instead.
