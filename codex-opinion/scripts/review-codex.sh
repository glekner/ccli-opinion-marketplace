#!/bin/bash
#
# review-codex.sh - Get Codex's code review of git changes
#
# Usage: echo "diff content" | ./review-codex.sh
#    or: ./review-codex.sh "diff content"
#
# Environment variables (optional):
#   CODEX_MODEL - Model to use (uses Codex config default)
#

set -e

# Get diff from argument or stdin
if [ -n "$1" ]; then
    DIFF_CONTENT="$1"
else
    DIFF_CONTENT=$(cat)
fi

if [ -z "$DIFF_CONTENT" ]; then
    echo "Error: No diff content provided" >&2
    exit 1
fi

# Check if codex CLI is available
if ! command -v codex &> /dev/null; then
    echo "Error: 'codex' command not found. Is Codex CLI installed?" >&2
    echo "Install with: npm install -g @openai/codex" >&2
    exit 1
fi

# Build the review prompt
REVIEW_PROMPT="You are a senior code reviewer. Please review the following git diff and provide a concise, human-readable code review.

Focus on:
- Potential bugs or issues
- Code quality and best practices
- Security concerns
- Suggestions for improvement

Be direct and constructive. Skip obvious or trivial issues. Keep your review concise and actionable.

## Git Diff

\`\`\`diff
$DIFF_CONTENT
\`\`\`

Provide your code review:"

# Build command args
CMD_ARGS=("exec")

# Add model if specified
if [ -n "$CODEX_MODEL" ]; then
    CMD_ARGS+=("--model" "$CODEX_MODEL")
fi

# Use yolo mode for non-interactive execution (no approval prompts)
CMD_ARGS+=("--yolo")

# Add the prompt
CMD_ARGS+=("$REVIEW_PROMPT")

# Call codex in non-interactive exec mode
codex "${CMD_ARGS[@]}"
