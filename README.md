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

**Features:**
- `/ask-cursor` command to trigger Cursor consultation
- Automatically gathers full conversation context + relevant files
- Creates a comprehensive mega-prompt for Cursor
- Returns Cursor's response as additional context
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
/ask-cursor
```

Claude will gather context, consult Cursor, and synthesize both opinions.

## License

Private use only.
