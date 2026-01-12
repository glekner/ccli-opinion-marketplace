#!/bin/bash
#
# ask-cursor.sh - Delegate a question to Cursor agent and get its opinion
#
# Usage: echo "your prompt" | ./ask-cursor.sh
#    or: ./ask-cursor.sh "your prompt"
#
# Environment variables (configure in ~/.zshrc or ~/.bashrc):
#   CURSOR_API_KEY     - Your Cursor API key (required)
#   CURSOR_MODEL       - Model to use (default: claude-sonnet-4-20250514)
#   CURSOR_OUTPUT_FMT  - Output format: text, json, stream-json (default: text)
#

set -e

# Configuration with defaults
CURSOR_MODEL="${CURSOR_MODEL:-claude-sonnet-4-20250514}"
CURSOR_OUTPUT_FMT="${CURSOR_OUTPUT_FMT:-text}"

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

# Call cursor agent with the prompt
agent -p "$PROMPT" \
    --api-key "$CURSOR_API_KEY" \
    --model "$CURSOR_MODEL" \
    --output-format "$CURSOR_OUTPUT_FMT" \
    --approve-mcps \
    --sandbox disabled \
    --force
