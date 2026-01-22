# Claude Cognitive Reasoning Framework

A comprehensive cognitive architecture for AI agents, featuring 9 reasoning patterns, a meta-orchestrator, and production-ready agent implementations. This framework moves beyond "prompt engineering" into "cognitive architecture" — ensuring agents don't use a hammer for a screw.

**Author:** Kim Asplund
**License:** MIT
**Version:** 3.0

---

## Features

- **9 Core Reasoning Patterns** - Specialized methodologies for different problem types
- **IR-v2 Meta-Orchestrator** - Automatic pattern selection using 11-dimension scoring
- **17 Production Agents** - Ready-to-use agent implementations with ChromaDB memory
- **10 Skill Frameworks** - Domain-specific capabilities (security, git, documentation, etc.)
- **Parallel Execution** - Run multiple patterns simultaneously for 2-4x speedup
- **Handover Protocol** - State persistence across multi-pattern reasoning chains
- **Self-Improving Architecture** - Agents learn and improve via ChromaDB memory
- **Memory Consolidation** - "Sleep-like" periodic consolidation for cross-agent learning
- **Autonomous Orchestration** - Auto-invoke skills/agents based on task patterns with hooks

---

## Quick Start

### One-Line Installation

```bash
git clone https://github.com/kimasplund/claude_cognitive_reasoning.git && cd claude_cognitive_reasoning && ./scripts/install.sh
```

### Manual Installation

Clone the repository and copy files to your Claude Code configuration directory:

```bash
# Clone the repository
git clone https://github.com/kimasplund/claude_cognitive_reasoning.git
cd claude_cognitive_reasoning

# Or use the install script
./scripts/install.sh          # Full installation
./scripts/install.sh --skills # Skills only
./scripts/install.sh --agents # Agents only

# Manual: Install cognitive skills (personal - available in all projects)
cp -r cognitive-skills/* ~/.claude/skills/

# Install agents
cp agent-examples/*.md ~/.claude/agents/

# Install skill frameworks
cp -r skill-frameworks/* ~/.claude/skills/

# Install commands
mkdir -p ~/.claude/commands
cp commands/*.md ~/.claude/commands/

# Copy the CLAUDE.md quick reference (optional - for project-level)
cp CLAUDE.md ~/.claude/CLAUDE.md
```

### Verify Installation

```bash
# Check skills are installed
ls ~/.claude/skills/

# You should see directories like:
# integrated-reasoning-v2/
# tree-of-thoughts/
# adversarial-reasoning/
# ...

# Check agents are installed
ls ~/.claude/agents/

# You should see files like:
# ceo-orchestrator.md
# architect-agent.md
# security-agent.md
# ...
```

### Start Using

Skills activate automatically when Claude detects a matching problem type. You can also invoke them manually:

```bash
# In Claude Code CLI, skills are available as slash commands
/integrated-reasoning-v2    # Meta-orchestrator for complex problems
/tree-of-thoughts           # Systematic solution exploration
/adversarial-reasoning      # Security validation and stress-testing

# Agents are available via the Task tool
# Claude will automatically use appropriate agents based on context
```

---

## Directory Structure

```
claude_cognitive_reasoning/
├── CLAUDE.md                          # Quick reference guide
├── README.md                          # This file
│
├── cognitive-skills/                  # Core reasoning patterns
│   ├── INTEGRATION_GUIDE.md           # How to compose patterns
│   ├── integrated-reasoning-v2/       # Meta-orchestrator (IR-v2)
│   ├── tree-of-thoughts/              # ToT - Optimization
│   ├── breadth-of-thought/            # BoT - Exploration
│   ├── self-reflecting-chain/         # SRC - Sequential logic
│   ├── hypothesis-elimination/        # HE - Diagnosis
│   ├── adversarial-reasoning/         # AR - Security validation
│   ├── dialectical-reasoning/         # DR - Trade-offs
│   ├── analogical-transfer/           # AT - Novel problems
│   ├── rapid-triage-reasoning/        # RTR - Time-critical
│   ├── negotiated-decision-framework/ # NDF - Stakeholder alignment
│   ├── parallel-execution/            # Run patterns simultaneously
│   ├── reasoning-handover-protocol/   # Cross-pattern state transfer
│   └── ralph-loop-integration/        # Iterative refinement wrapper
│
├── agent-examples/                    # Production agent implementations
│   ├── ceo-orchestrator.md            # Strategic decision-making
│   ├── architect-agent.md             # System design (DR, ToT, AR)
│   ├── security-agent.md              # Threat modeling (AR, HE)
│   ├── root-cause-analyzer.md         # Debugging (HE, ChromaDB)
│   ├── break-it-tester.md             # Adversarial QA (AR)
│   ├── qa-agent.md                    # Test planning
│   ├── pm-planner.md                  # Project planning
│   ├── pm-executor.md                 # Execution tracking
│   ├── research-specialist.md         # Research synthesis
│   ├── agent-hr-manager.md            # Agent creation & management
│   ├── memory-consolidation-agent.md  # "Sleep-like" memory optimization
│   ├── code-finder.md                 # Code location & search
│   ├── codebase-documenter.md         # Documentation generation
│   ├── docs-git-committer.md          # Doc updates & git commits
│   ├── frontend-ui-developer.md       # UI/UX development
│   ├── implementor.md                 # Feature implementation
│   └── product-manager-agent.md       # Product strategy
│
├── skill-frameworks/                  # Domain-specific skills
│   ├── agent-creator/                 # Create new agents
│   ├── skill-creator/                 # Create new skills
│   ├── agent-memory-skills/           # ChromaDB persistent memory
│   ├── chromadb-integration-skills/   # Vector database patterns
│   ├── security-analysis-skills/      # STRIDE, OWASP, CVSS
│   ├── error-handling-skills/         # Cross-language error patterns
│   ├── document-writing-skills/       # Documentation templates
│   ├── git-workflow-skills/           # Git best practices
│   └── confidence-check-skills/       # Pre-implementation validation
│
├── commands/                          # Claude Code commands
│   └── init-workspace.md              # Initialize project workspace (v3.0)
│
├── autonomous-infrastructure/         # Self-improving orchestration system
│   ├── README.md                      # Architecture & installation guide
│   ├── skill-triggers.yaml            # Pattern → skill/agent mappings
│   ├── skill-recommender.sh           # PreToolUse hook for suggestions
│   ├── skill-outcome-logger.sh        # PostToolUse hook for logging
│   └── sync-outcomes-to-chroma.py     # JSONL → ChromaDB sync
│
├── research/                          # Research papers & analysis
│   ├── llm_reasoning_psychology_research_2025-01.md
│   ├── meta-cognitive-architectures-research-2026-01.md
│   ├── memory_consolidation_analysis_2026-01.md
│   └── memory_consolidation_ai_agents_research_2026-01.md
│
└── .reasoning/                        # Test results & validation
    ├── pattern-tests/                 # Individual pattern tests
    ├── parallel-tests/                # Parallel execution tests
    ├── handover-tests/                # Handover protocol tests
    └── e2e-chain-test/                # End-to-end integration
```

---

## The 9 Cognitive Patterns

| Pattern | Acronym | Purpose | Best For |
|---------|---------|---------|----------|
| **Tree of Thoughts** | ToT | Find optimal solution via branching exploration | Optimization, best-path decisions |
| **Breadth of Thought** | BoT | Exhaustively explore all viable options | Unknown solution space, need multiple options |
| **Self-Reflecting Chain** | SRC | Sequential reasoning with backtracking | Step-by-step logic, debugging |
| **Hypothesis-Elimination** | HE | Diagnose via evidence-based elimination | Root cause analysis, debugging |
| **Adversarial Reasoning** | AR | Stress-test via STRIKE framework attacks | Security validation, robustness |
| **Dialectical Reasoning** | DR | Resolve tensions via thesis-antithesis-synthesis | Trade-offs, competing requirements |
| **Analogical Transfer** | AT | Solve novel problems via cross-domain parallels | New domains, creative solutions |
| **Rapid Triage Reasoning** | RTR | Fast decisions under time pressure | Incidents, emergencies |
| **Negotiated Decision Framework** | NDF | Multi-stakeholder consensus building | Team decisions, competing interests |

### IR-v2: The Meta-Orchestrator

IR-v2 automatically selects the optimal pattern(s) using 11-dimension scoring:

1. SolutionType (optimization vs exploration vs diagnosis)
2. Uncertainty level
3. Time pressure
4. Stakeholder count
5. Novelty (familiar vs unprecedented)
6. Reversibility of decisions
7. Evidence availability
8. Constraint tightness
9. Decomposability
10. Risk tolerance
11. Sequential dependencies

**Fast-paths:** Time pressure ≥5 → RTR | Stakeholders ≥4 → NDF | Security context → AR

---

## Agents Overview

| Agent | Primary Pattern | Use Case |
|-------|-----------------|----------|
| **ceo-orchestrator** | IR-v2 | Strategic decisions, resource allocation |
| **architect-agent** | DR, ToT, AR | System design, architecture decisions |
| **security-agent** | AR, HE | Threat modeling, vulnerability assessment |
| **root-cause-analyzer** | HE | Debugging, incident investigation |
| **break-it-tester** | AR | Adversarial testing, finding bugs |
| **research-specialist** | BoT, AT | Research synthesis, exploration |
| **pm-planner** | ToT, NDF | Project planning, requirements |
| **pm-executor** | RTR | Task tracking, execution |
| **memory-consolidation-agent** | - | Cross-agent learning, memory optimization |
| **code-finder** | - | Code location, pattern search |
| **codebase-documenter** | - | Documentation generation |
| **docs-git-committer** | - | Doc updates, git commits |
| **frontend-ui-developer** | - | UI/UX component development |
| **implementor** | - | Feature implementation |
| **product-manager-agent** | - | Product strategy, roadmaps |
| **agent-hr-manager** | - | Agent creation & management |
| **qa-agent** | - | Test planning |

---

## Usage Examples

### Automatic Pattern Selection

```
User: "My API is returning 500 errors intermittently but only in production"

Claude: [Uses IR-v2 to score problem → selects Hypothesis-Elimination]
        [Generates hypotheses, tests systematically, identifies root cause]
```

### Manual Skill Invocation

```
User: "/adversarial-reasoning Review this authentication implementation"

Claude: [Applies STRIKE framework: Spoofing, Tampering, Repudiation,
         Information Disclosure, DoS, Elevation of Privilege]
```

### Multi-Pattern Reasoning

```
User: "Design a new caching architecture for our microservices"

Claude: [IR-v2 detects trade-offs → uses Dialectical Reasoning]
        [Then validates with Adversarial Reasoning for failure modes]
        [Handover protocol preserves context between patterns]
```

---

## Configuration

### Project-Level CLAUDE.md

Add to your project's root or `.claude/` directory:

```markdown
# CLAUDE.md

## Cognitive Skills Available
See ~/.claude/skills/ for full list. Key patterns:
- **IR-v2** = Auto-select optimal reasoning pattern
- **AR** = Security validation via STRIKE
- **HE** = Root cause diagnosis

## Testing Philosophy
- TEST, TEST, TEST - No code is done until tested
- Use break-it-tester agent for adversarial QA
```

### Skill Customization

Each skill's `SKILL.md` contains YAML frontmatter you can modify:

```yaml
---
name: tree-of-thoughts
description: Find best solution through systematic branching exploration
allowed-tools: Read, Grep, Glob, WebSearch
---
```

---

## Requirements

**Core:**
- **Claude Code CLI** (latest version)
- **Claude API access** (Opus or Sonnet models recommended)
- **~50MB disk space** for full installation

**For autonomous-infrastructure (optional):**
- **jq** - JSON processor (`apt install jq` or `brew install jq`)
- **Python 3.8+** - For sync scripts
- **chromadb** - Python package (`pip install chromadb`)

---

## Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Add tests in `.reasoning/` for new patterns
4. Submit a pull request

---

## Research & References

This framework incorporates concepts from:

- Tree of Thoughts (Yao et al., 2023)
- Chain-of-Thought Prompting (Wei et al., 2022)
- Self-Consistency (Wang et al., 2023)
- ReAct: Reasoning and Acting (Yao et al., 2022)
- Memory Consolidation in Cognitive Architectures (2024-2026)

See the `research/` directory for detailed research notes:
- `llm_reasoning_psychology_research_2025-01.md` - LLM reasoning psychology foundations
- `meta-cognitive-architectures-research-2026-01.md` - Meta-cognitive architecture patterns
- `memory_consolidation_analysis_2026-01.md` - Human memory consolidation mechanisms
- `memory_consolidation_ai_agents_research_2026-01.md` - AI agent memory consolidation SOTA

---

## License

MIT License - See individual skill files for details.

---

## Author

**Kim Asplund**
Vaasa, Finland
[GitHub](https://github.com/kimasplund)

*"Cognitive architecture, not just prompt engineering — ensuring agents don't use a hammer for a screw."*
