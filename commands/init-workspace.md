---
description: Initialize Claude Code workspace with agents, skills, and cognitive reasoning structure
argument-hint: [minimal|standard|comprehensive]
allowed-tools: [Task, Bash, Read, Write, Glob, Grep, WebSearch]
model: claude-sonnet-4-5
---

# Claude Code Workspace Initialization v3.0

Initialize this project workspace with appropriate agents, skills, cognitive reasoning support, and directory structure.

**What's New in v3.0** (2026-01-19):
- Cognitive skills integration (9 reasoning patterns + IR-v2)
- `.claude/decisions/` for strategic decision logs
- `.claude/reasoning/` for multi-pattern reasoning sessions
- Dynamic path resolution (no hardcoded paths)
- Quality validation with rubric scoring

---

## Phase 1: Project Context Analysis

**Objective**: Understand what this project needs using BoT (Breadth of Thought) for exhaustive discovery.

### Tasks

1. **Read project documentation**:
   - README.md, CLAUDE.md (if exists)
   - package.json / pyproject.toml / Cargo.toml
   - High-level documentation

2. **Infer project characteristics**:
   - **Domain**: Web dev / AI-ML / Finance / DevOps / Data / Systems / Legal
   - **Language**: Python / JavaScript / Rust / Go / TypeScript
   - **Scale**: Small (<1K LOC) / Medium (1-10K) / Large (>10K)
   - **Stage**: Prototype / Development / Production

3. **Identify key workflows**:
   - Testing strategy (unit, integration, e2e)
   - Build/deploy requirements
   - Documentation needs
   - Cognitive reasoning needs (complex decisions, debugging, security)

### Deliverable

```markdown
## Project Classification

**Name**: [project name]
**Domain**: [inferred domain]
**Language**: [primary language]
**Scale**: [Small/Medium/Large]
**Stage**: [Prototype/Development/Production]

**Cognitive Needs Identified**:
- Complex decisions: [Yes/No] → needs ToT, DR, IR-v2
- Debugging: [Yes/No] → needs HE, SRC
- Security review: [Yes/No] → needs AR
- Research: [Yes/No] → needs BoT, AT
```

---

## Phase 2: Resource Discovery

**Objective**: Discover available agents, skills, and commands.

### 2.1 Agent Discovery

```bash
# List available agents
ls ~/.claude/agents/ 2>/dev/null | head -20
```

### 2.2 Skills Discovery

```bash
# List cognitive skills
ls ~/.claude/skills/ 2>/dev/null | grep -E "reasoning|thoughts|hypothesis|adversarial|dialectical|analogical|triage|negotiated|integrated" | head -15

# List domain skills
ls ~/.claude/skills/ 2>/dev/null | grep -v -E "reasoning|thoughts" | head -20
```

### 2.3 Commands Discovery

```bash
# List available commands
ls ~/.claude/commands/ 2>/dev/null
```

---

## Phase 3: Selection & Recommendation

**Objective**: Select appropriate resources using evaluation criteria.

### 3.1 Agent Selection

**Criteria**:
1. Domain match (project domain → specialized agents)
2. Workflow match (needs debugging → root-cause-analyzer)
3. Stage match (production → security-agent, qa-agent)

**Recommendation Format**:
```markdown
### Recommended Agents

1. **[agent-name]**
   - Purpose: [One-line description]
   - Why: [Specific reason for this project]
```

### 3.2 Cognitive Skills Selection

**Always Recommended**:
- `integrated-reasoning-v2` - Meta-orchestrator for pattern selection

**Domain-Specific**:
| Project Need | Recommended Skills |
|--------------|-------------------|
| Complex decisions | tree-of-thoughts, dialectical-reasoning |
| Debugging | hypothesis-elimination, self-reflecting-chain |
| Security | adversarial-reasoning |
| Research | breadth-of-thought, analogical-transfer |
| Time-critical | rapid-triage-reasoning |
| Stakeholder alignment | negotiated-decision-framework |

### 3.3 Commands Selection

Create project-specific commands based on detected build/test tools.

---

## Phase 4: User Approval

Present complete initialization plan:

```markdown
# Workspace Initialization Plan

## Proposed Changes

### Agents ([N] to symlink)
- [agent-1] - [Purpose]

### Cognitive Skills (Available from ~/.claude/skills/)
- integrated-reasoning-v2 - Meta-orchestrator
- [skill-1] - [Purpose]

### Directory Structure
```
.claude/
├── agents/          # Project-specific agents (symlinks)
├── commands/        # Project commands
├── refs/            # Reference documentation
├── context/         # Project context (ADRs, conventions)
├── research/        # Research outputs
├── decisions/       # Strategic decision logs (DEC-YYYY-MM-DD-NNN.md)
├── reasoning/       # Multi-pattern reasoning sessions
└── workspace/       # Temporary work area
    ├── planning/
    ├── drafts/
    └── notes/
```

**Approve?** (yes/no/modify)
```

---

## Phase 5: Initialization

### 5.1 Create Directory Structure

```bash
echo "Creating .claude/ workspace structure..."

mkdir -p .claude/{agents,commands,refs,context,research,decisions,reasoning}
mkdir -p .claude/workspace/{planning,drafts,notes,status-reports}

echo "Directory structure created"
```

### 5.2 Link Agents

```bash
echo "Linking agents from library..."

for agent in [agent-1] [agent-2]; do
  src="$HOME/.claude/agents/${agent}.md"
  if [ -f "$src" ]; then
    ln -sf "$src" ".claude/agents/${agent}.md"
    echo "Linked ${agent}"
  else
    echo "Agent not found: ${agent}"
  fi
done
```

### 5.3 Create Reference READMEs

```bash
# Create decisions/ README
cat > .claude/decisions/README.md << 'EOF'
# Strategic Decisions

Document strategic decisions using format:
`DEC-YYYY-MM-DD-NNN.md`

## Decision Log Template

```markdown
# DEC-YYYY-MM-DD-NNN: [Decision Title]

**Date**: YYYY-MM-DD
**Status**: Proposed | Approved | Implemented | Deprecated
**Stakeholders**: [List]

## Context
[Background and problem statement]

## Decision
[The decision made]

## Consequences
[Expected outcomes and trade-offs]

## Reasoning Pattern Used
[ToT/BoT/DR/etc. if cognitive skills were applied]
```
EOF

# Create reasoning/ README
cat > .claude/reasoning/README.md << 'EOF'
# Cognitive Reasoning Sessions

Store multi-pattern reasoning sessions here.

## Directory Structure

```
.claude/reasoning/
└── session-YYYYMMDD-HHMMSS-XXXXXXXX/
    ├── manifest.json          # Session metadata
    ├── pattern-state/         # Per-pattern state
    │   └── {pattern}/
    │       └── state.json
    ├── handovers/             # Pattern transitions
    ├── checkpoints/           # Timed snapshots
    └── synthesis/             # Final outputs
```

## When to Use

- Complex problems requiring multiple reasoning patterns
- High-stakes decisions needing >90% confidence
- Problems benefiting from pattern handover (e.g., BoT → ToT → SRC)
EOF

echo "READMEs created"
```

### 5.4 Create/Update CLAUDE.md

```bash
if [ ! -f CLAUDE.md ]; then
  cat > CLAUDE.md << 'EOF'
# CLAUDE.md

## Project Configuration for Claude Code

### Agents
See `.claude/agents/` for project-specific agents (symlinked from global).

### Cognitive Skills
This project uses the cognitive reasoning framework:
- **IR-v2**: Meta-orchestrator for automatic pattern selection
- **9 Patterns**: ToT, BoT, SRC, HE, AR, DR, AT, RTR, NDF

Load via Skill tool: `Use integrated-reasoning-v2 to analyze this problem`

### Directory Organization

- `.claude/decisions/` - Strategic decision logs
- `.claude/reasoning/` - Multi-pattern reasoning sessions
- `.claude/workspace/` - Temporary work area

### Commands

- `/init-workspace` - Initialize workspace (this was used to create this structure)

---

**Initialized**: [DATE]
**Version**: init-workspace v3.0
EOF
  echo "Created CLAUDE.md"
else
  echo "CLAUDE.md exists, not overwriting"
fi
```

---

## Phase 6: Validation

```bash
echo ""
echo "=== Validation Report ==="
echo ""

echo "Directory Structure:"
test -d .claude && echo "  .claude/" || echo "  MISSING .claude/"
test -d .claude/agents && echo "  .claude/agents/" || echo "  MISSING agents/"
test -d .claude/decisions && echo "  .claude/decisions/" || echo "  MISSING decisions/"
test -d .claude/reasoning && echo "  .claude/reasoning/" || echo "  MISSING reasoning/"
test -d .claude/workspace && echo "  .claude/workspace/" || echo "  MISSING workspace/"

echo ""
echo "Agents:"
ls -la .claude/agents/*.md 2>/dev/null | wc -l | xargs -I {} echo "  {} agents linked"

echo ""
echo "Validation complete"
```

---

## Phase 7: Summary

```markdown
# Workspace Initialization Complete

## Created
- `.claude/` directory structure
- Agent symlinks
- Decision log template
- Reasoning session structure

## Available Cognitive Skills
Load from ~/.claude/skills/ via Skill tool:
- integrated-reasoning-v2 (meta-orchestrator)
- tree-of-thoughts, breadth-of-thought, self-reflecting-chain
- hypothesis-elimination, adversarial-reasoning, dialectical-reasoning
- analogical-transfer, rapid-triage-reasoning, negotiated-decision-framework

## Next Steps
1. Restart Claude Code to load configuration
2. Test agents: "Use [agent-name] to help with [task]"
3. Test skills: "Use integrated-reasoning-v2 to analyze this problem"
```

---

## Configuration Modes

### Minimal
- Basic directory structure only
- No agent symlinks
- Time: <1 minute

### Standard (Default)
- Full directory structure
- 3-5 relevant agents
- Cognitive skills documented
- Time: ~3 minutes

### Comprehensive
- Everything in Standard
- All reference docs
- Custom project commands
- Full CLAUDE.md
- Time: ~5 minutes

---

**Version**: 3.0
**Last Updated**: 2026-01-19
**Cognitive Skills**: Integrated with reasoning framework v2.1
