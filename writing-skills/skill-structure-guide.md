# Skill Structure Guide

**Load this reference when:** deciding how to organize skill files, writing code examples, or setting up a new skill directory.

---

## Code Examples

**One excellent example beats many mediocre ones.**

Choose the most relevant language:
- Testing techniques → TypeScript/JavaScript
- System debugging → Shell/Python
- Data processing → Python

A good example is:
- Complete and runnable
- Well-commented explaining WHY
- From a real scenario
- Shows the pattern clearly
- Ready to adapt (not a generic fill-in-the-blank template)

Don't:
- Implement the same example in 5+ languages
- Create fill-in-the-blank templates
- Write contrived examples

You're good at porting — one great example is enough.

---

## File Organization

### Self-Contained Skill
```
defense-in-depth/
  SKILL.md    # Everything inline
```
When: All content fits, no heavy reference needed.

### Skill with Reusable Tool
```
condition-based-waiting/
  SKILL.md    # Overview + patterns
  example.ts  # Working helpers to adapt
```
When: The supporting file is reusable code, not just narrative.

### Skill with Heavy Reference
```
pptx/
  SKILL.md       # Overview + workflows
  pptxgenjs.md   # 600 lines API reference
  ooxml.md       # 500 lines XML structure
  scripts/       # Executable tools
```
When: Reference material is too large to inline (100+ lines of docs/API).

---

## Inline vs Separate File Decision

| Content type | Where it goes |
|---|---|
| Principles and concepts | Inline in SKILL.md |
| Code patterns < 50 lines | Inline in SKILL.md |
| API docs, comprehensive syntax (100+ lines) | Separate reference file |
| Reusable scripts or utilities | Separate file |
| Everything else | Inline |

**Target:** Keep SKILL.md under 500 lines. Split to references when approaching that limit.
