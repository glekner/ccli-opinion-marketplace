#!/bin/bash
#
# review-codex.sh - Get Codex's code review of git changes
#
# Usage: ./review-codex.sh [workspace-path]
#
# Environment variables (optional):
#   CODEX_MODEL - Model to use (default: gpt-5.2-high)
#

set -e

# Configuration with defaults
CODEX_MODEL="${CODEX_MODEL:-gpt-5.2-high}"

# Get workspace from argument or use current directory
WORKSPACE="${1:-$(pwd)}"

# Check if codex CLI is available
if ! command -v codex &> /dev/null; then
    echo "Error: 'codex' command not found. Is Codex CLI installed?" >&2
    echo "Install with: npm install -g @openai/codex" >&2
    exit 1
fi

# Change to workspace directory so Codex operates there
cd "$WORKSPACE"

# Build the review prompt - let Codex read files itself
REVIEW_PROMPT="You are a senior code reviewer. Review the uncommitted changes in this repository.

Run \`git diff HEAD\` to see the changes, then review them.

Focus on:
- Potential bugs or issues
- Code quality and best practices
- Security concerns
- Suggestions for improvement

You can read any files to understand context around the changes.

Be direct and constructive. Skip obvious or trivial issues. Keep your review concise and actionable."

# Build command args - use read-only sandbox for reviews
CMD_ARGS=("exec")
CMD_ARGS+=("--model" "$CODEX_MODEL")
CMD_ARGS+=("--sandbox" "read-only")
CMD_ARGS+=("$REVIEW_PROMPT")

# Call codex with read-only sandbox
codex "${CMD_ARGS[@]}"
