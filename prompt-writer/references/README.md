# Reference Documentation

This directory contains in-depth analysis of production AI system prompts and prompt engineering techniques.

## Files

### [production-patterns.md](./production-patterns.md)
Detailed analysis of 13 real AI system prompts from:
- **Windsurf (Cascade)** - Agentic coding assistant
- **Manus AI** - Autonomous general-purpose agent
- **Cursor** - AI IDE integration
- **Claude Code** - Foundation model specialization
- **Devin AI** - Autonomous software engineer with OS access
- **Emergent E1** - MVP builder with testing protocol
- **Lovable** - Real-time web app editor with live preview
- **v0 (Vercel)** - Generative UI assistant
- **Google Antigravity** - Advanced coding assistant with workflows

Covers: core architectures, behavioral rules, tool protocols, quality standards, safety models, communication formats, environment configuration, and MVP-first development.

### [mode-patterns.md](./mode-patterns.md) (NEW)
Comprehensive guide to prompt modes in production systems:
- **Chat Mode** - Conversational assistance without code changes
- **Builder Mode** - Autonomous code implementation
- **Vibe Coding Mode** - Natural language to full app generation
- **Planning Mode** - Architecture design and specifications
- **Execution Mode** - Step-by-step plan implementation
- **Classifier Mode** - Intent detection and routing

Includes mode detection heuristics, transition patterns, and implementation checklists.

### [tool-schema-patterns.md](./tool-schema-patterns.md) (NEW)
Analysis of tool definition schemas from production systems:
- File operations (read, write, search-replace)
- Code search (semantic vs regex)
- Terminal command execution
- Dependency management
- Memory and context management
- User interaction patterns

Includes JSON schema templates, best practices, and anti-patterns.

### [prompt-techniques.md](./prompt-techniques.md)
40 prompt engineering techniques with examples:
1-8. Foundational techniques (Zero-Shot, Few-Shot, CoT, Role, etc.)
9-13. **Agentic patterns** (NEW - from production systems)
  - Autonomous Execution Loop
  - Proactive Memory Management
  - Safety with Non-Override
  - Structured Change Communication
  - XML-Structured Information
14-22. **Advanced reasoning patterns** (NEW)
  - Text-Only Enforcement
  - Few-Shot with Commentary
  - Subagent Delegation
  - Variable Substitution
  - Phase-Based Workflow
  - Explicit Negative Instructions
  - Prompt Caching Awareness
  - Token Budget Constraints
  - Modular Section Composition
23-30. **Autonomous agent patterns** (NEW)
  - ReAct (Reason + Act Loop)
  - Plan-and-Solve
  - Reflexion (Self-Evaluation)
  - Tree of Thoughts / Graph of Thoughts
  - Explicit Termination Conditions
  - Error Recovery Templates
  - Self-Correction During Execution
  - Drift Prevention

### [advanced-patterns.md](./advanced-patterns.md)
Deep dive into Claude Code architecture:
- System prompt architecture (modular composition)
- Subagent delegation ("never delegate understanding")
- XML-structured sub-prompts
- Phase-based workflows (batch, dream, coordinator)
- Token budget constraints
- Few-shot examples with commentary
- Prompt injection defense patterns

### [prompt-templates.md](../assets/prompt-templates.md)
Production-grade prompt templates (located in assets/).
