#!/usr/bin/env python3
"""Capture git status and diff outputs into timestamped files.

This helper script adheres to the workflow required by git-auto-commit:
only `git status` and `git diff` are invoked, so it works even in
restricted environments. The resulting files make it easy to share the
exact context when summarizing changes and drafting commit messages.
"""
from __future__ import annotations

import argparse
import datetime as dt
import pathlib
import subprocess
import sys


def run(cmd: list[str]) -> str:
    """Execute a git command and capture stdout; raise on non-zero."""
    completed = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    if completed.returncode != 0:
        raise SystemExit(f"Command {' '.join(cmd)} failed: {completed.stderr.strip()}")
    return completed.stdout.rstrip() + "\n"


def write_file(path: pathlib.Path, content: str) -> None:
    path.write_text(content, encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description="Save git status and diff outputs.")
    parser.add_argument(
        "--out-dir",
        default=".codex/git-auto-commit",
        help="Directory to store the generated files (default: .codex/git-auto-commit)",
    )
    parser.add_argument(
        "--diff-args",
        nargs=argparse.REMAINDER,
        default=["--unified=3"],
        help="Additional arguments passed to git diff (default: --unified=3)",
    )
    args = parser.parse_args()

    out_dir = pathlib.Path(args.out_dir).expanduser().resolve()
    out_dir.mkdir(parents=True, exist_ok=True)

    timestamp = dt.datetime.now().strftime("%Y%m%d-%H%M%S")
    status_path = out_dir / f"git-status-{timestamp}.txt"
    diff_path = out_dir / f"git-diff-{timestamp}.patch"

    status_output = run(["git", "status", "--short", "--branch"])
    diff_cmd = ["git", "diff"] + args.diff_args
    diff_output = run(diff_cmd)

    write_file(status_path, status_output)
    write_file(diff_path, diff_output)

    summary_lines = [
        f"Saved git status   -> {status_path}",
        f"Saved git diff     -> {diff_path}",
        "Share these files when summarizing or drafting the commit message.",
    ]
    sys.stdout.write("\n".join(summary_lines) + "\n")


if __name__ == "__main__":
    main()
