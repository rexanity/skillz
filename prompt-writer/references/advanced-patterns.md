# Claude Code Advanced Prompt Patterns

Deep patterns extracted from the Claude Code codebase. These are production-grade techniques used in Anthropic's CLI.

---

## 1. System Prompt Architecture

### Modular Section Composition

Claude Code doesn't use monolithic prompts. It composes them from sections:

```typescript
systemPromptSection(name, compute)     // memoized, cached until /clear
DANGEROUS_uncachedSystemPromptSection(name, compute, reason) // breaks cache
```

**Application**: Build complex prompts as arrays of section functions.
Filter out null sections. This allows feature-gated and conditional content.

```
Section 1: "Role" → always included
Section 2: "Project Context" → included if project detected
Section 3: "Tool Guidance" → included if tools available
Section 4: "Current Task" → always included
```

### Prompt Caching with Dynamic Boundary

```
[STATIC SECTION - cacheable across sessions]
--- DYNAMIC BOUNDARY ---
[SESSION-SPECIFIC CONTENT]
```

Everything before the boundary uses `scope: 'global'` for cross-user
prompt caching. The naming `DANGEROUS_uncachedSystemPromptSection()`
signals that cache-busting is sometimes necessary.

**Application**: Put universal rules first, context-specific content last.
This saves tokens and cost when the static portion is cached.

---

## 2. Subagent Delegation (AgentTool)

### Core Principle: "Never Delegate Understanding"

> "When spawning a fresh agent, it starts with zero context.
> Brief the agent like a smart colleague who just walked into the room."

### Required Context Transfer

Every subagent prompt must include:
1. **What** you're trying to accomplish and **why**
2. **What** you've already learned or ruled out
3. **File paths**, line numbers, specific changes (not vague references)
4. **What "done" looks like** explicitly

### Anti-Pattern (Lazy Delegation)

❌ "Based on your findings, fix the bug"

### Correct Pattern

✅ "Read src/auth.ts lines 45-60. The JWT validation uses the old secret
format. Fix it to use the new rotation format from src/config/secrets.ts.
Run `npm test -- auth` to verify."

---

## 3. XML-Structured Sub-Prompts

Claude Code uses XML tags extensively for structuring information:

| Tag | Purpose |
|-----|---------|
| `<task-notification>` | Worker/tool results with structured metadata |
| `<analysis>` | Scratchpad reasoning (stripped before output) |
| `<summary>` | Final user-facing response |
| `<system-reminder>` | Automated system messages |
| `<example>` | Few-shot examples with commentary |
| `<current_notes_content>` | Session memory content |

### Benefits
- Clear boundaries between sections
- Easier to parse programmatically
- Reduces confusion between different data sources
- Enables selective stripping (e.g., `<analysis>` removed from output)

### Example

```xml
<task-notification>
  <tool>Bash</tool>
  <command>npm test</command>
  <status>completed</status>
  <output>All 42 tests passed</output>
</task-notification>
```

---

## 4. Phase-Based Workflows

### Batch Skill (batch.ts)

```
Phase 1: Research/Plan
Phase 2: Spawn Workers (5-30 parallel agents)
Phase 3: Track Progress (status table rendering)
```

### Dream Consolidation

```
Phase 1: Orient - understand what happened
Phase 2: Gather - collect relevant information
Phase 3: Consolidate - merge into coherent memory
Phase 4: Prune and Index - remove stale, update references
```

### Coordinator Mode

```
Research → Synthesis → Implementation → Verification
```

**Key insight**: "Parallelism is your superpower." Explicitly encourage
parallel execution. Verification means **proving** the code works, not
**confirming** it exists.

---

## 5. Text-Only Enforcement (Compact)

```
CRITICAL: Respond with TEXT ONLY. Do NOT call any tools.
Tool calls will be REJECTED and will waste your only turn.

[task]

Remember: TEXT ONLY. No tool calls.
```

Uses a strong preamble **and** trailer to reinforce the constraint.
The model has only one turn — wasting it on a tool call breaks the flow.

---

## 6. Token Budget Constraints

| Constraint | Value |
|------------|-------|
| MEMORY.md max lines | 200 |
| MEMORY.md max size | ~25KB |
| Session memory section | 2000 tokens per item |
| Session memory total | 12000 tokens |

When the model knows its budget, it self-regulates output size.
Include explicit constraints in prompts for predictable output length.

---

## 7. Few-Shot Examples with Commentary

Don't just show **what** to do — explain **why**:

```xml
<example>
<commentary>
We read the file first to understand the current structure before
making any changes. This prevents blind edits that could break things.
</commentary>
<user>Fix the auth bug in src/auth.ts</user>
<assistant>Let me read src/auth.ts to understand the current auth flow.</assistant>
</example>
```

The commentary teaches reasoning patterns, not just actions.

---

## 8. Explicit Negative Instructions

Production systems include extensive "what NOT to do":

```
Don't:
- Don't add features beyond what was asked
- Don't refactor unless explicitly requested
- Don't create helpers for one-time operations
- Don't propose changes to code you haven't read
- Don't race — don't fabricate fork results without running
- Don't peek — don't check worker results prematurely
- Don't delegate understanding — read the files yourself
```

Negative instructions are often more effective than positive ones because
they prevent specific failure modes the model is prone to.

---

## 9. Variable Substitution Templates

MagicDocs and SessionMemory use `{{variable}}` syntax with custom file
override support:

```
~/.claude/magic-docs/prompt.md        → custom Magic Docs prompt
~/.claude/session-memory/config/prompt.md → custom session memory prompt
~/.claude/session-memory/config/template.md → custom template
```

**Application**: Use `{{variable}}` for reusable templates. Allow runtime
overrides and persistent variable files.

---

## 10. Skill Registration Pattern

Skills use YAML frontmatter with rich metadata:

```yaml
---
description: "What this skill does"
when_to_use: "When to invoke"
user-invocable: true
allowed-tools: ["Read", "Bash", "Edit"]
argument-hint: "<instruction>"
effort: high
---
```

Additional fields:
- `model` — override model per skill
- `disableModelInvocation` — skip LLM call
- `executionContext` — "fork" for isolated execution
- `agent` — delegate to specific subagent type
- `paths` — conditional activation based on file patterns
- `hooks` — pre/post execution hooks
- `shell` — shell execution configuration

---

## Key Takeaways for Prompt Writers

1. **Modular > Monolithic** — compose prompts from sections
2. **Cache-aware** — separate static from dynamic content
3. **XML-structured** — use tags for clear boundaries
4. **Phase-based** — break complex tasks into explicit phases
5. **Negative instructions** — tell the model what NOT to do
6. **Token budgets** — constrain output size explicitly
7. **Commentary examples** — teach reasoning, not just actions
8. **Never delegate understanding** — include full context for subagents
