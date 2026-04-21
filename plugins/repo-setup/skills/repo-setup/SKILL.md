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

**First, run this check to see what's already installed:**

```bash
echo "=== RTK ===" && (rtk gain > /dev/null 2>&1 && echo "✓ installed" || echo "✗ not installed")
echo "=== code-review-graph ===" && (code-review-graph status > /dev/null 2>&1 && echo "✓ installed + graph built" || (which code-review-graph > /dev/null 2>&1 && echo "✓ installed (no graph yet)" || echo "✗ not installed"))
echo "=== CLAUDE.md ===" && ([ -f CLAUDE.md ] && echo "✓ exists" || echo "✗ missing")
echo "=== .mcp.json ===" && ([ -f .mcp.json ] && echo "✓ exists" || echo "✗ missing")
```

Skip any step where the output shows ✓. Work through these in order.

### Step 1 — RTK (Rust Token Killer)

Source: https://github.com/rtk-ai/rtk

```bash
curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/master/install.sh | sh
rtk gain      # verify correct rtk (should show token savings stats)
rtk init -g   # global initialization
```

⚠️ Name collision: if `rtk gain` fails, you may have the wrong `rtk`. Reinstall from the URL above.

### Step 2 — code-review-graph MCP

Source: https://github.com/tirth8205/code-review-graph

This plugin bundles a `.mcp.json` for the MCP server, but you still need to install the tool and build the graph:

```bash
pip install code-review-graph
code-review-graph build    # index the codebase (required before first use)
```

Tell the user: **restart Claude Code for the MCP to activate, then run `build`.**

Other useful commands:
```bash
code-review-graph update    # incremental re-index after changes
code-review-graph status    # show graph stats
code-review-graph watch     # auto-update on file changes
```

### Step 3 — CLAUDE.md

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

### Step 4 — Verify setup

```bash
code-review-graph status    # confirms graph is built
cat .mcp.json               # confirms MCP entry exists
```

## What NOT to do

- Don't overwrite existing CLAUDE.md content — append the missing sections
- Don't add project-specific details (stack, ports, business logic) — that's the user's job
- Don't assume the tech stack — ask if it's not obvious from the repo files
