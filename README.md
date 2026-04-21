# skillz

A collection of Claude Code skills. Each skill is a folder with a `SKILL.md` file.

## For AI: How to Help a User Install Skills

When a user asks you to help them install a skill from this repo:

1. **Show them the skill list below** and ask which one(s) they want, or recommend based on their goal.
2. **Run the install command** for the chosen skill (copy the folder to `~/.claude/skills/`).
3. **Verify** the skill landed at `~/.claude/skills/<skill-name>/SKILL.md`.

```bash
# Install a skill (replace <skill-name> with the folder name)
mkdir -p ~/.claude/skills && cp -r /path/to/skillz/<skill-name> ~/.claude/skills/

# Or clone and install directly from GitHub
git clone https://github.com/rexanity/skillz /tmp/skillz
cp -r /tmp/skillz/<skill-name> ~/.claude/skills/
```

After installing, the skill is available in Claude Code. The user may need to restart their Claude Code session.

---

## Available Skills

### `prompt-writer`
**What it does:** Crafts AI system prompts and agent instructions using patterns from 13+ production AI systems (Cursor, Windsurf, Manus, Claude Code, Devin, v0, etc.)

**Use when the user wants to:**
- Write or improve a system prompt
- Design an agent's instructions or persona
- Apply production prompt engineering patterns

**Install:**
```bash
cp -r /tmp/skillz/prompt-writer ~/.claude/skills/
```

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

**Install:**
```bash
cp -r /tmp/skillz/writing-skills ~/.claude/skills/
```

**Key files:**
- `SKILL.md` — TDD workflow for skill authoring
- `anthropic-best-practices.md` — Anthropic's official skill authoring guidance
- `testing-skills-with-subagents.md` — How to pressure-test skills with subagents

---

## Quick Install (all skills)

```bash
git clone https://github.com/rexanity/skillz /tmp/skillz
mkdir -p ~/.claude/skills
cp -r /tmp/skillz/prompt-writer ~/.claude/skills/
cp -r /tmp/skillz/writing-skills ~/.claude/skills/
```

## Skill Folder Layout

```
<skill-name>/
└── SKILL.md          # Required — this is what Claude Code loads
└── references/       # Optional supporting docs
└── assets/           # Optional templates / examples
```

Claude Code loads any `SKILL.md` it finds under `~/.claude/skills/`. Subdirectory structure beyond that is for human and AI reference only.
