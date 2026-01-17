# Cognitive Skills Integration Guide

**Version**: 1.0
**Updated**: 2026-01-18
**Purpose**: Guide for integrating cognitive reasoning patterns into AI agents

## Overview

This guide shows how to integrate the 9 cognitive reasoning methodologies into agent definitions. Each methodology provides structured thinking patterns that improve decision quality and provide auditable reasoning trails.

## Quick Reference: Which Pattern for Which Agent Type

| Agent Type | Primary Pattern | Secondary Patterns |
|------------|-----------------|-------------------|
| **Debugging/Diagnosis** | HE (Hypothesis-Elimination) | SRC, AR |
| **Strategic Decision** | IR-v2 meta-selection | ToT, DR, NDF |
| **Architecture Design** | ToT (Tree of Thoughts) | BoT, AR, DR |
| **Research/Exploration** | BoT (Breadth of Thought) | AT, SRC |
| **Security Analysis** | AR (Adversarial Reasoning) | HE, ToT |
| **Incident Response** | RTR (Rapid Triage) | HE (follow-up) |
| **Stakeholder Alignment** | NDF (Negotiated Decision) | DR, ToT |
| **Novel Problem Solving** | AT (Analogical Transfer) | BoT, ToT |
| **Trade-off Resolution** | DR (Dialectical Reasoning) | NDF, ToT |

---

## Integration Pattern 1: Primary Methodology

For agents with a clear primary reasoning need, declare the cognitive skill as the primary pattern:

```markdown
**Agent**: Root Cause Analyzer
**Skills Integration**: hypothesis-elimination, agent-memory-skills
**Primary Reasoning Pattern**: Hypothesis-Elimination (HE) with HEDAM methodology
```

Then structure the agent's phases around the methodology:

```markdown
### Phase 1: Initial Investigation
[Standard agent investigation steps]

### Phase 2: Hypothesis Generation (HEDAM Step H)
Generate 8-15 hypotheses across all categories...

### Phase 3: Evidence Hierarchy Design (HEDAM Step E)
Prioritize evidence by discrimination power...

### Phase 3.5: Systematic Elimination (HEDAM Step D)
Update ALL hypotheses per evidence found...

### Phase 4: Confirmation Testing (HEDAM Step A)
Test leading hypothesis with specific predictions...

### Phase 5: Documentation (HEDAM Step M)
Document findings for future reference...
```

---

## Integration Pattern 2: Meta-Orchestration

For agents handling diverse problems, integrate IR-v2 as the pattern selector:

```markdown
**Agent**: CEO Orchestrator
**Skills Integration**: integrated-reasoning-v2, agent-memory-skills
**Available Reasoning Patterns**: 9 (ToT, BoT, SRC, HE, AR, DR, AT, RTR, NDF)
```

Then include pattern selection logic:

```markdown
### Pattern Selection (Using IR-v2)

For complex decisions, score the 11 dimensions:
1. Sequential Dependencies (1-5)
2. Criteria Clarity (1-5)
3. Solution Space Known (1-5)
4. Single Answer Needed (1-5)
5. Evidence Available (1-5)
6. Opposing Valid Views (1-5)
7. Problem Novelty (1-5)
8. Robustness Required (1-5)
9. Solution Exists (1-5)
10. Time Pressure (1-5)
11. Stakeholder Complexity (1-5)

**Fast-paths**:
- TimePressure = 5 → Use RTR automatically
- StakeholderComplexity ≥ 3 → Consider NDF
- SolutionExists < 3 → AR not applicable

**Calculate affinity scores**, select highest-scoring pattern.
```

---

## Integration Pattern 3: Chained Patterns

For complex workflows, chain patterns in sequence:

```markdown
### Phase 1: Explore Options (BoT)
Use Breadth of Thought to map solution space...
- Generate 8-10 fundamentally different approaches
- Prune conservatively (keep >40% confidence)
- Output: Top 5 viable options

### Phase 2: Optimize Selection (ToT)
Use Tree of Thoughts on top 3 options...
- Deep exploration (4-6 levels)
- Score against criteria
- Output: Single best option

### Phase 3: Validate Before Commit (AR)
Use Adversarial Reasoning on selected option...
- STRIKE framework threat modeling
- Attack from 10 angles
- Output: Validated solution or redesign needed
```

---

## Pattern-Specific Integration Examples

### Hypothesis-Elimination (HE) Integration

Best for: root-cause-analyzer, debugger, diagnostic agents

```markdown
## Your Investigation Methodology (HEDAM Process)

### H - Hypothesis Generation
- Generate 8-15 hypotheses (fewer suggests incomplete thinking)
- Categories: Recent changes, Dependencies, Resources, Data, Timing, Security, Human error, Unknown
- For each: Document mechanism, prior probability, discriminating evidence

### E - Evidence Hierarchy
- List all evidence sources
- Score: Discrimination Power (how many hypotheses affected?) / Cost (how hard to get?)
- Gather in priority order (highest score first)

### D - Discrimination/Elimination
- For EACH evidence: Update ALL hypotheses
- Status: ELIMINATED / WEAKENED / UNCHANGED / STRENGTHENED
- Continue until 1-2 remain

### A - Assertion/Confirmation
- Test remaining hypothesis with specific predictions
- If prediction fails: Reopen eliminated hypotheses

### M - Memorialize
- Document root cause, elimination path, prevention steps
```

### Adversarial Reasoning (AR) Integration

Best for: security-agent, pre-deployment validator, qa-agent

```markdown
## Validation Methodology (STRIKE Framework)

### S - Specify Target
- What are we attacking?
- What counts as "breaking" it?
- Assumed adversary skill level?

### T - Threat Modeling (STRIDE+)
- Spoofing, Tampering, Repudiation, Information Disclosure
- Denial of Service, Elevation of Privilege
- Supply Chain, Social Engineering

### R - Risk-Ranked Attack Generation
- Score: Impact (1-5) × Feasibility (1-5)
- Critical (20-25): Must fix before shipping
- High (15-19): Address in current cycle

### I - Investigate Attack Paths
- Develop top 5 attack scenarios in detail
- Attacker profile, sequence, detection opportunities

### K - Kill Chain Disruption
- Prevention controls at each attack stage
- Detection and response procedures

### E - Edge Cases
- Non-malicious but problematic scenarios
- Boundary conditions, timing, scale, state
```

### Dialectical Reasoning (DR) Integration

Best for: architect-agent, strategy-agent, decision-facilitator

```markdown
## Trade-off Resolution (Hegelian Spiral)

### Phase 1: Thesis Articulation
- Steel-man Position A (strongest possible version)
- Identify its genuine insights and ideal conditions

### Phase 2: Antithesis Articulation
- Steel-man Position B (independently, not just negation)
- Identify its genuine insights and ideal conditions

### Phase 3: Tension Analysis
- Map the core conflict
- Why simple compromise fails
- What's the deeper question?

### Phase 4: Synthesis Generation
- Contextual (A for context X, B for context Y)
- Temporal (A for stage 1, B for stage 2)
- Structural (A for layer 1, B for layer 2)
- Transcendence (new option that dissolves tension)

### Phase 5: Recursive Check
- Does synthesis have its own antithesis?
- Max 3 levels of recursion
```

### Negotiated Decision Framework (NDF) Integration

Best for: product-manager-agent, stakeholder-coordinator, project-lead

```markdown
## Stakeholder Alignment (ALIGN Framework)

### A - Analyze Stakeholder Landscape
- Map: Power vs Interest grid
- For each: Stated position, underlying interest, success criteria
- Identify relationships and alliances

### L - Locate Zones of Agreement
- Shared goals (even if approaches differ)
- Overlapping interests
- Agreed constraints

### I - Identify Irreducible Conflicts
- Type: False / Resource / Value / Interest / Relational
- Which conflicts are actually solvable?

### G - Generate Integrative Options
- Expand the pie
- Trade across issues
- Add new elements to enable trades
- Reframe at higher level

### N - Negotiate Commitment
- Know each party's BATNA
- Seek: Comply < Accept < Endorse < Champion
- Document conditions and contingencies
```

---

## Agent Definition Checklist

When creating or updating an agent, verify:

- [ ] **Skills Integration** header lists relevant cognitive skills
- [ ] **Primary Reasoning Pattern** identified if agent has clear focus
- [ ] Phase structure aligns with methodology steps
- [ ] Methodology-specific templates included
- [ ] Fast-paths documented (e.g., TimePressure=5 → RTR)
- [ ] Output templates match methodology outputs
- [ ] Limitations acknowledged

---

## Version Compatibility

| Skill | Current Version | Key Change from Previous |
|-------|-----------------|-------------------------|
| integrated-reasoning-v2 | 2.1 | 9 patterns, 11 dimensions, uncertainty propagation |
| hypothesis-elimination | 2.0 | HEDAM process, evidence hierarchy |
| adversarial-reasoning | 2.0 | STRIKE framework, STRIDE+ |
| dialectical-reasoning | 2.0 | Hegelian spiral, synthesis types |
| analogical-transfer | 2.0 | BRIDGE framework |
| rapid-triage-reasoning | 1.0 | RAPID framework (new) |
| negotiated-decision-framework | 1.0 | ALIGN framework (new) |
| tree-of-thoughts | 1.0 | 5 branches, 4 levels |
| breadth-of-thought | 1.0 | 8-10 approaches, 40% threshold |
| self-reflecting-chain | 1.0 | 60% backtrack threshold |

---

## Example: Full Agent Integration

```markdown
---
name: security-validator-agent
description: Validates solutions before deployment using adversarial analysis
tools: Read, Grep, Glob, Bash, WebSearch
---

**Agent**: Security Validator
**Version**: 1.0
**Skills Integration**: adversarial-reasoning, hypothesis-elimination
**Primary Reasoning Pattern**: Adversarial Reasoning (AR) with STRIKE framework
**Secondary Pattern**: HE for vulnerability root cause if breach detected

You are a security validation specialist. Before any solution ships, you attack it.

## Methodology

### Phase 1: Target Specification (STRIKE-S)
[Define what you're attacking and success criteria]

### Phase 2: Threat Modeling (STRIKE-T)
[STRIDE+ analysis across all categories]

### Phase 3: Attack Generation (STRIKE-R)
[Generate and prioritize attacks by Impact × Feasibility]

### Phase 4: Attack Path Development (STRIKE-I)
[Detailed scenarios for Critical/High risks]

### Phase 5: Countermeasure Design (STRIKE-K)
[Prevention, detection, response for each attack]

### Phase 6: Edge Case Enumeration (STRIKE-E)
[Non-malicious failure modes]

## If Vulnerability Found → Switch to HE
When a real vulnerability is discovered during validation:
1. Switch to Hypothesis-Elimination methodology
2. Generate 8-15 hypotheses for how it was introduced
3. Follow HEDAM to find root cause
4. Document for prevention

## Output Template
[AR output template from adversarial-reasoning skill]
```
