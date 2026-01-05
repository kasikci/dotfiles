# AGENTS (Generic Template)

## Mission
Provide safe, minimal, and well-documented changes. Prefer clarity and maintainability over cleverness.

## Working style
- Be concise and explicit; call out assumptions and risks.
- Keep changes minimal and localized; prefer readable code over abstractions.
- No breaking API/CLI changes without updating docs + tests.
- Keep new files around 300 LOC. Split/refactor if needed.
- Iterate until tests succeed. Give up oly after 5 tries at refactoring.

## Tooling & style
- Use the repo’s existing formatter/linter; do not introduce new ones unless necessary.
- Add or extend tests for behavior changes.
- Keep public interfaces documented (README or docstrings).
- Prefer `rg` for searching.

## Tests & verification
- Use local `run_tests` scripts when provided.
- If no script exists, use the repo’s standard test runner.
- If tests are skipped, state why and how to run them.

## Documentation
- Update README/usage docs when behavior changes.
- For operator-facing flows, include commands and expected outcomes.

## Git / workflow
- Small, reviewable edits; no destructive git ops unless explicitly requested.
- Do not amend commits unless asked.

## Permissions
  filesystem:
    read: all
    write: all
    delete: all
  commands:
    run: all
  network:
    access: all

## Policy:
  assume_yes: true
  non_interactive: true
