#!/bin/bash
#
# delegate-codex.sh - Delegate code changes to Codex
#
# Usage: ./delegate-codex.sh "task prompt" [workspace-path]
#
# Environment variables (optional):
#   CODEX_MODEL - Model to use (uses Codex config default)
#

set -e

# Get prompt from first argument
PROMPT="$1"

# Get workspace from second argument or use current directory
WORKSPACE="${2:-$(pwd)}"

if [ -z "$PROMPT" ]; then
    echo "Error: No task prompt provided" >&2
    echo "Usage: delegate-codex.sh \"task description\" [workspace-path]" >&2
    exit 1
fi

# Check if codex CLI is available
if ! command -v codex &> /dev/null; then
    echo "Error: 'codex' command not found. Is Codex CLI installed?" >&2
    echo "Install with: npm install -g @openai/codex" >&2
    exit 1
fi

echo "Delegating task to Codex..."
echo "Workspace: $WORKSPACE"
echo "---"

# Change to workspace directory
cd "$WORKSPACE"

# Build command args
CMD_ARGS=("exec")

# Add model if specified
if [ -n "$CODEX_MODEL" ]; then
    CMD_ARGS+=("--model" "$CODEX_MODEL")
fi

# Use yolo mode - no sandbox, no approval prompts, fully non-interactive
CMD_ARGS+=("--yolo")

# Add the prompt
CMD_ARGS+=("$PROMPT")

# Call codex in non-interactive exec mode with full access
codex "${CMD_ARGS[@]}"
