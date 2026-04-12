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
