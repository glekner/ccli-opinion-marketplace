#!/bin/bash
#
# review-cursor.sh - Get Cursor's code review of git changes
#
# Usage: echo "diff content" | ./review-cursor.sh
#    or: ./review-cursor.sh "diff content"
#
# Environment variables:
#   CURSOR_API_KEY     - Your Cursor API key (required)
#   CURSOR_MODEL       - Model to use (default: claude-sonnet-4-20250514)
#

set -e

# Configuration with defaults
CURSOR_MODEL="${CURSOR_MODEL:-claude-sonnet-4-20250514}"

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

# Check for API key
if [ -z "$CURSOR_API_KEY" ]; then
    echo "Error: CURSOR_API_KEY environment variable is not set" >&2
    echo "Please set it in your shell profile (~/.zshrc or ~/.bashrc):" >&2
    echo "  export CURSOR_API_KEY='your-api-key-here'" >&2
    exit 1
fi

# Check if cursor agent CLI is available
if ! command -v agent &> /dev/null; then
    echo "Error: 'agent' command not found. Is Cursor agent CLI installed?" >&2
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

# Call cursor agent in READ-ONLY mode (no --force, no --sandbox disabled)
agent -p "$REVIEW_PROMPT" \
    --api-key "$CURSOR_API_KEY" \
    --model "$CURSOR_MODEL" \
    --output-format text \
    --approve-mcps
