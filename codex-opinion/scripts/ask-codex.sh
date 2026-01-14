#!/bin/bash
#
# ask-codex.sh - Delegate a question to Codex and get its opinion
#
# Usage: echo "your prompt" | ./ask-codex.sh
#    or: ./ask-codex.sh "your prompt"
#
# Environment variables (optional):
#   CODEX_MODEL - Model to use (uses Codex config default)
#

set -e

# Get prompt from argument or stdin
if [ -n "$1" ]; then
    PROMPT="$1"
else
    PROMPT=$(cat)
fi

if [ -z "$PROMPT" ]; then
    echo "Error: No prompt provided" >&2
    exit 1
fi

# Check if codex CLI is available
if ! command -v codex &> /dev/null; then
    echo "Error: 'codex' command not found. Is Codex CLI installed?" >&2
    echo "Install with: npm install -g @openai/codex" >&2
    exit 1
fi

# Build command args
CMD_ARGS=("exec")

# Add model if specified
if [ -n "$CODEX_MODEL" ]; then
    CMD_ARGS+=("--model" "$CODEX_MODEL")
fi

# Use yolo mode for non-interactive execution (no approval prompts)
# with read-only sandbox for safety
CMD_ARGS+=("--yolo")

# Add the prompt
CMD_ARGS+=("$PROMPT")

# Call codex in non-interactive exec mode
codex "${CMD_ARGS[@]}"
