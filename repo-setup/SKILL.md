---
name: repo-setup
description: Sets up a new repo with Rex's standard best practices — code-review-graph MCP, TDD + Definition of Done workflow, CLAUDE.md template, and RTK token optimization.
license: MIT
authors:
  - rexchung
keywords:
  - setup
  - best-practices
  - tdd
  - code-review
  - mcp
categories:
  - productivity
  - dev-process
metadata:
  version: 1.0.0
---

# Repo Setup

Sets up a repo with Rex's standard development best practices.

## When to use this skill

Run this when starting a new project or onboarding an existing repo:
- User says "set up this repo", "initialize best practices", "add my standard setup"
- New repo has no `.mcp.json` or `CLAUDE.md`
- User wants code-review-graph or TDD/DoD enforced in this project

## Setup Steps

Work through these in order. Check if each already exists before creating.

### Step 1 — code-review-graph MCP

Create `.mcp.json` in the repo root (or merge into existing):

```json
{
  "mcpServers": {
    "code-review-graph": {
      "command": "uvx",
      "args": ["code-review-graph", "serve"],
      "type": "stdio"
    }
  }
}
```

Verify `uvx` is available: `which uvx`. If not, install with `pip install uv`.

After creating `.mcp.json`, tell the user: **restart Claude Code for the MCP to activate.**

### Step 2 — CLAUDE.md

Check if `CLAUDE.md` exists. If yes, append the missing sections (don't overwrite existing project content). If no, create it from the template in `references/claude-md-template.md`.

Key sections to always include:
1. RTK token-optimization instructions (from `references/rtk-section.md`)
2. TDD + DoD workflow
3. code-review-graph MCP usage guide
4. Documentation rules

Customize the verification commands section for the repo's tech stack:
- Python/FastAPI: `uv run pytest`, `uv run ruff check`, `uv run mypy`
- TypeScript/Node: `bun test` or `vitest run`, `tsc --noEmit`, `biome check`
- Rust: `cargo test`, `cargo clippy`
- Mixed: include both

### Step 3 — Verify setup

```bash
# Confirm .mcp.json is valid JSON
cat .mcp.json | python3 -m json.tool

# Confirm CLAUDE.md exists and has TDD section
grep -l "TDD" CLAUDE.md
```

### Step 4 — Initial graph index (optional but recommended)

After the user restarts Claude Code with the MCP active, run:
```bash
# The graph indexes automatically on first use.
# To force index now if the MCP is already active:
# Use the MCP tool: get_architecture_overview
```

## What NOT to do

- Don't overwrite existing CLAUDE.md content — append the missing sections
- Don't add project-specific details (stack, ports, business logic) — that's the user's job
- Don't run `code-review-graph` CLI tools until the user confirms the MCP is active
- Don't assume the tech stack — ask if it's not obvious from the repo files
