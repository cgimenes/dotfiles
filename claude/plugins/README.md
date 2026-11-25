# personal marketplace

Personal Claude Code plugins for software development.

## devflow

Ticket workflows with human gates. Start with `/devflow:work <ABC-123 and/or description>`. It checks the branch, reads the ticket, moves it to In Progress, decides bug or feature, and hands off.

### Bugfix flow

| Step | Who | Command |
|------|-----|---------|
| 1. Repro steps (UI based) | Claude, user runs them | `/devflow:repro` |
| 2. Fix | Claude | `/devflow:fix [feedback]` |
| 3. Review code, loop to 2 | user | none |
| 4. Review with fresh subagent | Claude | `/devflow:review` |
| 5. Stage | user | `git add` |
| 6. Branch, commit, push, PR | Claude | `/devflow:ship` |

### Feature flow

| Step | Who | Command |
|------|-----|---------|
| 1. Acceptance criteria and plan, user approves | Claude + user | `/devflow:plan` |
| 2. Implement | Claude | `/devflow:fix [feedback]` |
| 3 to 6 | same as bugfix | same as bugfix |

`/devflow:bugfix` and `/devflow:feature` detect the current step in their flow and point to the next one.

### Review feedback flow

`/devflow:review-feedback [PR]` lists every review suggestion on a PR with trade-offs and a recommendation. You choose which to do and how, then `fix`, your review, `/devflow:review`, staging and `/devflow:ship` follow. `ship` commits, pushes and extends the PR description. It never replies to or resolves threads.

### Other skills

- `/devflow:generate-spec`: writes a detailed specification to `specs/[TASK_NAME].md`. `plan` offers it for large features.
- `/devflow:pairup <file>`: executes `cc:` markers left in a file and answers through `uu:` comments.
- `devflow:nestjs`: NestJS rules, loaded by `fix` when the project uses NestJS.

Claude never changes git state outside `ship`, except `work` checking out the default branch and pulling it (`--ff-only`) after you confirm. `ship` is user-invoked only and commits exactly the staged set.

## Install

Try without installing:

```sh
claude --plugin-dir ~/dotfiles/claude/plugins/devflow
```

Install permanently (run once per config dir, e.g. with `CLAUDE_CONFIG_DIR=<profile dir>` for a work profile):

```sh
claude plugin marketplace add ~/dotfiles/claude/plugins
claude plugin install devflow@personal
```

After editing files, run `/reload-plugins` or restart the session.

## Layout

```
claude/plugins/
  .claude-plugin/marketplace.json
  devflow/
    .claude-plugin/plugin.json
    agents/reviewer.md           read-only fresh-context reviewer (step 4)
    skills/work                  common start and bug/feature router
    skills/bugfix, repro         bugfix flow
    skills/feature, plan         feature flow
    skills/review-feedback       PR review suggestions flow
    skills/fix, review, ship     shared steps
    skills/generate-spec         specification writer
    skills/pairup                inline `cc:` instruction pairing
    skills/nestjs                NestJS rules, loaded by fix
```
