---
description: Delegate code changes to Cursor as a background task
argument-hint: "[task description]"
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

# Delegate Task to Cursor

The user wants Cursor AI to make code changes in the current project.

## User's Task Description

$ARGUMENTS

## Important: This runs Cursor with WRITE permissions

Cursor will be given full access to read and modify files in the current working directory. This is a SLOW operation - expect 2-5 minutes.

When calling Bash, you MUST set a long timeout:
- Use `timeout: 600000` (10 minutes) for the Bash tool call

## Your Task

1. **Identify the Task**: Determine what code changes the user wants made.
   - If a task description was provided above, use that as the primary task
   - Otherwise, summarize the current conversation to understand what needs to be done

2. **Gather Context**: Collect relevant context including:
   - Files that need to be modified
   - Coding conventions in use
   - Any constraints or requirements mentioned in the conversation

3. **Build a Comprehensive Prompt**: Create a detailed, actionable prompt that tells Cursor exactly what changes to make. Include:
   - Clear description of the task
   - Relevant code snippets or file contents
   - Specific requirements or constraints
   - Expected outcome

4. **Execute Delegation**: Call the delegate script with the working directory.

   **CRITICAL**: Set timeout to 600000ms (10 minutes) because Cursor uses a slow model:
   ```bash
   # timeout: 600000
   "${CLAUDE_PLUGIN_ROOT}/scripts/delegate-cursor.sh" "YOUR_COMPREHENSIVE_PROMPT" "$(pwd)"
   ```

5. **Report Results**: When Cursor completes, summarize:
   - What files were modified or created
   - What changes were made
   - Any issues or warnings from Cursor

## Notes

- Cursor will run in the SAME working directory as Claude Code (passed via `$(pwd)`)
- Cursor has full write permissions - it can create, modify, and delete files
- The task may take several minutes to complete
- Review Cursor's changes after completion - you can use Read/Glob to inspect
- If the command fails due to missing CURSOR_API_KEY, inform the user they need to set it
- If the `agent` command is not found, they need to install the Cursor CLI
