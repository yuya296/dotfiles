---
name: bugfix
description: Root-cause-oriented bug fixing workflow with lateral impact investigation and recurrence-prevention guardrails. Use when users ask to fix defects/bugs and want analysis beyond immediate symptoms, horizontal scans for similar faults, and concrete prevention actions such as test additions, validations, static checks, and process safeguards. Trigger especially on requests like "根本原因", "水平展開", "再発防止", "ガードレール", "不具合修正の進め方".
---

# Bugfix Root Cause Guardrails

## Goal

Apply a bug fix process that:
- Diagnose root cause before implementing changes.
- Scan horizontally for similar defects in adjacent modules.
- Add guardrails so the same failure mode cannot recur silently.

## Workflow

1. Define failure and impact.
2. Analyze root cause.
3. Design fix options and choose the resilient one.
4. Perform lateral investigation.
5. Implement fix and preventive guardrails.
6. Verify and report evidence.

## Step 1: Define Failure and Impact

Capture:
- Expected behavior vs actual behavior.
- Trigger conditions and input/state prerequisites.
- User/system impact severity.
- Earliest known introduction point (commit, release, config, migration, dependency update).

Do not modify code until this baseline is explicit.

## Step 2: Analyze Root Cause

Use a causal chain, not only the direct failing line:
- Identify immediate failure point.
- Ask why that point became invalid.
- Continue until reaching a design/process/test gap that allowed the defect.

Reject shallow fixes that only mask symptoms unless the user explicitly requests temporary mitigation.

## Step 3: Design Fix Options

Create at least two options when feasible:
- Minimal patch.
- Structural fix that addresses root cause.

Prefer the structural fix when risk and effort are acceptable. State trade-offs:
- Correctness risk.
- Regression risk.
- Complexity and maintainability.
- Delivery speed.

## Step 4: Perform Lateral Investigation

Search for equivalent failure patterns across the codebase:
- Same API misuse or missing validation pattern.
- Same state transition assumptions.
- Same copy-pasted logic branch.
- Same boundary condition handling gap.

Use fast code search first (`rg` patterns, call sites, schema usage, shared utilities). Review all suspicious matches and classify:
- `confirmed`: same defect exists.
- `related`: similar risk, no defect yet.
- `not-applicable`: superficially similar only.

Record findings in the report.

If needed, read `references/lateral-investigation-checklist.md`.

## Step 5: Implement Fix and Guardrails

Implement root-cause fix plus at least one preventive guardrail:
- Tests: regression test for the reproduced bug and neighboring edge cases.
- Validation: stronger runtime checks or invariant assertions.
- Type/contract hardening: stricter types, interfaces, schema constraints.
- Tooling: lint/static analysis/rules to block the pattern.
- Process: review checklist or CI gate for high-risk paths.

Prefer guardrails that fail early and loudly.

If needed, read `references/prevention-catalog.md`.

## Step 6: Verify and Report Evidence

Verify with:
- Reproduction case now passing.
- Existing relevant test suites.
- New guardrail behavior confirmed.
- Horizontal findings status confirmed.

Return a concise report with:
1. Root cause summary.
2. Why the fix addresses the root cause.
3. Horizontal scan scope and findings.
4. Added guardrails and rationale.
5. Residual risks and follow-up actions.

## Output Template

Use this structure in responses:

```text
[Root cause]
- Immediate cause:
- Deeper cause:
- Enabling gap:

[Fix strategy]
- Chosen approach:
- Why not shallow patch:

[Lateral investigation]
- Scope:
- Confirmed similar defects:
- Related risk points:
- Not applicable:

[Prevention guardrails]
- Tests:
- Validation/contract/tooling/process:

[Verification]
- Repro test:
- Regression suite:
- Remaining risks:
```
