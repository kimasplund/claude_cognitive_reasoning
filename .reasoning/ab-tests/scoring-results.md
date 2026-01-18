# IR-v2 A/B Test Suite: Scoring Results

**Test Date**: 2026-01-18
**Total Test Cases**: 20

---

## Calculation Template

For each test case:
1. Extract dimension scores
2. Apply formulas to calculate all 9 pattern scores
3. Determine winner (highest score, respecting thresholds and fast-paths)

---

## Test Case 1: Debug Memory Leak

**Dimensions**: Seq=4, Criteria=4, SpaceKnown=3, Single=5, Evidence=5, Opposing=1, Novelty=2, Robust=3, SolExists=2, Time=2, Stakeholder=1

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (4*0.35) + (5*0.30) + (3*0.20) + ((6-2)*0.15) = 1.40 + 1.50 + 0.60 + 0.60 = 4.10
BoT  = ((6-3)*0.35) + ((6-5)*0.30) + ((6-4)*0.20) + (2*0.15) = 1.05 + 0.30 + 0.40 + 0.30 = 2.05
SRC  = (4*0.45) + (4*0.25) + (5*0.20) + ((6-1)*0.10) = 1.80 + 1.00 + 1.00 + 0.50 = 4.30
HE   = (5*0.40) + (5*0.30) + ((6-2)*0.20) + ((6-1)*0.10) = 2.00 + 1.50 + 0.80 + 0.50 = 4.80
AR   = 0 (SolutionExists=2 < 3)
DR   = (1*0.50) + (4*0.20) + ((6-5)*0.15) + (MIN(5,1)*0.15) = 0.50 + 0.80 + 0.15 + 0.15 = 1.60
AT   = (2*0.45) + ((6-3)*0.30) + ((6-5)*0.15) + ((6-4)*0.10) = 0.90 + 0.90 + 0.15 + 0.20 = 2.15
RTR  = (2*0.50) + (5*0.25) + (5*0.15) + ((6-2)*0.10) = 1.00 + 1.25 + 0.75 + 0.40 = 3.40
NDF  = 0 (StakeholderComplexity=1 < 3)
```

**Results**: HE=4.80, SRC=4.30, ToT=4.10, RTR=3.40, AT=2.15, BoT=2.05, DR=1.60, AR=0, NDF=0
**Selected**: HE (4.80)
**Expected**: HE
**MATCH**: YES

---

## Test Case 2: Choose Tech Stack

**Dimensions**: Seq=2, Criteria=4, SpaceKnown=5, Single=5, Evidence=4, Opposing=3, Novelty=1, Robust=4, SolExists=3, Time=2, Stakeholder=2

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (4*0.35) + (5*0.30) + (5*0.20) + ((6-1)*0.15) = 1.40 + 1.50 + 1.00 + 0.75 = 4.65
BoT  = ((6-5)*0.35) + ((6-5)*0.30) + ((6-4)*0.20) + (1*0.15) = 0.35 + 0.30 + 0.40 + 0.15 = 1.20
SRC  = (2*0.45) + (4*0.25) + (5*0.20) + ((6-3)*0.10) = 0.90 + 1.00 + 1.00 + 0.30 = 3.20
HE   = (4*0.40) + (5*0.30) + ((6-1)*0.20) + ((6-3)*0.10) = 1.60 + 1.50 + 1.00 + 0.30 = 4.40
AR   = (4*0.40) + (3*0.30) + ((6-1)*0.15) + (4*0.15) = 1.60 + 0.90 + 0.75 + 0.60 = 3.85
DR   = (3*0.50) + (4*0.20) + ((6-4)*0.15) + (MIN(5,3)*0.15) = 1.50 + 0.80 + 0.30 + 0.45 = 3.05
AT   = (1*0.45) + ((6-5)*0.30) + ((6-4)*0.15) + ((6-2)*0.10) = 0.45 + 0.30 + 0.30 + 0.40 = 1.45
RTR  = (2*0.50) + (5*0.25) + (4*0.15) + ((6-1)*0.10) = 1.00 + 1.25 + 0.60 + 0.50 = 3.35
NDF  = 0 (StakeholderComplexity=2 < 3)
```

**Results**: ToT=4.65, HE=4.40, AR=3.85, RTR=3.35, SRC=3.20, DR=3.05, AT=1.45, BoT=1.20, NDF=0
**Selected**: ToT (4.65)
**Expected**: ToT
**MATCH**: YES

---

## Test Case 3: Production Outage

**Dimensions**: Seq=3, Criteria=4, SpaceKnown=3, Single=5, Evidence=4, Opposing=1, Novelty=2, Robust=2, SolExists=2, Time=5, Stakeholder=1

**Fast-Path Check**: TimePressure=5 --> RTR FAST-PATH TRIGGERED

```
ToT  = (4*0.35) + (5*0.30) + (3*0.20) + ((6-2)*0.15) = 1.40 + 1.50 + 0.60 + 0.60 = 4.10
BoT  = ((6-3)*0.35) + ((6-5)*0.30) + ((6-4)*0.20) + (2*0.15) = 1.05 + 0.30 + 0.40 + 0.30 = 2.05
SRC  = (3*0.45) + (4*0.25) + (5*0.20) + ((6-1)*0.10) = 1.35 + 1.00 + 1.00 + 0.50 = 3.85
HE   = (4*0.40) + (5*0.30) + ((6-2)*0.20) + ((6-1)*0.10) = 1.60 + 1.50 + 0.80 + 0.50 = 4.40
AR   = 0 (SolutionExists=2 < 3)
DR   = (1*0.50) + (4*0.20) + ((6-4)*0.15) + (MIN(5,1)*0.15) = 0.50 + 0.80 + 0.30 + 0.15 = 1.75
AT   = (2*0.45) + ((6-3)*0.30) + ((6-4)*0.15) + ((6-3)*0.10) = 0.90 + 0.90 + 0.30 + 0.30 = 2.40
RTR  = (5*0.50) + (5*0.25) + (4*0.15) + ((6-2)*0.10) = 2.50 + 1.25 + 0.60 + 0.40 = 4.75
NDF  = 0 (StakeholderComplexity=1 < 3)
```

**Results**: RTR=4.75 (FAST-PATH), HE=4.40, ToT=4.10, SRC=3.85, AT=2.40, BoT=2.05, DR=1.75, AR=0, NDF=0
**Selected**: RTR (4.75 + fast-path)
**Expected**: RTR
**MATCH**: YES

---

## Test Case 4: Explore ML Approaches

**Dimensions**: Seq=2, Criteria=2, SpaceKnown=2, Single=3, Evidence=2, Opposing=2, Novelty=4, Robust=3, SolExists=1, Time=2, Stakeholder=1

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (2*0.35) + (3*0.30) + (2*0.20) + ((6-4)*0.15) = 0.70 + 0.90 + 0.40 + 0.30 = 2.30
BoT  = ((6-2)*0.35) + ((6-3)*0.30) + ((6-2)*0.20) + (4*0.15) = 1.40 + 0.90 + 0.80 + 0.60 = 3.70
SRC  = (2*0.45) + (2*0.25) + (3*0.20) + ((6-2)*0.10) = 0.90 + 0.50 + 0.60 + 0.40 = 2.40
HE   = (2*0.40) + (3*0.30) + ((6-4)*0.20) + ((6-2)*0.10) = 0.80 + 0.90 + 0.40 + 0.40 = 2.50
AR   = 0 (SolutionExists=1 < 3)
DR   = (2*0.50) + (2*0.20) + ((6-2)*0.15) + (MIN(3,2)*0.15) = 1.00 + 0.40 + 0.60 + 0.30 = 2.30
AT   = (4*0.45) + ((6-2)*0.30) + ((6-2)*0.15) + ((6-2)*0.10) = 1.80 + 1.20 + 0.60 + 0.40 = 4.00
RTR  = (2*0.50) + (3*0.25) + (2*0.15) + ((6-4)*0.10) = 1.00 + 0.75 + 0.30 + 0.20 = 2.25
NDF  = 0 (StakeholderComplexity=1 < 3)
```

**Results**: AT=4.00, BoT=3.70, HE=2.50, SRC=2.40, ToT=2.30, DR=2.30, RTR=2.25, AR=0, NDF=0
**Selected**: AT (4.00)
**Expected**: BoT
**MATCH**: NO - AT wins instead of BoT (see mismatch analysis)

---

## Test Case 5: Team Conflict on Architecture

**Dimensions**: Seq=2, Criteria=3, SpaceKnown=4, Single=4, Evidence=3, Opposing=5, Novelty=1, Robust=3, SolExists=3, Time=2, Stakeholder=4

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (3*0.35) + (4*0.30) + (4*0.20) + ((6-1)*0.15) = 1.05 + 1.20 + 0.80 + 0.75 = 3.80
BoT  = ((6-4)*0.35) + ((6-4)*0.30) + ((6-3)*0.20) + (1*0.15) = 0.70 + 0.60 + 0.60 + 0.15 = 2.05
SRC  = (2*0.45) + (3*0.25) + (4*0.20) + ((6-5)*0.10) = 0.90 + 0.75 + 0.80 + 0.10 = 2.55
HE   = (3*0.40) + (4*0.30) + ((6-1)*0.20) + ((6-5)*0.10) = 1.20 + 1.20 + 1.00 + 0.10 = 3.50
AR   = (3*0.40) + (3*0.30) + ((6-1)*0.15) + (3*0.15) = 1.20 + 0.90 + 0.75 + 0.45 = 3.30
DR   = (5*0.50) + (3*0.20) + ((6-3)*0.15) + (MIN(4,5)*0.15) = 2.50 + 0.60 + 0.45 + 0.60 = 4.15
AT   = (1*0.45) + ((6-4)*0.30) + ((6-3)*0.15) + ((6-2)*0.10) = 0.45 + 0.60 + 0.45 + 0.40 = 1.90
RTR  = (2*0.50) + (4*0.25) + (3*0.15) + ((6-1)*0.10) = 1.00 + 1.00 + 0.45 + 0.50 = 2.95
NDF  = (4*0.45) + (5*0.25) + ((6-3)*0.15) + ((6-2)*0.15) = 1.80 + 1.25 + 0.45 + 0.60 = 4.10
```

**Results**: DR=4.15, NDF=4.10, ToT=3.80, HE=3.50, AR=3.30, RTR=2.95, SRC=2.55, BoT=2.05, AT=1.90
**Selected**: DR (4.15), with NDF very close (4.10)
**Expected**: NDF
**MATCH**: PARTIAL - DR wins by 0.05 over NDF (see mismatch analysis)

---

## Test Case 6: Monolith vs Microservices

**Dimensions**: Seq=3, Criteria=3, SpaceKnown=4, Single=4, Evidence=3, Opposing=5, Novelty=2, Robust=4, SolExists=3, Time=2, Stakeholder=3

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (3*0.35) + (4*0.30) + (4*0.20) + ((6-2)*0.15) = 1.05 + 1.20 + 0.80 + 0.60 = 3.65
BoT  = ((6-4)*0.35) + ((6-4)*0.30) + ((6-3)*0.20) + (2*0.15) = 0.70 + 0.60 + 0.60 + 0.30 = 2.20
SRC  = (3*0.45) + (3*0.25) + (4*0.20) + ((6-5)*0.10) = 1.35 + 0.75 + 0.80 + 0.10 = 3.00
HE   = (3*0.40) + (4*0.30) + ((6-2)*0.20) + ((6-5)*0.10) = 1.20 + 1.20 + 0.80 + 0.10 = 3.30
AR   = (4*0.40) + (3*0.30) + ((6-2)*0.15) + (3*0.15) = 1.60 + 0.90 + 0.60 + 0.45 = 3.55
DR   = (5*0.50) + (3*0.20) + ((6-3)*0.15) + (MIN(4,5)*0.15) = 2.50 + 0.60 + 0.45 + 0.60 = 4.15
AT   = (2*0.45) + ((6-4)*0.30) + ((6-3)*0.15) + ((6-3)*0.10) = 0.90 + 0.60 + 0.45 + 0.30 = 2.25
RTR  = (2*0.50) + (4*0.25) + (3*0.15) + ((6-2)*0.10) = 1.00 + 1.00 + 0.45 + 0.40 = 2.85
NDF  = (3*0.45) + (5*0.25) + ((6-3)*0.15) + ((6-2)*0.15) = 1.35 + 1.25 + 0.45 + 0.60 = 3.65
```

**Results**: DR=4.15, ToT=3.65, NDF=3.65, AR=3.55, HE=3.30, SRC=3.00, RTR=2.85, AT=2.25, BoT=2.20
**Selected**: DR (4.15)
**Expected**: DR
**MATCH**: YES

---

## Test Case 7: Novel AI Ethics Policy

**Dimensions**: Seq=2, Criteria=2, SpaceKnown=1, Single=3, Evidence=1, Opposing=3, Novelty=5, Robust=4, SolExists=1, Time=2, Stakeholder=3

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (2*0.35) + (3*0.30) + (1*0.20) + ((6-5)*0.15) = 0.70 + 0.90 + 0.20 + 0.15 = 1.95
BoT  = ((6-1)*0.35) + ((6-3)*0.30) + ((6-2)*0.20) + (5*0.15) = 1.75 + 0.90 + 0.80 + 0.75 = 4.20
SRC  = (2*0.45) + (2*0.25) + (3*0.20) + ((6-3)*0.10) = 0.90 + 0.50 + 0.60 + 0.30 = 2.30
HE   = (1*0.40) + (3*0.30) + ((6-5)*0.20) + ((6-3)*0.10) = 0.40 + 0.90 + 0.20 + 0.30 = 1.80
AR   = 0 (SolutionExists=1 < 3)
DR   = (3*0.50) + (2*0.20) + ((6-1)*0.15) + (MIN(3,3)*0.15) = 1.50 + 0.40 + 0.75 + 0.45 = 3.10
AT   = (5*0.45) + ((6-1)*0.30) + ((6-1)*0.15) + ((6-2)*0.10) = 2.25 + 1.50 + 0.75 + 0.40 = 4.90
RTR  = (2*0.50) + (3*0.25) + (1*0.15) + ((6-5)*0.10) = 1.00 + 0.75 + 0.15 + 0.10 = 2.00
NDF  = (3*0.45) + (3*0.25) + ((6-2)*0.15) + ((6-2)*0.15) = 1.35 + 0.75 + 0.60 + 0.60 = 3.30
```

**Results**: AT=4.90, BoT=4.20, NDF=3.30, DR=3.10, SRC=2.30, RTR=2.00, ToT=1.95, HE=1.80, AR=0
**Selected**: AT (4.90)
**Expected**: AT
**MATCH**: YES

---

## Test Case 8: Prove Algorithm Correctness

**Dimensions**: Seq=5, Criteria=5, SpaceKnown=4, Single=5, Evidence=4, Opposing=1, Novelty=2, Robust=5, SolExists=3, Time=2, Stakeholder=1

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (5*0.35) + (5*0.30) + (4*0.20) + ((6-2)*0.15) = 1.75 + 1.50 + 0.80 + 0.60 = 4.65
BoT  = ((6-4)*0.35) + ((6-5)*0.30) + ((6-5)*0.20) + (2*0.15) = 0.70 + 0.30 + 0.20 + 0.30 = 1.50
SRC  = (5*0.45) + (5*0.25) + (5*0.20) + ((6-1)*0.10) = 2.25 + 1.25 + 1.00 + 0.50 = 5.00
HE   = (4*0.40) + (5*0.30) + ((6-2)*0.20) + ((6-1)*0.10) = 1.60 + 1.50 + 0.80 + 0.50 = 4.40
AR   = (5*0.40) + (3*0.30) + ((6-2)*0.15) + (4*0.15) = 2.00 + 0.90 + 0.60 + 0.60 = 4.10
DR   = (1*0.50) + (5*0.20) + ((6-4)*0.15) + (MIN(5,1)*0.15) = 0.50 + 1.00 + 0.30 + 0.15 = 1.95
AT   = (2*0.45) + ((6-4)*0.30) + ((6-4)*0.15) + ((6-5)*0.10) = 0.90 + 0.60 + 0.30 + 0.10 = 1.90
RTR  = (2*0.50) + (5*0.25) + (4*0.15) + ((6-2)*0.10) = 1.00 + 1.25 + 0.60 + 0.40 = 3.25
NDF  = 0 (StakeholderComplexity=1 < 3)
```

**Results**: SRC=5.00, ToT=4.65, HE=4.40, AR=4.10, RTR=3.25, DR=1.95, AT=1.90, BoT=1.50, NDF=0
**Selected**: SRC (5.00)
**Expected**: SRC
**MATCH**: YES

---

## Test Case 9: Security Audit Before Launch

**Dimensions**: Seq=3, Criteria=4, SpaceKnown=4, Single=4, Evidence=4, Opposing=1, Novelty=2, Robust=5, SolExists=4, Time=3, Stakeholder=2

**Fast-Path Check**: TimePressure=3 (no RTR fast-path)

```
ToT  = (4*0.35) + (4*0.30) + (4*0.20) + ((6-2)*0.15) = 1.40 + 1.20 + 0.80 + 0.60 = 4.00
BoT  = ((6-4)*0.35) + ((6-4)*0.30) + ((6-4)*0.20) + (2*0.15) = 0.70 + 0.60 + 0.40 + 0.30 = 2.00
SRC  = (3*0.45) + (4*0.25) + (4*0.20) + ((6-1)*0.10) = 1.35 + 1.00 + 0.80 + 0.50 = 3.65
HE   = (4*0.40) + (4*0.30) + ((6-2)*0.20) + ((6-1)*0.10) = 1.60 + 1.20 + 0.80 + 0.50 = 4.10
AR   = (5*0.40) + (4*0.30) + ((6-2)*0.15) + (4*0.15) = 2.00 + 1.20 + 0.60 + 0.60 = 4.40
DR   = (1*0.50) + (4*0.20) + ((6-4)*0.15) + (MIN(4,1)*0.15) = 0.50 + 0.80 + 0.30 + 0.15 = 1.75
AT   = (2*0.45) + ((6-4)*0.30) + ((6-4)*0.15) + ((6-3)*0.10) = 0.90 + 0.60 + 0.30 + 0.30 = 2.10
RTR  = (3*0.50) + (4*0.25) + (4*0.15) + ((6-2)*0.10) = 1.50 + 1.00 + 0.60 + 0.40 = 3.50
NDF  = 0 (StakeholderComplexity=2 < 3)
```

**Results**: AR=4.40, HE=4.10, ToT=4.00, SRC=3.65, RTR=3.50, AT=2.10, BoT=2.00, DR=1.75, NDF=0
**Selected**: AR (4.40)
**Expected**: AR
**MATCH**: YES

---

## Test Case 10: Simple API Endpoint

**Dimensions**: Seq=2, Criteria=2, SpaceKnown=2, Single=2, Evidence=2, Opposing=1, Novelty=1, Robust=2, SolExists=2, Time=1, Stakeholder=1

**Fast-Path Check**: TimePressure=1 (no RTR fast-path)

```
ToT  = (2*0.35) + (2*0.30) + (2*0.20) + ((6-1)*0.15) = 0.70 + 0.60 + 0.40 + 0.75 = 2.45
BoT  = ((6-2)*0.35) + ((6-2)*0.30) + ((6-2)*0.20) + (1*0.15) = 1.40 + 1.20 + 0.80 + 0.15 = 3.55
SRC  = (2*0.45) + (2*0.25) + (2*0.20) + ((6-1)*0.10) = 0.90 + 0.50 + 0.40 + 0.50 = 2.30
HE   = (2*0.40) + (2*0.30) + ((6-1)*0.20) + ((6-1)*0.10) = 0.80 + 0.60 + 1.00 + 0.50 = 2.90
AR   = 0 (SolutionExists=2 < 3)
DR   = (1*0.50) + (2*0.20) + ((6-2)*0.15) + (MIN(2,1)*0.15) = 0.50 + 0.40 + 0.60 + 0.15 = 1.65
AT   = (1*0.45) + ((6-2)*0.30) + ((6-2)*0.15) + ((6-2)*0.10) = 0.45 + 1.20 + 0.60 + 0.40 = 2.65
RTR  = (1*0.50) + (2*0.25) + (2*0.15) + ((6-1)*0.10) = 0.50 + 0.50 + 0.30 + 0.50 = 1.80
NDF  = 0 (StakeholderComplexity=1 < 3)
```

**Results**: BoT=3.55, HE=2.90, AT=2.65, ToT=2.45, SRC=2.30, RTR=1.80, DR=1.65, AR=0, NDF=0
**Selected**: BoT (3.55)
**Expected**: Direct (all scores low)
**MATCH**: NO - BoT wins, but MAX score is only 3.55 (see mismatch analysis)

---

## Test Case 11: Database Query Optimization

**Dimensions**: Seq=4, Criteria=5, SpaceKnown=3, Single=5, Evidence=5, Opposing=1, Novelty=2, Robust=3, SolExists=2, Time=3, Stakeholder=1

**Fast-Path Check**: TimePressure=3 (no RTR fast-path)

```
ToT  = (5*0.35) + (5*0.30) + (3*0.20) + ((6-2)*0.15) = 1.75 + 1.50 + 0.60 + 0.60 = 4.45
BoT  = ((6-3)*0.35) + ((6-5)*0.30) + ((6-5)*0.20) + (2*0.15) = 1.05 + 0.30 + 0.20 + 0.30 = 1.85
SRC  = (4*0.45) + (5*0.25) + (5*0.20) + ((6-1)*0.10) = 1.80 + 1.25 + 1.00 + 0.50 = 4.55
HE   = (5*0.40) + (5*0.30) + ((6-2)*0.20) + ((6-1)*0.10) = 2.00 + 1.50 + 0.80 + 0.50 = 4.80
AR   = 0 (SolutionExists=2 < 3)
DR   = (1*0.50) + (5*0.20) + ((6-5)*0.15) + (MIN(5,1)*0.15) = 0.50 + 1.00 + 0.15 + 0.15 = 1.80
AT   = (2*0.45) + ((6-3)*0.30) + ((6-5)*0.15) + ((6-4)*0.10) = 0.90 + 0.90 + 0.15 + 0.20 = 2.15
RTR  = (3*0.50) + (5*0.25) + (5*0.15) + ((6-2)*0.10) = 1.50 + 1.25 + 0.75 + 0.40 = 3.90
NDF  = 0 (StakeholderComplexity=1 < 3)
```

**Results**: HE=4.80, SRC=4.55, ToT=4.45, RTR=3.90, AT=2.15, BoT=1.85, DR=1.80, AR=0, NDF=0
**Selected**: HE (4.80)
**Expected**: HE
**MATCH**: YES

---

## Test Case 12: Vendor Selection

**Dimensions**: Seq=2, Criteria=5, SpaceKnown=5, Single=5, Evidence=4, Opposing=2, Novelty=1, Robust=4, SolExists=3, Time=2, Stakeholder=3

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (5*0.35) + (5*0.30) + (5*0.20) + ((6-1)*0.15) = 1.75 + 1.50 + 1.00 + 0.75 = 5.00
BoT  = ((6-5)*0.35) + ((6-5)*0.30) + ((6-5)*0.20) + (1*0.15) = 0.35 + 0.30 + 0.20 + 0.15 = 1.00
SRC  = (2*0.45) + (5*0.25) + (5*0.20) + ((6-2)*0.10) = 0.90 + 1.25 + 1.00 + 0.40 = 3.55
HE   = (4*0.40) + (5*0.30) + ((6-1)*0.20) + ((6-2)*0.10) = 1.60 + 1.50 + 1.00 + 0.40 = 4.50
AR   = (4*0.40) + (3*0.30) + ((6-1)*0.15) + (4*0.15) = 1.60 + 0.90 + 0.75 + 0.60 = 3.85
DR   = (2*0.50) + (5*0.20) + ((6-4)*0.15) + (MIN(5,2)*0.15) = 1.00 + 1.00 + 0.30 + 0.30 = 2.60
AT   = (1*0.45) + ((6-5)*0.30) + ((6-4)*0.15) + ((6-2)*0.10) = 0.45 + 0.30 + 0.30 + 0.40 = 1.45
RTR  = (2*0.50) + (5*0.25) + (4*0.15) + ((6-1)*0.10) = 1.00 + 1.25 + 0.60 + 0.50 = 3.35
NDF  = (3*0.45) + (2*0.25) + ((6-5)*0.15) + ((6-2)*0.15) = 1.35 + 0.50 + 0.15 + 0.60 = 2.60
```

**Results**: ToT=5.00, HE=4.50, AR=3.85, SRC=3.55, RTR=3.35, DR=2.60, NDF=2.60, AT=1.45, BoT=1.00
**Selected**: ToT (5.00)
**Expected**: ToT
**MATCH**: YES

---

## Test Case 13: Critical Bug (Non-Emergency)

**Dimensions**: Seq=4, Criteria=5, SpaceKnown=3, Single=5, Evidence=5, Opposing=1, Novelty=2, Robust=4, SolExists=2, Time=3, Stakeholder=1

**Fast-Path Check**: TimePressure=3 (no RTR fast-path)

```
ToT  = (5*0.35) + (5*0.30) + (3*0.20) + ((6-2)*0.15) = 1.75 + 1.50 + 0.60 + 0.60 = 4.45
BoT  = ((6-3)*0.35) + ((6-5)*0.30) + ((6-5)*0.20) + (2*0.15) = 1.05 + 0.30 + 0.20 + 0.30 = 1.85
SRC  = (4*0.45) + (5*0.25) + (5*0.20) + ((6-1)*0.10) = 1.80 + 1.25 + 1.00 + 0.50 = 4.55
HE   = (5*0.40) + (5*0.30) + ((6-2)*0.20) + ((6-1)*0.10) = 2.00 + 1.50 + 0.80 + 0.50 = 4.80
AR   = 0 (SolutionExists=2 < 3)
DR   = (1*0.50) + (5*0.20) + ((6-5)*0.15) + (MIN(5,1)*0.15) = 0.50 + 1.00 + 0.15 + 0.15 = 1.80
AT   = (2*0.45) + ((6-3)*0.30) + ((6-5)*0.15) + ((6-4)*0.10) = 0.90 + 0.90 + 0.15 + 0.20 = 2.15
RTR  = (3*0.50) + (5*0.25) + (5*0.15) + ((6-2)*0.10) = 1.50 + 1.25 + 0.75 + 0.40 = 3.90
NDF  = 0 (StakeholderComplexity=1 < 3)
```

**Results**: HE=4.80, SRC=4.55, ToT=4.45, RTR=3.90, AT=2.15, BoT=1.85, DR=1.80, AR=0, NDF=0
**Selected**: HE (4.80)
**Expected**: HE
**MATCH**: YES

---

## Test Case 14: Research State of Art

**Dimensions**: Seq=1, Criteria=2, SpaceKnown=1, Single=1, Evidence=3, Opposing=3, Novelty=3, Robust=2, SolExists=1, Time=2, Stakeholder=1

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (2*0.35) + (1*0.30) + (1*0.20) + ((6-3)*0.15) = 0.70 + 0.30 + 0.20 + 0.45 = 1.65
BoT  = ((6-1)*0.35) + ((6-1)*0.30) + ((6-2)*0.20) + (3*0.15) = 1.75 + 1.50 + 0.80 + 0.45 = 4.50
SRC  = (1*0.45) + (2*0.25) + (1*0.20) + ((6-3)*0.10) = 0.45 + 0.50 + 0.20 + 0.30 = 1.45
HE   = (3*0.40) + (1*0.30) + ((6-3)*0.20) + ((6-3)*0.10) = 1.20 + 0.30 + 0.60 + 0.30 = 2.40
AR   = 0 (SolutionExists=1 < 3)
DR   = (3*0.50) + (2*0.20) + ((6-3)*0.15) + (MIN(1,3)*0.15) = 1.50 + 0.40 + 0.45 + 0.15 = 2.50
AT   = (3*0.45) + ((6-1)*0.30) + ((6-3)*0.15) + ((6-1)*0.10) = 1.35 + 1.50 + 0.45 + 0.50 = 3.80
RTR  = (2*0.50) + (1*0.25) + (3*0.15) + ((6-3)*0.10) = 1.00 + 0.25 + 0.45 + 0.30 = 2.00
NDF  = 0 (StakeholderComplexity=1 < 3)
```

**Results**: BoT=4.50, AT=3.80, DR=2.50, HE=2.40, RTR=2.00, ToT=1.65, SRC=1.45, AR=0, NDF=0
**Selected**: BoT (4.50)
**Expected**: BoT
**MATCH**: YES

---

## Test Case 15: Department Reorganization

**Dimensions**: Seq=2, Criteria=2, SpaceKnown=3, Single=4, Evidence=2, Opposing=4, Novelty=2, Robust=4, SolExists=3, Time=2, Stakeholder=5

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (2*0.35) + (4*0.30) + (3*0.20) + ((6-2)*0.15) = 0.70 + 1.20 + 0.60 + 0.60 = 3.10
BoT  = ((6-3)*0.35) + ((6-4)*0.30) + ((6-2)*0.20) + (2*0.15) = 1.05 + 0.60 + 0.80 + 0.30 = 2.75
SRC  = (2*0.45) + (2*0.25) + (4*0.20) + ((6-4)*0.10) = 0.90 + 0.50 + 0.80 + 0.20 = 2.40
HE   = (2*0.40) + (4*0.30) + ((6-2)*0.20) + ((6-4)*0.10) = 0.80 + 1.20 + 0.80 + 0.20 = 3.00
AR   = (4*0.40) + (3*0.30) + ((6-2)*0.15) + (2*0.15) = 1.60 + 0.90 + 0.60 + 0.30 = 3.40
DR   = (4*0.50) + (2*0.20) + ((6-2)*0.15) + (MIN(4,4)*0.15) = 2.00 + 0.40 + 0.60 + 0.60 = 3.60
AT   = (2*0.45) + ((6-3)*0.30) + ((6-2)*0.15) + ((6-2)*0.10) = 0.90 + 0.90 + 0.60 + 0.40 = 2.80
RTR  = (2*0.50) + (4*0.25) + (2*0.15) + ((6-2)*0.10) = 1.00 + 1.00 + 0.30 + 0.40 = 2.70
NDF  = (5*0.45) + (4*0.25) + ((6-2)*0.15) + ((6-2)*0.15) = 2.25 + 1.00 + 0.60 + 0.60 = 4.45
```

**Results**: NDF=4.45, DR=3.60, AR=3.40, ToT=3.10, HE=3.00, AT=2.80, BoT=2.75, RTR=2.70, SRC=2.40
**Selected**: NDF (4.45)
**Expected**: NDF
**MATCH**: YES

---

## Test Case 16: Design New Language Feature

**Dimensions**: Seq=3, Criteria=3, SpaceKnown=2, Single=4, Evidence=2, Opposing=3, Novelty=4, Robust=4, SolExists=2, Time=2, Stakeholder=2

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (3*0.35) + (4*0.30) + (2*0.20) + ((6-4)*0.15) = 1.05 + 1.20 + 0.40 + 0.30 = 2.95
BoT  = ((6-2)*0.35) + ((6-4)*0.30) + ((6-3)*0.20) + (4*0.15) = 1.40 + 0.60 + 0.60 + 0.60 = 3.20
SRC  = (3*0.45) + (3*0.25) + (4*0.20) + ((6-3)*0.10) = 1.35 + 0.75 + 0.80 + 0.30 = 3.20
HE   = (2*0.40) + (4*0.30) + ((6-4)*0.20) + ((6-3)*0.10) = 0.80 + 1.20 + 0.40 + 0.30 = 2.70
AR   = 0 (SolutionExists=2 < 3)
DR   = (3*0.50) + (3*0.20) + ((6-2)*0.15) + (MIN(4,3)*0.15) = 1.50 + 0.60 + 0.60 + 0.45 = 3.15
AT   = (4*0.45) + ((6-2)*0.30) + ((6-2)*0.15) + ((6-3)*0.10) = 1.80 + 1.20 + 0.60 + 0.30 = 3.90
RTR  = (2*0.50) + (4*0.25) + (2*0.15) + ((6-4)*0.10) = 1.00 + 1.00 + 0.30 + 0.20 = 2.50
NDF  = 0 (StakeholderComplexity=2 < 3)
```

**Results**: AT=3.90, BoT=3.20, SRC=3.20, DR=3.15, ToT=2.95, HE=2.70, RTR=2.50, AR=0, NDF=0
**Selected**: AT (3.90)
**Expected**: AT
**MATCH**: YES

---

## Test Case 17: Merge Conflict Resolution

**Dimensions**: Seq=3, Criteria=4, SpaceKnown=4, Single=5, Evidence=4, Opposing=5, Novelty=2, Robust=4, SolExists=3, Time=3, Stakeholder=2

**Fast-Path Check**: TimePressure=3 (no RTR fast-path)

```
ToT  = (4*0.35) + (5*0.30) + (4*0.20) + ((6-2)*0.15) = 1.40 + 1.50 + 0.80 + 0.60 = 4.30
BoT  = ((6-4)*0.35) + ((6-5)*0.30) + ((6-4)*0.20) + (2*0.15) = 0.70 + 0.30 + 0.40 + 0.30 = 1.70
SRC  = (3*0.45) + (4*0.25) + (5*0.20) + ((6-5)*0.10) = 1.35 + 1.00 + 1.00 + 0.10 = 3.45
HE   = (4*0.40) + (5*0.30) + ((6-2)*0.20) + ((6-5)*0.10) = 1.60 + 1.50 + 0.80 + 0.10 = 4.00
AR   = (4*0.40) + (3*0.30) + ((6-2)*0.15) + (4*0.15) = 1.60 + 0.90 + 0.60 + 0.60 = 3.70
DR   = (5*0.50) + (4*0.20) + ((6-4)*0.15) + (MIN(5,5)*0.15) = 2.50 + 0.80 + 0.30 + 0.75 = 4.35
AT   = (2*0.45) + ((6-4)*0.30) + ((6-4)*0.15) + ((6-3)*0.10) = 0.90 + 0.60 + 0.30 + 0.30 = 2.10
RTR  = (3*0.50) + (5*0.25) + (4*0.15) + ((6-2)*0.10) = 1.50 + 1.25 + 0.60 + 0.40 = 3.75
NDF  = 0 (StakeholderComplexity=2 < 3)
```

**Results**: DR=4.35, ToT=4.30, HE=4.00, RTR=3.75, AR=3.70, SRC=3.45, AT=2.10, BoT=1.70, NDF=0
**Selected**: DR (4.35)
**Expected**: DR
**MATCH**: YES

---

## Test Case 18: Customer Emergency Escalation

**Dimensions**: Seq=3, Criteria=4, SpaceKnown=3, Single=5, Evidence=4, Opposing=1, Novelty=2, Robust=2, SolExists=2, Time=5, Stakeholder=2

**Fast-Path Check**: TimePressure=5 --> RTR FAST-PATH TRIGGERED

```
ToT  = (4*0.35) + (5*0.30) + (3*0.20) + ((6-2)*0.15) = 1.40 + 1.50 + 0.60 + 0.60 = 4.10
BoT  = ((6-3)*0.35) + ((6-5)*0.30) + ((6-4)*0.20) + (2*0.15) = 1.05 + 0.30 + 0.40 + 0.30 = 2.05
SRC  = (3*0.45) + (4*0.25) + (5*0.20) + ((6-1)*0.10) = 1.35 + 1.00 + 1.00 + 0.50 = 3.85
HE   = (4*0.40) + (5*0.30) + ((6-2)*0.20) + ((6-1)*0.10) = 1.60 + 1.50 + 0.80 + 0.50 = 4.40
AR   = 0 (SolutionExists=2 < 3)
DR   = (1*0.50) + (4*0.20) + ((6-4)*0.15) + (MIN(5,1)*0.15) = 0.50 + 0.80 + 0.30 + 0.15 = 1.75
AT   = (2*0.45) + ((6-3)*0.30) + ((6-4)*0.15) + ((6-3)*0.10) = 0.90 + 0.90 + 0.30 + 0.30 = 2.40
RTR  = (5*0.50) + (5*0.25) + (4*0.15) + ((6-2)*0.10) = 2.50 + 1.25 + 0.60 + 0.40 = 4.75
NDF  = 0 (StakeholderComplexity=2 < 3)
```

**Results**: RTR=4.75 (FAST-PATH), HE=4.40, ToT=4.10, SRC=3.85, AT=2.40, BoT=2.05, DR=1.75, AR=0, NDF=0
**Selected**: RTR (4.75 + fast-path)
**Expected**: RTR
**MATCH**: YES

---

## Test Case 19: Mathematical Proof Review

**Dimensions**: Seq=5, Criteria=5, SpaceKnown=4, Single=5, Evidence=4, Opposing=1, Novelty=2, Robust=5, SolExists=4, Time=2, Stakeholder=1

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (5*0.35) + (5*0.30) + (4*0.20) + ((6-2)*0.15) = 1.75 + 1.50 + 0.80 + 0.60 = 4.65
BoT  = ((6-4)*0.35) + ((6-5)*0.30) + ((6-5)*0.20) + (2*0.15) = 0.70 + 0.30 + 0.20 + 0.30 = 1.50
SRC  = (5*0.45) + (5*0.25) + (5*0.20) + ((6-1)*0.10) = 2.25 + 1.25 + 1.00 + 0.50 = 5.00
HE   = (4*0.40) + (5*0.30) + ((6-2)*0.20) + ((6-1)*0.10) = 1.60 + 1.50 + 0.80 + 0.50 = 4.40
AR   = (5*0.40) + (4*0.30) + ((6-2)*0.15) + (4*0.15) = 2.00 + 1.20 + 0.60 + 0.60 = 4.40
DR   = (1*0.50) + (5*0.20) + ((6-4)*0.15) + (MIN(5,1)*0.15) = 0.50 + 1.00 + 0.30 + 0.15 = 1.95
AT   = (2*0.45) + ((6-4)*0.30) + ((6-4)*0.15) + ((6-5)*0.10) = 0.90 + 0.60 + 0.30 + 0.10 = 1.90
RTR  = (2*0.50) + (5*0.25) + (4*0.15) + ((6-2)*0.10) = 1.00 + 1.25 + 0.60 + 0.40 = 3.25
NDF  = 0 (StakeholderComplexity=1 < 3)
```

**Results**: SRC=5.00, ToT=4.65, HE=4.40, AR=4.40, RTR=3.25, DR=1.95, AT=1.90, BoT=1.50, NDF=0
**Selected**: SRC (5.00)
**Expected**: SRC
**MATCH**: YES

---

## Test Case 20: API Deprecation Strategy

**Dimensions**: Seq=3, Criteria=3, SpaceKnown=4, Single=4, Evidence=3, Opposing=4, Novelty=2, Robust=4, SolExists=3, Time=2, Stakeholder=4

**Fast-Path Check**: TimePressure=2 (no RTR fast-path)

```
ToT  = (3*0.35) + (4*0.30) + (4*0.20) + ((6-2)*0.15) = 1.05 + 1.20 + 0.80 + 0.60 = 3.65
BoT  = ((6-4)*0.35) + ((6-4)*0.30) + ((6-3)*0.20) + (2*0.15) = 0.70 + 0.60 + 0.60 + 0.30 = 2.20
SRC  = (3*0.45) + (3*0.25) + (4*0.20) + ((6-4)*0.10) = 1.35 + 0.75 + 0.80 + 0.20 = 3.10
HE   = (3*0.40) + (4*0.30) + ((6-2)*0.20) + ((6-4)*0.10) = 1.20 + 1.20 + 0.80 + 0.20 = 3.40
AR   = (4*0.40) + (3*0.30) + ((6-2)*0.15) + (3*0.15) = 1.60 + 0.90 + 0.60 + 0.45 = 3.55
DR   = (4*0.50) + (3*0.20) + ((6-3)*0.15) + (MIN(4,4)*0.15) = 2.00 + 0.60 + 0.45 + 0.60 = 3.65
AT   = (2*0.45) + ((6-4)*0.30) + ((6-3)*0.15) + ((6-3)*0.10) = 0.90 + 0.60 + 0.45 + 0.30 = 2.25
RTR  = (2*0.50) + (4*0.25) + (3*0.15) + ((6-2)*0.10) = 1.00 + 1.00 + 0.45 + 0.40 = 2.85
NDF  = (4*0.45) + (4*0.25) + ((6-3)*0.15) + ((6-2)*0.15) = 1.80 + 1.00 + 0.45 + 0.60 = 3.85
```

**Results**: NDF=3.85, ToT=3.65, DR=3.65, AR=3.55, HE=3.40, SRC=3.10, RTR=2.85, AT=2.25, BoT=2.20
**Selected**: NDF (3.85)
**Expected**: NDF
**MATCH**: YES

---

## Summary Results Table

| # | Problem | Expected | Selected | Score | Match |
|---|---------|----------|----------|-------|-------|
| 1 | Debug memory leak | HE | HE | 4.80 | YES |
| 2 | Choose tech stack | ToT | ToT | 4.65 | YES |
| 3 | Production outage | RTR | RTR | 4.75 | YES |
| 4 | Explore ML approaches | BoT | AT | 4.00 | NO |
| 5 | Team conflict | NDF | DR | 4.15 | PARTIAL |
| 6 | Monolith vs microservices | DR | DR | 4.15 | YES |
| 7 | Novel AI ethics policy | AT | AT | 4.90 | YES |
| 8 | Prove algorithm correctness | SRC | SRC | 5.00 | YES |
| 9 | Security audit | AR | AR | 4.40 | YES |
| 10 | Simple API endpoint | Direct | BoT | 3.55 | NO |
| 11 | Database query optimization | HE | HE | 4.80 | YES |
| 12 | Vendor selection | ToT | ToT | 5.00 | YES |
| 13 | Critical bug (non-emergency) | HE | HE | 4.80 | YES |
| 14 | Research state of art | BoT | BoT | 4.50 | YES |
| 15 | Department reorganization | NDF | NDF | 4.45 | YES |
| 16 | Design new language feature | AT | AT | 3.90 | YES |
| 17 | Merge conflict resolution | DR | DR | 4.35 | YES |
| 18 | Customer emergency | RTR | RTR | 4.75 | YES |
| 19 | Mathematical proof review | SRC | SRC | 5.00 | YES |
| 20 | API deprecation strategy | NDF | NDF | 3.85 | YES |

**Total**: 17 exact matches + 1 partial + 2 mismatches out of 20 test cases
