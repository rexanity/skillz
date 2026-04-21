# skillz

A collection of Claude Code skills and plugins.

---

## For AI: How to Help a User Install Skills

When a user asks you to help them install something from this repo:

1. **Show them the catalog below** and ask which one(s) they want, or recommend based on their goal.
2. **Run the install command** for the chosen item.
3. **Verify** it landed correctly (skill at `~/.claude/skills/<name>/SKILL.md`, plugin at `~/.claude/plugins/<name>/`).

After installing, the user may need to restart their Claude Code session.

---

## Catalog

### `claude-best-practices` — Skill
**One-time or continuous improvement.** Distills community best practices for Claude Code: CLAUDE.md structure, settings hierarchy, skills frontmatter, hooks patterns, MCP setup, and Boris Cherny's top workflow tips.

**Use when:** setting up Claude Code for the first time, optimizing an existing setup, or learning advanced patterns.

**Install:**
```bash
# Vercel Skills (recommended)
npx @vercel-labs/skills install https://github.com/rexanity/skillz/tree/main/claude-best-practices

# Manual
cp -r /tmp/skillz/claude-best-practices ~/.claude/skills/
```

---

### `repo-setup` — Skill (agent-agnostic)
**Per-project. Works in any agent** (Cursor, Codex, Claude Code, etc.). Guides setup of a repo with Rex's standard dev practices: code-review-graph MCP, TDD + DoD workflow, CLAUDE.md template, RTK token optimization.

**Use when:** starting a new project or onboarding an existing repo in any AI coding tool.

**Install:**
```bash
npx @vercel-labs/skills install https://github.com/rexanity/skillz/tree/main/repo-setup

# or manual
cp -r /tmp/skillz/repo-setup ~/.claude/skills/
```

---

### `plugins/repo-setup` — Plugin (Claude Code only)
**Per-project. Claude Code only.** Same as `repo-setup` but packaged as a plugin — **automatically configures the code-review-graph MCP** alongside the skill. Installs in one command.

**Use when:** starting a project in Claude Code and want MCP + setup skill in one install.

**Install — for AI: choose the right method based on whether the marketplace is registered:**

**Method 1: `/plugin install` (requires marketplace registration first)**

The `rexanity` marketplace must be registered in `~/.claude/plugins/known_marketplaces.json` before this works. Check if it's already there:
```bash
cat ~/.claude/plugins/known_marketplaces.json | grep rexanity
```

If missing, add it:
```bash
node -e "
const fs = require('fs');
const path = require('os').homedir() + '/.claude/plugins/known_marketplaces.json';
const data = JSON.parse(fs.readFileSync(path, 'utf8'));
data.rexanity = {
  source: { source: 'github', repo: 'rexanity/skillz' },
  installLocation: require('os').homedir() + '/.claude/plugins/marketplaces/rexanity-skillz',
  lastUpdated: new Date().toISOString()
};
fs.writeFileSync(path, JSON.stringify(data, null, 2));
console.log('registered rexanity marketplace');
"
```

Then install:
```bash
/plugin install repo-setup@rexanity
```

**Method 2: Manual copy (always works, no registration needed)**
```bash
git clone https://github.com/rexanity/skillz /tmp/skillz

# Option A — copy into project's .claude/ directory (per-project)
mkdir -p .claude/skills/repo-setup
cp /tmp/skillz/plugins/repo-setup/.mcp.json ./.mcp.json
cp -r /tmp/skillz/plugins/repo-setup/skills/repo-setup/* .claude/skills/repo-setup/

# Option B — copy to global plugins cache
cp -r /tmp/skillz/plugins/repo-setup ~/.claude/plugins/cache/rexanity/repo-setup
```

Plugin structure:
```
plugins/repo-setup/
├── .claude-plugin/plugin.json   ← makes it installable
├── .mcp.json                    ← code-review-graph (auto-configured)
└── skills/repo-setup/SKILL.md   ← setup workflow
```

> **Note for AI:** If the user just wants the skill without the MCP, use the `repo-setup` skill install above — it's simpler and works in any agent.

---

### `prompt-writer` — Skill
**Reusable across projects.** Crafts AI system prompts and agent instructions using patterns from 13+ production systems (Cursor, Windsurf, Manus, Claude Code, Devin, v0, etc.)

**Use when:** writing or improving a system prompt, designing agent instructions.

**Install:**
```bash
npx @vercel-labs/skills install https://github.com/rexanity/skillz/tree/main/prompt-writer
```

---

### `writing-skills` — Skill
**Reusable across projects.** Teaches how to author, test, and iterate on Claude Code skills using TDD (write test → watch fail → write skill → watch pass → refactor).

**Use when:** creating a new skill or improving an existing one.

**Install:**
```bash
npx @vercel-labs/skills install https://github.com/rexanity/skillz/tree/main/writing-skills
```

---

## Install Everything

```bash
# Skills (agent-agnostic, always works)
npx @vercel-labs/skills install https://github.com/rexanity/skillz/tree/main/claude-best-practices
npx @vercel-labs/skills install https://github.com/rexanity/skillz/tree/main/repo-setup
npx @vercel-labs/skills install https://github.com/rexanity/skillz/tree/main/prompt-writer
npx @vercel-labs/skills install https://github.com/rexanity/skillz/tree/main/writing-skills

# Plugin (Claude Code only — requires rexanity marketplace registered, see plugin section above)
/plugin install repo-setup@rexanity
```

## Symlink from `~/.agents/skills/` (if already cloned there)

```bash
mkdir -p ~/.claude/skills
ln -s ~/.agents/skills/claude-best-practices ~/.claude/skills/claude-best-practices
ln -s ~/.agents/skills/repo-setup ~/.claude/skills/repo-setup
ln -s ~/.agents/skills/prompt-writer ~/.claude/skills/prompt-writer
ln -s ~/.agents/skills/writing-skills ~/.claude/skills/writing-skills
```

---

## Skill vs Plugin

| | Skill | Plugin |
|--|-------|--------|
| Works in | Any agent (Cursor, Codex, Claude Code…) | Claude Code only |
| Installs | `~/.claude/skills/` or agent-specific dir | `~/.claude/plugins/` |
| Can bundle MCP | No | Yes |
| Can bundle multiple skills | No | Yes |
| Best for | Single reusable capability | Per-project setup with config |
