---
name: integrated-reasoning-v2
description: Enhanced meta-orchestration for selecting and combining reasoning patterns. Now includes 7 methodologies (ToT, BoT, SRC, HE, AR, DR, AT) with weighted multi-dimensional selection, feedback loops, and validated confidence aggregation. Use when facing complex problems requiring optimal reasoning strategy selection.
license: MIT
version: 2.0
---

# Integrated Reasoning v2 - Meta-Orchestration

**Purpose**: Select and orchestrate optimal reasoning pattern(s) for your problem. V2 addresses limitations of v1: adds new patterns, replaces order-dependent decision tree with weighted scoring, includes feedback loops, and fixes confidence aggregation.

## Available Reasoning Patterns (7)

| Pattern | Purpose | Best For |
|---------|---------|----------|
| **Tree of Thoughts (ToT)** | Find optimal solution through deep exploration | Optimization, clear criteria, find THE best |
| **Breadth of Thought (BoT)** | Map solution space comprehensively | Unknown space, need multiple options |
| **Self-Reflecting Chain (SRC)** | Sequential reasoning with validation | Dependent steps, proofs, linear traces |
| **Hypothesis-Elimination (HE)** | Systematic elimination through evidence | Diagnosis, debugging, root cause |
| **Adversarial Reasoning (AR)** | Stress-test through attack simulation | Validation, security, pre-mortems |
| **Dialectical Reasoning (DR)** | Synthesize opposing valid perspectives | Trade-offs, stakeholder conflicts |
| **Analogical Transfer (AT)** | Solve via cross-domain parallels | Novel problems, no direct precedent |

---

## Pattern Selection: Weighted Multi-Dimensional Scoring

### Step 1: Assess Problem Characteristics

Score each dimension (1-5):

```markdown
| Dimension | Score | Description |
|-----------|-------|-------------|
| **Sequential Dependencies** | _/5 | Do steps depend on previous steps? |
| **Criteria Clarity** | _/5 | Can you clearly evaluate solutions? |
| **Solution Space Known** | _/5 | Do you know the options? |
| **Single Answer Needed** | _/5 | Need ONE answer vs multiple options? |
| **Evidence Available** | _/5 | Can you gather discriminating evidence? |
| **Opposing Valid Views** | _/5 | Are there legitimate conflicting perspectives? |
| **Problem Novelty** | _/5 | Is this unprecedented in your domain? |
| **Robustness Required** | _/5 | Need to stress-test before committing? |
```

### Step 2: Calculate Pattern Affinity Scores

```
ToT  = (Criteria × 0.35) + (SingleAnswer × 0.30) + (SpaceKnown × 0.20) + ((6-Novelty) × 0.15)

BoT  = ((6-SpaceKnown) × 0.35) + ((6-SingleAnswer) × 0.30) + ((6-Criteria) × 0.20) + (Novelty × 0.15)

SRC  = (Sequential × 0.45) + (Criteria × 0.25) + (SingleAnswer × 0.20) + ((6-OpposingViews) × 0.10)

HE   = (Evidence × 0.40) + (SingleAnswer × 0.30) + ((6-Novelty) × 0.20) + ((6-OpposingViews) × 0.10)

AR   = (Robustness × 0.50) + (SingleAnswer × 0.25) + ((6-Novelty) × 0.15) + (Evidence × 0.10)

DR   = (OpposingViews × 0.45) + ((6-SingleAnswer) × 0.25) + (Criteria × 0.15) + ((6-Evidence) × 0.15)

AT   = (Novelty × 0.45) + ((6-SpaceKnown) × 0.30) + ((6-Evidence) × 0.15) + ((6-Sequential) × 0.10)
```

### Step 3: Interpret Scores

| Scenario | Action |
|----------|--------|
| One pattern scores >4.0 | Use that pattern directly |
| Top 2 within 0.5 of each other | Consider multi-pattern orchestration |
| All patterns <3.0 | Problem may need decomposition first |
| Top pattern <2.5 | None fit well; use Direct Analysis |

---

## Multi-Pattern Orchestration

### When to Orchestrate

- Top 2 patterns within 0.5 points AND
- Problem is high-stakes (consequences matter) AND
- Time budget allows (>45 minutes available)

### Orchestration Patterns

**Sequential Orchestration** (most common):
1. Use exploration pattern first (BoT, AT)
2. Use optimization pattern second (ToT, HE)
3. Use validation pattern last (AR, SRC)

**Parallel Orchestration** (when patterns are complementary):
- Run 2 patterns independently
- Compare conclusions
- Use agreement/disagreement to calibrate confidence

**Nested Orchestration** (when patterns address different aspects):
- Apply different patterns to different sub-problems
- Synthesize at the end

### Orchestration Decision Table

| Pattern A High | Pattern B High | Orchestration |
|----------------|----------------|---------------|
| BoT | ToT | Sequential: BoT (explore) → ToT (optimize top options) |
| BoT | HE | Sequential: BoT (generate hypotheses) → HE (eliminate) |
| ToT | AR | Sequential: ToT (select) → AR (validate before commit) |
| ToT | SRC | Sequential: ToT (decide) → SRC (plan implementation) |
| DR | ToT | Sequential: DR (resolve tension) → ToT (optimize within synthesis) |
| AT | ToT | Sequential: AT (find analogies) → ToT (evaluate derived solutions) |
| AT | BoT | Parallel: Both explore, merge findings |
| HE | SRC | Sequential: HE (find cause) → SRC (trace mechanism) |

---

## Feedback Loop: 15-Minute Checkpoint

**After 15 minutes of applying selected pattern:**

```markdown
## Checkpoint Evaluation

### Progress Check
- [ ] Have I made meaningful progress toward goal?
- [ ] Is my confidence increasing?

### Pattern Fit Check
- [ ] Am I fighting the methodology?
- [ ] Have I discovered new problem characteristics?

### New Information
- [ ] Has the problem changed?
- [ ] Do my characteristic scores need updating?

### Decision
If 2+ checks FAIL:
  → PAUSE: Re-score characteristics
  → If different pattern scores highest: SWITCH
  → If same pattern: Continue with awareness

If all checks PASS:
  → Continue current pattern
  → Set next checkpoint at 30 min mark
```

---

## Confidence Aggregation (Fixed)

**V1 Problem**: Additive confidence boosting was statistically invalid.

**V2 Approach**: Agreement-based bounded adjustment.

### Single Pattern Confidence
Use the pattern's internal confidence score (per its methodology).

### Multi-Pattern Confidence

```markdown
## Multi-Pattern Synthesis

### Raw Scores
- Pattern A conclusion: [Answer A] at [X]% confidence
- Pattern B conclusion: [Answer B] at [Y]% confidence
- Pattern C conclusion: [Answer C] at [Z]% (if used)

### Agreement Analysis

**FULL AGREEMENT** (same conclusion):
- Final Confidence = MAX(X, Y, Z) + 5%
- Cap at 95%
- Rationale: Independent paths converging increases trust

**PARTIAL AGREEMENT** (2/3 agree):
- Final Confidence = (AVG of agreeing × 0.7) + (disagreeing × 0.15)
- Must document the disagreement
- Consider: Why does one pattern disagree?

**NO AGREEMENT** (different conclusions):
- Final Confidence = MIN(X, Y, Z) - 10%
- This is a FEATURE not a bug - disagreement reveals complexity
- Action: Either (a) gather more information, or (b) present trade-offs to stakeholder

### Shared Assumption Discount
If patterns share significant assumptions, apply -5% adjustment.
(Same LLM, same problem framing, same information = shared blind spots)
```

---

## Pattern Limitations Reference

**Tree of Thoughts (ToT)**:
- Requires clear evaluation criteria
- Deep recursion may overfit to evaluation function
- Fixed branching can force artificial distinctions

**Breadth of Thought (BoT)**:
- Cannot truly be "exhaustive"
- 8-10 branches may not cover solution space
- Returns multiple options requiring further decision

**Self-Reflecting Chain (SRC)**:
- Limited by weakest step in chain
- Backtracking is costly
- Assumes linear dependency structure

**Hypothesis-Elimination (HE)**:
- Requires discriminating evidence
- Can only find causes in the hypothesis set
- Time-sensitive (may not suit exploration)

**Adversarial Reasoning (AR)**:
- Requires existing solution to attack
- Can be demoralizing if overused
- May miss non-adversarial failure modes

**Dialectical Reasoning (DR)**:
- Requires genuinely opposing valid views
- Synthesis isn't always possible
- Can be slower than just deciding

**Analogical Transfer (AT)**:
- Analogy quality varies widely
- Source domain may mislead
- Requires creativity in finding parallels

---

## Quick Selection Guide

```
"I need to find the BEST option among known choices"
  → Tree of Thoughts

"I need to explore ALL possible approaches"
  → Breadth of Thought

"I need to trace through a logical chain step by step"
  → Self-Reflecting Chain

"I need to find THE CAUSE of something"
  → Hypothesis-Elimination

"I need to VALIDATE a solution before committing"
  → Adversarial Reasoning

"I'm stuck between two valid but opposing approaches"
  → Dialectical Reasoning

"This problem is novel - no one has solved it in my domain"
  → Analogical Transfer

"I'm not sure which to use"
  → Score the dimensions (Step 1)
```

---

## Example Application

**Problem**: "Design our company's approach to AI governance"

### Characteristic Scoring
| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential Dependencies | 2 | Not really step-by-step |
| Criteria Clarity | 3 | Some criteria, but subjective |
| Solution Space Known | 2 | Emerging field, options unclear |
| Single Answer Needed | 4 | Need one policy |
| Evidence Available | 2 | Few precedents to learn from |
| Opposing Valid Views | 5 | Big tension: innovation vs caution |
| Problem Novelty | 5 | Very new challenge |
| Robustness Required | 4 | High stakes, need validation |

### Pattern Affinity Scores
- ToT: (3×.35)+(4×.30)+(2×.20)+(1×.15) = 2.80
- BoT: (4×.35)+(2×.30)+(3×.20)+(5×.15) = 3.35
- SRC: (2×.45)+(3×.25)+(4×.20)+(1×.10) = 2.55
- HE: (2×.40)+(4×.30)+(1×.20)+(1×.10) = 2.30
- AR: (4×.50)+(4×.25)+(1×.15)+(2×.10) = 3.35
- **DR: (5×.45)+(2×.25)+(3×.15)+(4×.15) = 3.80** ← Highest
- AT: (5×.45)+(4×.30)+(4×.15)+(4×.10) = 4.45 ← Highest

### Recommendation
**Primary**: Analogical Transfer (4.45) - Look at how other governance challenges were solved
**Secondary**: Dialectical Reasoning (3.80) - Innovation vs caution tension needs synthesis

**Orchestration**: AT → DR → AR
1. Use AT to find analogous governance frameworks (environmental, financial, medical)
2. Use DR to synthesize the innovation/caution tension
3. Use AR to stress-test the proposed governance approach

---

## Version History

**V2.0** (Current):
- Added 4 new patterns: HE, AR, DR, AT
- Replaced decision tree with weighted multi-dimensional scoring
- Added 15-minute feedback checkpoint
- Fixed confidence aggregation (no more invalid additive boosting)
- Added orchestration decision table
- Added pattern limitations reference

**V1.0** (Deprecated):
- 3 patterns: ToT, BoT, SRC
- Order-dependent decision tree
- No feedback loop
- Invalid confidence aggregation
