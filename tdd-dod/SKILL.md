---
name: tdd-dod
description: BDD-flavored TDD + Definition of Done Workflow — mandatory for all coding tasks
---

# BDD + TDD + Definition of Done Workflow

**Trigger:** Any coding task — feature, bug fix, refactor.

**This is the MANDATORY workflow for ALL code contributions.**

BDD here is not a framework (no Cucumber, no `.feature` files required) — it's
a **discipline** for how you describe, name, and scope tests. Given/When/Then
drives *what* you test and *what you call it*; your project's native test
runner still runs it (pytest, jest, vitest, go test, rspec, JUnit, etc.).

---

## The Workflow (Do NOT Deviate)

```
Scenarios (Given/When/Then) → Failing Tests (RED) → Implement (GREEN) → Refactor → Verify DoD
```

**Never write implementation code before its scenario and its failing test exist.**

---

## Step 1: Scenarios (Given / When / Then)

Before any code, restate the task as **scenarios** from an actor's point of view.
One scenario per observable behavior — each becomes exactly one test.

### Feature template

```
Feature: [capability, from the user's / system's POV]
  As a [user role / system / caller]
  I want [outcome]
  So that [business value]
```

### Scenario template

```
Scenario: [name the rule, not the mechanism]
  Given [the world before the action — facts, state, preconditions]
  And   [additional context if needed]
  When  [the single triggering action]
  Then  [the observable outcome]
  And   [additional observable consequences]
```

**One "When" per scenario.** If you're writing two Whens, it's two scenarios.

### Example — threshold alerting

```
Feature: Threshold alerting
  As an operator
  I want to be alerted when a metric crosses a threshold
  So that I can respond before it becomes a problem

Scenario: value above the threshold raises a HIGH alert
  Given the threshold is 30
  When the metric is reported as 32.5
  Then the alert level is HIGH
  And an alert record is persisted

Scenario: value at exactly the threshold is still NORMAL
  Given the threshold is 30
  When the metric is reported as 30.0
  Then the alert level is NORMAL

Scenario: value below the threshold is NORMAL
  Given the threshold is 30
  When the metric is reported as 28.0
  Then the alert level is NORMAL

Scenario: non-numeric input is rejected
  When the metric is reported as "n/a"
  Then a validation error is raised
```

### Example — multi-actor scenario (the kind of bug unit tests miss)

```
Scenario: two tenants sharing a resource keep their data isolated
  Given tenant A and tenant B both exist
  And tenant A has one record
  And tenant B has no records
  When I fetch records for tenant B
  Then the result is empty
```

If you cannot write the scenario, you do not yet understand the task. Stop and clarify.

---

## Step 2: Write Failing Tests (RED Phase)

### One scenario → one test. Translate literally.

- `Scenario: X` → `test_<given_X>_<when_Y>_<then_Z>` (or your language's naming convention)
- `Given` → **Arrange** block (fixtures, seed state, construct inputs)
- `When` → **Act** block — **one line, one call**
- `Then` → **Assert** block (observable outcome only)

### Test template (language-agnostic shape)

```
test "given two tenants sharing a resource, when one acts, then the other is unaffected":
    # Given: two tenants, only A has a record
    tenant_a = make_tenant()
    tenant_b = make_tenant()
    create_record(tenant_a, data="x")

    # When: we fetch B's records
    result = repository.list_records(tenant_b.id)

    # Then: no leak from A
    assert result == []
```

Use your project's idiomatic test framework and naming convention (e.g.,
`describe/it` in JS, `test_*` in Python, `Test*` in Go, `@Test` in Java).
The **shape** (Arrange / Act / Assert, one scenario per test) is what matters.

### Test philosophy — Behavior over implementation

**Tests encode business rules (the Thens), NOT implementation details.**
A test should survive an implementation rewrite as long as the observable
behavior is unchanged. If a test breaks during refactor but the Then still
holds → the test is wrong.

| ✅ Behavior (Then-shaped)                   | ❌ Implementation (mechanism-shaped)  |
|--------------------------------------------|---------------------------------------|
| `"market is closed on a holiday"`          | `"is_open calls date.weekday()"`      |
| `"one failing job must not block others"`  | `"mock.add_job.call_count == 2"`      |
| `"inverted range returns empty"`           | `"while loop exits when cur > end"`   |
| `"B's data is empty after A writes"`       | `"query filters by tenant_id column"` |

**Gut check before writing each test:** "Would this test need to change if I
swapped the underlying library / ORM / framework / runtime but kept the same
Given/When/Then?" If yes — test the outcome, not the mechanism.

### Outside-in — test at the highest meaningful boundary

Prefer scenarios at the **business-logic boundary** (service methods, API
endpoints, UI component public API) over isolated unit tests of private
helpers. A scenario that goes through a public entry point protects every
private function it touches; a scenario against a private helper only
protects itself and invites implementation-coupled tests. Drop to unit level
only for pure algorithmic helpers (date math, parsing, calculations with
many edge cases).

### Scenario coverage (write ALL of these per feature)

| Category        | Scenario shape                              |
|-----------------|---------------------------------------------|
| **Happy path**  | Given normal state, When acted, Then succeeds |
| **Boundary**    | Given value at threshold, When acted, Then expected side of boundary |
| **Negative**    | Given precondition not met, When acted, Then no action / no state change |
| **Error**       | Given invalid input, When acted, Then raises / returns error |
| **Isolation**   | Given two actors sharing a resource, When one acts, Then the other is unaffected |
| **Idempotence** | Given an action already applied, When reapplied, Then state is unchanged |

The **Isolation** row is what catches the class of bugs where a query forgets
a WHERE clause (cross-tenant, cross-user, cross-account leaks). Include it
whenever your feature touches data keyed by more than one owner.

### Run → they MUST fail

Run your project's test command for the new test file. Expected: **ALL FAIL**
(implementation doesn't exist yet).

**If a scenario passes before you've implemented anything → the test doesn't
actually exercise the Then. Fix the test, not the code.**

---

## Step 3: Implement (GREEN Phase)

Write the **minimum code** to turn each scenario green. Do not implement
Thens that aren't yet asserted by a test.

### Function documentation

Each public function/method/component should have:
- A one-line description of what it does
- Documented parameters and return value (types + meaning)
- At least one usage example where non-obvious

Use your language's idiomatic doc format (docstrings, JSDoc, GoDoc, Javadoc, rustdoc, etc.).

### Run tests → they MUST pass

Run your project's test command. Expected: **ALL PASS**.

---

## Step 4: Refactor

- Clean up code, extract functions, improve naming
- Extract magic numbers/strings to named constants
- **Run tests after every change** — they must stay green

---

## Step 5: Verify Definition of Done

**Run ALL verification commands your project defines before marking complete.**
Typical categories below — use whatever your stack provides.

### Tests (MANDATORY)

- All tests pass (0 failures)
- Coverage meets project threshold (if configured)
- New scenarios from Step 1 are all covered

### Linting & Types

- Linter passes with 0 errors (eslint, ruff, rubocop, golangci-lint, etc.)
- Type checker passes with 0 errors (tsc, mypy, pyright, flow, etc., where applicable)
- Formatter has been run (prettier, black, gofmt, rustfmt, etc.)

### Build

- Project builds successfully (if there's a build step)
- No new warnings introduced

### DoD Checklist

| Category | Check |
|----------|-------|
| **Tests** | Written, passing, meets coverage threshold |
| **Types** | Public APIs have explicit types (where language supports it) |
| **Docs** | Public functions/classes/components documented with examples |
| **Constants** | No magic numbers/strings (extracted to named constants) |
| **Naming** | Follows project + language conventions |
| **Error handling** | Errors handled explicitly with logging/reporting |
| **No hardcoded values** | Use environment variables or config |
| **Async/performance** | Long operations don't block the user-facing path |
| **Schema changes** | DB migrations / schema updates committed alongside code |
| **No TODOs** | No `TODO: fix this later` comments left behind |
| **No debug code** | No stray `print`, `console.log`, `dbg!`, debuggers, commented-out code |
| **Docs updated** | README, API docs, changelog current |

---

## Step 6: Task Completion Format

When marking complete, output this:

```markdown
## Task Completion: [Feature Name]

### DoD Verification

**Tests:**
- [x] Tests written: `<path to test file(s)>`
- [x] Tests pass: [X]/[X] tests passing
- [x] Coverage: [X]% (meets project threshold)

**Code Quality:**
- [x] Types: Public APIs typed
- [x] Docs: Complete with examples
- [x] Constants: Extracted (no magic values)
- [x] Linting: Linter + type checker pass (0 errors)

**Integration:**
- [x] Backend/service layer: functional
- [x] UI: implemented (if applicable)
- [x] Schema/migration: created (if applicable)

**Verification Commands Run:**
<project-specific test, lint, typecheck, build commands>

**Status:** COMPLETE - All DoD criteria satisfied
```

---

## Anti-Patterns (NEVER Acceptable)

### BDD / test-shape anti-patterns

| Anti-Pattern | Why It's Bad | Correct Approach |
|--------------|--------------|------------------|
| `test_query_filters_by_tenant_id()` | Names the mechanism, not the rule | `test_given_X_when_Y_then_Z` — name the behavior |
| Multiple `When`s in one scenario | Hides which action caused the failure | Split into separate scenarios |
| Asserting internal calls (`mock.called_with(...)`) as the primary Then | Couples test to implementation | Assert the observable outcome (DB row, return value, HTTP response, rendered DOM) |
| Single-actor tests for multi-tenant code | Misses cross-actor leaks | Add an **Isolation** scenario with 2+ actors |
| Scenario with no `Given` | State is implicit; test is fragile | State the precondition explicitly, even if it's "no data exists" |
| Happy-path only | Edge cases ship broken | One scenario per row of the Scenario Coverage table |

### General anti-patterns

| Anti-Pattern | Why It's Bad | Correct Approach |
|--------------|--------------|------------------|
| `// TODO: add tests later` | Tests are mandatory | Write scenarios + tests NOW |
| `// FIXME: temporary` | Tech debt accumulates | Solve properly |
| `console.log("DEBUG:", value)` | Debug code in production | Use proper logging |
| Magic numbers/strings | Hard to maintain | Extract to named constants |
| No docs on public API | Code is opaque | Add doc comment with example |
| Swallowed errors (`catch {}`) | Silent failures | Log and handle, or let it propagate |
| Blocking user-facing path | Poor UX | Use async / background work |

---

## Project-Specific Commands

Discover and use whatever your project defines. Common patterns:

- **Node/JS/TS:** `npm test`, `bun test`, `pnpm test`, `npm run lint`, `npm run typecheck`, `npm run build`
- **Python:** `pytest`, `ruff check`, `mypy`, `pyright`
- **Go:** `go test ./...`, `go vet`, `golangci-lint run`, `go build ./...`
- **Rust:** `cargo test`, `cargo clippy`, `cargo build`
- **Ruby:** `bundle exec rspec`, `bundle exec rubocop`
- **Java/Kotlin:** `./gradlew test`, `./gradlew check`, `./gradlew build`

Check `package.json` scripts, `Makefile`, `justfile`, `CONTRIBUTING.md`, or
`CLAUDE.md` for the canonical commands for this project.
