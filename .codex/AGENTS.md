# AGENTS.md — Codex working agreements for this repo

## Invariants (must always hold)
- Keep changes minimal and localized.
- Prefer simple, readable code over abstractions.
- No breaking API/CLI changes without updating docs + tests.
- Preserve existing behavior unless the task explicitly changes it.
- Don’t introduce new deps/tools unless explicitly required by the task.

## First steps (do before editing)
1) Identify the project’s “truth” commands:
   - Build:
   - Unit tests:
   - Integration tests (if any):
   - Lint/format:
2) Locate the most relevant existing tests and examples.
3) State a short plan: files to touch, tests to add/update, and risk.

## Implementation loop (tight)
- Make one small change at a time.
- After each meaningful change:
  - run the smallest relevant test command
  - if it fails: stop, diagnose, fix; don’t continue stacking changes
- Prefer adding a failing test first for bug fixes.

## Testing expectations
- Any behavior change must have tests.
- Keep tests focused:
  - one new test per case/bug
  - avoid snapshot/golden bloat unless the repo already uses it
- Don’t relax assertions to “make tests pass” unless you justify why the old assertion was wrong.

## Code style & conventions
- Use the repo’s existing formatter/linter (do not introduce new ones).
- Match existing patterns in the surrounding code (naming, errors, logging).
- Keep public interfaces documented (README and/or docstrings where the repo expects it).

## Commit / diff hygiene
- Prefer small commits; if non-trivial, split into:
  1) refactor-only (no behavior change)
  2) behavior change + tests
- Keep diffs reviewable: avoid unrelated cleanup.

## Output requirements (what to report back)
When you finish, include:
- What changed (high-level)
- Files touched
- Tests run (exact commands) + result summary
- Any follow-ups or known limitations

## Safety / guardrails
- Don’t exfiltrate secrets; never print env vars or tokens.
- Don’t modify lockfiles or generated files unless required by the change.
