---
name: fix
description: Step 2 of the bugfix and feature workflows. Fix a reproduced bug at its root cause, implement an approved feature plan, or apply the user's review feedback to the existing change. Never stages or commits.
argument-hint: "[review feedback, optional]"
---

# Implement the change

Input: $ARGUMENTS (empty on first pass, review feedback on later passes).

The work type (bug or feature) is in the `Work context` block of the conversation.

## Preconditions

- First pass, bug: the user must have confirmed the repro in this conversation. If not, say so and suggest the `repro` skill, unless the user explicitly said to skip it.
- First pass, feature: the user must have approved the plan in this conversation. If not, say so and suggest the `plan` skill, unless the user explicitly said to skip it.
- Later passes: $ARGUMENTS holds feedback from the user's review (step 3). Fix every finding the user names. Separate concerns stay separate, so the user can split commits later.

## Rules

- Bug: fix the root cause, not the symptom. After the real fix, check whether earlier workarounds or related changes are still needed and remove them.
- Feature: implement the approved plan and its acceptance criteria, nothing more. If the plan turns out wrong or incomplete, stop and tell the user before deviating.
- Follow the project's existing patterns before inventing a new one. Read neighboring code first.
- Put logic where it belongs: business logic and calculations on the backend, atomic operations in one backend transaction, queries in repositories, validation at the boundary.
- Data access goes through a dedicated repository, injected by DI.
  - Whenever the fix needs data access, inject an instance of that model's dedicated repository into the class through the DI framework. No `moduleRef.get`, no manual instantiation.
  - If the repository class does not exist, create it, following the existing repositories' pattern. Queries and persistence logic live in it, as methods.
  - If a class you change or need to change for the fix uses an `EntityManager` directly, `getRepository` or similar for data access, refactor that class to use the injected repository. Move the queries into repository methods. This refactor is in scope, do not leave it for later.
  - Keep transactions as they are: when the project passes the entity manager into repository methods for atomic work, do the same, calling the manager's own method directly.
  - Classes untouched by the fix keep their current data access. Report them as out-of-scope findings.
- Modules: never add a provider that belongs to another module directly to a module's `providers` array. Export it from its owning module, then import that module where it is needed. If a module you touch already re-declares a foreign provider, fix it the same way. Resolve circular imports with the DI framework's own mechanisms, not by re-declaring the provider.
- Framework specifics: if `package.json` has `@nestjs/*` dependencies, invoke the `devflow:nestjs` skill with the Skill tool before writing code, and apply it together with the rules above.
- Keep the change minimal and scoped. Problems found outside the scope: do not fix, report them at the end so the user can ticket them as a BUG in Linear.
- No comments unless the reason is non-obvious. No dead code, no compat shims, no speculative flags.
- Never stage, unstage, commit, branch, checkout, stash or push. Edit files in the working tree only.

## Verify

- Run type checks, linters and the relevant tests. For frontend work run `tsc --noEmit` and eslint.
- Bug: add or update a test that fails before the fix and passes after, when the project has a test setup that fits.
- Feature: add tests covering the acceptance criteria, when the project has a test setup that fits.
- Report failures faithfully with the output. Do not claim a pass that did not run.

## Report

1. Bug: root cause, in one or two sentences. Feature: what was built and any deviation from the plan.
2. What changed, per file, short.
3. Out-of-scope findings, if any.
4. How to test by hand. Bug: reuse the repro steps, say what should now be different (reproduced before, fixed after). Feature: reuse the acceptance steps from the plan. Include flags, URLs and commands if they changed.
5. What was verified and what was not.

Then stop. Step 3 is the user's review. They will either send feedback (run this skill again) or say they are satisfied, which leads to the `review` skill.
