# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Claude Code plugin marketplace repository containing the **cursor-opinion** plugin. The plugin allows users to get a second opinion from Cursor AI during their Claude Code conversations.

## Repository Structure

```
ccli-opinion-marketplace/
├── cursor-opinion/           # The plugin package
│   ├── .claude-plugin/
│   │   └── plugin.json       # Plugin manifest (name, version, description)
│   ├── commands/
│   │   ├── ask-cursor.md     # /ask-cursor [context] - get Cursor's opinion
│   │   ├── delegate.md       # /delegate [task] - have Cursor make changes
│   │   └── review.md         # /review - git diff code review
│   ├── skills/
│   │   └── cursor-opinion/
│   │       └── SKILL.md      # Skill instructions for context gathering
│   └── scripts/
│       ├── ask-cursor.sh     # Bash wrapper for opinions (read-only)
│       ├── delegate-cursor.sh # Bash wrapper for code changes (write)
│       └── review-cursor.sh  # Bash wrapper for code review (read-only)
└── README.md                 # Marketplace installation instructions
```

## How the Plugin Works

### /ask-cursor [optional context]
1. User triggers `/ask-cursor` command (optionally with additional context)
2. Claude gathers full conversation context, relevant code, and constraints
3. Claude builds a comprehensive "mega-prompt" for Cursor
4. `ask-cursor.sh` calls the Cursor `agent` CLI with the prompt
5. Cursor's response is returned and Claude synthesizes both perspectives

### /delegate [task description]
1. User triggers `/delegate` with a task description
2. Claude gathers context and builds a detailed task prompt
3. `delegate-cursor.sh` runs Cursor with `--workspace $(pwd)` to operate in user's project
4. Cursor makes code changes with write permissions
5. Claude reports what files were modified

### /review
1. User triggers `/review` to get code review
2. Claude gathers git diff (`git diff HEAD`)
3. `review-cursor.sh` sends diff to Cursor (read-only, no write permissions)
4. Cursor provides concise code review feedback

## Key Implementation Details

- **Timeout requirement**: Cursor uses a slow-thinking model. All Bash calls to scripts must use `timeout: 600000` (10 minutes).
- **Working directory for /delegate**: Uses `--workspace $(pwd)` to ensure Cursor operates in user's project, not plugin root.
- **Environment variables**: Plugin requires `CURSOR_API_KEY`. Optional: `CURSOR_MODEL` (default: claude-sonnet-4-20250514).
- **Script execution**: Scripts use `${CLAUDE_PLUGIN_ROOT}/scripts/*.sh` path variable provided by Claude Code plugin system.
- **Command arguments**: Use `argument-hint` in YAML frontmatter for optional args; access via `$ARGUMENTS` or `$1`, `$2`.

## Plugin Installation (for users)

```bash
# Add the marketplace
/plugin marketplace add glekner/ccli-opinion-marketplace

# Install the plugin
/plugin install cursor-opinion@ccli-opinion-marketplace
```
