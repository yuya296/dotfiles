# Lateral Investigation Checklist

Use this checklist when scanning for similar defects.

## 1. Pattern Extraction

- Extract the failing pattern as a searchable signature.
- Include function names, error messages, field names, and state transitions.
- Prepare 2-4 `rg` query variants to reduce false negatives.

## 2. Search Axes

- Same utility/helper usage.
- Same external API/SDK call shape.
- Same data model fields (read/write/transform).
- Same validation boundary (input parsing, null handling, range checks).
- Same concurrency/lifecycle timing point.

## 3. Classification

For each hit, classify exactly one:
- `confirmed`: bug is present and reproducible or clearly provable.
- `related`: risky similarity but not currently broken.
- `not-applicable`: structurally different despite textual similarity.

## 4. Evidence

For `confirmed` and `related`:
- Record file path and line.
- Record why it matches the risk pattern.
- Record required fix level (patch now / follow-up issue).

## 5. Closure Rule

Complete lateral investigation only when:
- Search queries and scope are documented.
- All major hit clusters are reviewed.
- Confirmed defects are either fixed now or tracked with owner and deadline.
