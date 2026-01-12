# Cursor Opinion Plugin

A private Claude Code plugin that lets you get a second opinion from Cursor AI during your conversation with Claude.

## Features

- `/ask-cursor` command to trigger Cursor consultation
- Automatically gathers conversation context and relevant files
- Creates a comprehensive prompt for Cursor with full context
- Returns Cursor's response as additional input for Claude to consider
- Claude synthesizes both perspectives for better recommendations

## Prerequisites

1. **Cursor CLI** - The `agent` command must be available in your PATH
   - Install Cursor and ensure the CLI is set up

2. **API Key** - Set your Cursor API key as an environment variable:
   ```bash
   # Add to ~/.zshrc or ~/.bashrc
   export CURSOR_API_KEY='your-api-key-here'
   ```

## Installation

This plugin is installed locally at `~/.claude/plugins/cursor-opinion/`.

To enable it in Claude Code:
```
/plugin install ~/.claude/plugins/cursor-opinion
```

Or add it to your Claude Code settings.

## Usage

During any conversation with Claude, simply type:
```
/ask-cursor
```

Claude will:
1. Gather all relevant context from your conversation
2. Create a comprehensive prompt for Cursor
3. Call the Cursor agent CLI
4. Present Cursor's response
5. Synthesize both AI perspectives for you

You can also ask naturally: "Can you get Cursor's opinion on this?"

## Configuration

Environment variables for customization:

| Variable | Default | Description |
|----------|---------|-------------|
| `CURSOR_API_KEY` | (required) | Your Cursor API key |
| `CURSOR_MODEL` | `claude-sonnet-4-20250514` | Model for Cursor to use |
| `CURSOR_OUTPUT_FMT` | `text` | Output format: text, json, stream-json |

## Plugin Structure

```
cursor-opinion/
├── .claude-plugin/
│   └── plugin.json           # Plugin manifest
├── commands/
│   └── ask-cursor.md         # /ask-cursor slash command
├── skills/
│   └── cursor-opinion/
│       └── SKILL.md          # Skill instructions
├── scripts/
│   └── ask-cursor.sh         # Cursor CLI wrapper script
└── README.md
```

## Troubleshooting

**"agent command not found"**
- Ensure Cursor CLI is installed and `agent` is in your PATH

**"CURSOR_API_KEY not set"**
- Add `export CURSOR_API_KEY='...'` to your shell profile and restart your terminal

**Script permission denied**
- Run: `chmod +x ~/.claude/plugins/cursor-opinion/scripts/ask-cursor.sh`
