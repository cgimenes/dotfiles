---
name: repro
description: Step 1 of the bugfix workflow. Produce manual steps for the user to reproduce a bug, using the report gathered by the work skill. Does not edit code.
argument-hint: "[Linear issue id or bug description, optional]"
allowed-tools: Read, Grep, Glob, mcp__claude_ai_Linear__get_issue, mcp__claude_ai_Linear__list_comments, mcp__claude_ai_Linear__extract_images
---

# Reproduce the bug

Input: $ARGUMENTS

Goal: user can reproduce the bug by hand following your steps. Do not edit any file. Do not change git state. Do not change the Linear ticket.

## 1. Get the report

- Use the `Work context` block from this conversation. It already holds the report, the ticket id and the branch check.
- No `Work context` in the conversation: the start steps did not run. Invoke the `devflow:work` skill instead, it hands back to the bugfix flow.

## 2. Find the code path

Read the code that handles the failing behavior. Identify the entry point (route, screen, job, command), the data it depends on and the likely failing spot. Say plainly what is verified in code and what is a guess.

## 3. Write the repro steps

Give the user a numbered list they can follow by hand.

Steps must be UI based whenever possible. Write them as what a user does in the app: open this screen, click this button, fill this field with this value, expect this on screen. A backend bug usually still has a UI path that triggers it, so find that path first by tracing which screen calls the failing route.

Fall back to API steps only when no UI path exists (webhooks, scheduled jobs, internal endpoints, admin-only routes with no screen) or the UI cannot reach the failing state. Then say in one line why the UI cannot be used, and give a `curl` or Bruno request. Where it helps, give the UI steps first and the API request as an optional shortcut.

- Environment: branch, services to run, env vars or flags, build and run commands, hot reload notes.
- Data needed: seed data, accounts, roles, fixtures, exact values.
- Steps: app URL, screen names, menu paths, buttons, field values, device or viewport for mobile issues.
- Expected result.
- Actual result (the bug), including the exact error text or status code when known.
- Where to look when it fails: what to see on screen first, then network tab, logs, DB rows.

If a failing automated test is the easier proof, offer it as an option. Do not write it until the user asks.

Also state:

- Suspected area (file and function) and confidence.
- Missing information that blocks a reliable repro, as direct questions.

## 4. Stop

End by asking the user to run the steps and report back: reproduced, not reproduced, or different behavior. Next step is `fix`, only after the user confirms the repro. If the result differs from the report, revise the steps and ask again.
