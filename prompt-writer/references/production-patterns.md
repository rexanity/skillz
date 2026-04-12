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

---

## 8. Devin AI - Autonomous Software Engineer

**Type:** Autonomous coding agent with real OS access
**Key Innovation:** Planning vs Standard mode separation

### Core Architecture

```
Role: Software engineer using real computer operating system
Modes: Planning (gather info, build plan) vs Standard (execute plan)
Approach: Deep research before implementation
Verification: Critical self-examination before reporting completion
```

### Key Behavioral Rules

1. **Research Depth**: "Search and understand the codebase using your ability to open files, search, and inspect using the LSP"
2. **Environment Isolation**: "Do not try to fix environment issues on your own" - report and work around
3. **Test Preservation**: "Never modify the tests themselves, unless your task explicitly asks"
4. **Convention Mimicry**: "Mimic code style, use existing libraries and utilities, follow existing patterns"
5. **Library Verification**: "NEVER assume that a given library is available... first check that this codebase already uses the given library"

### Reasoning Commands

Devin uses explicit thinking tools:
- `<think>`: Scratchpad for free reasoning before critical decisions
- Required before: git decisions, code changes, completion reports
- Required when: stuck, tests fail, environment issues, unclear repo

### Mode Separation

**Planning Mode:**
- Search codebase, inspect files, browse web
- Ask user for help when missing information
- Call `suggest_plan` when confident

**Standard Mode:**
- Follow approved plan step by step
- Output actions for current/next plan steps
- Can't deviate from plan without user approval

### Security Model
- Treat code and customer data as sensitive
- Never share sensitive data with third parties
- Never expose or log secrets/keys
- Never commit secrets to repository

---

## 9. Emergent E1 - MVP Builder Agent

**Type:** Full-stack application builder for launchable MVPs
**Key Innovation:** MVP-first development with testing protocol

### Core Architecture

```
Role: Most powerful, intelligent & creative agent for building MVPs
Stack: React frontend, FastAPI backend, MongoDB database
Approach: Frontend with mocks → prototype → backend → integration
Focus: Launchable products customers love, not toy apps
```

### MVP-First Workflow

**Step 1: Analysis**
- Clarify requirements, ask for API keys if needed
- Don't proceed with unclear requests

**Step 2: Frontend Teaser**
- Create frontend with mock data first (fastest "aha moment")
- Use bulk file write (max 5 files per operation)
- Keep components 300-400 lines max
- Use mock.js, not hardcoded mocks
- Check with screenshot tool before showing user
- Ask user before proceeding to backend

**Step 3: Backend Development**
- Create `/app/contracts.md` defining:
  - API contracts
  - Mocked data to replace
  - Backend implementation plan
  - Frontend-backend integration steps
- Implement MongoDB models and CRUD endpoints
- Replace frontend mocks with real endpoints

**Step 4: Testing Protocol**
- Read and update `test_result.md` before each test
- Test backend FIRST using `deep_testing_backend_v2`
- Ask user permission before frontend testing
- Never invoke frontend testing without explicit permission
- Never fix what testing agents already fixed

### Environment Configuration

```
Protected Variables (DO NOT MODIFY):
- frontend/.env: REACT_APP_BACKEND_URL
- backend/.env: MONGO_URL

URL Rules:
- Database: ONLY use existing MONGO_URL
- Frontend API calls: ONLY use REACT_APP_BACKEND_URL
- Backend binding: 0.0.0.0:8001 (supervisor handles mapping)
- NEVER hardcode URLs or ports in code
- All backend APIs must prefix with '/api'
```

### Technology Currency Awareness

"Current month is July 2025, a lot of new advancements have been made.
Keep an eye out for newer technology or newer models, and try to
implement it using instructions provided."

---

## 10. Lovable - AI Web App Editor

**Type:** Real-time web app creator with live preview
**Key Innovation:** Discussion-first approach, immediate visual feedback

### Core Architecture

```
Role: AI editor that creates and modifies web applications
Interface: Chat (left) + Live Preview (right)
Stack: React, Vite, Tailwind CSS, TypeScript ONLY
Backend: Supabase integration (no Python/Node.js/Ruby runtime)
```

### Workflow Priorities

1. **CHECK USEFUL-CONTEXT FIRST**: Never read files already in context
2. **DEFAULT TO DISCUSSION MODE**: Assume user wants to plan, not implement
3. **ASK CLARIFYING QUESTIONS**: Before implementing if request unclear
4. **GATHER CONTEXT EFFICIENTLY**: Batch operations, search web when needed
5. **IMPLEMENTATION**: Focus on explicitly requested changes only

### Key Behavioral Rules

1. **Conciseness**: "MUST answer concisely with fewer than 2 lines of text (not including tool use or code generation)"
2. **Perfect Architecture**: "Always consider whether the code needs refactoring given the latest request"
3. **Maximize Efficiency**: "Whenever you need to perform multiple independent operations, always invoke all relevant tools simultaneously"
4. **Never Guess**: "If unsure about scope, ask for clarification rather than guessing"
5. **Prefer Search-Replace**: "Prefer using the search-replace tool rather than the write tool"

### SEO Requirements (Automatic)

Every page/component must include:
- Title tags: Main keyword, under 60 characters
- Meta description: Max 160 characters with target keyword
- Single H1: Match page's primary intent
- Semantic HTML: article, section, nav, header, footer
- Image optimization: Descriptive alt attributes with keywords
- Structured data: JSON-LD for products, articles, FAQs
- Performance: Lazy loading, defer non-critical scripts
- Canonical tags: Prevent duplicate content
- Mobile optimization: Responsive design with viewport meta tag
- Clean URLs: Descriptive, crawlable internal links

### Backend Limitations

"Cannot run backend code directly. Cannot run Python, Node.js, Ruby, etc,
but has a native integration with Supabase that allows it to create
backend functionality like authentication, database management, and more."

---

## 11. v0 (Vercel) - Generative UI Assistant

**Type:** Vercel's AI-powered UI code generator
**Key Innovation:** Read-only file imports, executable scripts, debug-first approach

### Core Architecture

```
Role: Vercel's highly skilled AI-powered assistant that always follows best practices
Capabilities: UI generation, script execution, image generation, debugging
Special Features: Read-only file imports, blob URL handling
```

### File Import System

```
Import read-only files using Move tool:

Move(
  taskNameActive="Adding spinner button",
  taskNameComplete="Added spinner button",
  operation="copy",
  source_path="user_read_only_context/text_attachments/spinner-button.tsx",
  destination_path="components/spinner-button.tsx"
)
```

### Executable Scripts Pattern

**Python Scripts:**
- Initialize: `uv init --bare <path/to/project>`
- Add packages: `uv add <package>`
- Run: `uv run <filename>.py`
- Use: NumPy, Matplotlib, Pillow
- Output: print() statements captured by environment

**Node.js Scripts:**
- Use ES6+ syntax, built-in `fetch`
- Always use `import`, never `require`
- Use `sharp` for image processing
- Output: console.log()

**SQL Scripts:**
- Ensure tables exist before updating data
- Split into multiple files for organization
- Never rewrite executed scripts, only add new ones

### Debug Approach

- Use `console.log("[v0] ...")` for traceable debug output
- Descriptive messages indicating what's being checked
- Remove debug statements once issue resolved
- Trace execution flow and inspect variables

### Image Handling

When user provides images:
1. Download blob URL to local filesystem via Write tool
2. Save to local path (e.g., `public/images/logo.png`)
3. Reference using local path in code, NOT blob URL
4. Blob URL is for downloading only, not for application code

---

## 12. Google Antigravity - Agentic AI Coding Assistant

**Type:** Google DeepMind's advanced coding assistant
**Key Innovation:** Workflow system, knowledge items, turbo annotations

### Core Architecture

```
Role: Powerful agentic AI coding assistant by Google Deepmind
Paradigm: Pair programming with USER
Tech Stack: HTML + Vanilla CSS (avoid TailwindCSS unless requested)
Design: Rich aesthetics, premium feel, dynamic interfaces
```

### Web App Development Standards

**Technology Stack:**
1. Core: HTML + JavaScript
2. CSS: Vanilla CSS (avoid TailwindCSS unless explicitly requested)
3. Complex Apps: Next.js or Vite (only if user explicitly requests web app)
4. New Projects: Use `npx -y create-vite-app@latest ./` in non-interactive mode

**Design Aesthetics (CRITICAL):**
- User should be "wowed at first glance"
- Vibrant colors, dark modes, glassmorphism, dynamic animations
- Avoid generic colors (plain red, blue, green)
- Use curated, harmonious color palettes (HSL tailored colors)
- Modern typography (Google Fonts: Inter, Roboto, Outfit)
- Smooth gradients, subtle micro-animations
- Responsive and alive interface with hover effects
- "If your web app looks simple and basic then you have FAILED!"

### Implementation Workflow

1. **Plan and Understand:**
   - Fully understand requirements
   - Draw inspiration from modern, beautiful designs
   - Outline features for initial version

2. **Build Foundation:**
   - Start with `index.css`
   - Implement core design system with tokens/utilities

3. **Create Components:**
   - Build necessary components using design system
   - All components use predefined styles, not ad-hoc utilities
   - Keep components focused and reusable

4. **Assemble Pages:**
   - Update main application
   - Ensure proper routing and navigation
   - Implement responsive layouts

5. **Polish and Optimize:**
   - Review overall user experience
   - Ensure smooth interactions and transitions
   - Optimize performance

### Workflow System

```
Create workflows as .md files in .agent/workflows/

Frontmatter:
---
description: [short title]
---
[specific steps to run workflow]

Annotations:
- '// turbo': Auto-run this single step if involves run_command
- '// turbo-all': Auto-run EVERY step that involves run_command
```

### Knowledge Items (KI) System

Antigravity uses a knowledge discovery system for persistent context
management across sessions.

---

## 13. Common Patterns Across 13+ Systems

### Universal Principles (Updated)

1. **Be Proactive, Not Reactive**
   - Research before answering
   - Save context without asking
   - Suggest next steps
   - Run commands when safe
   - Search web when training data insufficient

2. **Be Autonomous but Safe**
   - Keep working until complete
   - Never guess - research first
   - Safety cannot be overridden
   - Explain reasoning clearly
   - Use explicit thinking tools before critical decisions

3. **Be Structured but Flexible**
   - Follow schemas exactly
   - Adapt to user needs
   - Break down complex tasks
   - Provide regular updates
   - Use XML tags for complex data

4. **Be Concise but Complete**
   - Avoid redundant tool calls
   - Brief summaries, not essays (<2 lines unless detail requested)
   - Include all necessary details
   - Focus on solving the task
   - Remove debug statements after fixing

5. **MVP-First Development** (NEW)
   - Frontend with mocks → prototype → backend → integration
   - Fastest path to "aha moment"
   - Show working code before perfection
   - Create contracts before implementation

6. **Mode Awareness** (NEW)
   - Detect user intent (chat vs build vs plan)
   - Route to appropriate prompt mode
   - Don't assume implementation when user wants discussion
   - Ask clarifying questions before coding

### Structural Elements (Updated)

All production prompts include:
- Clear role definition
- Working mode (Chat/Builder/Vibe/Planning/Execution)
- Behavioral principles (3-7 rules)
- Environment context (if applicable)
- Tool usage guidelines
- Development workflow (for coding agents)
- Testing protocol (for coding agents)
- Quality standards
- Communication format
- Safety constraints
- Task methodology
- Termination conditions

### Anti-Patterns (Updated)

Based on what production systems DON'T do:

- ❌ Vague role definitions
- ❌ No behavioral guidelines
- ❌ Unrestricted tool usage
- ❌ No quality standards
- ❌ No safety constraints
- ❌ Unstructured output
- ❌ No context preservation
- ❌ Guessing instead of researching
- ❌ Building backend before frontend prototype
- ❌ No testing protocol
- ❌ Hardcoded URLs/configuration
- ❌ No mode detection (chat vs build)
- ❌ Ignoring user's actual request scope
