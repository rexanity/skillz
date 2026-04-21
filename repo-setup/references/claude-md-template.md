# [Project Name] — Claude Code Context

**Project**: [one-line description]

---

<!-- rtk-instructions v2 -->
## RTK (Rust Token Killer) - Token-Optimized Commands

### Golden Rule

**Always prefix commands with `rtk`**. If RTK has a dedicated filter, it uses it. If not, it passes through unchanged.

**Important**: Even in command chains with `&&`, use `rtk`:
```bash
# ❌ Wrong
git add . && git commit -m "msg" && git push

# ✅ Correct
rtk git add . && rtk git commit -m "msg" && rtk git push
```

### RTK Commands by Workflow

#### Build & Compile (80-90% savings)
```bash
rtk tsc                 # TypeScript errors grouped by file/code (83%)
rtk lint                # ESLint/Biome violations grouped (84%)
rtk next build          # Next.js build with route metrics (87%)
rtk cargo build         # Cargo build output
rtk cargo clippy        # Clippy warnings grouped by file (80%)
```

#### Test (90-99% savings)
```bash
rtk vitest run          # Vitest failures only (99.5%)
rtk playwright test     # Playwright failures only (94%)
rtk cargo test          # Cargo test failures only (90%)
rtk test <cmd>          # Generic test wrapper - failures only
```

#### Git (59-80% savings)
```bash
rtk git status          # Compact status
rtk git log             # Compact log (works with all git flags)
rtk git diff            # Compact diff (80%)
rtk git show            # Compact show (80%)
```

---

## MANDATORY: TDD + DoD Workflow

**BEFORE coding any task:**

1. **Write tests first** — Red → Green → Refactor. Never skip.
2. **Verify Definition of Done before marking complete:**
   - Tests written AND passing (≥50% coverage)
   - Types/annotations on all public APIs
   - Docstrings on public functions
   - Linting clean (no warnings)
   - No magic numbers (use named constants)
   - No TODOs, no debug print statements

**Verification commands:**

```bash
# Python/FastAPI
uv run pytest tests/ --cov=app --cov-report=term-missing
uv run ruff check app/ && uv run mypy app/

# TypeScript/Node
bun test --coverage
bun run typecheck && bun run lint

# Rust
cargo test && cargo clippy -- -D warnings
```

*(Customize above for this repo's actual stack)*

---

## MCP Tools: code-review-graph

**IMPORTANT: This project has a knowledge graph. ALWAYS use the
code-review-graph MCP tools BEFORE using Grep/Glob/Read to explore
the codebase.** The graph is faster, cheaper (fewer tokens), and gives
you structural context (callers, dependents, test coverage) that file
scanning cannot.

### When to use graph tools FIRST

- **Exploring code**: `semantic_search_nodes` or `query_graph` instead of Grep
- **Understanding impact**: `get_impact_radius` instead of manually tracing imports
- **Code review**: `detect_changes` + `get_review_context` instead of reading entire files
- **Finding relationships**: `query_graph` with callers_of/callees_of/imports_of/tests_for
- **Architecture questions**: `get_architecture_overview` + `list_communities`

Fall back to Grep/Glob/Read **only** when the graph doesn't cover what you need.

### Key Tools

| Tool | Use when |
|------|----------|
| `detect_changes` | Reviewing code changes — gives risk-scored analysis |
| `get_review_context` | Need source snippets for review — token-efficient |
| `get_impact_radius` | Understanding blast radius of a change |
| `get_affected_flows` | Finding which execution paths are impacted |
| `query_graph` | Tracing callers, callees, imports, tests, dependencies |
| `semantic_search_nodes` | Finding functions/classes by name or keyword |
| `get_architecture_overview` | Understanding high-level codebase structure |
| `refactor_tool` | Planning renames, finding dead code |

### Workflow

1. The graph auto-updates on file changes (via hooks).
2. Use `detect_changes` for code review.
3. Use `get_affected_flows` to understand impact.
4. Use `query_graph` pattern="tests_for" to check coverage.

---

## Documentation Rules

| What changed? | Where to document |
|---------------|-------------------|
| New feature | `docs/features/{feature-name}/OVERVIEW.md` |
| Architecture decision | `docs/adr/ADR-XXX-{slug}.md` |
| API endpoint changed | Update OpenAPI annotations — no new doc |
| Bug fix | Update troubleshooting guide IF broadly relevant |
| **Feature shipped** | **DELETE implementation docs** — keep only ADR + feature overview |

**Rules:**
1. No implementation docs after feature ships (they become stale)
2. Check existing docs before creating new files
3. Feature docs go in `docs/features/{name}/` — NOT root `docs/`

---

## Database Safety Rules

*(Remove this section if the project has no database)*

**NEVER run without backup:**
- `Base.metadata.create_all()` — can drop/recreate tables (data loss)
- `Base.metadata.drop_all()` — DROPS ALL TABLES

**ALWAYS use migrations** (Alembic, Prisma migrate, etc.) for schema changes.
