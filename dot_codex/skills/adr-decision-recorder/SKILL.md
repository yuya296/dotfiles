---
name: adr-decision-recorder
description: Decide whether a decision in a user-agent conversation should be recorded as an ADR, and create the ADR when needed. Use when the conversation includes a decision signal (e.g., "OK", "let's do that", "その方針で行こう") and you must judge ADR necessity, then write a new ADR under docs/adr with the required template.
---

# Adr Decision Recorder

## Overview

Determine if a decision in the conversation warrants an ADR and, when it does, create the ADR file in the expected location and format.

## Workflow

1. Detect a decision in the conversation.
   - Decision signals include: "OK", "let us do that", "we will", "let's do it this way", "その方針で行こう", "決めよう", or any explicit agreement on a direction.
   - If no decision is present, do nothing and avoid creating an ADR.

2. Decide whether an ADR is warranted.
   - Create an ADR if any of these apply:
     - Someone might later ask, "Why is it like this?"
     - Changing it later has broad impact (multiple modules, data, user impact).
     - There are trade-offs (speed vs maintainability, flexibility vs simplicity, etc.).
     - It narrows future choices (lock-in, structural fixation).
     - There were multiple alternatives and the rationale matters.
   - If none apply, do not create an ADR.

3. Gather required content.
   - Ensure you have: context, options considered, decision, consequences, references.
   - If any are unclear, ask concise follow-up questions before writing the ADR.

4. Create the ADR file.
   - Location and name: `docs/adr/ADR-${NUMBER}-${TITLE}.md`
   - If `docs/adr` does not exist, create it.
   - Determine NUMBER:
     - Find the highest existing ADR number under `docs/adr/ADR-*.md`.
     - Increment by 1.
     - Preserve zero-padding width if the existing files use it. If no ADRs exist, start at 1 (use no padding unless a standard is established).
   - Determine TITLE:
     - Short, English, ASCII-only, kebab-case (e.g., `use-postgresql-for-events`).
     - Reflect the decision topic.

5. Write the ADR content in Japanese using this template:

```
## Context
<なぜこの判断が必要か。背景や制約も含めて簡潔に>

## Options considered
- <選択肢1> - <簡単な長所/短所>
- <選択肢2> - <簡単な長所/短所>

## Decision
<何を決めたか。理由も一言で>

## Consequences
<想定される影響、トレードオフ、フォローアップ、リスク>

## References
- <関連リンク。なければ "N/A">
```

6. Summarize the ADR creation in the response with the file path.
