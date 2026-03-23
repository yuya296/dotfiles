---
name: gh-cli-operator
description: Operate GitHub tasks with gh CLI. Use this skill whenever running any `gh` command or when the user asks to operate GitHub (pull requests, issues, reviews, checks, comments, or reviewers).
---

# Gh Cli Operator

## Overview

Use `gh` as the default interface for GitHub tasks in the terminal.
Resolve URLs to concrete targets, gather facts first, then perform only the requested write actions.

## Workflow

1. Identify target and intent.
2. Verify `gh` availability and authentication.
3. Inspect current state with read-only commands.
4. Execute requested mutation only after confirming scope.
5. Report results with exact command outcomes and next actions.


## Step 1: Identify Target and Intent

Parse user input into one of these targets:
- Repository URL: `https://github.com/<owner>/<repo>`
- Pull request URL: `https://github.com/<owner>/<repo>/pull/<number>`
- Issue URL: `https://github.com/<owner>/<repo>/issues/<number>`
- Owner/repo shorthand: `<owner>/<repo>`

Classify intent early:
- Inspect: status, diff, checks, reviewer comments
- Review: produce findings from code changes
- Mutate: comment, reply, review submit, merge, labels

If the user asks for "review", default to code-review behavior:
- Prioritize bugs, regressions, risk, missing tests.
- List findings first, ordered by severity.
- Include file and line references when available.

## Step 2: Verify CLI Readiness

Run these checks first:

```bash
gh --version
gh auth status
```

If authentication is missing or invalid, stop and ask the user to authenticate before proceeding.

## Step 3: Read-Only Inspection Commands

Prefer these commands for discovery:

```bash
gh repo view <owner>/<repo>
gh pr view <url-or-number> --json number,title,author,state,mergeStateStatus,reviewDecision,commits,files,statusCheckRollup,reviews,comments

gh pr diff <url-or-number>
gh pr checks <url-or-number>
gh issue view <url-or-number> --json number,title,author,state,labels,assignees,comments
```

Use `--json` when you need stable fields for reliable summaries.

For inline PR review comments, use API endpoints:

```bash
gh api repos/<owner>/<repo>/pulls/<number>/comments
gh api repos/<owner>/<repo>/pulls/<number>/reviews
```

## Step 4: Write Actions (Only If Requested)

Common mutation commands:

```bash
gh pr comment <url-or-number> --body "..."
gh pr review <url-or-number> --comment --body "..."
gh pr review <url-or-number> --approve --body "..."
gh pr review <url-or-number> --request-changes --body "..."
gh pr merge <url-or-number> --squash --delete-branch

gh issue comment <url-or-number> --body "..."
gh issue edit <url-or-number> --add-label "..."
```

Inline-review follow-up actions:

```bash
# Reply to a PR review comment (quote <body>):
gh pr-comment-reply <owner/repo> <pr-number> <comment-id> '<body>'

# Resolve / unresolve a review thread:
gh pr-comment-resolve <thread-node-id>
gh pr-comment-unresolve <thread-node-id>
```
`<body>` must be quoted when using `gh pr-comment-reply`.

Do not perform merge, close, label edits, review submission, or thread resolution unless the user requested that exact action.

### PR Body Protocol (Required)

Apply this protocol whenever creating or editing PR descriptions.

1. Write PR body to a real multiline file.
   - Example: `/tmp/pr_body.md`
2. Use `--body-file` only.
   - `gh pr create ... --body-file /tmp/pr_body.md`
   - `gh pr edit <pr> --body-file /tmp/pr_body.md`
3. Validate body immediately after mutation.
   - `gh pr view <pr> --json body --jq .body`
4. If literal `\\n` is present, treat as failure and immediately re-apply with `--body-file`.

Never use escaped newline strings (for example `\\n`) in `--body` for PR descriptions.

## Review Playbook for PR URLs

When the user provides a PR URL and asks for review:

1. Collect metadata with `gh pr view ... --json ...`.
2. Inspect changes with `gh pr diff` and file list from JSON.
3. Check CI status using `gh pr checks`.
4. If reviewer feedback handling is requested, fetch inline comments with `gh api .../pulls/<number>/comments`.
5. Produce findings in severity order:
   - High: correctness/security/data loss
   - Medium: behavior regressions/performance/reliability
   - Low: maintainability/style/minor clarity
6. If no findings, state that explicitly and mention residual test risk.

## Reviewer Comment Triage Playbook

Use this when the user asks to "対応要否整理", "reply", or "close out review comments".

1. Fetch all inline comments for the PR.
2. Group comments by issue theme and deduplicate duplicates.
3. For each theme, decide one of:
   - 対応必須
   - 対応推奨
   - 対応不要
4. State rationale from current implementation/spec and changed files.
5. If asked to reply, post concise replies per comment and include links to posted replies.

## Output Format

Return concise, actionable output:

1. Target: repo/PR/issue identity.
2. Current status: state, checks, review decision.
3. Findings or action result: concrete evidence.
4. Next command options: exact `gh` commands user can run next.

## Safety Rules

- Avoid destructive operations unless explicitly requested.
- Prefer read-only commands first.
- Echo assumptions when target is ambiguous.
- When command fails, show the critical error and propose the minimal fix.
- Never claim a write action succeeded without command output confirming it.
- For PR descriptions, do not use `--body` with escaped newlines; use `--body-file` and post-verify.

## Practical Tips (from real runs)

- For long PR bodies, prefer `--body-file` over inline `--body` to avoid shell interpolation bugs with backticks.
  - Example: `gh pr create --title "..." --body-file /tmp/pr_body.md`
- Never pass escaped newline strings (for example `\\n`) directly to `--body`; use a real multiline file with `--body-file` (`gh pr create` / `gh pr edit`) to prevent literal `\\n` in PR comments.
  - Example: `printf '%s\n' "## Summary" "- item" > /tmp/pr_body.md && gh pr edit <pr> --body-file /tmp/pr_body.md`
- After editing PR description, verify rendered body text via `gh pr view <pr> --json body --jq .body`.
- On `zsh`, reviewer IDs with brackets must be quoted.
  - Example: `gh pr edit <pr> --add-reviewer 'github-copilot[bot]'`
- `gh pr view --json reviewRequests` may not surface GitHub App reviewers reliably.
  - Verify reviewer assignment with: `gh api repos/<owner>/<repo>/pulls/<number>/requested_reviewers`
- If `--add-reviewer <name>` fails with "not found", check whether it is a user/team alias mismatch and retry with the exact bot/app login.
