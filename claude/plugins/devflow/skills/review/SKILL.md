---
name: review
description: Step 4 of the bugfix and feature workflows. Run a fresh-context subagent review of the uncommitted change against the bug report or the feature requirements and the project conventions. Read-only, never fixes on its own.
argument-hint: "[Linear issue id or description, optional]"
---

# Review the change with a fresh-context reviewer

Input: $ARGUMENTS

The reviewer must not be anchored on your reasoning. Give it the report, the repro steps or acceptance criteria, and the diff. Do not give it your explanation of the change.

## 1. Collect inputs (read-only)

- `git status --short` to list changed and untracked files.
- Write the tracked diff to a temp file: `f=$(mktemp) && git diff HEAD > "$f" && echo "$f"`. If a pre-staged set exists, `git diff HEAD` already includes it.
- Untracked files do not show in the diff. Pass their paths to the reviewer so it reads them directly.
- Do not run `git add -N` or anything else that touches the index.

## 2. Launch the reviewer

Use the Agent tool with `subagent_type: "devflow:reviewer"`. Prompt contains only:

- The work type (bug, feature or review feedback round) from the `Work context` block. A review feedback round has none, say so.
- The report: Linear issue content if an id is known (fetch it), otherwise the user's description. For a review feedback round: the PR title and description.
- Bug: the repro steps and expected behavior from this conversation. Feature: the acceptance criteria and the approved plan from this conversation. The plan is the spec, not your reasoning. Review feedback round: the suggestions the user chose, each with the chosen option and notes, as the requirements. The diff is only the new changes since the last pushed commit: `git diff HEAD`.
- The path of the diff file and the list of untracked files.
- The repo root path.

## 3. Report

Relay the reviewer's findings, most severe first, without softening them or dropping any. Group as blocking and non-blocking. Add your own view only where you disagree with a finding, and say why.

## 4. Stop

- Blocking findings: ask whether to fix them. On yes, use the `fix` skill with the findings as feedback. Do not edit in this skill.
- No blocking findings: tell the user the code is ready for them to stage (step 5), then run `/devflow:ship`.
- Never stage, commit or change git state.
