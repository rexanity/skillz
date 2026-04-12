# Tool Schema Patterns in Production AI Systems

Analysis of tool definition schemas from production AI coding assistants.

---

## Why Tool Schemas Matter

Tool schemas define **how AI agents interact with external capabilities**. Well-designed schemas:
- Make tool usage predictable and consistent
- Enable better function calling by LLMs
- Provide clear parameter validation
- Include helpful descriptions and examples
- Support error handling and recovery

---

## Core Schema Structure

### JSON Schema Standard

Most production systems use JSON Schema format:

```json
{
  "name": "tool_name",
  "description": "What this tool does and when to use it",
  "parameters": {
    "type": "object",
    "properties": {
      "param1": {
        "type": "string",
        "description": "What this parameter does",
        "example": "example-value"
      }
    },
    "required": ["param1"]
  }
}
```

---

## Tool Categories & Patterns

### 1. File Operations

#### Read File (Cursor Pattern)

```json
{
  "name": "read_file",
  "description": "Read the contents of a file. Returns 1-indexed file contents from start_line to end_line, with summary of lines outside range.\n\nIMPORTANT: This tool can view at most 250 lines at a time. Assess if contents are sufficient, and call again if needed.",
  "parameters": {
    "type": "object",
    "properties": {
      "target_file": {
        "type": "string",
        "description": "Path of the file to read (relative or absolute)"
      },
      "should_read_entire_file": {
        "type": "boolean",
        "description": "Whether to read the entire file. Defaults to false."
      },
      "start_line_one_indexed": {
        "type": "integer",
        "description": "The one-indexed line number to start reading from (inclusive)"
      },
      "end_line_one_indexed_inclusive": {
        "type": "integer",
        "description": "The one-indexed line number to end reading at (inclusive)"
      },
      "explanation": {
        "type": "string",
        "description": "One sentence explanation as to why this tool is being used"
      }
    },
    "required": [
      "target_file",
      "should_read_entire_file",
      "start_line_one_indexed",
      "end_line_one_indexed_inclusive"
    ]
  }
}
```

**Key Design Choices:**
- Requires explanation for every use (encourages intentionality)
- Line-based reading prevents context overflow
- Explicit about limitations (250 lines max)

#### Write File (Lovable Pattern)

```json
{
  "lov-write": {
    "description": "Write to a file. Overwrites existing file if exists.\n\n### IMPORTANT: MINIMIZE CODE WRITING\n- PREFER using line-replace for most changes\n- MAXIMIZE use of \"// ... keep existing code\" for unchanged sections\n- ONLY write specific sections that need to change\n- Create all files in parallel when possible",
    "parameters": {
      "type": "object",
      "properties": {
        "file_path": {
          "type": "string",
          "example": "src/main.ts"
        },
        "content": {
          "type": "string",
          "example": "console.log('Hello, World!')"
        }
      },
      "required": ["file_path", "content"]
    }
  }
}
```

**Key Design Choices:**
- Embeds best practices in description
- Encourages minimal changes
- Supports parallel execution

#### Line-Based Replace (Lovable Pattern)

```json
{
  "lov-line-replace": {
    "description": "Line-Based Search and Replace Tool\n\nThe PREFERRED tool for editing existing files. Uses explicit line numbers.\n\nELLIPSIS USAGE:\nFor sections >6 lines, use ellipsis (...) to omit unchanged content:\n- Include first 2-3 lines of section\n- Add \"...\" on its own line\n- Include last 2-3 lines of section\n- Focus on uniqueness, not exact line counts",
    "parameters": {
      "type": "object",
      "properties": {
        "file_path": {
          "type": "string",
          "example": "src/components/TaskList.tsx"
        },
        "search": {
          "description": "Content to search for (use ... for large sections)",
          "type": "string"
        },
        "first_replaced_line": {
          "type": "number",
          "description": "First line number to replace (1-indexed)",
          "example": 15
        },
        "last_replaced_line": {
          "type": "number",
          "description": "Last line number to replace (1-indexed)",
          "example": 28
        },
        "replace": {
          "type": "string",
          "description": "New content to replace with"
        }
      },
      "required": ["file_path", "search", "first_replaced_line", "last_replaced_line", "replace"]
    }
  }
}
```

**Key Design Choices:**
- Line-number validation prevents accidental overwrites
- Ellipsis pattern reduces token usage
- Validates content matches before replacing

#### Search & Replace (Diff Format - Cline Pattern)

```
Instead of JSON schema, Cline uses SEARCH/REPLACE blocks:

<<<<<<< SEARCH
[exact content to find, character-for-character]
=======
[new content to replace with]
>>>>>>> REPLACE

Critical rules:
1. SEARCH must match EXACTLY (whitespace, indentation, comments)
2. Only replaces first match occurrence
3. Keep blocks concise - break large changes into smaller blocks
4. Include just enough surrounding lines for uniqueness
```

---

### 2. Code Search

#### Semantic Search (Cursor Pattern)

```json
{
  "name": "codebase_search",
  "description": "Find snippets of code most relevant to the search query.\nThis is a SEMANTIC search tool - query should ask for something semantically matching what is needed.",
  "parameters": {
    "type": "object",
    "properties": {
      "query": {
        "type": "string",
        "description": "The search query. Reuse the user's exact query/most recent message with their wording."
      },
      "target_directories": {
        "type": "array",
        "items": { "type": "string" },
        "description": "Glob patterns for directories to search over"
      },
      "explanation": {
        "type": "string",
        "description": "One sentence explanation as to why this tool is being used"
      }
    },
    "required": ["query"]
  }
}
```

**Key Design Choices:**
- Semantic (not keyword) search
- Recommends reusing user's exact wording
- Optional directory scoping

#### Regex Search (Lovable Pattern)

```json
{
  "lov-search-files": {
    "description": "Regex-based code search with file filtering and context.\n\nTip: Use \\\\ to escape special characters in regex patterns.",
    "parameters": {
      "type": "object",
      "properties": {
        "query": {
          "type": "string",
          "example": "useEffect\\("
        },
        "include_pattern": {
          "type": "string",
          "example": "src/**"
        },
        "exclude_pattern": {
          "type": "string",
          "example": "src/components/ui/**"
        },
        "case_sensitive": {
          "type": "boolean",
          "example": false
        }
      },
      "required": ["query", "include_pattern"]
    }
  }
}
```

**Key Design Choices:**
- Traditional regex (not semantic)
- Include/exclude glob patterns
- Case sensitivity option

---

### 3. Terminal Commands

#### Run Command (Cursor Pattern)

```json
{
  "name": "run_terminal_cmd",
  "description": "PROPOSE a command to run on behalf of the user.\nThe user will approve before execution. Do NOT assume command has started running.\n\nGuidelines:\n1. `cd` to appropriate directory if new shell\n2. Pass NON-INTERACTIVE FLAGS (e.g., --yes for npx)\n3. If command would use pager, append ` | cat`\n4. For long-running commands, set `is_background` to true\n5. Don't include newlines in command",
  "parameters": {
    "type": "object",
    "properties": {
      "command": {
        "type": "string",
        "description": "The terminal command to execute"
      },
      "is_background": {
        "type": "boolean",
        "description": "Whether command should run in background"
      },
      "explanation": {
        "type": "string",
        "description": "One sentence explanation as to why this command needs to be run"
      }
    },
    "required": ["command"]
  }
}
```

**Key Design Choices:**
- Requires user approval (safety)
- Detailed guidelines in description
- Background execution support
- Requires explanation for intentionality

---

### 4. Dependency Management

#### Add Dependency (Lovable Pattern)

```json
{
  "lov-add-dependency": {
    "description": "Use this tool to add a dependency to the project. The dependency should be a valid npm package name.",
    "parameters": {
      "type": "object",
      "properties": {
        "package": {
          "type": "string",
          "example": "lodash@latest"
        }
      },
      "required": ["package"]
    }
  }
}
```

**Key Design Choices:**
- Simple, single-parameter interface
- Supports version specification (@latest)
- Clear description of valid input

---

### 5. Memory & Context

#### Create Memory (Windsurf Pattern)

```json
{
  "name": "create_memory",
  "description": "Save important context about the user's task, codebase, requests, and preferences for future reference.\n\nYou DO NOT need USER permission to create a memory.\nYou DO NOT need to be conservative about creating memories.\nSave context liberally - it will be auto-retrieved when relevant.",
  "parameters": {
    "type": "object",
    "properties": {
      "content": {
        "type": "string",
        "description": "The important context/information to save"
      },
      "category": {
        "type": "string",
        "enum": ["user_preference", "codebase_context", "technical_decision", "requirement"],
        "description": "Category of this memory"
      }
    },
    "required": ["content"]
  }
}
```

**Key Design Choices:**
- Explicitly states no permission needed
- Encourages liberal use (don't be conservative)
- Optional categorization for retrieval

---

### 6. User Interaction

#### Ask User Question (v0 Pattern)

```json
{
  "name": "AskUserQuestions",
  "description": "Ask the user questions when you need clarification, want to validate assumptions, or need to make a decision you're unsure about.\n\nIMPORTANT: Do not call this in parallel with other tools. Wait for user's response before proceeding.",
  "parameters": {
    "type": "object",
    "properties": {
      "questions": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "question": {
              "type": "string",
              "description": "The complete question to ask"
            },
            "header": {
              "type": "string",
              "description": "Short label (max 12 chars)"
            },
            "options": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "label": { "type": "string" },
                  "description": { "type": "string" }
                }
              },
              "minItems": 2,
              "maxItems": 4
            },
            "multiSelect": {
              "type": "boolean",
              "default": false
            }
          }
        },
        "minItems": 1,
        "maxItems": 4
      }
    },
    "required": ["questions"]
  }
}
```

**Key Design Choices:**
- Structured question format with options
- Limits to 1-4 questions at once
- Supports multi-select
- Must be called synchronously (wait for response)

---

## Schema Design Best Practices

### 1. Write Descriptive Descriptions

❌ **Bad:**
```json
"description": "Read a file"
```

✅ **Good:**
```json
"description": "Read the contents of a file. Returns 1-indexed file contents from start_line to end_line, with summary of lines outside range. IMPORTANT: Can view at most 250 lines at a time."
```

**Include:**
- What the tool does
- Important limitations
- When to use it
- Best practices

### 2. Add Examples

❌ **Bad:**
```json
"package": { "type": "string" }
```

✅ **Good:**
```json
"package": {
  "type": "string",
  "example": "lodash@latest"
}
```

### 3. Require Explanations for Expensive Operations

For tools that are expensive or have side effects, add:

```json
"explanation": {
  "type": "string",
  "description": "One sentence explanation as to why this tool is being used, and how it contributes to the goal."
}
```

This forces the AI to think about WHY it's using the tool.

### 4. Use Explicit Validation

```json
"required": ["file_path", "content"]
```

Always specify required parameters explicitly.

### 5. Support Parallel Execution

In descriptions, note when tools can be called in parallel:

```
If you need to create multiple files, create all of them at once instead of one by one, because it's much faster.
```

### 6. Embed Best Practices in Descriptions

Don't just describe WHAT the tool does - describe HOW to use it well:

```
### IMPORTANT: MINIMIZE CODE WRITING
- PREFER using line-replace for most changes
- MAXIMIZE use of "// ... keep existing code"
- ONLY write specific sections that need to change
```

---

## Common Patterns Across Systems

### Explanation Parameter

Most tools from multiple systems include:

```json
"explanation": {
  "type": "string",
  "description": "One sentence explanation as to why this tool is being used"
}
```

**Adopted by:** Cursor, Windsurf, Manus, Claude Code

### Line-Based Operations

For file editing, most systems use line-number-based approaches:

- **Cursor**: `start_line_one_indexed`, `end_line_one_indexed_inclusive`
- **Lovable**: `first_replaced_line`, `last_replaced_line`
- **Cline**: SEARCH/REPLACE blocks with exact content matching

**Rationale:** Prevents context drift, enables precise targeting.

### Required User Approval

For destructive operations:

```
"The user will approve before execution. Do NOT assume command has started running."
```

**Adopted by:** Cursor, Windsurf, Manus, Devin AI

### Parallel Execution Encouragement

Many tools explicitly state:

```
"When making multiple edits, invoke necessary tools simultaneously in parallel. Do NOT wait for one edit to complete before starting the next."
```

**Adopted by:** Lovable, Emergent, v0, Antigravity

---

## Anti-Patterns

❌ **Vague Descriptions:**
```json
{
  "name": "edit",
  "description": "Edit a file"
}
```

❌ **Missing Examples:**
```json
{
  "mode": { "type": "string" }
}
```

❌ **No Required Fields:**
```json
{
  "required": []
}
```

❌ **Allowing Full File Writes by Default:**
Systems that only have write_file without read-first approach lead to:
- Accidental content loss
- Context overflow
- Inefficient token usage

❌ **No Explanation Requirement:**
Without requiring explanations, AI agents use tools randomly without reasoning.

---

## Tool Schema Template

Use this template when defining tools for your AI agent:

```json
{
  "tool_name": {
    "description": "What this tool does and WHEN to use it.\n\nInclude:\n- Best practices\n- Limitations\n- Important notes\n- Parallel execution guidance (if applicable)",
    "parameters": {
      "type": "object",
      "properties": {
        "param_name": {
          "type": "string|number|boolean|array|object",
          "description": "What this parameter does",
          "example": "example-value"
        }
      },
      "required": ["param1", "param2"]
    }
  }
}
```

---

## Checklist for Tool Schema Design

When creating tool schemas:

- [ ] Description explains WHAT the tool does
- [ ] Description includes WHEN to use it
- [ ] Description has best practices embedded
- [ ] Description notes any limitations
- [ ] All parameters have descriptions
- [ ] Examples provided for complex parameters
- [ ] Required parameters clearly specified
- [ ] Types are correct (string vs number vs boolean)
- [ ] Explanation parameter included for expensive operations
- [ ] Parallel execution guidance provided if applicable
- [ ] User approval requirement stated if applicable
- [ ] Enum constraints used for fixed options
- [ ] Min/max constraints used for arrays

---

## References

Tool schemas analyzed from:
- Cursor Agent Tools v1.0.json
- Lovable Agent Tools.json
- Windsurf Tools Wave 11.txt
- Manus tools.json
- Emergent Tools.json
- v0 Tools.json
- And 12 other production systems
