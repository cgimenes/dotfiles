---
name: plan
description: Step 1 of the feature workflow. Turn a feature ticket or description into acceptance criteria and a short implementation plan, then wait for the user's approval. Does not edit code.
argument-hint: "[Linear issue id or feature description, optional]"
allowed-tools: Read, Grep, Glob
---

# Plan the feature

Input: $ARGUMENTS

Goal: user and Claude agree on what is built and how, before any code is written. Do not edit any file. Do not change git state. Do not change the Linear ticket.

## 1. Get the requirements

- Use the `Work context` block from this conversation. It holds the report, the ticket id and the branch check.
- No `Work context` in the conversation: the start steps did not run. Invoke the `devflow:work` skill instead, it hands back to the feature flow.
- For a large or ambiguous feature, offer to write a full specification with the `devflow:generate-spec` skill first. Do not start it unless the user says yes.

## 2. Acceptance criteria

List what must be true when the feature is done, as checkable bullets. Mark each as `explicit` (stated in the ticket) or `inferred` (your reasoning). Ask direct questions for gaps, product decisions and conflicting statements. Do not decide product behavior silently.

## 3. Explore the code

Read the code the feature touches and similar existing features. Identify the entry points (routes, screens, jobs), the data model, the project's patterns to follow and anything that could break. Say plainly what is verified in code and what is a guess.

## 4. Write the plan

Short, in the conversation. Cover only what applies:

- Approach in two or three sentences.
- Changes by layer: data model and migrations, backend (routes, services, repositories, validation at the boundary), frontend (screens, components, state).
- Where logic lives: business logic on the backend, atomic work in one transaction.
- Tests to add.
- Risks, failure cases and rollout concerns.
- Out of scope.
- If there is a real design trade-off, give the options with their trade-offs, then one recommendation.

## 5. Acceptance steps

Steps the user can follow by hand to check the finished feature. UI based whenever possible: open this screen, click this button, fill this field with this value, expect this on screen. Fall back to API steps only when no UI path exists, and say why in one line. Include environment, data needed and expected results.

## 6. Stop

Ask the user to approve the plan or send changes. Revise and ask again on feedback. Next step is `fix`, only after explicit approval.
