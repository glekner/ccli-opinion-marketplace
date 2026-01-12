# Cursor Opinion Skill

This skill allows you to get a second opinion from Cursor AI agent on any topic during your conversation with Claude.

## When to Use

Use this skill when the user:
- Explicitly asks for Cursor's opinion or a "second opinion"
- Wants to compare approaches or get an alternative perspective
- Triggers the `/ask-cursor` command

## How to Execute

When this skill is invoked, you must:

1. **Gather Context**: Compile all relevant context from the current conversation, including:
   - The specific question or topic being discussed
   - Relevant code snippets that have been shared or discussed
   - Key files that have been read or modified
   - Important decisions or constraints mentioned
   - The user's goals and requirements

2. **Create a Mega-Prompt**: Formulate a comprehensive prompt for Cursor that includes:
   - A clear statement of the question or problem
   - All relevant code context
   - Any constraints or requirements
   - A request for Cursor's perspective, recommendations, or alternative approaches

3. **Execute the Script**: Run the ask-cursor.sh script with the mega-prompt:
   ```bash
   ${CLAUDE_PLUGIN_ROOT}/scripts/ask-cursor.sh "YOUR_MEGA_PROMPT_HERE"
   ```

4. **Process the Response**: When Cursor responds:
   - Present the response to the user clearly
   - Compare and contrast Cursor's opinion with your own analysis
   - Synthesize both perspectives to provide the best possible guidance
   - Highlight any areas of agreement or disagreement

## Prompt Template

Use this template when creating the mega-prompt for Cursor:

```
I'm helping a developer with the following task/question:

## Context
[Summarize the conversation context and what the user is trying to achieve]

## Relevant Code
[Include any relevant code snippets or file contents]

## Specific Question
[The exact question or decision point where we need input]

## Constraints
[Any requirements, limitations, or preferences mentioned]

Please provide your analysis and recommendations. Consider:
- Best practices and common patterns
- Potential pitfalls or edge cases
- Alternative approaches if applicable
- Trade-offs between different options
```

## Important Notes

- Always inform the user that you're consulting Cursor for additional input
- Be transparent about when opinions differ between Claude and Cursor
- Use Cursor's response as additional context, not as the sole authority
- If the script fails (missing API key, CLI not installed), inform the user of the setup requirements
