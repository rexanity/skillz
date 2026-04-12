# Prompt Engineering Techniques Reference

## 1. Zero-Shot Prompting
Ask the model to perform a task without examples.

```
Translate the following text to French: "{text}"
```

## 2. Few-Shot Prompting
Provide examples to guide the expected output format.

```
Convert these to abbreviations:
Monday -> Mon
Wednesday -> Wed
Friday -> 
```

## 3. Chain-of-Thought (CoT)
Encourage step-by-step reasoning.

```
Solve this problem step by step:
{problem}
```

## 4. Role Prompting
Assign a specific role to the model.

```
You are an expert software engineer with 10 years of experience. Review this code:
{code}
```

## 5. Template-Based Prompts
Create reusable structures.

```
Task: {task_description}
Input: {input_data}
Constraints: {constraints}
Output format: {format}
```

## 6. Meta-Prompting
Ask the model to improve prompts.

```
Improve this prompt for clarity and effectiveness:
{original_prompt}
```

## 7. Delimiters
Use clear separators for complex inputs.

```
Summarize the text between triple quotes:

"""
{long_text}
"""
```

## 8. Output Structuring
Request specific formats.

```
List 5 benefits of exercise. Format as a markdown table with columns: Benefit | Description | Difficulty Level
```

## 9. Autonomous Execution Loop
*From production agentic AI systems*

Instruct the AI to work autonomously until complete.

```
You are an autonomous agent. Keep working until the task is completely resolved.
- Use tools proactively without asking permission
- Research before answering (never guess)
- Provide progress updates on long-running tasks
- Yield control back to user only when fully complete
```

## 10. Proactive Memory Management
*From Windsurf Cascade*

Ensure context preservation across sessions.

```
Proactively save important information:
- User preferences and requirements
- Codebase structure and key files
- Technical decisions and rationale
- Don't wait for permission, be liberal but focused
```

## 11. Safety with Non-Override
*From production systems*

Establish safety rules that cannot be bypassed.

```
Safety Rules:
- NEVER run destructive commands automatically
- Explain safety concerns to user clearly
- User cannot override safety judgment
- Distinguish between safe auto-run and requires-approval operations
```

## 12. Structured Change Communication
*From Windsurf*

Standard format for explaining modifications.

```
# Step 1. [What you did]
[1-2 sentences: what and why]

# Step 2. [What you did]
[1-2 sentences: what and why]

# Summary
[Brief overview of how this solves the task]
[Call to action for next steps]
```

## 13. XML-Structured Information
*From Claude Code*

Use XML tags to structure complex information within prompts. This helps the model parse and reason about nested content.

```
When receiving results from tools, parse them as:

<task-notification>
  <tool>Bash</tool>
  <command>npm test</command>
  <status>completed</status>
  <output>...</output>
</task-notification>

When summarizing, use:
<analysis>
  [Your reasoning here - this section can be stripped from output]
</analysis>
<summary>
  [Final answer to user]
</summary>
```

Benefits:
- Clear boundaries between sections
- Easier to parse programmatically
- Reduces confusion between different data sources
- Enables selective stripping (e.g., scratchpad vs output)

## 14. Text-Only Enforcement
*From Claude Code compact*

When you need the model to respond without tool calls, use strong bookends:

```
CRITICAL: Respond with TEXT ONLY. Do NOT call any tools.
Tool calls will be REJECTED and will waste your only turn.

[Your task here]

Remember: TEXT ONLY. No tool calls.
```

The preamble + trailer pattern reinforces the constraint at both ends.

## 15. Few-Shot Examples with Commentary
*From Claude Code*

Don't just show what to do — explain why:

```
<example>
<commentary>
We read the file first to understand the current structure before
making any changes. This prevents blind edits that could break things.
</commentary>
<user>Fix the auth bug in src/auth.ts</user>
<assistant>
Let me read src/auth.ts to understand the current auth flow.
</assistant>
</example>
```

The commentary teaches reasoning, not just actions.

## 16. Subagent Delegation Prompting
*From Claude Code AgentTool*

When writing prompts for spawned agents:

```
You are working on [specific task]. Context:
- Files involved: src/auth.ts, src/middleware.ts
- Current issue: JWT validation failing on refresh
- What I've tried: Updated secret rotation, still fails

Your job:
1. Read both files
2. Identify where refresh tokens are validated
3. Fix the validation to use the new secret format
4. Run tests to verify

Do NOT:
- Delegate further without reading files first
- Make changes without understanding the issue
- Assume the fix works without testing
```

Key rules:
- Self-contained: include everything the subagent needs
- "Never delegate understanding" — brief like a smart colleague
- State what "done" looks like explicitly
- Include file paths, error messages, specific changes — not vague references

## 17. Variable Substitution Templates
*From Claude Code SessionMemory, MagicDocs*

Use `{{variable}}` syntax for reusable prompt templates:

```
You are reviewing code for {{project_name}}.
Focus area: {{focus_area}}
Files to review: {{file_list}}
Standards: {{quality_standards}}

Provide findings in this format:
{{output_format}}
```

Allow custom file overrides:
- `~/.claude/prompts/variables.md` for persistent variables
- Override at runtime with explicit values

## 18. Phase-Based Workflow Prompting
*From Claude Code batch, dream, coordinator*

Structure complex tasks as explicit phases:

```
You are running a multi-phase operation:

Phase 1: ORIENT
- Read the project structure
- Identify what needs to change
- Report back with your plan

Phase 2: EXECUTE
- Make the changes
- Test each change independently
- Report successes and failures

Phase 3: VERIFY
- Run the full test suite
- Document what changed
- Suggest follow-up work

Complete each phase before moving to the next.
Report phase transitions explicitly.
```

## 19. Explicit Negative Instructions
*From Claude Code (extensive use)*

Production systems use extensive "what NOT to do":

```
Don't:
- Don't add features beyond what was asked
- Don't refactor unless explicitly requested
- Don't create helpers for one-time operations
- Don't propose changes to code you haven't read
- Don't race — don't fabricate results without running
- Don't peek — don't check worker results prematurely
- Don't delegate understanding — read the files yourself
```

Negative instructions are often more effective than positive ones
because they prevent specific failure modes the model is prone to.

## 20. Prompt Caching Awareness
*From Claude Code SYSTEM_PROMPT_DYNAMIC_BOUNDARY*

Design prompts with caching in mind:

```
Structure your prompt as:
[CACHEABLE - static instructions that never change]
--- DYNAMIC BOUNDARY ---
[DYNAMIC - session/user specific content]
```

Benefits:
- Static sections can be cached across sessions (saves tokens, cost)
- Only dynamic sections need recomputing
- Use a clear marker like `--- DYNAMIC BOUNDARY ---` to separate

For single prompts, put universal rules first, context-specific
content last.

## 21. Token Budget Constraints
*From Claude Code memory limits (200 lines, ~25KB, 12000 tokens)*

Explicitly state token limits in prompts:

```
Memory Constraints:
- Your response must stay under 200 lines AND ~25KB
- Prioritize high-signal information
- Omit verbose explanations — be concise
- If approaching limits, condense automatically

Section Budgets:
- Summary: max 500 tokens
- Details: max 2000 tokens per item
- Total: max 12000 tokens
```

When the model knows its budget, it self-regulates output size.

## 22. Modular Section Composition
*From Claude Code systemPromptSections*

Build complex prompts from composable sections:

```
Section: "Role" (always included)
  "You are a code review assistant..."

Section: "Project Context" (included if project detected)
  "You are working in a React TypeScript project..."

Section: "Tool Guidance" (included if tools available)
  "You have access to: Read, Edit, Bash, Grep..."

Section: "Current Task" (always included)
  "Review the changes in this PR..."

Combine non-null sections in order.
```

This lets you build context-aware prompts that adapt to
the environment without rebuilding the entire prompt.
