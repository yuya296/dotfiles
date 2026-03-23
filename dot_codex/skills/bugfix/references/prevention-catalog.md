# Prevention Catalog

Pick one or more guardrails based on failure mode.

## Test Guardrails

- Reproduction regression test: codify exact failing input/state.
- Boundary tests: min/max/null/empty/invalid enum/timezone/locale.
- Property-based or table-driven tests for combinational paths.
- Contract tests for external dependency response variations.

## Runtime Guardrails

- Input validation at boundaries with explicit error paths.
- Invariant assertions for impossible states.
- Idempotency checks for retry-sensitive operations.
- Feature flag safety default and rollback switch.

## Type and Schema Guardrails

- Tighten nullable/optional typing.
- Replace stringly-typed fields with enums/value objects.
- Schema constraints for DB/API payloads.
- Versioned adapters for backward compatibility boundaries.

## Tooling and CI Guardrails

- Lint rule for banned risky pattern.
- Static analysis check in CI.
- Required test targets in pull request checks.
- Diff-based policy check for critical directories.

## Process Guardrails

- Add review checklist item tied to the defect class.
- Add release note verification for risky components.
- Add operational runbook note for quick diagnosis.

## Selection Heuristics

- Prefer compile-time and CI-time detection over runtime detection.
- Prefer shared utility fixes over duplicated local fixes.
- Prefer deterministic tests over manual QA-only coverage.
- Prefer one strong guardrail over many weak ones.
