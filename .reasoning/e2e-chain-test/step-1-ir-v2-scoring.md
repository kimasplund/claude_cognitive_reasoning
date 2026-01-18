# Step 1: IR-v2 Dimension Scoring and Pattern Selection

**Problem**: "Our API response times have degraded from 200ms to 2000ms over the past week. Users are complaining. Find the cause and recommend a fix."

---

## 1.1 Problem Characteristic Assessment

| Dimension | Score | Justification |
|-----------|-------|---------------|
| **Sequential Dependencies** | 2/5 | Finding root cause and fix are somewhat independent; fix depends on cause but not rigidly step-by-step |
| **Criteria Clarity** | 4/5 | Clear target: return to 200ms response time; measurable success |
| **Solution Space Known** | 2/5 | Unknown root cause means unknown solution space initially |
| **Single Answer Needed** | 5/5 | Need THE root cause and ONE recommended fix, not multiple options |
| **Evidence Available** | 5/5 | Production system with logs, metrics, APM, profiling available |
| **Opposing Valid Views** | 2/5 | Performance issues rarely have legitimate "opposing views" - something is broken |
| **Problem Novelty** | 2/5 | Performance debugging is well-understood domain; not novel |
| **Robustness Required** | 4/5 | Fix needs to be reliable; production system, user-facing |
| **Solution Exists** | 1/5 | No candidate solution yet - need to diagnose first |
| **Time Pressure** | 4/5 | Users complaining, but not down/incident; high but not emergency |
| **Stakeholder Complexity** | 2/5 | Engineering team can fix without complex stakeholder alignment |

---

## 1.2 Time Pressure Fast-Path Check

**Time Pressure = 4** (High but not emergency)

Per IR-v2 rules:
- Time Pressure < 5, so we do NOT auto-select RTR
- However, Time Pressure >= 4 suggests RTR for initial triage
- Problem is diagnostic (HE applicable)

**Decision**: Start with RTR for quick triage, then deeper analysis with HE

---

## 1.3 Pattern Affinity Score Calculations

### RTR (Rapid Triage Reasoning)
```
RTR = (TimePressure x 0.50) + (SingleAnswer x 0.25) + (Evidence x 0.15) + ((6-Novelty) x 0.10)
RTR = (4 x 0.50) + (5 x 0.25) + (5 x 0.15) + (4 x 0.10)
RTR = 2.00 + 1.25 + 0.75 + 0.40
RTR = 4.40
```

### HE (Hypothesis-Elimination)
```
HE = (Evidence x 0.40) + (SingleAnswer x 0.30) + ((6-Novelty) x 0.20) + ((6-OpposingViews) x 0.10)
HE = (5 x 0.40) + (5 x 0.30) + (4 x 0.20) + (4 x 0.10)
HE = 2.00 + 1.50 + 0.80 + 0.40
HE = 4.70
```

### ToT (Tree of Thoughts)
```
ToT = (Criteria x 0.35) + (SingleAnswer x 0.30) + (SpaceKnown x 0.20) + ((6-Novelty) x 0.15)
ToT = (4 x 0.35) + (5 x 0.30) + (2 x 0.20) + (4 x 0.15)
ToT = 1.40 + 1.50 + 0.40 + 0.60
ToT = 3.90
```

### BoT (Breadth of Thought)
```
BoT = ((6-SpaceKnown) x 0.35) + ((6-SingleAnswer) x 0.30) + ((6-Criteria) x 0.20) + (Novelty x 0.15)
BoT = (4 x 0.35) + (1 x 0.30) + (2 x 0.20) + (2 x 0.15)
BoT = 1.40 + 0.30 + 0.40 + 0.30
BoT = 2.40
```

### SRC (Self-Reflecting Chain)
```
SRC = (Sequential x 0.45) + (Criteria x 0.25) + (SingleAnswer x 0.20) + ((6-OpposingViews) x 0.10)
SRC = (2 x 0.45) + (4 x 0.25) + (5 x 0.20) + (4 x 0.10)
SRC = 0.90 + 1.00 + 1.00 + 0.40
SRC = 3.30
```

### AR (Adversarial Reasoning)
```
AR = (Robustness x 0.40) + (SolutionExists x 0.30) + ((6-Novelty) x 0.15) + (Evidence x 0.15)
AR = (4 x 0.40) + (1 x 0.30) + (4 x 0.15) + (5 x 0.15)

NOTE: SolutionExists = 1 < 3, so AR = 0 (nothing to attack yet)
AR = 0
```

### DR (Dialectical Reasoning)
```
DR = (OpposingViews x 0.50) + (Criteria x 0.20) + ((6-Evidence) x 0.15) + (MIN(SingleAnswer, OpposingViews) x 0.15)
DR = (2 x 0.50) + (4 x 0.20) + (1 x 0.15) + (2 x 0.15)
DR = 1.00 + 0.80 + 0.15 + 0.30
DR = 2.25
```

### AT (Analogical Transfer)
```
AT = (Novelty x 0.45) + ((6-SpaceKnown) x 0.30) + ((6-Evidence) x 0.15) + ((6-Sequential) x 0.10)
AT = (2 x 0.45) + (4 x 0.30) + (1 x 0.15) + (4 x 0.10)
AT = 0.90 + 1.20 + 0.15 + 0.40
AT = 2.65
```

### NDF (Negotiated Decision Framework)
```
NDF = (StakeholderComplexity x 0.45) + (OpposingViews x 0.25) + ((6-Criteria) x 0.15) + ((6-TimePressure) x 0.15)

NOTE: StakeholderComplexity = 2 < 3, so NDF = 0 (single decision-maker)
NDF = 0
```

---

## 1.4 Pattern Affinity Ranking

| Rank | Pattern | Score | Notes |
|------|---------|-------|-------|
| 1 | **HE** | 4.70 | Highest - perfect for diagnosis |
| 2 | **RTR** | 4.40 | High due to time pressure - good for initial triage |
| 3 | ToT | 3.90 | Will be useful AFTER root cause found (for fix selection) |
| 4 | SRC | 3.30 | Could trace code path but not primary |
| 5 | AT | 2.65 | Not novel enough to need analogies |
| 6 | BoT | 2.40 | Need answer, not options exploration |
| 7 | DR | 2.25 | No genuine opposing views |
| 8 | AR | 0 | No solution to attack yet |
| 9 | NDF | 0 | No stakeholder complexity |

---

## 1.5 Pattern Selection Decision

### Top 2 Analysis

**HE (4.70)** and **RTR (4.40)** are within 0.5 of each other.

Per IR-v2 orchestration rules:
- Top 2 within 0.5 points AND
- Problem is high-stakes (production, users complaining) AND
- Time budget allows (not a 5-minute incident)

**Decision**: Multi-pattern orchestration is appropriate.

### Sequential vs Parallel Decision

Consulting IR-v2 Orchestration Decision Table:

| Pattern A High | Pattern B High | Orchestration |
|----------------|----------------|---------------|
| RTR | HE | Sequential: RTR (immediate triage) -> HE (post-incident RCA) |

**RTR and HE are complementary, not independent:**
- RTR provides quick stabilization/triage
- HE provides deep root cause analysis
- RTR output (initial hypothesis) feeds into HE

**Decision**: **Sequential orchestration (not parallel)**

### Full Chain Selection

Given that we need to:
1. Quickly triage the situation (RTR)
2. Find root cause systematically (HE)
3. Evaluate fix options once cause is known (ToT - score 3.90)

**Selected Chain**: RTR -> HE -> ToT

---

## 1.6 Uncertainty Propagation Check

Checking dimensions with potential uncertainty (+-1):

| Dimension | Score | If -1 | If +1 | Affects Winner? |
|-----------|-------|-------|-------|-----------------|
| Time Pressure | 4 | 3 (RTR: 3.90) | 5 (auto-RTR) | No - HE still top |
| Evidence Available | 5 | 4 (HE: 4.30) | N/A | No - HE still top |
| Solution Exists | 1 | N/A | 2 (AR still 0) | No |

**No uncertainty-driven pattern changes**. Confidence in selection is high.

---

## 1.7 Final Selection Summary

```
SELECTED PATTERN CHAIN: RTR -> HE -> ToT

Orchestration: Sequential
  - Step 1: RTR (Rapid Triage) - 10 min - Quick assessment, immediate actions
  - Step 2: HE (Hypothesis-Elimination) - 25 min - Systematic root cause analysis
  - Step 3: ToT (Tree of Thoughts) - 10 min - Evaluate fix approaches

Total estimated time: 45 minutes

Confidence in pattern selection: 92%
  - HE and RTR clearly top-scoring
  - ToT logical follow-on for fix evaluation
  - Sequential orchestration matches IR-v2 table
  - No uncertainty in dimension scoring
```
