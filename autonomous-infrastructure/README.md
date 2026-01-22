# Autonomous Skill Orchestration Infrastructure

This module enables Claude Code to **proactively use skills and agents** without explicit user requests, while maintaining a self-improving memory loop.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        User Request                              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  PreToolUse Hook: skill-recommender.sh                          │
│  ├─ Pattern match against skill-triggers.yaml                   │
│  ├─ Query skill_memory for past successes                       │
│  └─ Inject skill recommendations into context                   │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                     Task/Skill Execution                         │
│  (Claude uses recommended skills/agents based on complexity)     │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  PostToolUse Hook: skill-outcome-logger.sh                      │
│  ├─ Log task type, skills used, success/failure                 │
│  └─ Write to ~/.claude/logs/skill_outcomes.jsonl                │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  Periodic Sync: sync-outcomes-to-chroma.py                      │
│  └─ JSONL → ChromaDB skill_memory collection                    │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│  Weekly: memory-consolidation-agent                             │
│  ├─ Cross-agent pattern detection                               │
│  ├─ Schema formation (abstract principles)                      │
│  ├─ Temporal decay (age-weight memories)                        │
│  └─ Knowledge transfer between agents                           │
└─────────────────────────────────────────────────────────────────┘
```

## Files

| File | Purpose |
|------|---------|
| `skill-triggers.yaml` | Pattern → skill/agent mappings for auto-invocation |
| `skill-recommender.sh` | PreToolUse hook that suggests skills based on task patterns |
| `skill-outcome-logger.sh` | PostToolUse hook that logs outcomes to JSONL |
| `sync-outcomes-to-chroma.py` | Syncs JSONL outcomes to ChromaDB for persistence |

## Complexity Gates

The system distinguishes between tasks that should be done directly vs orchestrated:

```yaml
complexity_requirements:
  min_estimated_tool_calls: 5
  multi_file_change: true
  ambiguity_present: true
  skip_patterns:
    - "quick|simple|just|only"
    - "typo|spelling|rename"
    - "one file|single file"
```

**Do directly (< 5 tool calls):**
- Simple fixes, typos, single-file changes
- Quick lookups (grep, glob, read)

**Use skills inline:**
- Need specific methodology (reasoning patterns)
- Want structured output (reports, docs)

**Delegate to agents:**
- Complex multi-file changes
- Deep exploration needed
- Parallel workstreams

## Trigger Patterns

| Task Type | Patterns | Skills/Agents |
|-----------|----------|---------------|
| Debugging | `debug\|bug\|error\|failing` | root-cause-analyzer, debug:parallel |
| Implementation | `implement\|build\|create` | plan:parallel, implementor |
| Research | `research\|investigate\|explore` | research-specialist, research:deep |
| Architecture | `architect\|design\|trade-off` | integrated-reasoning-v2, architect-agent |
| Security | `security\|vulnerab\|audit` | security-agent, break-it-tester |

## Requirements

- **jq** - JSON processor (used by hooks)
- **Python 3.8+** - For ChromaDB sync script
- **chromadb** - Python package for vector storage

```bash
# Install dependencies
sudo apt install jq           # Debian/Ubuntu
brew install jq               # macOS

pip install chromadb
```

## Installation

1. Copy files to `~/.claude/`:

```bash
cp skill-triggers.yaml ~/.claude/
mkdir -p ~/.claude/hooks
cp *.sh ~/.claude/hooks/
cp sync-outcomes-to-chroma.py ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh ~/.claude/hooks/*.py
```

2. Add hooks to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Task",
        "hooks": [{"type": "command", "command": "$HOME/.claude/hooks/skill-recommender.sh"}]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Task",
        "hooks": [{"type": "command", "command": "$HOME/.claude/hooks/skill-outcome-logger.sh"}]
      },
      {
        "matcher": "Skill",
        "hooks": [{"type": "command", "command": "$HOME/.claude/hooks/skill-outcome-logger.sh"}]
      }
    ]
  }
}
```

> **Note**: Use `$HOME` instead of `~` for reliable path expansion. You can also use `/hooks` command in Claude Code to manage hooks interactively.

3. Create skill_memory collection in ChromaDB (done automatically on first sync)

4. Add to your `CLAUDE.md` (see `example-CLAUDE.md` for full template):

```markdown
## Autonomous Behavior

Check ~/.claude/skill-triggers.yaml for auto-invocation patterns.
Query skill_memory before complex tasks. Store outcomes after completion.
```

5. Verify installation:

```bash
# Check hooks are executable
ls -la ~/.claude/hooks/

# Test skill recommender (should output JSON if patterns match)
echo '{"tool_input":{"prompt":"debug this error"}}' | ~/.claude/hooks/skill-recommender.sh

# Verify jq is working
echo '{}' | jq .
```

## Maintenance

**Daily:** Outcomes auto-logged to JSONL

**End of session:** Run sync
```bash
python3 ~/.claude/hooks/sync-outcomes-to-chroma.py
```

**Weekly:** Run memory consolidation
```bash
# In Claude Code
/consolidate weekly
# Or invoke memory-consolidation-agent directly
```

## Self-Improvement Loop

The system continuously improves through:

1. **Pattern Learning** - Successful skill/agent combinations are remembered
2. **Confidence Weighting** - High-success patterns get priority
3. **Cross-Agent Transfer** - Validated patterns propagate to similar agents
4. **Temporal Decay** - Stale patterns naturally fade unless reinforced

This creates a virtuous cycle where Claude gets better at selecting the right tools over time.
