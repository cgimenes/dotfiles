---
name: feature
description: Entry point for the feature workflow. Use when the task is new behavior or a requested change, not a bug. Detects the current step and runs or points to the next one.
argument-hint: "[Linear issue id or feature description]"
---

# Feature workflow

Input: $ARGUMENTS (Linear issue id, free text, or both).

Normally reached through the `work` skill, which checks the branch, moves the ticket to In Progress and classifies the task. If the conversation has no `Work context` block, invoke `devflow:work` first. It hands back here.

## Steps

| # | Step | Who | Skill |
|---|------|-----|-------|
| 1 | Plan: requirements, acceptance criteria, approach. User approves | Claude + user | `plan` |
| 2 | Implement the approved plan | Claude | `fix` |
| 3 | Review code, give feedback, loop back to 2 until satisfied | user | none |
| 4 | Review code with fresh-context subagent | Claude | `review` |
| 5 | Stage the changes | user | none |
| 6 | Branch, commit, push, open PR | Claude | `ship` (user types `/devflow:ship`) |

## Gates

- Step 1 ends with the user's approval of the plan. Do not implement before it.
- Steps 3 and 5 belong to the user. Never skip, never do them on their behalf.
- Never stage, unstage, commit, branch, checkout, push, merge or open a PR outside `ship`. One exception: `work` may check out the default branch and `git pull --ff-only` after the user confirms.
- Never start `ship` yourself. Only the user starts it.

## Find current step

Read-only checks only: `git status --short`, `git diff --cached --stat`, `git branch --show-current`, plus what the conversation already contains.

- No approved plan in conversation: step 1. Follow the `plan` skill.
- Plan approved, no code changes yet: step 2. Follow the `fix` skill.
- Unstaged changes exist and user has not said review is done: step 3 is the user's. Offer the `fix` skill if they have feedback, or `review` if they say they are satisfied.
- Review done with no open findings and nothing staged: tell user to stage and then run `/devflow:ship`.
- Staged changes exist: tell user to run `/devflow:ship`.

If unclear, ask one short question instead of guessing.
