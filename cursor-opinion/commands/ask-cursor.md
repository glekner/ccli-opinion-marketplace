---
description: Get Cursor AI's opinion on the current topic or question
allowed-tools:
  - Bash
  - Read
  - Glob
  - Grep
---

# Ask Cursor for Opinion

The user wants to get Cursor AI's perspective as a second opinion.

## Important: This is a SLOW operation

Cursor is configured to use a powerful, slow-thinking model. **Expect the command to take 2-5 minutes to complete.** This is normal behavior, not a timeout issue.

When calling Bash, you MUST set a long timeout:
- Use `timeout: 600000` (10 minutes) for the Bash tool call

## Your Task

1. **Summarize the Current Context**: Review the entire conversation and identify:
   - What problem or question is being discussed
   - What code or files are relevant
   - What approaches have been considered
   - What the user's constraints and preferences are

2. **Build a Comprehensive Prompt**: Create a detailed prompt for Cursor that includes all relevant context. The prompt should be self-contained so Cursor can understand the situation without seeing our conversation.

3. **Call Cursor Agent**: Execute the following command with your constructed prompt.

   **CRITICAL**: Set timeout to 600000ms (10 minutes) because Cursor uses a slow model:
   ```bash
   # timeout: 600000
   ${CLAUDE_PLUGIN_ROOT}/scripts/ask-cursor.sh "YOUR_COMPREHENSIVE_PROMPT"
   ```

   If the prompt is very long, you can pipe it:
   ```bash
   # timeout: 600000
   echo "YOUR_COMPREHENSIVE_PROMPT" | ${CLAUDE_PLUGIN_ROOT}/scripts/ask-cursor.sh
   ```

4. **Present Cursor's Response**: Share what Cursor said with the user and integrate it into our discussion.

5. **Synthesize Opinions**: Compare your own analysis with Cursor's response:
   - Highlight points of agreement
   - Explain any differences in perspective
   - Provide a unified recommendation that considers both viewpoints

## Notes

- **The command will take several minutes** - this is expected, be patient
- If the command fails due to missing CURSOR_API_KEY, inform the user they need to set it in their shell profile
- If the `agent` command is not found, they need to install the Cursor CLI
- Always be transparent that this is Cursor's opinion, not your own
