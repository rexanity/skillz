---
name: claude-best-practices
description: Guides Claude Code setup and workflow optimization using community best practices. Use when setting up Claude Code for a project, improving an existing setup, learning advanced patterns, or configuring skills/hooks/MCP/settings.
---

# Claude Code Best Practices

## Setup Checklist (Highest ROI First)

1. **CLAUDE.md** — create at repo root with project context, coding standards, and recurring mistakes. This is your most impactful lever.
2. **Pre-allow permissions** — whitelist safe bash commands so Claude stops asking: `Bash(git *)`, `Bash(npm *)`, `Bash(uv *)`.
3. **MCP servers** — give Claude your tools (GitHub, Slack, Sentry, BigQuery) via `.mcp.json`.
4. **PostToolUse hook** — auto-format code after edits so CI never fails on style.
5. **Plan mode first** — shift+tab twice before auto-accept. Verify the plan, then let it execute.
6. **Slash commands** — put repeated workflows in `.claude/commands/` (e.g., `/commit-push-pr`).
7. **Subagents** — put automated processes in `.claude/agents/` (e.g., code simplifier, test runner).
8. **Parallelism** — run 5 local tabs + 5-10 on claude.ai/code simultaneously for high throughput.

## CLAUDE.md

**Loading rules (critical for monorepos):**
- Ancestors load at startup (Claude walks UP the tree)
- Descendants load lazily (only when Claude reads files in that subdirectory)
- Siblings never load
- `~/.claude/CLAUDE.md` applies to all projects

**What to put where:**
| Location | Content |
|----------|---------|
| `~/.claude/CLAUDE.md` | Personal preferences, tools, global habits |
| `<repo>/CLAUDE.md` | Project standards, architecture, recurring mistakes |
| `<subdir>/CLAUDE.md` | Component-specific patterns (lazy-loaded) |
| `CLAUDE.local.md` | Personal overrides, gitignored |

**What to include:** tech stack, build/test commands, architecture overview, terminology, known pitfalls, DoD checklist.

## Skills Frontmatter (14 fields)

| Field | Use when |
|-------|----------|
| `name` | Sets the `/slash-command` name. Defaults to directory name. |
| `description` | Trigger conditions for auto-discovery (third person, 1536 char cap with `when_to_use`) |
| `when_to_use` | Extra trigger phrases — appended to description in the listing |
| `argument-hint` | Shown in autocomplete, e.g. `[issue-number]` |
| `disable-model-invocation: true` | Prevent Claude from auto-invoking — user-only |
| `user-invocable: false` | Hide from `/` menu — background knowledge only |
| `allowed-tools` | Tools allowed without permission prompts when skill is active |
| `model` | Override model for this skill (`haiku`, `sonnet`, `opus`) |
| `effort` | Override effort level (`low`, `medium`, `high`, `xhigh`, `max`) |
| `context: fork` | Run skill in an isolated subagent context |
| `paths` | Glob patterns — skill only activates for matching files |

## Settings Hierarchy

Five levels, highest wins:

```
1. Managed (org-enforced)
2. Command line args
3. .claude/settings.local.json  ← personal overrides, gitignore this
4. .claude/settings.json        ← team-shared
5. ~/.claude/settings.json      ← your global defaults
```

**Most useful settings:**
```json
{
  "model": "opus",
  "effort": "high",
  "permissions": {
    "defaultMode": "auto",
    "allow": ["Bash(git *)", "Bash(npm *)", "Read(/workspace)"]
  },
  "hooks": {
    "PostToolUse": [{ "matcher": "Edit", "type": "command", "command": "npm run format" }]
  }
}
```

## Hooks

| Event | Use for |
|-------|---------|
| `PostToolUse` (Edit) | Auto-format after file edits |
| `PostToolUse` (Bash) | Run tests after commands |
| `Stop` | Validate completed work, send notifications |
| `PreToolUse` | Block dangerous commands, rewrite to safer alternatives |

## Key Patterns from Boris Cherny (Claude Code creator)

- **Use Opus with thinking** for all coding — requires less steering, faster overall despite cost
- **Give Claude a way to verify its work** — improves output quality 2-3x (run tests, linters, type checks)
- **Tag `@claude` on PRs** with the GitHub action — auto-updates CLAUDE.md with lessons from code review
- **Share CLAUDE.md with your team** — document Claude's mistakes so every instance avoids them
- **Context rot** — kicks in around 300-400k tokens; start a fresh session rather than continuing

## Official Skills (Built-in)

| Skill | What it does |
|-------|-------------|
| `simplify` | Review changed code for reuse, quality, efficiency |
| `batch` | Run commands across multiple files in bulk |
| `debug` | Debug failing commands or code issues |
| `loop` | Run a prompt on a recurring interval (up to 3 days) |
| `claude-api` | Build apps with the Anthropic SDK |

## References

- Full best practices: https://github.com/shanraisshan/claude-code-best-practice
- Official skills repo: https://github.com/anthropics/skills
- Hooks repo: https://github.com/anthropics/claude-code-hooks
- Settings docs: https://code.claude.com/docs/en/
