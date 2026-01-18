# IR-v2 A/B Test Suite: Mismatch Analysis

**Test Date**: 2026-01-18
**Purpose**: Deep analysis of cases where selected pattern differs from expected

---

## Mismatch Summary

| Case | Problem | Expected | Selected | Score Gap | Severity |
|------|---------|----------|----------|-----------|----------|
| 4 | Explore ML approaches | BoT | AT | 0.30 | Low |
| 5 | Team conflict on architecture | NDF | DR | 0.05 | Minimal |
| 10 | Simple API endpoint | Direct | BoT | N/A | Design gap |

---

## Case 4: Explore ML Approaches

### Problem Description
Need to solve NLP task but unsure which approach (transformer, RNN, traditional ML).

### Dimension Scores
```
Seq=2, Criteria=2, SpaceKnown=2, Single=3, Evidence=2,
Opposing=2, Novelty=4, Robust=3, SolExists=1, Time=2, Stakeholder=1
```

### Expected Pattern: BoT (Breadth of Thought)
**Rationale**: Unknown solution space, need exhaustive exploration of all approaches.

### Selected Pattern: AT (Analogical Transfer)
**Score**: AT=4.00, BoT=3.70 (gap: 0.30)

### Why AT Won

The formula calculations:
```
BoT = ((6-2)*0.35) + ((6-3)*0.30) + ((6-2)*0.20) + (4*0.15)
    = 1.40 + 0.90 + 0.80 + 0.60 = 3.70

AT  = (4*0.45) + ((6-2)*0.30) + ((6-2)*0.15) + ((6-2)*0.10)
    = 1.80 + 1.20 + 0.60 + 0.40 = 4.00
```

**Key factors favoring AT**:
- Novelty=4 with 0.45 weight in AT formula gives 1.80
- AT benefits from (6-SpaceKnown) = 4 with 0.30 weight giving 1.20
- AT also gets (6-Evidence) = 4 with 0.15 weight

**Key factors for BoT**:
- (6-SpaceKnown) = 4 with 0.35 weight gives 1.40
- (6-SingleAnswer) = 3 with 0.30 weight gives 0.90
- Novelty=4 but only 0.15 weight gives 0.60

### Root Cause Analysis

The mismatch occurs because:

1. **Novelty weighting**: AT weights Novelty at 0.45, while BoT only weights it at 0.15
2. **Problem characterization**: Novelty=4 and SpaceKnown=2 creates overlap between AT and BoT use cases
3. **Semantic ambiguity**: This problem has both:
   - "Unknown solution space" (favors BoT)
   - "Novel application requiring cross-domain learning" (favors AT)

### Is This Mismatch Problematic?

**NO** - This is a semantically valid selection.

For ML approach exploration:
- **AT would have you**: Look at how similar NLP problems were solved in speech recognition, computer vision, or other domains - find analogies that transfer
- **BoT would have you**: Systematically enumerate all ML approaches and evaluate each

Both are reasonable strategies. In fact, AT || BoT (parallel execution) would be optimal here - exactly what IR-v2's orchestration system would suggest given the 0.30 gap.

### Recommendation

**No formula change needed**. The selection is semantically valid.

If perfect BoT selection is required for "exploration" problems, consider:
- Increase BoT weight on (6-SpaceKnown) from 0.35 to 0.40
- OR decrease AT weight on Novelty from 0.45 to 0.40

However, this would reduce AT's sensitivity to novel problems, which may not be desirable.

---

## Case 5: Team Conflict on Architecture

### Problem Description
Backend team wants REST, frontend team wants GraphQL. Project blocked.

### Dimension Scores
```
Seq=2, Criteria=3, SpaceKnown=4, Single=4, Evidence=3,
Opposing=5, Novelty=1, Robust=3, SolExists=3, Time=2, Stakeholder=4
```

### Expected Pattern: NDF (Negotiated Decision Framework)
**Rationale**: Multiple stakeholders with competing interests need consensus.

### Selected Pattern: DR (Dialectical Reasoning)
**Score**: DR=4.15, NDF=4.10 (gap: 0.05)

### Why DR Won (Barely)

The formula calculations:
```
DR  = (5*0.50) + (3*0.20) + ((6-3)*0.15) + (MIN(4,5)*0.15)
    = 2.50 + 0.60 + 0.45 + 0.60 = 4.15

NDF = (4*0.45) + (5*0.25) + ((6-3)*0.15) + ((6-2)*0.15)
    = 1.80 + 1.25 + 0.45 + 0.60 = 4.10
```

**Key factors favoring DR**:
- OpposingViews=5 with 0.50 weight gives 2.50 (massive contribution)

**Key factors for NDF**:
- StakeholderComplexity=4 with 0.45 weight gives 1.80
- OpposingViews=5 with 0.25 weight gives 1.25

### Root Cause Analysis

The mismatch occurs because:

1. **OpposingViews dominates**: At 0.50 weight in DR, a score of 5 contributes 2.50 points
2. **Stakeholder complexity not maximal**: At 4 (not 5), NDF gets 1.80 instead of 2.25
3. **Problem has both aspects**:
   - Conceptual tension between REST and GraphQL (DR domain)
   - Stakeholder coordination needed (NDF domain)

### Is This Mismatch Problematic?

**MINIMAL** - The 0.05 gap is within statistical noise.

Per IR-v2 orchestration guidelines, when scores are within 0.5, consider multi-pattern approaches:
> | DR | NDF | Sequential: DR (resolve conceptual tension) -> NDF (negotiate stakeholders) |

The system would recommend DR -> NDF orchestration, which is the optimal approach:
1. Use DR to find synthesis between REST and GraphQL positions
2. Use NDF to get stakeholder buy-in on the synthesis

### Recommendation

**No formula change needed**. This is a near-tie that correctly identifies both patterns as highly relevant.

If stricter NDF selection is required when stakeholders are the primary issue:
- Increase NDF weight on StakeholderComplexity from 0.45 to 0.50
- This would make NDF win when StakeholderComplexity >= 4

However, the current behavior (DR slightly ahead, NDF very close) correctly captures the dual nature of this problem.

---

## Case 10: Simple API Endpoint

### Problem Description
Add a new /users endpoint to existing well-designed REST API.

### Dimension Scores
```
Seq=2, Criteria=2, SpaceKnown=2, Single=2, Evidence=2,
Opposing=1, Novelty=1, Robust=2, SolExists=2, Time=1, Stakeholder=1
```

### Expected Pattern: Direct Analysis
**Rationale**: All scores low (< 2.5), routine task, no cognitive framework needed.

### Selected Pattern: BoT (Breadth of Thought)
**Score**: BoT=3.55 (highest among all patterns)

### Why BoT Won

The formula calculations:
```
BoT = ((6-2)*0.35) + ((6-2)*0.30) + ((6-2)*0.20) + (1*0.15)
    = 1.40 + 1.20 + 0.80 + 0.15 = 3.55
```

BoT wins because the formula uses (6-X) inversions:
- (6-SpaceKnown) = 4
- (6-SingleAnswer) = 4
- (6-Criteria) = 4

Low scores BECOME high scores through inversion, making BoT score well even though the problem doesn't warrant any framework.

### Root Cause Analysis

This is a **design gap**, not a formula error:

1. **No "Direct" threshold exists**: The system always selects a pattern
2. **Inversion effect**: BoT formula uses many (6-X) terms, which turn low scores into high contributions
3. **Missing heuristic**: There's no rule for "if all dimensions < 3, use Direct Analysis"

### Is This Mismatch Problematic?

**MODERATE** - The system over-engineers trivial tasks.

Using BoT for a simple API endpoint would waste effort on "exhaustive exploration" when just following existing patterns suffices.

### Recommendation

**Add "Direct Analysis" threshold to IR-v2**:

```python
def should_use_direct_analysis(dimensions):
    """Check if problem is too simple for cognitive frameworks."""

    # Condition 1: All scores low
    if all(score < 3 for score in dimensions.values()):
        return True

    # Condition 2: Max pattern score below threshold
    all_scores = calculate_all_pattern_scores(dimensions)
    if max(all_scores.values()) < 4.0:
        return True

    # Condition 3: No strong signal in any dimension
    if max(dimensions.values()) < 4:
        return True

    return False
```

**Proposed rule for SKILL.md**:

> **DIRECT ANALYSIS THRESHOLD**
>
> If ALL of the following are true, skip pattern selection and use Direct Analysis:
> 1. No dimension scores 4 or higher
> 2. Maximum pattern affinity score < 4.0
> 3. Problem fits within established patterns/templates
>
> Direct Analysis = Apply domain knowledge directly without structured cognitive framework.

---

## Summary: Mismatch Classification

| Case | Type | Severity | Action Required |
|------|------|----------|-----------------|
| 4 | Semantic overlap | Low | None - both patterns valid |
| 5 | Near-tie | Minimal | None - orchestration handles this |
| 10 | Design gap | Moderate | Add Direct threshold |

---

## Quantified Impact

### If No Changes Made

- 85% accuracy remains acceptable
- Case 4 and 5 select reasonable alternatives
- Case 10 over-engineers trivial tasks

### If Direct Threshold Added

- Accuracy improves to 90% (18/20)
- Trivial tasks correctly identified
- No negative impact on complex problems

### Formula Changes NOT Recommended

Changing weights to fix Cases 4 and 5 would:
- Reduce discrimination for other problem types
- Create new edge cases
- Undermine validated formula effectiveness

The current formulas are **well-calibrated**. The mismatches are at boundaries where multiple patterns are genuinely applicable.

---

## Appendix: Mismatch Score Breakdown

### Case 4 - All Pattern Scores
```
AT   = 4.00  <-- SELECTED
BoT  = 3.70  <-- EXPECTED
HE   = 2.50
SRC  = 2.40
ToT  = 2.30
DR   = 2.30
RTR  = 2.25
AR   = 0.00
NDF  = 0.00
```

### Case 5 - All Pattern Scores
```
DR   = 4.15  <-- SELECTED
NDF  = 4.10  <-- EXPECTED (gap: 0.05)
ToT  = 3.80
HE   = 3.50
AR   = 3.30
RTR  = 2.95
SRC  = 2.55
BoT  = 2.05
AT   = 1.90
```

### Case 10 - All Pattern Scores
```
BoT  = 3.55  <-- SELECTED
HE   = 2.90
AT   = 2.65
ToT  = 2.45
SRC  = 2.30
RTR  = 1.80
DR   = 1.65
AR   = 0.00
NDF  = 0.00

Expected: Direct (no pattern selected)
Observation: MAX score = 3.55 < 4.0, supports Direct threshold
```

---

## Conclusion

The IR-v2 pattern selection algorithm is **fundamentally sound**.

- **Case 4**: AT and BoT are both valid for exploration problems. No fix needed.
- **Case 5**: DR and NDF are both needed. Near-tie correctly suggests orchestration.
- **Case 10**: Missing feature (Direct threshold), not formula error.

**Recommended Action**: Add Direct Analysis threshold to handle trivial tasks. No formula weight changes.
