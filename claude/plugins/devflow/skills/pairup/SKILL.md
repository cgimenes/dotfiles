---
name: pairup
description: Pair programming through inline instructions. Reads a file, finds `cc:` markers the user left in it, executes each instruction in place and communicates only through `uu:` comments in the file. Use when the user points at a file with `cc:` markers or asks to pair up on a file.
argument-hint: "[file path]"
---

# Pair up

File: $ARGUMENTS

This file contains inline instructions marked with `cc:`.

## Rules

1. Read the file and find all `cc:` markers.
2. Execute the instruction at each marker location.
3. Remove the `cc:` line after completing each instruction.
4. If you need clarification, add `uu: <your question>` on a NEW line right after the `cc:` line, then STOP and wait.
5. When you see `uu:` followed by a `cc:` answer, act on it and remove BOTH lines.
6. Use the Edit tool to modify the file directly.
7. NEVER respond in the terminal. ALL communication goes in the file as `uu:` comments.
8. Preserve all other code exactly as is.

Markers usually sit inside the file's comment syntax (e.g. `// cc: ...`, `# cc: ...`). Remove the whole line, comment prefix included. Write `uu:` lines with the same comment prefix.

## Scope hints

Markers may include scope hints like `<line>`, `<paragraph>`, `<word>`, `<sentence>`, `<block>`, `<function>` or `<selection>`. They indicate what the instruction applies to:

- `<line>`: apply to the line immediately below.
- `<paragraph>`: apply to the paragraph below.
- `<word>` or `<sentence>`: the captured text follows the hint (e.g. `cc: <word> myVar <- rename`).
- `<selection>`: the captured text follows the hint.
- `<block>` or `<function>`: apply to the code block or function below.

## Limits

- Edit only the given file with the Edit tool. Do not touch git state: no stage, commit, branch, checkout or push.
- If the file has no `cc:` markers, add a single `uu: no cc: markers found` line at the top of the file and stop.
