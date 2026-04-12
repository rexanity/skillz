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
