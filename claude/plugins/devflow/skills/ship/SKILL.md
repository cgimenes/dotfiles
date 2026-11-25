---
name: ship
description: Step 6 of the bugfix and feature workflows. Branch, commit exactly the staged set, push and open a PR. Only runs when the user types /devflow:ship.
argument-hint: "[Linear issue id, optional]"
disable-model-invocation: true
---

# Ship the staged change

Input: $ARGUMENTS

The user typing this command is the permission to branch, commit, push and open a PR for this task. It covers only what is listed here, only for this task.

## Preconditions (stop and report if any fails)

1. `git diff --cached --name-only` is not empty. If nothing is staged, stop and tell the user to stage first.
2. Remember the staged file list. Commit exactly that set. Never run `git add`, `git commit -a`, `git stash` or any command that changes what is staged. Unstaged changes stay untouched, mention them to the user.
3. Only when a new branch must be created: ticket id from $ARGUMENTS, else from the conversation, else ask once. If there is no ticket, say so and use a branch name without it.
3a. Only when a new branch must be created: work type, bug or feature, from the `Work context` block. Not in the conversation: ask once. Not needed on a branch that already has an open PR, such as after `review-feedback`.
4. If the repo has a changelog (look for `CHANGELOG*`) and it is not part of the staged set, stop and tell the user. Do not edit or stage it yourself.

## Branch

- Check `git branch --show-current` and whether the branch already has an open PR (`gh pr view --json number,url,state 2>/dev/null`).
- Already on a work branch (`fix/` or `feat/`) with an open PR: skip branching and PR creation, go to Commit, then Push, then Update PR.
- On `main` (or the default branch): `git checkout -b {prefix}/{ticket-id}-{short-slug}`, with prefix `fix` for a bug and `feat` for a feature, for example `fix/ABC-123-order-total-rounding` or `feat/ABC-456-export-invoices`. The staged changes carry over. Lowercase slug, hyphens, a few words.
- On any other branch without a PR: ask whether to branch from it or from `main`. Branch from `main` unless told otherwise.

## Commit

- Read `git log --oneline -10` and match the repo's commit style. Include the ticket id if the repo does so.
- Message in normal prose: short subject in imperative mood, then a body that gives the motivation and, for a bug, the root cause, not a file list.
- If the staged set clearly holds separate concerns, propose splitting into several commits and ask before doing it. Splitting needs unstage and restage, which only the user can authorize.
- End the message with the attribution line from the harness system reminder, when one is present. Pass the message with a heredoc.
- Do not use `--no-verify`. If hooks fail, report the output and stop. Do not work around them.

## Push

`git push -u origin <branch>`. Never force push. If rejected, report and stop.

## Open PR

Base `main` unless told otherwise. Use `gh pr create`. Title: same style as the commit subject. Body in normal prose.

Bug:

- **Problem**: what was wrong and where it showed up, with the ticket link or id.
- **Root cause**.
- **Fix**: what changed and why this approach.
- **How to test**: the repro steps from this conversation, and the expected result after the fix.
- **Out of scope**: problems found and not fixed, if any.

Feature:

- **Motivation**: what the user or business needs, with the ticket link or id.
- **Changes**: what was built and why this approach, including notable decisions from the approved plan.
- **How to test**: the acceptance steps from the plan, and the expected results.
- **Out of scope**: what was deliberately left out, if any.

End the body with the PR attribution line from the harness system reminder, when one is present.

## Update PR

When new commits were pushed to an already open PR, update the description with `gh pr edit --body-file` so it also explains the motivation behind the new commits. Read the current body first and extend it. Do not replace it.

## Finish

Print: branch name, commit hash(es), PR URL. Never merge. Mention any unstaged changes that were left alone.
