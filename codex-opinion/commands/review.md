---
description: Send git diff to Codex for code review
allowed-tools:
  - Bash
---

# Codex Code Review

The user wants Codex to review current git changes.

## Important: This is a READ-ONLY operation

Codex will analyze the changes but will NOT modify any files. This is a SLOW operation - expect 2-5 minutes.

When calling Bash, you MUST set a long timeout:
- Use `timeout: 600000` (10 minutes) for the Bash tool call

## Your Task

1. **Check for Git Repository**: Verify we're in a git repository:
   ```bash
   git rev-parse --git-dir 2>&1
   ```
   If this fails, inform the user they're not in a git repository.

2. **Check for Changes**: Verify there are uncommitted changes:
   ```bash
   git status --porcelain
   ```
   If empty, inform the user there are no uncommitted changes to review.

3. **Run the Review**: Call the review script with the current working directory.

   **CRITICAL**: Set timeout to 600000ms (10 minutes):
   ```bash
   # timeout: 600000
   "${CLAUDE_PLUGIN_ROOT}/scripts/review-codex.sh" "$(pwd)"
   ```

   Codex will run `git diff HEAD` itself and read any files it needs for context.

4. **Present the Review**: Share Codex's code review feedback with the user clearly.

5. **Synthesize (Optional)**: If you have additional observations about the code changes, add them to complement Codex's review. Highlight points of agreement or offer different perspectives.

## Notes

- If there are no uncommitted changes, inform the user - don't call Codex
- This is a read-only operation - Codex cannot modify files
- The review focuses on practical issues: bugs, security, quality
- Codex has full workspace access and can read files for context
- If the `codex` command is not found, inform the user they need to install the Codex CLI (`npm install -g @openai/codex`)
