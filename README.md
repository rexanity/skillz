# Prompt Writer Skill

Expert AI prompt writing skill built with production-proven patterns from Windsurf, Manus, Cursor, and Claude.

## Installation

### Option 1: With Paks (Recommended)

Install directly from this repository:

```bash
paks install https://github.com/rexanity/skillz/tree/main/prompt-writer
```

Or if published to the registry:

```bash
paks install prompt-writer
```

### Option 2: Without Paks (Manual)

Copy the skill files to your AI tool's skill directory:

```bash
# Clone the repository
git clone https://github.com/rexanity/skillz.git

# Copy the skill folder to your tool's skills directory
cp -r skillz/prompt-writer ~/.your-ai-tool/skills/
```

Or simply copy the entire `prompt-writer/` folder wherever your AI agent can access it:

```
prompt-writer/
├── SKILL.md              # Main skill file (required)
├── references/           # Reference docs (optional but recommended)
└── assets/               # Templates (optional but recommended)
```

Most AI agents will automatically detect `SKILL.md` in the folder.

### Option 3: Use SKILL.md Directly

If your AI tool doesn't support skills, just copy the `SKILL.md` content and paste it as a system prompt or custom instruction:

1. Open `prompt-writer/SKILL.md`
2. Copy everything after the YAML frontmatter
3. Paste into your AI tool's system prompt or custom instructions

## Usage

Once installed, activate the skill when you need to:
- Write system prompts for AI agents
- Improve existing prompts
- Learn production prompt patterns
- Create specialized prompts for coding, research, or automation

## Structure

| File | Purpose |
|------|---------|
| `SKILL.md` | Main skill with 5-phase prompt writing workflow, 13 patterns |
| `references/production-patterns.md` | Analysis of 7 AI system patterns + context engineering |
| `references/prompt-techniques.md` | 30 prompt engineering techniques |
| `references/advanced-patterns.md` | Deep dive: Claude Code architecture, subagent delegation, injection defense |
| `assets/prompt-templates.md` | 6 production-grade templates |

## What's Inside

Built from analysis of production AI systems:
- **Windsurf (Cascade)** - Agentic coding patterns
- **Manus AI** - Autonomous agent patterns
- **Cursor** - IDE integration patterns
- **Claude Code** - Foundation model patterns, subagent delegation

Plus 2025-2026 research on:
- **ReAct** (Stanford) - Reason + Act loops for autonomous agents
- **Context Engineering** - What knowledge to provide, not just how to ask
- **Prompt Injection Defense** - Security patterns for agents reading external content
- **Termination Conditions** - Preventing runaway agents
- **Reflexion & Self-Correction** - Agents that learn from their own mistakes

Includes: autonomous execution loops, tool protocols, safety models, memory management, code quality standards, structured communication formats, reasoning patterns (ReAct, Plan-and-Solve, ToT, Reflexion), error recovery, drift prevention, and injection defense.
