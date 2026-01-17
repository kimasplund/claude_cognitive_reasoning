# IR-v2 Pattern Selection Algorithm Test Results

**Test Date**: 2026-01-18
**IR-v2 Version**: 2.1
**Test Scenarios**: 5 diverse problem types

---

## Formula Reference (from SKILL.md)

```
ToT  = (Criteria * 0.35) + (SingleAnswer * 0.30) + (SpaceKnown * 0.20) + ((6-Novelty) * 0.15)
BoT  = ((6-SpaceKnown) * 0.35) + ((6-SingleAnswer) * 0.30) + ((6-Criteria) * 0.20) + (Novelty * 0.15)
SRC  = (Sequential * 0.45) + (Criteria * 0.25) + (SingleAnswer * 0.20) + ((6-OpposingViews) * 0.10)
HE   = (Evidence * 0.40) + (SingleAnswer * 0.30) + ((6-Novelty) * 0.20) + ((6-OpposingViews) * 0.10)
AR   = (Robustness * 0.40) + (SolutionExists * 0.30) + ((6-Novelty) * 0.15) + (Evidence * 0.15)
       [AR = 0 if SolutionExists < 3]
DR   = (OpposingViews * 0.50) + (Criteria * 0.20) + ((6-Evidence) * 0.15) + (MIN(SingleAnswer, OpposingViews) * 0.15)
AT   = (Novelty * 0.45) + ((6-SpaceKnown) * 0.30) + ((6-Evidence) * 0.15) + ((6-Sequential) * 0.10)
RTR  = (TimePressure * 0.50) + (SingleAnswer * 0.25) + (Evidence * 0.15) + ((6-Novelty) * 0.10)
       [Auto-selected when TimePressure = 5]
NDF  = (StakeholderComplexity * 0.45) + (OpposingViews * 0.25) + ((6-Criteria) * 0.15) + ((6-TimePressure) * 0.15)
       [NDF = 0 if StakeholderComplexity < 3]
```

---

## Test Problem 1: Debug a Memory Leak

**Scenario**: Users report app slowing down over time. Need to find root cause.

### Step 1: Dimension Scoring

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential Dependencies | 4 | Debugging follows trace: reproduce -> profile -> isolate -> fix |
| Criteria Clarity | 4 | Clear: memory usage should be stable, leaks should be eliminated |
| Solution Space Known | 3 | Common leak patterns known (closures, event listeners, etc.) |
| Single Answer Needed | 5 | Need to find THE cause of this specific leak |
| Evidence Available | 5 | Memory profilers, heap snapshots, allocation logs available |
| Opposing Valid Views | 1 | No real opposing views - there is a bug to find |
| Problem Novelty | 2 | Memory leaks are well-understood problem domain |
| Robustness Required | 3 | Need to verify fix actually resolves the issue |
| Solution Exists | 2 | No candidate fix yet - still searching for cause |
| Time Pressure | 2 | Users annoyed but not emergency |
| Stakeholder Complexity | 1 | Technical decision, single team |

### Step 2: Pattern Affinity Calculations

```
ToT  = (4 * 0.35) + (5 * 0.30) + (3 * 0.20) + ((6-2) * 0.15)
     = 1.40 + 1.50 + 0.60 + 0.60
     = 4.10

BoT  = ((6-3) * 0.35) + ((6-5) * 0.30) + ((6-4) * 0.20) + (2 * 0.15)
     = 1.05 + 0.30 + 0.40 + 0.30
     = 2.05

SRC  = (4 * 0.45) + (4 * 0.25) + (5 * 0.20) + ((6-1) * 0.10)
     = 1.80 + 1.00 + 1.00 + 0.50
     = 4.30

HE   = (5 * 0.40) + (5 * 0.30) + ((6-2) * 0.20) + ((6-1) * 0.10)
     = 2.00 + 1.50 + 0.80 + 0.50
     = 4.80  <-- HIGHEST

AR   = 0 (SolutionExists = 2 < 3, nothing to attack)

DR   = (1 * 0.50) + (4 * 0.20) + ((6-5) * 0.15) + (MIN(5,1) * 0.15)
     = 0.50 + 0.80 + 0.15 + 0.15
     = 1.60

AT   = (2 * 0.45) + ((6-3) * 0.30) + ((6-5) * 0.15) + ((6-4) * 0.10)
     = 0.90 + 0.90 + 0.15 + 0.20
     = 2.15

RTR  = (2 * 0.50) + (5 * 0.25) + (5 * 0.15) + ((6-2) * 0.10)
     = 1.00 + 1.25 + 0.75 + 0.40
     = 3.40

NDF  = 0 (StakeholderComplexity = 1 < 3)
```

### Step 3: Results

| Pattern | Score | Notes |
|---------|-------|-------|
| **HE**  | **4.80** | **WINNER** |
| SRC     | 4.30 | Second place |
| ToT     | 4.10 | Third place |
| RTR     | 3.40 | |
| AT      | 2.15 | |
| BoT     | 2.05 | |
| DR      | 1.60 | |
| AR      | 0.00 | Blocked: no solution exists |
| NDF     | 0.00 | Blocked: single stakeholder |

**Winner**: **Hypothesis-Elimination (HE)** with score 4.80

**Why HE wins**:
- High evidence availability (5) - memory profilers give discriminating data
- Single answer needed (5) - finding THE cause
- Low novelty (2) - well-understood domain boosts HE
- No opposing views (1) - objective diagnostic problem

**Fast-path check**: TimePressure = 2, no fast-path triggered.

**Validation**: CORRECT. Debugging is a diagnostic problem where you form hypotheses about causes (closure leak? event listener leak? global variable?) and eliminate them through evidence (heap snapshots). HE is the appropriate methodology.

---

## Test Problem 2: Choose Cloud Provider

**Scenario**: AWS vs GCP vs Azure for a startup. Strategic decision.

### Step 1: Dimension Scoring

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential Dependencies | 2 | Not step-by-step; comparisons can be done in parallel |
| Criteria Clarity | 4 | Can define: cost, features, team familiarity, scalability |
| Solution Space Known | 5 | Options known: AWS, GCP, Azure (maybe others) |
| Single Answer Needed | 5 | Must pick ONE provider |
| Evidence Available | 4 | Benchmarks, pricing calculators, case studies available |
| Opposing Valid Views | 3 | Each provider has valid defenders; some debate |
| Problem Novelty | 1 | Very common decision, tons of precedent |
| Robustness Required | 4 | Big commitment, hard to switch later |
| Solution Exists | 3 | Have candidates (all 3 providers) |
| Time Pressure | 2 | Strategic decision, not urgent |
| Stakeholder Complexity | 2 | Primarily tech leadership decision |

### Step 2: Pattern Affinity Calculations

```
ToT  = (4 * 0.35) + (5 * 0.30) + (5 * 0.20) + ((6-1) * 0.15)
     = 1.40 + 1.50 + 1.00 + 0.75
     = 4.65  <-- HIGHEST

BoT  = ((6-5) * 0.35) + ((6-5) * 0.30) + ((6-4) * 0.20) + (1 * 0.15)
     = 0.35 + 0.30 + 0.40 + 0.15
     = 1.20

SRC  = (2 * 0.45) + (4 * 0.25) + (5 * 0.20) + ((6-3) * 0.10)
     = 0.90 + 1.00 + 1.00 + 0.30
     = 3.20

HE   = (4 * 0.40) + (5 * 0.30) + ((6-1) * 0.20) + ((6-3) * 0.10)
     = 1.60 + 1.50 + 1.00 + 0.30
     = 4.40

AR   = (4 * 0.40) + (3 * 0.30) + ((6-1) * 0.15) + (4 * 0.15)
     = 1.60 + 0.90 + 0.75 + 0.60
     = 3.85 (SolutionExists = 3, passes threshold)

DR   = (3 * 0.50) + (4 * 0.20) + ((6-4) * 0.15) + (MIN(5,3) * 0.15)
     = 1.50 + 0.80 + 0.30 + 0.45
     = 3.05

AT   = (1 * 0.45) + ((6-5) * 0.30) + ((6-4) * 0.15) + ((6-2) * 0.10)
     = 0.45 + 0.30 + 0.30 + 0.40
     = 1.45

RTR  = (2 * 0.50) + (5 * 0.25) + (4 * 0.15) + ((6-1) * 0.10)
     = 1.00 + 1.25 + 0.60 + 0.50
     = 3.35

NDF  = 0 (StakeholderComplexity = 2 < 3)
```

### Step 3: Results

| Pattern | Score | Notes |
|---------|-------|-------|
| **ToT** | **4.65** | **WINNER** |
| HE      | 4.40 | Second place (within 0.5!) |
| AR      | 3.85 | Third place |
| RTR     | 3.35 | |
| SRC     | 3.20 | |
| DR      | 3.05 | |
| AT      | 1.45 | |
| BoT     | 1.20 | |
| NDF     | 0.00 | Blocked: low stakeholder complexity |

**Winner**: **Tree of Thoughts (ToT)** with score 4.65

**Why ToT wins**:
- Known solution space (5) - options are defined
- Clear criteria (4) - can evaluate against metrics
- Need single answer (5) - must pick ONE
- Low novelty (1) - common decision

**Close second**: HE at 4.40 (within 0.5 - consider orchestration)

**Orchestration recommendation**: ToT -> AR
1. ToT to evaluate and rank options against criteria
2. AR to stress-test the winning choice before committing

**Fast-path check**: TimePressure = 2, no fast-path triggered.

**Validation**: CORRECT. This is a classic "pick the best from known options with clear criteria" problem - exactly what ToT is designed for. The orchestration with AR makes sense given the high robustness requirement.

---

## Test Problem 3: Production Incident

**Scenario**: Database is returning errors RIGHT NOW. Users affected.

### Step 1: Fast-Path Check

**Time Pressure = 5** (emergency/incident)

**FAST-PATH TRIGGERED**: Skip full scoring, use **RTR** directly.

Per SKILL.md:
> **CRITICAL**: If Time Pressure = 5 (emergency/incident):
> - Skip full scoring
> - Use **Rapid Triage Reasoning (RTR)** directly

### Step 2: Full Scoring (for verification)

Even though fast-path triggers, let's verify the formulas still make RTR win:

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential Dependencies | 3 | Some sequence: assess -> stabilize -> diagnose |
| Criteria Clarity | 4 | Clear: database should return results, not errors |
| Solution Space Known | 3 | Common DB issues known but could be novel |
| Single Answer Needed | 5 | Need to identify and fix THE issue |
| Evidence Available | 4 | Error logs, metrics, alerts available |
| Opposing Valid Views | 1 | No debate during incident - fix it! |
| Problem Novelty | 2 | Database errors are common domain |
| Robustness Required | 2 | Speed trumps perfection right now |
| Solution Exists | 2 | No candidate fix yet |
| Time Pressure | **5** | **RIGHT NOW** |
| Stakeholder Complexity | 1 | On-call engineer decides |

```
ToT  = (4 * 0.35) + (5 * 0.30) + (3 * 0.20) + ((6-2) * 0.15)
     = 1.40 + 1.50 + 0.60 + 0.60
     = 4.10

BoT  = ((6-3) * 0.35) + ((6-5) * 0.30) + ((6-4) * 0.20) + (2 * 0.15)
     = 1.05 + 0.30 + 0.40 + 0.30
     = 2.05

SRC  = (3 * 0.45) + (4 * 0.25) + (5 * 0.20) + ((6-1) * 0.10)
     = 1.35 + 1.00 + 1.00 + 0.50
     = 3.85

HE   = (4 * 0.40) + (5 * 0.30) + ((6-2) * 0.20) + ((6-1) * 0.10)
     = 1.60 + 1.50 + 0.80 + 0.50
     = 4.40

AR   = 0 (SolutionExists = 2 < 3)

DR   = (1 * 0.50) + (4 * 0.20) + ((6-4) * 0.15) + (MIN(5,1) * 0.15)
     = 0.50 + 0.80 + 0.30 + 0.15
     = 1.75

AT   = (2 * 0.45) + ((6-3) * 0.30) + ((6-4) * 0.15) + ((6-3) * 0.10)
     = 0.90 + 0.90 + 0.30 + 0.30
     = 2.40

RTR  = (5 * 0.50) + (5 * 0.25) + (4 * 0.15) + ((6-2) * 0.10)
     = 2.50 + 1.25 + 0.60 + 0.40
     = 4.75  <-- HIGHEST (even without fast-path!)

NDF  = 0 (StakeholderComplexity = 1 < 3)
```

### Step 3: Results

| Pattern | Score | Notes |
|---------|-------|-------|
| **RTR** | **4.75** | **WINNER** (also fast-path) |
| HE      | 4.40 | Second place |
| ToT     | 4.10 | Third place |
| SRC     | 3.85 | |
| AT      | 2.40 | |
| BoT     | 2.05 | |
| DR      | 1.75 | |
| AR      | 0.00 | Blocked |
| NDF     | 0.00 | Blocked |

**Winner**: **Rapid Triage Reasoning (RTR)** with score 4.75

**Why RTR wins**:
1. **Fast-path auto-selection** when TimePressure = 5
2. Even without fast-path, RTR scores highest due to:
   - Extreme time pressure (5) with 0.50 weight
   - Single answer needed (5)
   - Evidence available for quick decisions (4)

**Orchestration recommendation**: RTR -> HE (post-incident)
1. RTR now for immediate triage and stabilization
2. HE after incident for proper root cause analysis

**Fast-path check**: TimePressure = 5, **FAST-PATH TRIGGERED**.

**Validation**: CORRECT. The fast-path mechanism works as intended. During a production incident, you need rapid decisions - "good enough now" beats "perfect later". The follow-up orchestration with HE for RCA is also appropriate.

---

## Test Problem 4: Novel AI Feature

**Scenario**: Build something no one has built before. Unprecedented feature.

### Step 1: Dimension Scoring

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential Dependencies | 2 | Creative exploration, not linear |
| Criteria Clarity | 2 | Hard to evaluate what doesn't exist yet |
| Solution Space Known | 1 | Unknown - that's the whole point |
| Single Answer Needed | 3 | Need to converge eventually, but exploring first |
| Evidence Available | 1 | No precedent = no evidence |
| Opposing Valid Views | 2 | Maybe some debate on approach, but not primary |
| Problem Novelty | **5** | **Unprecedented by definition** |
| Robustness Required | 3 | Will need validation but exploration first |
| Solution Exists | 1 | No - we're inventing |
| Time Pressure | 2 | R&D timeline, not emergency |
| Stakeholder Complexity | 2 | Primarily technical team |

### Step 2: Pattern Affinity Calculations

```
ToT  = (2 * 0.35) + (3 * 0.30) + (1 * 0.20) + ((6-5) * 0.15)
     = 0.70 + 0.90 + 0.20 + 0.15
     = 1.95

BoT  = ((6-1) * 0.35) + ((6-3) * 0.30) + ((6-2) * 0.20) + (5 * 0.15)
     = 1.75 + 0.90 + 0.80 + 0.75
     = 4.20

SRC  = (2 * 0.45) + (2 * 0.25) + (3 * 0.20) + ((6-2) * 0.10)
     = 0.90 + 0.50 + 0.60 + 0.40
     = 2.40

HE   = (1 * 0.40) + (3 * 0.30) + ((6-5) * 0.20) + ((6-2) * 0.10)
     = 0.40 + 0.90 + 0.20 + 0.40
     = 1.90

AR   = 0 (SolutionExists = 1 < 3)

DR   = (2 * 0.50) + (2 * 0.20) + ((6-1) * 0.15) + (MIN(3,2) * 0.15)
     = 1.00 + 0.40 + 0.75 + 0.30
     = 2.45

AT   = (5 * 0.45) + ((6-1) * 0.30) + ((6-1) * 0.15) + ((6-2) * 0.10)
     = 2.25 + 1.50 + 0.75 + 0.40
     = 4.90  <-- HIGHEST

RTR  = (2 * 0.50) + (3 * 0.25) + (1 * 0.15) + ((6-5) * 0.10)
     = 1.00 + 0.75 + 0.15 + 0.10
     = 2.00

NDF  = 0 (StakeholderComplexity = 2 < 3)
```

### Step 3: Results

| Pattern | Score | Notes |
|---------|-------|-------|
| **AT**  | **4.90** | **WINNER** |
| BoT     | 4.20 | Second place (within 0.5!) |
| DR      | 2.45 | |
| SRC     | 2.40 | |
| RTR     | 2.00 | |
| ToT     | 1.95 | |
| HE      | 1.90 | |
| AR      | 0.00 | Blocked: no solution exists |
| NDF     | 0.00 | Blocked: low stakeholder complexity |

**Winner**: **Analogical Transfer (AT)** with score 4.90

**Why AT wins**:
- Maximum novelty (5) with 0.45 weight - AT thrives on novelty
- Unknown solution space (1) -> (6-1)=5 with 0.30 weight
- No evidence (1) -> (6-1)=5 with 0.15 weight
- AT is designed for "solve by finding parallels in other domains"

**Close second**: BoT at 4.20 (within 0.5 - consider orchestration)

**Orchestration recommendation**: AT || BoT -> ToT
1. Parallel: AT finds analogies from other domains, BoT explores the space
2. Then: ToT to select best approach from what was discovered

**Fast-path check**: TimePressure = 2, no fast-path triggered.

**Validation**: CORRECT. For truly novel problems, you need to look at how similar problems were solved elsewhere (AT) or exhaustively explore possibilities (BoT). ToT fails because there's no known option space to optimize over. The parallel AT || BoT approach is perfect for innovation.

---

## Test Problem 5: Team Disagreement

**Scenario**: Backend and frontend teams disagree on API design. Need to resolve.

### Step 1: Dimension Scoring

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential Dependencies | 2 | Not step-by-step; it's a negotiation |
| Criteria Clarity | 3 | Some technical criteria but also preferences |
| Solution Space Known | 4 | Options are known (various API designs) |
| Single Answer Needed | 4 | Need ONE API design |
| Evidence Available | 3 | Can benchmark, but much is subjective |
| Opposing Valid Views | **5** | **Both teams have legitimate perspectives** |
| Problem Novelty | 1 | API design disagreements are common |
| Robustness Required | 3 | Want durable solution both accept |
| Solution Exists | 3 | Each team has proposed their design |
| Time Pressure | 2 | Blocking work but not emergency |
| Stakeholder Complexity | **4** | **Multiple teams with competing interests** |

### Step 2: Pattern Affinity Calculations

```
ToT  = (3 * 0.35) + (4 * 0.30) + (4 * 0.20) + ((6-1) * 0.15)
     = 1.05 + 1.20 + 0.80 + 0.75
     = 3.80

BoT  = ((6-4) * 0.35) + ((6-4) * 0.30) + ((6-3) * 0.20) + (1 * 0.15)
     = 0.70 + 0.60 + 0.60 + 0.15
     = 2.05

SRC  = (2 * 0.45) + (3 * 0.25) + (4 * 0.20) + ((6-5) * 0.10)
     = 0.90 + 0.75 + 0.80 + 0.10
     = 2.55

HE   = (3 * 0.40) + (4 * 0.30) + ((6-1) * 0.20) + ((6-5) * 0.10)
     = 1.20 + 1.20 + 1.00 + 0.10
     = 3.50

AR   = (3 * 0.40) + (3 * 0.30) + ((6-1) * 0.15) + (3 * 0.15)
     = 1.20 + 0.90 + 0.75 + 0.45
     = 3.30 (SolutionExists = 3, passes threshold)

DR   = (5 * 0.50) + (3 * 0.20) + ((6-3) * 0.15) + (MIN(4,5) * 0.15)
     = 2.50 + 0.60 + 0.45 + 0.60
     = 4.15

AT   = (1 * 0.45) + ((6-4) * 0.30) + ((6-3) * 0.15) + ((6-2) * 0.10)
     = 0.45 + 0.60 + 0.45 + 0.40
     = 1.90

RTR  = (2 * 0.50) + (4 * 0.25) + (3 * 0.15) + ((6-1) * 0.10)
     = 1.00 + 1.00 + 0.45 + 0.50
     = 2.95

NDF  = (4 * 0.45) + (5 * 0.25) + ((6-3) * 0.15) + ((6-2) * 0.15)
     = 1.80 + 1.25 + 0.45 + 0.60
     = 4.10 (StakeholderComplexity = 4, passes threshold)
```

### Step 3: Results

| Pattern | Score | Notes |
|---------|-------|-------|
| **DR**  | **4.15** | **WINNER** |
| NDF     | 4.10 | Second place (within 0.5!) |
| ToT     | 3.80 | Third place |
| HE      | 3.50 | |
| AR      | 3.30 | |
| RTR     | 2.95 | |
| SRC     | 2.55 | |
| BoT     | 2.05 | |
| AT      | 1.90 | |

**Winner**: **Dialectical Reasoning (DR)** with score 4.15

**Why DR wins**:
- Maximum opposing views (5) with 0.50 weight - DR thrives on tension
- Both sides have valid perspectives (classic thesis vs antithesis)
- DR seeks synthesis, not winner-take-all

**Very close second**: NDF at 4.10 (within 0.05!)

**Orchestration recommendation**: DR -> NDF
1. DR first to find the conceptual synthesis (what's the right technical answer that honors both perspectives?)
2. NDF second to get stakeholder buy-in on the synthesis

Per SKILL.md orchestration table:
> | DR | NDF | Sequential: DR (resolve conceptual tension) -> NDF (negotiate stakeholders) |

**Fast-path check**: TimePressure = 2, no fast-path triggered.

**Validation**: CORRECT. This problem has two aspects: (1) conceptual tension between two valid technical approaches, and (2) stakeholder coordination to get buy-in. DR resolves the intellectual conflict to find synthesis; NDF handles the human/political aspect. The near-tie correctly identifies that both are needed.

---

## Summary: Formula Validation Results

### All Fast-Paths Tested

| Trigger | Test Case | Behavior |
|---------|-----------|----------|
| TimePressure = 5 | Problem 3 (Incident) | TRIGGERED - RTR auto-selected |
| AR SolutionExists < 3 | Problems 1, 3, 4 | AR correctly zeroed out |
| NDF StakeholderComplexity < 3 | Problems 1, 2, 3, 4 | NDF correctly zeroed out |

### Pattern Selection Accuracy

| Problem | Expected Pattern | Selected Pattern | Match? |
|---------|------------------|------------------|--------|
| 1. Memory Leak | HE (diagnostic) | HE (4.80) | YES |
| 2. Cloud Provider | ToT (optimization) | ToT (4.65) | YES |
| 3. Incident | RTR (emergency) | RTR (4.75 + fast-path) | YES |
| 4. Novel Feature | AT (innovation) | AT (4.90) | YES |
| 5. Team Disagreement | DR or NDF (conflict) | DR (4.15), NDF close | YES |

**Result: 5/5 correct selections**

### Formula Verification

All formulas computed correctly:
- Weights sum to 1.0 for each pattern
- Inverses (6-X) correctly applied
- Thresholds (AR, NDF) correctly enforced
- Fast-path (RTR) correctly triggered

### Orchestration Recommendations Generated

| Problem | Orchestration |
|---------|---------------|
| 1 | HE standalone (clear winner) |
| 2 | ToT -> AR (validate choice) |
| 3 | RTR -> HE (post-incident RCA) |
| 4 | AT \|\| BoT -> ToT (explore then select) |
| 5 | DR -> NDF (synthesis then buy-in) |

---

## Conclusion

The IR-v2 pattern selection algorithm **passes all tests**:

1. **Formula correctness**: All 9 pattern formulas calculate correctly
2. **Fast-paths work**: RTR auto-triggers at TimePressure=5
3. **Blocking conditions work**: AR and NDF correctly return 0 when thresholds not met
4. **Semantic correctness**: The "right" pattern wins for each problem type
5. **Orchestration**: Close scores correctly suggest multi-pattern approaches

The weighted multi-dimensional scoring system successfully replaces v1's order-dependent decision tree with a more robust selection mechanism that:
- Handles edge cases (no solution, no stakeholders, emergencies)
- Identifies when multiple patterns should combine
- Provides clear audit trail via dimension scores

**Algorithm Status**: VALIDATED
