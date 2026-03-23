---
name: git-auto-commit
description: Automate the "git status → diff summary → Japanese commit message → git commit" workflow. Use when a user wants Codex to review pending changes, describe the diff, draft a Japanese commit message, and perform `git commit` after confirmation.
---

# Git Auto Commit

## Overview
This skill streamlines the entire review-to-commit loop. It standardizes how to inspect the working tree, narrate the changes in Japanese, draft a polished Japanese commit message, confirm with the user, and finally run `git commit`. Only the commands explicitly allowed by the requester (`git status`, `git diff`, `git commit`) are required.

## Quick Start
1. Make sure you are inside the repository root (or the directory the user specifies).
2. Run `git status --short --branch` and share the raw output.
3. Run `git diff` (or the helper script below) and summarize the important chunks in Japanese.
4. Propose a Japanese commit message (subject ≤ 50 chars) plus short bullets for motivation/testing.
5. Ask for approval; on approval, run `git commit -m "..."` (or `git commit` + editor if preferred).
6. Re-run `git status --short` and report that the tree is clean (or list remaining files).

## Step-by-Step Workflow

### 1. Gather context
- Default: run `git status --short --branch` followed by `git diff`.
- For large diffs, run `scripts/git_context_snapshot.py --diff-args --stat` to capture both status and diff snapshots. Share the generated file paths with the user to keep references consistent.

### 2. Summarize differences (Japanese only)
- Group the summary by file or feature. Keep each bullet under 1 line when possible.
- Mention rationale if obvious. When uncertain, explicitly mark it as a hypothesis (例: `推測: ...`).
- If the diff contains noisy files (lockfiles, snapshots), call them out and confirm whether to include them in the commit.
- When the diff is huge, prioritize high-impact files first and ask whether to trim the commit scope.

### 3. Draft the commit message (Japanese)
- Use the template described in `references/workflow.md`:
  - Line 1: concise summary without punctuation (≤50 chars)
  - Line 2: blank
  - Body: bullet list such as `- 変更理由: ...` and `- 動作確認: ...`
- Mention any TODOs (tests not run, manual verification pending) directly in the body bullets.
- Offer minor variations if the tone/style could be improved (e.g., 「〜を調整」 vs 「〜を修正」) so the user can pick quickly.

### 4. Confirm and commit
- Echo the final summary + commit message and ask for approval.
- On approval, run `git commit -m "<subject>\n\n<body>"` (escaping quotes/newlines appropriately). If staging is incomplete, pause and ask how to proceed before committing.
- After the commit, run `git status --short` again and report whether the workspace is clean. If not clean, list remaining files and suggest next steps (追加コミット or cleanup).

## Helper Script
`scripts/git_context_snapshot.py` captures `git status` and `git diff` outputs into timestamped files under `.codex/git-auto-commit/` (configurable via `--out-dir`). Use it whenever the diff is large or needs to be reused in later messages. Invoke it from any repo:
```
python3 scripts/git_context_snapshot.py [--out-dir path] [--diff-args ...]
```
Only `git status` and `git diff` are executed under the hood, keeping compliance with the user's constraint.

## Reference
See `references/workflow.md` for:
- Detailed guidance on each phase (確認 / 要約 / メッセージ / コミット)
- Commit message template (Japanese) and reasoning checklist
- Troubleshooting tips (e.g., huge diffs, hook failures)

Keep all conversational responses in Japanese even though the skill itself is documented in English.
