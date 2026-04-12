# Prompt Modes in Production AI Systems

Analysis of different prompt modes used across production AI coding assistants.

---

## Why Multiple Modes?

Production systems recognize that **different user intents require different AI behaviors**. A one-size-fits-all prompt leads to:
- Over-eager code changes when user wants discussion
- Excessive verbosity when user wants quick answers
- Wrong abstraction level for the task at hand
- Poor user experience (surprising the user)

**Solution**: Mode-specific prompts with clear behavioral boundaries.

---

## Mode Classification

### Pattern 1: Intent Classifier (Kiro Approach)

Kiro uses a dedicated classifier prompt to route user requests:

```
Classify user intent into:
- "Do" mode: Direct code changes, debugging, feature implementation
- "Vibe" mode: Natural language app creation, exploratory building
- "Spec" mode: Specification writing, documentation, planning

Route to appropriate prompt based on classification.
```

**Benefits:**
- Automatic mode detection
- No user friction (don't need to specify mode)
- Consistent behavior within each mode

**Implementation:**
```
# Intent Classifier Prompt

You are an intent classifier. Given a user request, classify it into one of:

1. DO: User wants direct code changes or debugging
   - Keywords: fix, add, change, remove, update, delete
   - Examples: "Fix the bug in auth.ts", "Add dark mode"

2. VIBE: User wants to explore/create something from natural language
   - Keywords: create, build, make, I want, how about
   - Examples: "Build me a todo app", "Create a landing page"

3. SPEC: User wants documentation, planning, or specifications
   - Keywords: document, plan, design, explain, how does
   - Examples: "Document the API", "Explain the architecture"

Output ONLY the mode name (DO/VIBE/SPEC) and a 1-sentence justification.
```

---

## Mode-Specific Prompts

### Mode 1: Chat Mode
*From Cursor, Trae, VSCode Agent*

**Purpose:** Conversational assistance without automatic code changes

**Core Identity:**
```
You are in CHAT MODE. You provide convers assistance about code.
- Answer questions about codebase structure, patterns, best practices
- Explain code, architecture, and technical concepts
- Suggest approaches without implementing them
- Do NOT make code changes unless explicitly asked with action words
```

**Behavioral Rules:**
```
1. Assume user wants discussion, not implementation
2. Ask clarifying questions before suggesting code
3. Keep responses conversational and concise
4. Reference code you've read, don't guess
5. If user asks "how should I...", provide guidance, not code
6. Only write code if user says "implement", "create", "write"
```

**When to Suggest Switching to Builder Mode:**
- User says "implement this"
- User says "fix this bug"
- User says "add this feature"
- User provides specific technical requirements

---

### Mode 2: Builder Mode
*From Cursor, Trae, Augment Code*

**Purpose:** Autonomous code implementation with file operations

**Core Identity:**
```
You are in BUILDER MODE. You autonomously implement requested changes.
- Read and understand codebase before making changes
- Make focused, minimal changes
- Follow existing code conventions
- Test your changes when possible
- Explain what you changed and why
```

**Behavioral Rules:**
```
1. Research before implementing (never guess about codebase)
2. Make minimal, focused changes
3. Follow existing patterns and conventions
4. Test changes before declaring success
5. Explain changes with step-by-step breakdown
6. Don't add features beyond what was asked
7. Don't refactor unless explicitly requested
```

**Workflow:**
```
1. Understand the request
2. Research relevant code
3. Plan the changes
4. Implement systematically
5. Test/verify
6. Report what changed
```

---

### Mode 3: Vibe Coding Mode
*From Kiro, Google Gemini AI Studio*

**Purpose:** Natural language to full application generation

**Core Identity:**
```
You are in VIBE CODING MODE. Transform natural language into complete applications.
- Build full apps from descriptions
- Make bold design decisions
- Create beautiful, modern UI by default
- Assume best practices unless told otherwise
- Generate working code immediately
```

**Behavioral Rules:**
```
1. Interpret user intent generously
2. Make reasonable assumptions (don't ask too many questions)
3. Create complete, working applications
4. Use modern design patterns and aesthetics
5. Include authentication, database, routing if implied
6. Deploy or provide running URL if possible
```

**Tech Stack Defaults:**
```
Frontend: React + TypeScript + Tailwind CSS or Vanilla CSS
Styling: Modern, vibrant colors, dark mode, micro-animations
Routing: React Router or Next.js App Router
State: React hooks or Zustand for complex state
Backend: Supabase, Firebase, or mock data if not specified
```

**Design Standards:**
```
- User should be "wowed at first glance"
- Vibrant colors, gradients, glassmorphism
- Smooth transitions and micro-animations
- Modern typography (Inter, Roboto, Outfit from Google Fonts)
- Responsive design with mobile support
- Premium feel, not basic/MVP
```

---

### Mode 4: Planning Mode
*From Devin AI, Traycer AI, Antigravity*

**Purpose:** Architecture design, technical specifications, phase breakdown

**Core Identity:**
```
You are in PLANNING MODE. You are a technical lead creating specifications.
- Analyze requirements thoroughly
- Identify technical challenges
- Create detailed implementation plans
- Define file changes and locations
- Estimate complexity and risks
- DO NOT implement - only plan
```

**Behavioral Rules:**
```
1. Research codebase deeply before planning
2. Identify all files that need changes
3. Define exact locations for edits
4. Consider edge cases and error handling
5. Create phase-by-phase breakdown
6. Flag risks and unknowns
7. Present plan for approval before execution
```

**Output Format:**
```
# Technical Plan: [Feature Name]

## Overview
[1-2 paragraph summary]

## Files to Modify
1. `src/auth.ts` - Add JWT validation (lines 45-60)
2. `src/middleware.ts` - Update route guards
3. `tests/auth.test.ts` - Add test cases

## Implementation Phases

### Phase 1: [Name]
- [ ] Step 1: Specific action
- [ ] Step 2: Specific action
- Dependencies: [list]
- Risks: [list]

### Phase 2: [Name]
...

## Risks & Unknowns
- [Risk 1]: [Description and mitigation]
- [Unknown 1]: [How to resolve]

## Success Criteria
- [Criterion 1]
- [Criterion 2]
```

---

### Mode 5: Execution Mode
*From Devin AI, Traycer AI*

**Purpose:** Implement approved plans step-by-step

**Core Identity:**
```
You are in EXECUTION MODE. You follow an approved plan precisely.
- Execute plan steps in order
- Don't deviate from plan without approval
- Report progress after each phase
- Flag issues immediately
- Test after each phase
```

**Behavioral Rules:**
```
1. Follow the plan exactly as written
2. Complete each phase before moving to next
3. Report progress: "Phase X complete, Y remaining"
4. If you encounter issues, STOP and report
5. Don't add features not in the plan
6. Test after each phase
7. Update plan document with status
```

**Status Reporting:**
```
# Execution Status

## Phase 1: ✅ Complete
- Modified src/auth.ts
- Added JWT validation
- Tests passing (12/12)

## Phase 2: 🔄 In Progress
- Currently updating middleware
- ETA: 2 more steps

## Phase 3: ⏳ Pending
- Not started

## Issues
- None / [List any blockers]
```

---

### Mode 6: Classifier Mode
*From Kiro Mode_Classifier_Prompt*

**Purpose:** Route user requests to appropriate mode

**Implementation:**
```
You are an intent classifier for an AI coding assistant.

The assistant operates in different modes:
- DO: Direct code changes and debugging
- VIBE: Natural language app creation
- SPEC: Documentation and planning

Given the user's message, classify their intent:

<user_message>
{user's actual message}
</user_message>

Classification criteria:
- DO: User wants direct code action (fix, add, change, debug)
- VIBE: User wants to create/explore with natural language
- SPEC: User wants documentation, planning, explanation

Output format:
MODE: [DO/VIBE/SPEC]
CONFIDENCE: [HIGH/MEDIUM/LOW]
REASONING: [1 sentence explanation]

If CONFIDENCE is LOW, also suggest what clarification would help.
```

---

## Mode Detection Heuristics

If you don't have a dedicated classifier, use these heuristics:

### Signals for Chat Mode:
- Questions: "How does...", "What is...", "Why does..."
- Understanding: "Explain...", "Help me understand..."
- Discussion: "What do you think about...", "Should I..."
- Comparison: "Compare X and Y", "Pros and cons of..."

### Signals for Builder Mode:
- Action verbs: "Fix", "Add", "Remove", "Update", "Change"
- Specific targets: "The bug in auth.ts", "The login button"
- Implementation requests: "Implement...", "Create a function..."
- Error resolution: "This error...", "It's broken..."

### Signals for Vibe Mode:
- Creation desires: "Build me...", "I want an app that..."
- Exploratory: "How about we create...", "Let's make..."
- Vague but ambitious: "A social network for...", "A dashboard..."
- Natural language features: "Something like...", "Similar to..."

### Signals for Planning Mode:
- Documentation: "Document the...", "Write specs for..."
- Architecture: "Design the...", "Plan the..."
- Understanding structure: "How is X organized...", "What's the architecture..."
- Before implementation: "Before we build, let's plan..."

---

## Mode Transitions

### Recommended Flow:

```
User Request
    ↓
[Classifier] → Detect Mode
    ↓
Chat Mode ──(user asks for implementation)──→ Builder Mode
    ↓                                               ↓
(ask clarifying                              [Complete task]
 questions)                                         ↓
    ↓                                               ↓
    └────────(user wants planning)────────→ Planning Mode
                                                   ↓
                                            [Create plan]
                                                   ↓
                                            (user approves)
                                                   ↓
                                              Execution Mode
```

### Mode Transition Signals:

**Chat → Builder:**
- User says: "Implement this", "Go ahead", "Do it"
- User provides specific technical requirements

**Builder → Planning:**
- Task complexity exceeds threshold (e.g., >5 files)
- Multiple approaches possible, need user input
- Risks identified that require discussion

**Planning → Execution:**
- User approves the plan
- All unknowns resolved
- Resources available

**Any Mode → Chat:**
- User asks questions
- User wants explanation
- User says "never mind", "let's discuss"

---

## Examples from Production

### Trae AI:
- **Chat Prompt**: Conversational, uses AI Flow paradigm
- **Builder Prompt**: Agentic, autonomous code generation
- Separation: User selects mode in UI

### Kiro:
- **Mode Classifier**: Automatic intent detection
- **Do Mode**: Direct code changes
- **Vibe Mode**: Natural language creation
- **Spec Mode**: Documentation/planning

### Devin AI:
- **Planning Mode**: Research and create plans
- **Standard Mode**: Execute approved plans
- Separation: User indicates mode explicitly

### Traycer AI:
- **Plan Mode**: High-level technical design
- **Phase Mode**: Detailed implementation phases
- Separation: Sequential (plan first, then phase)

---

## Best Practices

### 1. Always Detect Mode
- Use automatic classifier or manual detection
- Don't assume - verify user intent
- Ask if ambiguous: "Would you like me to implement this or just discuss?"

### 2. Set Clear Expectations
- Announce mode at start: "I'm in builder mode, implementing your request"
- Explain what you'll do in this mode
- Ask permission to switch modes if needed

### 3. Allow Mode Switching
- User should be able to switch modes mid-conversation
- "Would you like me to switch to planning mode for this?"
- Detect when current mode isn't working

### 4. Mode-Specific Constraints
- **Chat**: No automatic code changes
- **Builder**: Minimal, focused changes only
- **Vibe**: Complete, working applications
- **Planning**: No implementation, only design
- **Execution**: Follow plan precisely, no deviations

### 5. Default to Less Aggressive Mode
- When uncertain, default to Chat/Planning
- Ask before implementing (Builder/Execution)
- Better to under-deliver than surprise user

---

## Anti-Patterns

❌ **Making code changes when user asked a question**
- User: "How does authentication work?"
- Bad: *Rewrites auth.ts*
- Good: Explains auth flow, offers to show code

❌ **Asking too many questions in vibe mode**
- User: "Build me a todo app"
- Bad: "What colors? What features? What backend?"
- Good: Creates complete todo app with sensible defaults

❌ **Implementing without plan in complex tasks**
- User: "Add user authentication to this app"
- Bad: Starts editing files immediately
- Good: Creates plan, identifies files, gets approval

❌ **Deviating from approved plan**
- User: "Follow the plan we agreed on"
- Bad: "I also refactored the database layer"
- Good: Executes plan exactly, suggests improvements separately

---

## Implementation Checklist

When building mode-aware prompts:

- [ ] Define modes appropriate for your use case
- [ ] Create classifier (automatic or manual detection)
- [ ] Write mode-specific behavioral rules
- [ ] Define mode transition criteria
- [ ] Set mode-specific constraints
- [ ] Add mode announcement in responses
- [ ] Allow user to override detected mode
- [ ] Test mode detection with various requests
- [ ] Ensure each mode has clear boundaries
