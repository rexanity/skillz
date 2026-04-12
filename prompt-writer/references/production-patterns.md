# Production AI System Patterns

Detailed analysis of system prompts from real-world AI products.

---

## 1. Windsurf (Cascade) - Agentic Coding Assistant

**Type:** Autonomous AI coding agent  
**Key Innovation:** AI Flow paradigm - works both independently and collaboratively

### Core Architecture

```
Role: World-class agentic coding assistant from Silicon Valley
Model: GPT 4.1 (self-reported)
Paradigm: Pair programming with autonomous execution
Context: User's workspace, active files, cursor position, OS info
```

### Key Behavioral Rules

1. **Autonomous Execution**: "Keep working until the user's query is completely resolved, before ending your turn"
2. **Minimal Tool Usage**: "Only call tools when absolutely necessary. NEVER make redundant tool calls as these are very expensive"
3. **Immediate Action**: "If you state that you will use a tool, immediately call that tool as your next action"
4. **Research First**: "NEVER guess or make up an answer. Your answer must be rooted in research"
5. **Proactive Memory**: "Proactively use the create_memory tool to save important context. DO NOT be conservative about creating memories"

### Code Quality Standards

- Must be immediately runnable
- Include all imports and dependencies
- For >300 lines, break into smaller edits (8192 token limit)
- No long hashes or binary code
- Beautiful modern UI for web apps
- Create dependency management files automatically

### Safety Model

- Commands judged as safe/unsafe automatically
- User cannot override safety judgment
- Auto-run allowlist in user settings
- Explicit permission required for destructive operations

### Communication Format

- First person for AI, second person for user
- Markdown formatting required
- Brief summaries of changes with step-by-step breakdown
- Proactively run terminal commands without asking permission

---

## 2. Manus AI - General-Purpose Autonomous Agent

**Type:** Autonomous assistant for diverse tasks  
**Key Innovation:** Broad capability model with tool orchestration

### Core Architecture

```
Role: Helpful, service-oriented AI assistant
Capabilities: Browser, file system, shell, communication, deployment
Approach: Break complex problems into manageable steps
Personality: Detail-focused, adaptable, patient, honest about limitations
```

### Capability Framework

**Information Processing:**
- Answer questions, conduct research, fact-check, summarize
- Process structured and unstructured data

**Content Creation:**
- Write articles, documentation, communications
- Create and edit code in various languages
- Generate creative content

**Problem Solving:**
- Break down complex problems into steps
- Troubleshoot errors, suggest alternatives
- Adapt to changing requirements

**Tool Categories:**
- Browser: Navigate, extract, interact, execute JS, screenshot
- File System: Read/write, search, organize, compress, convert
- Shell: Execute commands, install software, run scripts, automate
- Communication: Send messages, ask questions, provide updates
- Deployment: Expose ports, deploy websites, provide URLs

### Task Methodology

1. **Understanding Requirements:**
   - Analyze requests to identify core needs
   - Ask clarifying questions when ambiguous
   - Break down complex requests
   - Identify potential challenges upfront

2. **Planning & Execution:**
   - Create structured plans
   - Select appropriate tools
   - Execute methodically with monitoring
   - Adapt plans when encountering challenges
   - Provide regular status updates

3. **Quality Assurance:**
   - Verify results against requirements
   - Test solutions before delivery
   - Document processes for future reference
   - Seek feedback to improve outcomes

### Limitations (Explicitly Stated)

- Cannot access/share proprietary information
- Cannot harm systems or violate privacy
- Cannot create accounts on behalf of users
- Cannot access systems outside sandbox
- Cannot violate ethical/legal guidelines
- Limited context window

### Values

- Accuracy and reliability
- Respect for privacy and data
- Ethical use of technology
- Transparency about capabilities
- Continuous improvement

---

## 3. Cursor - AI IDE Agent

**Type:** Coding agent for IDE integration  
**Key Innovation:** Multiple agent versions with evolution over time

### Agent Versions

- Agent Prompt v1.0, v1.2
- Agent Prompt 2.0
- Agent Prompt 2025-09-03
- Agent CLI Prompt variants

### Common Patterns (Based on Structure)

- Persistent agent state across interactions
- Integration with IDE context (open files, cursor position)
- Tool-based interaction model
- Incremental improvement across versions

---

## 4. Claude Code (Anthropic) - LLM Provider

**Type:** Foundation model with coding specialization  
**Key Innovation:** Claude Code 2.0 architecture

### Versions Observed

- Claude Code 2.0.txt
- Claude Sonnet 4.6.txt
- Sonnet 4.5 Prompt

### Pattern: Specialized Models

Different prompt variants for different model versions and specializations.

---

## 5. Common Patterns Across All Systems

### Universal Principles

1. **Be Proactive, Not Reactive**
   - Research before answering
   - Save context without asking
   - Suggest next steps
   - Run commands when safe

2. **Be Autonomous but Safe**
   - Keep working until complete
   - Never guess - research first
   - Safety cannot be overridden
   - Explain reasoning clearly

3. **Be Structured but Flexible**
   - Follow schemas exactly
   - Adapt to user needs
   - Break down complex tasks
   - Provide regular updates

4. **Be Concise but Complete**
   - Avoid redundant tool calls
   - Brief summaries, not essays
   - Include all necessary details
   - Focus on solving the task

### Structural Elements

All production prompts include:
- Clear role definition
- Behavioral principles (3-7 rules)
- Tool usage guidelines
- Quality standards
- Communication format
- Safety constraints
- Task methodology

---

## 6. Anti-Patterns to Avoid

Based on what production systems DON'T do:

- ❌ Vague role definitions
- ❌ No behavioral guidelines
- ❌ Unrestricted tool usage
- ❌ No quality standards
- ❌ No safety constraints
- ❌ Unstructured output
- ❌ No context preservation
- ❌ Guessing instead of researching

---

## 7. Context Engineering — The Layer Above Prompt Engineering
*From 2025-2026 research (arXiv:2510.21413, DigitalOcean, contextual.ai)*

**Key insight**: Prompt engineering is *how* you ask. Context engineering
is *what* the model has access to when answering. Without proper context,
even perfect prompts produce generic or hallucinated outputs.

### Prompt Engineering vs Context Engineering

| Prompt Engineering | Context Engineering |
|---|---|
| How you phrase the question | What textbook the model has open |
| Instruction structure | Information retrieval pipeline |
| Behavioral rules | Domain-specific knowledge injection |
| Output format specification | Tool output cleaning & structuring |

### Layered Context Design

Organize agent inputs into distinct, purpose-driven layers:

```
Layer 1: System Rules (stable, cacheable)
  - Role definition, output style, safety rules, format requirements

Layer 2: Project Context (version-controlled files)
  - AGENTS.md, CLAUDE.md, architecture docs, conventions

Layer 3: Task Context (current request)
  - User's specific query, active files, cursor position

Layer 4: Retrieved Context (dynamic, from RAG/tools)
  - Relevant documentation, code snippets, prior decisions

Layer 5: Memory (persistent, across sessions)
  - User preferences, historical interactions, learned patterns

Layer 6: Tool Outputs (real-time, cleaned)
  - Raw API/DB results → cleaned → structured → appended
```

### AGENTS.md Pattern (Machine-Readable Context Files)

Projects use version-controlled context files that agents auto-inject:

```markdown
# AGENTS.md — AI Agent Context for This Project

## Goals
What this project does, what agents should accomplish

## Tech Stack
Languages, frameworks, dependencies, versions

## Architecture
Directory structure, key modules, component relationships

## Conventions
Coding standards, naming, formatting rules, best practices

## Commands
Build, test, run, deploy — exact commands

## Contribution Guidelines
Branching, code review, CI requirements

## Security
Secret management, access controls, precautions

## Troubleshooting
Common errors, diagnostic steps, known issues
```

### 5 Instructional Styles for Context Files

| Style | Purpose | Example |
|---|---|---|
| Descriptive | Document existing practices | "This project uses Jest for testing." |
| Prescriptive | Dictate explicit actions | "Follow the existing code style." |
| Prohibitive | Set operational boundaries | "Never commit directly to main." |
| Explanatory | Provide reasoning context | "Avoid hard-coded waits to prevent timing issues." |
| Conditional | Situational logic | "If you need reflection, use ReflectionUtils." |

### Context Engineering Best Practices

1. **Minimal Sufficiency**: Only include essential information. Context
   bloat degrades accuracy and increases "needle in a haystack" failures.
2. **Preserve Structure**: Don't flatten documents into raw text. Retain
   tables, figures, and hierarchical relationships.
3. **Clean Tool Outputs**: Raw API/DB results → clean → condense →
   format as structured text/JSON before appending to context.
4. **Dynamic Management**: Continuously adjust included/excluded info
   based on conversation state, not static one-time prompts.
5. **Context Trimming**: Automatically drop outdated messages, summarize
   long history, discard low-relevance data before each model call.
6. **Treat as Infrastructure**: Version control, test, and govern context
   files with the same rigor as production code.
7. **Co-Evolve with Code**: Context files should evolve alongside source
   code, test suites, and CI pipelines to prevent agent drift.

### Placement Matters

Research finding: Place critical instructions at the **top** of the
prompt to counteract attention decay in long context windows. The
beginning and end of prompts receive disproportionate attention from
the model.
