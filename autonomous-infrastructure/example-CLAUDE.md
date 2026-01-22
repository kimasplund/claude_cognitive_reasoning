# Global Claude Code Configuration

## Autonomous Behavior

### When to Orchestrate vs Do Directly

**Do it yourself (no agents):**
- Simple fixes (typos, small bugs, single-file changes)
- Quick lookups (grep, glob, read a file)
- Obvious implementations with clear requirements
- Tasks completable in < 5 tool calls

**Use skills inline:**
- Need a specific methodology (reasoning patterns, pre-commit checks)
- Want structured output (research reports, documentation)

**Delegate to agents:**
- Complex multi-file changes
- Tasks requiring deep exploration
- Parallel workstreams (multiple independent subtasks)
- Long-running operations (background with Ralph loop)

**Rule of thumb:** If you can do it faster than spawning an agent, just do it.

### Auto-Invocation Patterns

Check `~/.claude/skill-triggers.yaml` for pattern mappings. Only invoke when task complexity warrants it.

### Auto-Invoke Rules

**Debugging Tasks** (patterns: bug, error, failing, broken, crash):
- Auto-invoke: `root-cause-analyzer` agent
- Use: `debug:parallel` skill for complex issues
- Always generate hypotheses before diving into code

**Feature Implementation** (patterns: implement, build, create, add feature):
- Auto-invoke: `confidence-check-skills` before coding
- Use: `plan:parallel` for multi-file changes
- Spawn `implementor` agent for execution

**Codebase Exploration** (patterns: where is, find, how does X work):
- Auto-invoke: `Explore` agent (fast, thorough)
- Use: `code-finder` agent for specific searches
- Run in parallel when multiple search terms

**Research Tasks** (patterns: research, investigate, compare options):
- Auto-invoke: `research-specialist` agent
- Use: `research:deep` skill for comprehensive analysis

**Architecture Decisions** (patterns: design, architect, trade-offs):
- Auto-invoke: `integrated-reasoning-v2` skill
- Use: `architect-agent` for system design
- Apply dialectical reasoning for trade-offs

**Security Reviews** (patterns: security, vulnerability, audit):
- Auto-invoke: `security-agent`
- Use: `break-it-tester` for adversarial testing

### Parallel Execution

When tasks contain "and", "also", "multiple", or list several items:
1. Identify independent subtasks
2. Spawn agents in parallel using multiple Task tool calls in single message
3. Synthesize results after all complete

Example patterns for parallelization:
- "Fix bug X and add feature Y" → parallel agents
- "Search for A, B, and C" → parallel code-finder calls
- "Understand auth AND payment flows" → parallel Explore agents

### Background Tasks

Use `&` prefix or Ctrl+B for:
- Long-running test suites
- Continuous file watchers
- Ralph loops for iterative improvement

### Skill Memory Integration

**Automatic logging:** PostToolUse hooks log all Task/Skill outcomes to `~/.claude/logs/skill_outcomes.jsonl`

**Before complex tasks**, query ChromaDB `skill_memory` collection:
```
Query: "task description keywords"
Use: Past successful patterns to inform approach
```

**Periodic sync** (run at end of session or daily):
```bash
python3 ~/.claude/hooks/sync-outcomes-to-chroma.py
```

**Manual store** for significant learnings:
```
mcp__chroma__chroma_add_documents(
  collection_name="skill_memory",
  documents=["Task description, skills used, outcome"],
  ids=["unique_id"],
  metadatas=[{success: true, task_type: "...", skills: "..."}]
)
```

### Ralph Loop Usage

For iterative improvement tasks:
```bash
/ralph-loop "Task with clear completion criteria. Output DONE when complete." --completion-promise "DONE" --max-iterations 30
```

Good candidates:
- Getting tests to pass
- Fixing lint errors iteratively
- Implementing features with TDD
- Refactoring until quality metrics met

## Quality Gates

Before implementing:
1. Check confidence >= 90% (use confidence-check-skills)
2. Verify no duplicates exist
3. Understand existing patterns

Before committing:
1. Run `review:pre-commit` skill
2. Verify tests pass
3. Check for security issues

## MCP Servers Available

- `chroma` - Vector DB for persistent memory
- `uspto` - Patent research
- `finlex` - Finnish law
- `eurlex` - EU law

## Cognitive Patterns

Use `integrated-reasoning-v2` to select optimal reasoning:
- **ToT**: Find THE best among known options
- **BoT**: Explore ALL possible approaches
- **HE**: Find root CAUSE of issues
- **DR**: Synthesize opposing valid views
- **AR**: Stress-test solutions before committing
