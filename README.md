# Cursor Opinion Marketplace

A private Claude Code plugin marketplace containing the **cursor-opinion** plugin.

## Installation

```bash
# Add the marketplace
/plugin marketplace add glekner/cursor-opinion-marketplace

# Install the plugin
/plugin install cursor-opinion@cursor-opinion-marketplace
```

## Plugins

### cursor-opinion

Delegate questions to Cursor AI agent for a second opinion during your Claude Code conversation.

**Commands:**
- `/ask-cursor [context]` - Get Cursor's opinion on the current topic
- `/delegate [task]` - Have Cursor make code changes in your project
- `/review` - Send git diff to Cursor for code review

**Features:**
- Automatically gathers full conversation context + relevant files
- Creates comprehensive mega-prompts for Cursor
- Claude synthesizes both AI perspectives

**Prerequisites:**
1. Cursor CLI (`agent` command) installed and in PATH
2. `CURSOR_API_KEY` environment variable set

**Configuration (in `~/.zshrc` or `~/.bashrc`):**
```bash
export CURSOR_API_KEY='your-api-key-here'
export CURSOR_MODEL='claude-sonnet-4-20250514'  # optional, this is the default
```

## Usage

During any Claude Code conversation:
```
/ask-cursor                              # Get Cursor's opinion
/ask-cursor what about performance?      # With additional context
/delegate add error handling to api.js   # Have Cursor make changes
/review                                  # Get code review of git diff
```

Claude will gather context, consult Cursor, and synthesize both opinions.

## License

Private use only.
