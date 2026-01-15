#!/bin/bash
#
# review-cursor.sh - Get Cursor's code review of git changes
#
# Usage: ./review-cursor.sh [workspace-path]
#
# Environment variables (optional):
#   CURSOR_MODEL - Model to use (default: gpt-5.2-codex)
#

set -e

# Configuration with defaults
CURSOR_MODEL="${CURSOR_MODEL:-gpt-5.2-codex}"

# Get workspace from argument or use current directory
WORKSPACE="${1:-$(pwd)}"

# Check if cursor agent CLI is available
if ! command -v agent &> /dev/null; then
    echo "Error: 'agent' command not found. Is Cursor agent CLI installed?" >&2
    exit 1
fi

# Build the review prompt - let Cursor read files itself
REVIEW_PROMPT="You are a senior code reviewer. Review the uncommitted changes in this repository.

Run \`git diff HEAD\` to see the changes, then review them.

Focus on:
- Potential bugs or issues
- Code quality and best practices
- Security concerns
- Suggestions for improvement

You can read any files to understand context around the changes.

Be direct and constructive. Skip obvious or trivial issues. Keep your review concise and actionable."

# Call cursor agent with workspace access but READ-ONLY (no --force, no --sandbox disabled)
agent -p "$REVIEW_PROMPT" \
    --model "$CURSOR_MODEL" \
    --output-format text \
    --workspace "$WORKSPACE" \
    --approve-mcps
