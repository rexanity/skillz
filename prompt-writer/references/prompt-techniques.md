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

## 23. ReAct — Reason + Act Loop
*From Stanford research, adopted by LangChain, AutoGen, CrewAI*

The ReAct pattern interleaves reasoning traces with tool execution
in a structured loop:

```
For each step, follow this cycle:

Thought: [Reason about what you know and what you need to do next]
Action: [Call a tool with specific parameters]
Observation: [Process the tool's output]
Thought: [Analyze the observation, adjust plan]
Action: [Next tool or Finish]
...
Finish: [Final answer when query is resolved]
```

Example trajectory:
```
Question: What framework does this project use for testing?
Thought 1: I need to check the project's test configuration and
  dependencies to identify the testing framework.
Action 1: Read package.json and look for test-related dependencies.
Observation 1: Found "jest": "^29.0.0" in devDependencies, and
  jest.config.js at project root.
Thought 2: The project uses Jest 29. I should also check for any
  additional test utilities.
Action 2: Search for test utility files in the src/ directory.
Observation 2: Found src/test-utils/ with helper functions.
Finish: The project uses Jest 29 for testing, with custom utilities
  in src/test-utils/.
```

Key principles:
- Combine ReAct with Chain-of-Thought for best performance
- Each Thought must be explicit (not implied)
- Observation must be grounded in actual tool output (never fabricate)
- Finish only when the query is fully resolved

## 24. Plan-and-Solve Pattern
*Separates planning from execution to reduce premature tool usage*

```
Phase 1: PLAN
Before taking any action, create a plan:
1. Analyze the request to identify all sub-tasks
2. Determine which tools are needed for each sub-task
3. Order dependencies logically
4. Identify potential failure points
5. Present the plan to yourself (or user for approval)

Phase 2: EXECUTE
Follow the plan step by step:
- Execute one step at a time
- After each step, verify the result before proceeding
- If a step fails, return to PLAN phase to adjust
- Track progress against the original plan

Phase 3: VERIFY
- Check that all sub-tasks are complete
- Verify the final result matches the original request
- Report any deviations or unresolved items
```

This pattern prevents the common failure mode of agents jumping
into action without understanding the full scope of the task.

## 25. Reflexion — Self-Evaluation Loop
*Agent critiques its own outputs and regenerates improved actions*

```
After completing a task or encountering a failure:

<self-evaluation>
Goal: [What was the original objective]
What I did: [Summary of actions taken]
Result: [What actually happened]
Issues identified:
  - [Specific problem 1]
  - [Specific problem 2]
Root cause: [Why did this happen]
Improvement plan: [What I'll do differently]
</self-evaluation>

[Then re-execute with the improved approach]
```

Key rules:
- Be specific about failures (not vague "I should do better")
- Identify the root cause, not just symptoms
- The improvement plan must be actionable and different from before
- Limit retries (typically 2-3) to avoid infinite loops

## 26. Tree of Thoughts (ToT) / Graph of Thoughts (GoT)
*Explore multiple reasoning branches for complex decision trees*

```
When facing a complex problem with multiple possible approaches:

1. Generate 3 distinct approaches (branches)
2. For each approach, evaluate:
   - Feasibility (can it be done with available tools?)
   - Completeness (does it fully solve the problem?)
   - Risk (what could go wrong?)
3. Select the best branch to pursue
4. If the selected branch fails, backtrack and try the next best
5. Optionally combine elements from multiple branches

Document your evaluation:
<approach-evaluation>
Branch A: [description] — Feasibility: high, Completeness: medium, Risk: low
Branch B: [description] — Feasibility: medium, Completeness: high, Risk: medium
Branch C: [description] — Feasibility: low, Completeness: high, Risk: high
Selected: Branch A (best balance of feasibility and low risk)
</approach-evaluation>
```

This is especially useful for architecture decisions, debugging
complex issues, and research tasks with multiple hypotheses.

## 27. Explicit Termination Conditions
*Critical for preventing runaway agents (2025-2026 research consensus)*

Every autonomous agent task must define:

```
Termination Criteria:
- SUCCESS: [What does "done" look like? Be specific.]
- FAILURE: [What conditions mean the task has failed?]
- MAX_STEPS: [Maximum number of tool calls or reasoning steps]
- MAX_RETRIES: [Maximum retries per sub-task, typically 2-3]

When ANY criterion is met, stop immediately and report:
- Which criterion triggered termination
- What was accomplished
- What remains unresolved (if anything)
```

Example:
```
SUCCESS: All tests pass AND the bug in src/auth.ts is fixed
FAILURE: Cannot reproduce the issue after 3 different approaches
MAX_STEPS: 20 tool calls
MAX_RETRIES: 3 attempts per test run

If you hit MAX_STEPS without SUCCESS or FAILURE, summarize what
you've learned and recommend next steps for the user.
```

Research finding: Termination should be based on evidence
sufficiency, not arbitrary step limits. But step limits are
necessary as a safety backstop.

## 28. Error Recovery Templates
*Predefined conditional prompts for common failure modes*

```
Error Recovery Rules:

IF a tool call fails:
  1. Read the exact error message
  2. Diagnose the root cause (permissions? missing file? typo?)
  3. Retry at most once with a corrected approach
  4. If it fails again, try an alternative tool or method
  5. After 2 failed attempts, report to user with diagnosis

IF a test fails:
  1. Read the test output carefully
  2. Determine if the failure is related to your changes
  3. If related, fix the issue and re-run
  4. If unrelated to your changes, note it and continue

IF you get unexpected or empty results:
  1. Verify your inputs were correct
  2. Try a different approach to get the same information
  3. If all approaches fail, report the gap honestly

IF you detect you're going in circles:
  1. Stop immediately
  2. Summarize what you've tried and why it didn't work
  3. Propose a fundamentally different approach
  4. Limit to one more retry with the new approach
```

## 29. Self-Correction During Execution
*Agent detects and fixes its own mistakes mid-task*

```
Self-Correction Protocol:

After each action, ask yourself:
1. Did this produce the expected result?
2. If not, what went wrong?
3. Can I fix this immediately, or do I need to inform the user?

When you detect an error in your own work:
<correction>
Error: [What went wrong]
Cause: [Why it happened]
Fix: [What you'll do to correct it]
</correction>

Then immediately apply the fix before continuing.
Don't wait for the user to catch your mistakes.
```

## 30. Drift Prevention
*Keep multi-agent systems focused on the core objective*

```
Objective Drift Detection:
Every 5 steps, check yourself:
1. Re-read the original task
2. Ask: "Is what I'm doing right now directly advancing this goal?"
3. If no, immediately redirect to the core objective

Scope Creep Prevention:
- Don't add features beyond what was asked
- Don't refactor code that wasn't mentioned in the task
- Don't "fix" unrelated issues you happen to notice
- If you see something that needs attention, note it as a
  follow-up suggestion — don't do it now

Focus Check Template:
<focus-check>
Original task: [quote the task]
Current step: [what you're about to do]
Alignment: [yes/no — explain if no]
</focus-check>
```

## 31. MVP-First Development Workflow
*From Emergent E1, Lovable - Prioritize getting to working prototype quickly*

```
Development Phases:

Phase 1: Frontend Teaser (Fastest "Aha Moment")
- Create UI with mock data (use mock.js, not hardcoded)
- Maximum 5 files per bulk operation
- Keep components under 300-400 lines
- Verify with screenshot before showing user
- Ask user before proceeding to backend

Phase 2: Contract Definition
- Create contracts.md defining:
  * API endpoints needed
  * Data structures
  * Mocked data to replace
  * Integration steps
- Get user approval

Phase 3: Backend Implementation
- Create database models
- Implement CRUD endpoints
- Replace frontend mocks with real calls
- Test backend first

Phase 4: Integration & Testing
- End-to-end testing
- Fix integration issues
- Deploy or provide running URL

Rules:
- Never build backend before showing frontend prototype
- Always ask user permission before each phase
- Keep each file focused and under 400 lines
```

## 32. Environment-Aware Configuration
*From Emergent, Antigravity, Leap.new - Handle environment setup safely*

```
<environment>
Service Architecture:
- Frontend: [Framework] on port [X]
- Backend: [Framework] on [host:port]
- Database: [Type] via [CONNECTION_VAR]

Protected Variables (NEVER MODIFY):
- frontend/.env: [VAR_NAME] = [purpose]
- backend/.env: [VAR_NAME] = [purpose]

URL Rules:
- Database: ONLY use [VAR_NAME] from .env
- Frontend API: ONLY use [VAR_NAME] from .env
- Backend binding: [host:port] (handled by supervisor)
- NEVER hardcode URLs or ports in code
- All backend APIs must prefix with '[prefix]'

Restart Conditions:
- ONLY restart when: installing dependencies or changing .env
- Hot reload handles code changes automatically
</environment>
```

## 33. Discussion-First Default
*From Lovable - Assume user wants to plan before implementing*

```
Default Behavior: Assume DISCUSSION mode

When user sends request:
1. Check if it's informational or implementation request
2. If informational: Provide explanation, no code changes
3. If implementation: Ask clarifying questions first
4. Only implement when user uses explicit action words:
   - "implement", "code", "create", "add", "build"

Clarification Pattern:
"I understand you want to [restate request]. Before I proceed:
- [Clarification question 1]
- [Clarification question 2]

Should I implement this, or would you like to discuss further?"

Respect User Technical Level:
- Non-technical users: Don't ask them to manually edit files
- Technical users: Can provide code snippets for review
- Most users: Do it yourself, don't delegate to user
```

## 34. Design System Enforcement
*From Antigravity, Lovable - Ensure beautiful, modern UI by default*

```
Design Standards (MANDATORY for all web apps):

Color & Aesthetics:
- Use vibrant, curated colors (avoid generic red/blue/green)
- Implement dark mode or harmonious color palettes
- Use HSL colors for fine-grained control
- Apply smooth gradients and subtle micro-animations

Typography:
- Use modern fonts from Google Fonts (Inter, Roboto, Outfit)
- NEVER use browser default fonts
- Establish clear hierarchy (h1, h2, h3 with consistent sizing)

Interactions:
- Hover effects on all interactive elements
- Smooth transitions (200-300ms)
- Loading states for async operations
- Error states with helpful messages

Layout:
- Responsive design with mobile support
- Consistent spacing (use design tokens)
- Clear visual hierarchy
- Premium feel, not basic/MVP

Quality Bar:
"If your web app looks simple and basic then you have FAILED!"
User should be "wowed at first glance"
```

## 35. SEO-by-Default Pattern
*From Lovable, v0 - Automatically implement SEO on every page*

```
SEO Requirements (Apply to EVERY page/component):

Meta Tags:
- Title: Main keyword, under 60 characters
- Description: Max 160 characters with target keyword
- Canonical URL to prevent duplicate content

Structure:
- Single H1 per page (must match primary intent)
- Proper heading hierarchy (h1 → h2 → h3)
- Semantic HTML (article, section, nav, header, footer)

Content:
- Image alt attributes with descriptive keywords
- Descriptive, crawlable internal links
- JSON-LD structured data (products, articles, FAQs)

Performance:
- Lazy loading for images
- Defer non-critical scripts
- Optimize for fast page load

Mobile:
- Responsive design with viewport meta tag
- Touch-friendly interactive elements

Automatically implement these WITHOUT being asked.
```

## 36. Workflow System Pattern
*From Antigravity - Create reusable workflow definitions*

```
Create workflows as .md files in .agent/workflows/[name].md

Format:
---
description: [short title for the workflow]
---
1. [Step 1 description]
2. [Step 2 description]
3. [Step 3 description]

Auto-Run Annotations:
- '// turbo' above a step: Auto-run THIS step if it involves run_command
- '// turbo-all' anywhere: Auto-run ALL steps involving run_command

Usage:
- User invokes with /slash-command
- Agent reads workflow file
- Follows steps sequentially (or auto-runs if annotated)
- Can create new workflows when patterns emerge

Example:
---
description: How to deploy the application
---
1. Run tests: npm test
// turbo
2. Build: npm run build
// turbo
3. Deploy: npm run deploy
```

## 37. Debug-First Approach
*From v0, Devin AI - Use systematic debugging with traceable outputs*

```
Debugging Protocol:

1. Isolate the Issue:
   - Read error messages carefully
   - Check console logs and output
   - Reproduce the issue consistently

2. Add Traceable Debug Output:
   console.log("[v0] Checking authentication state...")
   console.log("[v0] API response:", responseData)
   
   - Use descriptive prefixes to identify debug source
   - Trace execution flow step by step
   - Inspect variables at critical points

3. Analyze and Hypothesize:
   - What do the logs tell me?
   - Where is the flow breaking?
   - What assumptions might be wrong?

4. Test Hypothesis:
   - Make targeted fix
   - Verify with debug output
   - Check if issue resolved

5. Clean Up:
   - Remove debug statements once issue resolved
   - Keep code clean and production-ready

Important: Don't jump to modifying code without understanding first.
```

## 38. Library Verification Pattern
*From Devin AI - Never assume dependencies exist*

```
Before Using Any Library or Framework:

1. CHECK if it's already in use:
   - Look at package.json / requirements.txt / Cargo.toml
   - Check neighboring files for imports
   - Search codebase for existing usage

2. If NOT found:
   - DO NOT assume it's available
   - Add to dependencies first
   - Then use it

3. When Creating New Components:
   - Look at existing components first
   - Match framework choice, naming conventions, typing
   - Follow established patterns

Example:
"Before using axios, let me check if it's already a dependency..."
[reads package.json]
"I see the project uses fetch, not axios. I'll use fetch instead."

NEVER assume a library is available just because it's well-known.
```

## 39. Technology Currency Awareness
*From Emergent - Stay updated with latest advancements*

```
Current Context: [Month Year]

Note: Recent months have seen rapid advancements in [field].
When implementing solutions:

1. Search web for latest best practices
2. Check for newer library versions
3. Look for modern alternatives to older patterns
4. Verify API documentation for changes
5. Mention if using cutting-edge vs established solutions

Example:
"Let me search for the latest React state management patterns..."
"I see Zustand has become more popular than Redux for new projects..."
"I'll use the modern approach with [new pattern]."

Don't rely solely on training data - verify with current information.
```

## 40. Read-Only File Import Pattern
*From v0 - Safely import from read-only context*

```
When user provides read-only files or templates:

Import Pattern:
Move(
  taskNameActive="Importing spinner button",
  taskNameComplete="Imported spinner button",
  operation="copy",
  source_path="user_read_only_context/path/to/file.tsx",
  destination_path="components/spinner-button.tsx"
)

Rules:
- MUST use copy operation (not write from scratch)
- Preserve original file structure and imports
- Destination should be relative to project root
- Check for existing similar components first
- Search read-only context before creating new files

Image/Asset Handling:
- Download blob URLs to local filesystem
- Save to public/images/[name].[ext]
- Reference using local path, NOT blob URL
- Blob URL is for downloading only
```
