# skillz

A collection of Claude Code skills. Each skill is a folder with a `SKILL.md` file.

## For AI: How to Help a User Install Skills

When a user asks you to help them install a skill from this repo:

1. **Show them the skill list below** and ask which one(s) they want, or recommend based on their goal.
2. **Run the install command** for the chosen skill using one of the methods below.
3. **Verify** the skill landed at `~/.claude/skills/<skill-name>/SKILL.md`.

After installing, the skill is available in Claude Code. The user may need to restart their Claude Code session.

---

## Available Skills

### `prompt-writer`
**What it does:** Crafts AI system prompts and agent instructions using patterns from 13+ production AI systems (Cursor, Windsurf, Manus, Claude Code, Devin, v0, etc.)

**Use when the user wants to:**
- Write or improve a system prompt
- Design an agent's instructions or persona
- Apply production prompt engineering patterns

**Key files:**
- `SKILL.md` — 5-phase prompt writing workflow, 17 patterns
- `references/` — Production patterns, prompt techniques (40+), tool schema patterns
- `assets/prompt-templates.md` — 10 ready-to-use templates

---

### `writing-skills`
**What it does:** Teaches how to author, test, and iterate on Claude Code skills using a TDD-style workflow (write test → watch fail → write skill → watch pass → refactor).

**Use when the user wants to:**
- Create a new skill from scratch
- Improve or debug an existing skill
- Understand how to verify a skill actually changes agent behavior

**Key files:**
- `SKILL.md` — TDD workflow for skill authoring
- `anthropic-best-practices.md` — Anthropic's official skill authoring guidance
- `testing-skills-with-subagents.md` — How to pressure-test skills with subagents

---

### `repo-setup`
**What it does:** Sets up a new repo with Rex's standard dev best practices — code-review-graph MCP, TDD + Definition of Done workflow, CLAUDE.md template, and RTK token optimization.

**Use when the user wants to:**
- Initialize a new project with best practices
- Add code-review-graph MCP to an existing repo
- Generate a CLAUDE.md with TDD/DoD and RTK sections pre-filled

**Key files:**
- `SKILL.md` — Step-by-step setup workflow
- `references/claude-md-template.md` — Full CLAUDE.md template to copy/customize

---

## Installation Methods

### Option 1: Vercel Skills (Recommended)

```bash
npx @vercel-labs/skills install https://github.com/rexanity/skillz/tree/main/prompt-writer
npx @vercel-labs/skills install https://github.com/rexanity/skillz/tree/main/writing-skills
npx @vercel-labs/skills install https://github.com/rexanity/skillz/tree/main/repo-setup
```

### Option 2: Symlink from `~/.agents/skills/` (if already cloned there)

If the skills already live in `~/.agents/skills/`, symlink them into Claude Code's skills directory instead of duplicating:

```bash
mkdir -p ~/.claude/skills
ln -s ~/.agents/skills/prompt-writer ~/.claude/skills/prompt-writer
ln -s ~/.agents/skills/writing-skills ~/.claude/skills/writing-skills
ln -s ~/.agents/skills/repo-setup ~/.claude/skills/repo-setup
```

Changes in `~/.agents/skills/` will be reflected immediately in Claude Code.

### Option 3: Manual copy from GitHub

```bash
git clone https://github.com/rexanity/skillz /tmp/skillz
mkdir -p ~/.claude/skills
cp -r /tmp/skillz/prompt-writer ~/.claude/skills/
cp -r /tmp/skillz/writing-skills ~/.claude/skills/
cp -r /tmp/skillz/repo-setup ~/.claude/skills/
```

### Option 4: Use SKILL.md directly (no install)

Copy the contents of any `SKILL.md` and paste as a system prompt or custom instruction in your AI tool.

---

## Skill Folder Layout

```
<skill-name>/
└── SKILL.md          # Required — this is what Claude Code loads
└── references/       # Optional supporting docs
└── assets/           # Optional templates / examples
```

Claude Code loads any `SKILL.md` it finds under `~/.claude/skills/`. Subdirectory structure beyond that is for human and AI reference only.
