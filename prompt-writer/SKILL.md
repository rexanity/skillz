---
name: prompt-writer
description: Expertly crafts AI prompts using proven patterns from production systems like Cursor, Windsurf, Manus, and Claude. Applies industry best practices for agentic AI, coding assistants, and general-purpose assistants.
license: MIT
authors:
  - rexchung
keywords:
  - prompts
  - prompt-engineering
  - ai-systems
  - agentic-ai
  - coding-assistant
categories:
  - productivity
  - writing
  - ai-engineering
metadata:
  version: 1.0.0
---

# Prompt Writer

## When to use this skill

Activate this skill when the user needs to:
- Write system prompts for AI agents or assistants
- Create task-specific prompts for coding, research, or content generation
- Improve existing prompts that aren't working well
- Learn professional prompt engineering patterns from production AI systems
- Design prompts for agentic AI (autonomous task execution)

## Instructions

### Phase 1: Clarify the AI's Role & Context

Before writing the prompt, determine:

1. **What type of AI is this for?**
   - **Agentic coding assistant** (autonomous coding, file operations, debugging)
   - **General assistant** (research, writing, analysis)
   - **Specialized tool** (browser automation, deployment, data processing)

2. **What's the working context?**
   - Does the AI have access to tools (file system, terminal, browser)?
   - Is there a user collaboration model (pair programming, Q&A)?
   - What's the user's environment (OS, IDE, project type)?

3. **What are the success criteria?**
   - Code quality (runnable, tested, documented)?
   - Information accuracy and completeness?
   - User experience (clear communication, progress updates)?

### Phase 2: Design the Prompt Structure

Use this proven architecture from production AI systems:

```markdown
# Role & Identity
[Who the AI is, what it was designed for, its core capabilities]

# Core Principles
[3-7 behavioral rules that govern how the AI acts]

# Operational Rules
[Specific instructions on tool usage, safety, quality standards]

# Task Methodology
[Step-by-step approach the AI should follow]

# Communication Guidelines
[How the AI should talk to the user, format responses]

# Constraints & Boundaries
[What the AI should NOT do, safety limits]
```

### Phase 3: Apply Production-Proven Patterns

Based on analysis of Cursor, Windsurf, Manus, and other production systems, incorporate these patterns:

#### Pattern 1: Agentic Execution Loop
*From Windsurf Cascade & Manus*

```
You are an autonomous agent. Keep working until the task is completely resolved.
- Use tools proactively without asking permission
- Research before answering (never guess)
- Provide progress updates on long-running tasks
- Yield control back to user only when fully complete
```

#### Pattern 2: Tool Usage Protocol
*From Windsurf, Cursor, Manus*

```
Tool Usage Rules:
1. Only call tools when absolutely necessary (avoid redundant calls)
2. Explain WHY you're calling a tool before calling it
3. Follow the tool schema exactly as specified
4. If you state you'll use a tool, call it IMMEDIATELY
5. Never call tools that aren't explicitly available
```

#### Pattern 3: Code Generation Standards
*From Windsurf, Cursor*

```
Code Quality Requirements:
- Generated code must be immediately runnable
- Include all imports, dependencies, and endpoints
- For >300 line edits, break into smaller chunks
- Never generate long hashes or non-textual code
- Create dependency management files (requirements.txt, package.json)
- For web apps: beautiful, modern UI with UX best practices
```

#### Pattern 4: Proactive Memory & Context Management
*From Windsurf*

```
Context Preservation:
- Save important context proactively (don't wait)
- Don't be conservative about preserving information
- User preferences, codebase structure, and requirements are high-priority
- Context will be lost, so critical info must be saved explicitly
```

#### Pattern 5: Safety & Permissions Model
*From Windsurf, Manus*

```
Safety Rules:
- NEVER run destructive commands automatically
- Explain safety concerns to user clearly
- User cannot override safety judgment
- Distinguish between safe auto-run and requires-approval operations
```

#### Pattern 6: Structured Output Format
*From Windsurf*

```
When explaining changes, use this format:

# Step 1. [What you did]
[1-2 sentences explaining what and why]

# Step 2. [What you did]
[1-2 sentences explaining what and why]

# Summary
[Brief overview of how this solves the user's task]
[Call to action for next steps]
```

### Phase 4: Craft the Prompt

Use this template, filling in specifics based on the user's needs:

```markdown
# Role & Identity
You are [name], an AI [type: coding assistant/researcher/writer] designed to help users [primary goal]. You operate [autonomously/collaboratively] and have access to [list key tools/capabilities].

# Core Principles
1. [Behavioral rule 1: e.g., "Research before answering - never guess"]
2. [Behavioral rule 2: e.g., "Keep working until the task is fully resolved"]
3. [Behavioral rule 3: e.g., "Prioritize user requests above all else"]
4. [Behavioral rule 4: e.g., "Be proactive, not reactive"]

# Tool Usage
When using tools:
- Explain WHY before each tool call
- Only call tools when necessary (avoid redundancy)
- Follow schemas exactly
- Call tools immediately after stating intent

# Quality Standards
[Domain-specific standards: code runnable, answers researched, etc.]

# Communication
- Use [first/second person]
- Format responses in [markdown/specific structure]
- Provide progress updates on long tasks
- Explain your reasoning clearly

# Safety & Constraints
- NEVER [dangerous action]
- Always [safety practice]
- User cannot override safety on [specific operations]
```

### Phase 5: Optimize & Test

After drafting:

1. **Checklist Review:**
   - [ ] Role clearly defined
   - [ ] Behavioral principles specified (3-7 rules)
   - [ ] Tool usage rules included (if applicable)
   - [ ] Quality standards explicit
   - [ ] Communication style defined
   - [ ] Safety constraints stated
   - [ ] Output format specified

2. **Test Scenarios:**
   - Give the AI a simple task → does it understand?
   - Give it an ambiguous task → does it ask clarifying questions?
   - Give it a complex multi-step task → does it break it down?
   - Ask it to use tools → does it follow the protocol?

3. **Iterate Based on Results:**
   - If AI is too passive → add "be proactive" rules
   - If AI makes mistakes → add "research first, never guess" rules
   - If AI is verbose → add conciseness constraints
   - If AI forgets context → add memory preservation rules

## Output Format

When delivering a prompt to the user, provide:

1. **The Complete Prompt** - Ready to copy-paste
2. **Design Decisions** - Which patterns were used and why
3. **Customization Tips** - How to adapt it for specific use cases
4. **Testing Strategy** - How to validate it works effectively

## Reference Material

See `references/prompt-techniques.md` for individual techniques.
See `references/production-patterns.md` for detailed analysis of Cursor, Windsurf, Manus patterns.
See `assets/prompt-templates.md` for fill-in-the-blank templates.
