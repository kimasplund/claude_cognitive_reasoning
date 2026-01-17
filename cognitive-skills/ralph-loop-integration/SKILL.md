---
name: ralph-loop-integration
description: Persistent iteration wrapper for cognitive reasoning patterns using ralph-loop's Stop hook mechanism. Use when high confidence (>90%) is required, complex multi-pattern orchestration needs iterative refinement, self-correcting analysis is needed, or long-running tasks require checkpointed persistence. Wraps IR-v2 patterns in completion promise-gated loops.
license: MIT
version: 1.0
---

# Ralph-Loop Integration for Cognitive Reasoning

**Purpose**: Integrate ralph-loop's persistent iteration mechanism with cognitive reasoning patterns. Ralph provides session persistence through Stop hooks and completion promises, enabling iterative refinement of reasoning until confidence thresholds are genuinely met.

## Core Concept: Ralph-Loop Mechanics

### What Ralph Does

Ralph is a Claude Code plugin that provides:

1. **Stop Hook Blocking**: Intercepts session exit and re-feeds the prompt
2. **Completion Promise Gating**: Exit only when `<promise>` tag evaluates to genuinely true
3. **State Persistence**: Maintains iteration context in `.claude/ralph-loop.local.md`
4. **Anti-Gaming Protection**: Promise must be genuinely satisfied, not just claimed

```
┌─────────────────────────────────────────────────────────┐
│                    Ralph-Loop Wrapper                    │
│                                                         │
│  ┌─────────────┐     ┌─────────────┐     ┌──────────┐  │
│  │ Iteration 1 │ ──→ │ Iteration 2 │ ──→ │   ...    │  │
│  │ (Pattern A) │     │ (Pattern B) │     │          │  │
│  └─────────────┘     └─────────────┘     └──────────┘  │
│         │                   │                  │        │
│         └───────────────────┴──────────────────┘        │
│                           │                             │
│                           ▼                             │
│                   ┌───────────────┐                     │
│                   │ Stop Hook     │                     │
│                   │ Evaluation    │                     │
│                   └───────┬───────┘                     │
│                           │                             │
│              ┌────────────┼────────────┐                │
│              │            │            │                │
│              ▼            │            ▼                │
│    ┌─────────────┐        │   ┌─────────────┐          │
│    │  Promise    │        │   │  Promise    │          │
│    │  NOT MET    │        │   │    MET      │          │
│    │  → Re-loop  │        │   │  → Exit     │          │
│    └─────────────┘        │   └─────────────┘          │
│                           │                             │
└───────────────────────────┼─────────────────────────────┘
                            │
                            ▼
                    .claude/ralph-loop.local.md
                    (State persistence)
```

### Ralph State File Structure

```markdown
# .claude/ralph-loop.local.md

## Session: auth-system-design-20260118
## Completion Promise: Recommendation ready at >90% confidence

### Iteration History

#### Iteration 1 (BoT)
- **Pattern**: Breadth of Thought
- **Duration**: 18 minutes
- **Confidence Achieved**: 78%
- **Key Findings**: 8 approaches explored, 5 retained above 40%
- **Next Pattern Recommendation**: ToT to optimize top 3
- **Promise Status**: NOT MET (78% < 90%)

#### Iteration 2 (ToT)
- **Pattern**: Tree of Thoughts
- **Duration**: 22 minutes
- **Confidence Achieved**: 85%
- **Key Findings**: JWT with JWKS rotation emerged as optimal
- **Next Pattern Recommendation**: AR to validate before claiming >90%
- **Promise Status**: NOT MET (85% < 90%)

#### Iteration 3 (AR)
- **Pattern**: Adversarial Reasoning
- **Duration**: 15 minutes
- **Confidence Achieved**: 92%
- **Key Findings**: 2 critical attacks mitigated, residual risk acceptable
- **Promise Status**: MET (92% > 90%)

### Current State
- **Active Iteration**: 3 (complete)
- **Total Duration**: 55 minutes
- **Final Confidence**: 92%
- **Exit Approved**: YES
```

---

## When to Use Ralph-Loop Integration

**Use ralph-loop when:**
- High confidence threshold required (>90%)
- Complex multi-pattern orchestration needed
- Self-correcting iteration is valuable
- Long-running analysis benefits from checkpointed persistence
- Problem may require multiple reasoning pattern switches
- You cannot afford premature conclusion

**Do not use ralph-loop when:**
- Single-pattern analysis is sufficient
- Time pressure requires rapid decision (use RTR instead)
- Problem is well-understood with clear solution
- Iteration overhead exceeds benefit
- Confidence threshold is low (<80%)

**Decision Matrix:**

| Scenario | Use Ralph? | Rationale |
|----------|------------|-----------|
| Security architecture requiring >90% validation | Yes | High stakes, needs iterative AR passes |
| Quick debugging with known patterns | No | Overhead exceeds benefit |
| Novel problem with unknown solution space | Yes | May need multiple BoT iterations |
| Production incident requiring immediate action | No | Use RTR, ralph adds latency |
| Complex trade-off requiring stakeholder buy-in | Yes | DR + NDF may need multiple iterations |

---

## Integration with IR-v2 Orchestration

### Ralph-Wrapped IR-v2 Session

```markdown
## Ralph-Loop Session: [Problem Name]

### Completion Promise
<promise>Recommendation ready at >90% confidence with all critical attacks mitigated</promise>

### IR-v2 Dimension Scores
| Dimension | Score |
|-----------|-------|
| Sequential Dependencies | 2 |
| Criteria Clarity | 4 |
| Solution Space Known | 2 |
| Single Answer Needed | 4 |
| Evidence Available | 3 |
| Opposing Valid Views | 3 |
| Problem Novelty | 4 |
| Robustness Required | 5 |
| Solution Exists | 1 |
| Time Pressure | 2 |
| Stakeholder Complexity | 3 |

### Initial Pattern Selection
**Primary**: BoT (4.35) - Unknown solution space needs exploration
**Secondary**: ToT (3.80) - Will optimize once space mapped
**Validation**: AR (3.90) - Required for >90% confidence claim

### Orchestration Plan
```
Ralph Loop Wrapper
├─ Iteration 1: BoT exploration → Target: Map solution space
├─ Iteration 2: ToT optimization → Target: Select optimal solution
├─ Iteration 3: AR validation → Target: >90% confidence
└─ Exit: <promise>Recommendation ready at >90% confidence</promise>
```

---

## Ralph + Pattern Integration Examples

### Example 1: BoT → ToT → AR Chain

```markdown
## Problem: Design distributed caching strategy
## Promise: Architecture validated with >90% confidence

### Iteration 1: BoT Exploration
**Objective**: Map all viable caching approaches
**Entry Criteria**: Unknown solution space
**Exit Criteria**: 5+ viable approaches identified

**Execution**:
1. Generate 8-10 distinct caching approaches
2. Explore each with strengths/weaknesses analysis
3. Conservative pruning (keep >40%)
4. Rank by viability

**Results**:
- Approaches explored: 8
- Retained: 6 (above 40% confidence)
- Top 3: Write-through (72%), Eventual (68%), CRDT (65%)
- Confidence: 78%

**Promise Check**: NOT MET (78% < 90%)
**Next Iteration**: ToT to optimize top 3 approaches

---

### Iteration 2: ToT Optimization
**Objective**: Find optimal solution from BoT findings
**Entry Criteria**: 6 viable approaches from BoT
**Exit Criteria**: Single best solution with clear rationale

**Execution**:
1. Deep evaluation of top 3 approaches
2. 4-level tree exploration
3. Score against criteria: latency, consistency, cost, scalability
4. Select winning path

**Results**:
- Winning path: Eventual → CRDTs → OR-Set → Tombstone-compaction
- Final score: 91/100
- Confidence: 85%

**Promise Check**: NOT MET (85% < 90%)
**Next Iteration**: AR to validate before claiming >90%

---

### Iteration 3: AR Validation
**Objective**: Stress-test CRDT solution
**Entry Criteria**: CRDT solution from ToT
**Exit Criteria**: All critical attacks mitigated OR solution rejected

**Execution**:
1. STRIKE framework threat modeling
2. Attack generation: Consistency attacks, partition handling, merge conflicts
3. Edge case enumeration: Clock drift, tombstone overflow, convergence delay
4. Countermeasure design

**Results**:
- Critical attacks found: 2 (clock drift exploitation, merge storm)
- Mitigations designed: 2 (vector clocks, merge throttling)
- Residual risk: 8% (acceptable)
- Confidence: 92%

**Promise Check**: MET (92% > 90%)
**Exit Approved**: YES

---

### Final Synthesis
**Solution**: CRDT-based eventual consistency with OR-Set and tombstone compaction
**Confidence**: 92%
**Iterations**: 3 (BoT → ToT → AR)
**Total Duration**: 55 minutes
**Mitigations Required**: Vector clocks, merge throttling
```

### Example 2: HE → SRC → AR Chain (Root Cause Analysis)

```markdown
## Problem: Intermittent 500 errors in production
## Promise: Root cause identified with >85% confidence and reproduction steps

### Iteration 1: HE Investigation
**Objective**: Identify root cause from symptom
**Entry Criteria**: Symptom observed (500 errors)
**Exit Criteria**: Root cause hypothesis with >70% confidence

**Execution**:
1. Generate 12 hypotheses (HEDAM-H)
2. Design evidence hierarchy (HEDAM-E)
3. Systematic elimination (HEDAM-D)
4. Assertion testing (HEDAM-A)

**Results**:
- Started with: 12 hypotheses
- Eliminated: 11
- Remaining: H7 (External API timeout)
- Confidence: 75%

**Promise Check**: NOT MET (need reproduction steps)
**Next Iteration**: SRC to trace exact failure path

---

### Iteration 2: SRC Trace
**Objective**: Trace failure mechanism step by step
**Entry Criteria**: H7 (External API timeout) at 75%
**Exit Criteria**: Complete failure path with reproduction steps

**Execution**:
1. Start at symptom (500 response)
2. Trace back through code path
3. Self-reflect at each step
4. Backtrack if confidence drops below 60%

**Results**:
- Chain traced: Request → Gateway → PaymentService → ExternalAPI → Timeout → 500
- Backtracked once: Initially missed async retry logic
- Reproduction: PaymentService.processPayment() with >5s external latency
- Confidence: 82%

**Promise Check**: NOT MET (82% < 85%)
**Next Iteration**: AR to validate reproduction

---

### Iteration 3: AR Validation
**Objective**: Confirm reproduction and validate fix
**Entry Criteria**: Reproduction steps from SRC
**Exit Criteria**: Reproduction confirmed OR rejection

**Execution**:
1. Execute reproduction test
2. Verify 500 error occurs
3. Apply proposed fix (timeout reduction)
4. Verify fix works

**Results**:
- Reproduction: CONFIRMED (500 error with 6s mock latency)
- Fix applied: Timeout 30s → 5s
- Fix validation: 500 errors eliminated
- Confidence: 88%

**Promise Check**: MET (88% > 85% with reproduction confirmed)
**Exit Approved**: YES

---

### Final Synthesis
**Root Cause**: ExternalPaymentAPI latency spike causing request queue backup
**Confidence**: 88%
**Reproduction**: `curl -X POST /payment --mock-latency 6s` → 500 error
**Fix**: Reduce timeout from 30s to 5s, add circuit breaker
**Iterations**: 3 (HE → SRC → AR)
```

---

## 15-Minute Checkpoint Integration

Ralph naturally integrates with IR-v2's 15-minute checkpoint protocol:

```markdown
## Checkpoint Protocol within Ralph Loop

### At Each 15-Minute Mark:
1. **Progress Check**
   - Has confidence increased since last checkpoint?
   - Am I making meaningful progress toward promise?

2. **Pattern Fit Check**
   - Am I fighting the current methodology?
   - Should I switch patterns for next iteration?

3. **State Persistence**
   - Update .claude/ralph-loop.local.md
   - Record confidence, findings, next steps

4. **Promise Re-evaluation**
   - Is the promise still appropriate?
   - Should threshold be adjusted? (requires user approval)

### Checkpoint Decision Matrix

| Confidence Trend | Pattern Fit | Action |
|------------------|-------------|--------|
| Increasing | Good | Continue current pattern |
| Flat | Good | Continue, but set switch trigger |
| Decreasing | Good | Investigate, may need more evidence |
| Increasing | Poor | Switch pattern next iteration |
| Flat | Poor | Switch pattern immediately |
| Decreasing | Poor | Switch pattern, reassess promise |
```

### Checkpoint Template

```markdown
## Checkpoint: [Timestamp]
**Iteration**: [N]
**Elapsed**: [X] minutes
**Pattern**: [Current pattern]

### Progress Assessment
- **Confidence Change**: [Start]% → [Current]%
- **Trend**: [Increasing/Flat/Decreasing]
- **Meaningful Progress**: [Yes/No]

### Pattern Fit Assessment
- **Fighting Methodology**: [Yes/No]
- **New Characteristics Discovered**: [List]
- **Pattern Still Optimal**: [Yes/No]

### State Update
- **Key Findings This Interval**: [Summary]
- **Evidence Gathered**: [List]
- **Branches Explored**: [Count]

### Decision
- **Action**: [Continue/Switch/Pause]
- **Next Pattern**: [If switching]
- **Rationale**: [Why]

### Promise Status
- **Current Confidence**: [X]%
- **Threshold**: [Y]%
- **Gap**: [Z]%
- **Estimated Iterations Remaining**: [N]
```

---

## Completion Promise Templates

### Standard Templates

```markdown
## High-Confidence Recommendation
<promise>INTEGRATED REASONING COMPLETE: Recommendation ready at >90% confidence</promise>

## Root Cause Analysis
<promise>ROOT CAUSE IDENTIFIED: Confidence >85% with reproduction steps verified</promise>

## Security Validation
<promise>ARCHITECTURE VALIDATED: All critical attacks mitigated with <15% residual risk</promise>

## Trade-off Resolution
<promise>SYNTHESIS COMPLETE: Trade-offs resolved with stakeholder-acceptable solution</promise>

## Exploration Complete
<promise>SOLUTION SPACE MAPPED: 5+ viable options with clear trade-off analysis</promise>

## Implementation Ready
<promise>IMPLEMENTATION PLAN COMPLETE: Step-by-step instructions with rollback procedures</promise>
```

### Compound Promises

For complex problems requiring multiple criteria:

```markdown
## Multi-Criteria Promise
<promise>
ANALYSIS COMPLETE when ALL of:
- Solution confidence >90%
- Security validation passed (AR)
- Performance validated (<100ms p99)
- Cost within budget (+/-10%)
</promise>
```

### Adaptive Promises

For problems where threshold may need adjustment:

```markdown
## Adaptive Promise
<promise>
BEST EFFORT COMPLETE when ANY of:
- Confidence >90% (full success)
- Confidence >80% after 3 iterations (acceptable)
- Time budget exhausted with clear next steps documented
</promise>
```

---

## Anti-Gaming Protections

Ralph's completion promise is designed to prevent premature exit. The system enforces:

### 1. Genuine Confidence Validation

```markdown
## Confidence Validation Rules

- Confidence MUST be supported by evidence chain
- Self-declared confidence requires justification
- AR validation required for >90% claims
- Declining confidence across iterations flags concern

### Invalid Confidence Claims (Auto-Rejected):
- "90% confident" without AR validation pass
- Confidence increased without new evidence
- Confidence exceeds evidence strength
```

### 2. Promise Integrity Checks

```markdown
## Promise Integrity

Before exit, verify:
- [ ] All promise criteria genuinely met (not just claimed)
- [ ] Evidence trail supports confidence level
- [ ] No unaddressed critical risks
- [ ] Synthesis reflects actual findings (not wishful thinking)

### Red Flags That Block Exit:
- Confidence claim contradicts evidence
- Critical attack identified but not mitigated
- Backtrack occurred without re-validation
- Time pressure causing premature conclusion
```

### 3. Iteration Minimum

```markdown
## Minimum Iteration Rules

For >90% confidence claims:
- Minimum 2 iterations required
- At least one must be validation pattern (AR, HE confirmation)
- Cannot claim >90% on first pass

For >85% confidence claims:
- Minimum 1 full iteration required
- Evidence must support claim

Exception: RTR (Rapid Triage) explicitly bypasses for emergency decisions
```

---

## State Recovery and Session Resume

Ralph's state file enables session recovery:

```markdown
## Session Recovery Protocol

### If Session Interrupted:
1. Load .claude/ralph-loop.local.md
2. Identify last complete iteration
3. Resume from checkpoint state
4. Continue toward promise

### Recovery Template:
```markdown
## Session Resume: [Session ID]

### Recovery Context
- **Original Problem**: [Problem statement]
- **Promise**: [Completion promise]
- **Last Complete Iteration**: [N]
- **Confidence at Interrupt**: [X]%
- **Pattern at Interrupt**: [Pattern name]

### Resumption Plan
1. Load iteration [N] state from ralph-loop.local.md
2. Verify findings still valid
3. Continue with [Next pattern]
4. Target: [Promise]
```

---

## Configuration

### Ralph-Loop Settings

```json
{
  "ralph_loop": {
    "enabled": true,
    "state_file": ".claude/ralph-loop.local.md",

    "promise_validation": {
      "require_evidence_chain": true,
      "require_ar_for_90_plus": true,
      "min_iterations_for_high_confidence": 2
    },

    "checkpoint_integration": {
      "interval_minutes": 15,
      "auto_checkpoint": true,
      "persist_on_pattern_switch": true
    },

    "exit_controls": {
      "block_premature_exit": true,
      "require_promise_met": true,
      "allow_adaptive_threshold": true
    },

    "anti_gaming": {
      "confidence_justification_required": true,
      "flag_declining_confidence": true,
      "block_unsupported_claims": true
    }
  }
}
```

---

## Quick Reference

### When to Wrap in Ralph Loop

```
"I need >90% confidence before recommending"
  → Wrap in ralph-loop with AR validation iteration

"This is a complex problem that may need pattern switching"
  → Ralph-loop with IR-v2 orchestration

"I can't afford to miss anything in this analysis"
  → Ralph-loop with BoT + AR iterations

"Root cause must be confirmed before fix deployment"
  → Ralph-loop with HE + SRC + AR chain

"Trade-offs involve multiple stakeholders"
  → Ralph-loop with DR + NDF iterations
```

### Ralph Loop vs Direct Execution

| Scenario | Ralph Loop | Direct |
|----------|------------|--------|
| High-stakes, need validation | Yes | |
| Quick answer sufficient | | Yes |
| May need pattern switching | Yes | |
| Single pattern fits well | | Yes |
| Long-running analysis | Yes | |
| Time-boxed decision | | Yes |
| Self-correction valuable | Yes | |
| First attempt likely correct | | Yes |

### Iteration Planning Guide

```
For >90% confidence:
  Iteration 1: Exploration (BoT) or Optimization (ToT)
  Iteration 2: Refinement (ToT) or Validation (AR)
  Iteration 3: Final Validation (AR)
  Typical: 3 iterations, 45-60 minutes

For >85% confidence:
  Iteration 1: Primary pattern
  Iteration 2: Validation (AR or HE confirmation)
  Typical: 2 iterations, 30-45 minutes

For exploration complete:
  Iteration 1: BoT exploration
  Iteration 2: BoT refinement (if needed)
  Typical: 1-2 iterations, 20-40 minutes
```

---

## Summary

Ralph-Loop Integration provides:

1. **Persistent Iteration**: Stop hook blocks premature exit until promise met
2. **State Persistence**: .claude/ralph-loop.local.md maintains iteration context
3. **Completion Promises**: Clear exit criteria prevent gaming
4. **IR-v2 Integration**: Seamless pattern switching across iterations
5. **Checkpoint Integration**: 15-minute checkpoints within ralph iterations
6. **Anti-Gaming Protection**: Evidence-backed confidence validation

Use ralph-loop when high confidence is required and iterative refinement adds value. The overhead of ralph is justified when:
- Stakes are high (>90% confidence needed)
- Problem complexity may require pattern switching
- Self-correction across iterations improves outcome
- Premature conclusion would be costly

**Reference**: See `integrated-reasoning-v2/SKILL.md` for pattern selection and `reasoning-handover-protocol/SKILL.md` for state management details.
