---
name: work
description: Entry point for working on a ticket or a described task. Checks the branch, reads the Linear ticket, moves it to In Progress, classifies the work as bug or feature, and hands off to the bugfix or feature skill. Use when the user says to start, pick up or work on a ticket or task.
argument-hint: "[Linear issue id and/or description]"
allowed-tools: Read, Grep, Glob, mcp__claude_ai_Linear__get_issue, mcp__claude_ai_Linear__list_comments, mcp__claude_ai_Linear__extract_images, mcp__claude_ai_Linear__list_issue_statuses, mcp__claude_ai_Linear__save_issue
---

# Start work

Input: $ARGUMENTS (Linear issue id, free text, or both).

Goal: common start for every task, then hand off to the right workflow. Do not edit any file. Do not change git state, except the confirmed checkout and pull of the default branch in step 0. The only other write allowed is moving the Linear ticket to In Progress, which needs no confirmation.

## 0. Check the branch

Before anything else, including the Linear status change:

- `git branch --show-current`. Default branch: `git symbolic-ref --short refs/remotes/origin/HEAD` with the `origin/` prefix stripped, falling back to `main`, then `master`.
- Not a git repo: skip this step and say so.
- On the default branch: continue silently.
- On any other branch: stop and ask for confirmation to run `git checkout <default branch>`. Say which branch they are on and that `ship` branches from the default one. Run `git status --short` first and mention uncommitted changes in the question. Offer three answers: switch, stay on the current branch, abort.
  - Switch: run `git checkout <default branch>`, then `git pull --ff-only`. No stash, no reset, no merge commit. If either fails (e.g. conflicting local changes, diverged history, no upstream), report the output and stop. Do not move the ticket after a failure.
  - Stay: continue on the current branch and say so.
  - Abort: stop. Do not move the ticket.
  - Do not checkout, pull or move the ticket until they answer. This checkout and pull are the only git state changes `work` may make, and only after an explicit yes.

## 1. Gather the report

- If input has a Linear id (e.g. `ABC-123`): `get_issue`, then `list_comments` (discussion is not in the issue), then `extract_images` on any screenshot markdown. Keep the id, it is used for the branch name later.
- If input is free text: use it as the report. Ticket id is optional, do not insist on one.
- Both given: Linear is the source of truth, free text adds context.

## 2. Move the ticket to In Progress

Right after `get_issue`. Skip when there is no ticket id.

- Look at the issue's current status type. If it is already `started` (In Progress, In Review or similar), `completed` or `canceled`, leave it alone and tell the user the current status. Never move a ticket backwards.
- Otherwise call `list_issue_statuses` for the issue's team, pick the status named `In Progress` (fall back to the single `started` type status if the name differs, ask the user if there are several), then `save_issue` with only the `id` and the new `state`. Change nothing else: no assignee, labels or comments.
- If the call fails, report the error and continue. Do not retry in a loop.

## 3. Classify: bug or feature

Decide from the ticket or description:

- Labels win over text. A label like Bug or Defect means bug. A label like Feature, Improvement or Enhancement means feature.
- Without a useful label, read the text. Bug signals: something that worked or should work is broken, errors, crashes, regressions, "expected X but got Y", steps to reproduce. Feature signals: new capability, "add", "support", "as a user I want", a change in behavior that was asked for.
- Neither fits or it is mixed (chore, refactor, docs, spike, bug report that really asks for new behavior): do not guess. Ask one short question: bug flow or feature flow?
- Clear case: state the result in one line with the reason, e.g. "Treating as bug: label Bug and steps to reproduce." Continue without waiting. The user can correct it.

## 4. Hand off

Write a short block in the conversation so later steps can rely on it:

```
Work context
- Ticket: <id or none>, <title>
- Type: bug | feature
- Branch check: done
- Ticket status: moved to In Progress | already <status> | not applicable
- Report: <key points of the ticket or description, including comments and screenshot content>
```

Then invoke the Skill tool with `devflow:bugfix` (type bug) or `devflow:feature` (type feature), passing the ticket id or the description as the argument.

## Gates

- Never stage, unstage, commit, branch, push, merge or open a PR. Never start `ship`.
- Everything after the hand off follows the rules of the invoked workflow.
