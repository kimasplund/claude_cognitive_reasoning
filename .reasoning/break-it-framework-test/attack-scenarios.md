# Attack Scenarios for Cognitive Framework

**Target**: Cognitive Skills Framework
**Date**: 2026-01-18
**Methodology**: STRIKE Framework Attack Path Development

---

## Scenario 1: Confidence Inflation Attack

**Attack Name**: Multi-Pattern Confidence Pump
**Category**: Logic Manipulation
**Impact**: 5 (False high-confidence recommendations ship with bugs)
**Feasibility**: 4 (Easy to construct problematic inputs)
**Risk Score**: 20 (Critical)

### Attacker Profile
- **Motivation**: Gaming the system to get "approved" recommendations
- **Resources**: Understanding of IR-v2 formulas
- **Method**: Craft problem dimensions that maximize agreement-based confidence boosting

### Attack Sequence

1. **Reconnaissance**: Read IR-v2 confidence aggregation rules
   - Note: Full agreement adds +5%
   - Note: Cap at 95% is mentioned but not enforced in formula text

2. **Weaponization**: Design problem that triggers parallel pattern execution
   - Score dimensions to get BoT and AT within 0.3 of each other
   - Both patterns will run in parallel

3. **Delivery**: Submit problem to framework
   ```
   Problem: "Design a caching strategy"
   Dimensions scored to trigger BoT || AT parallel execution
   ```

4. **Exploitation**: Both patterns converge on similar answer (likely given same problem)
   - BoT finds: "Redis caching" at 78%
   - AT finds: "Redis caching (like CDN analogy)" at 80%
   - Full agreement: max(78, 80) + 5% = 85%

5. **Escalation**: Chain multiple pattern agreements
   - Add ToT after BoT+AT merge
   - If ToT also agrees: Can we add another +5%?
   - The spec doesn't say we CAN'T...

6. **Action on Objective**:
   - Claim "95%+ confidence" through stacked boosts
   - Recommendation ships without proper validation
   - Actual solution has bugs not caught due to false confidence

### Detection Opportunities
- Track confidence deltas across handovers
- Flag any session reaching >90% without AR validation

### Current Mitigations (Gaps)
- 95% cap mentioned but not enforced in formula
- Shared assumption discount exists (-5%) but only applied once

### Recommended Countermeasures
1. **Prevention**: Inline cap in formula: `MIN(MAX(X,Y,Z) + 5%, 95%)`
2. **Prevention**: Require AR for any claim >85%
3. **Detection**: Log and review any session with >3 pattern agreements
4. **Response**: Mandatory cool-down before shipping >90% recommendations

---

## Scenario 2: Ralph-Loop Resource Exhaustion

**Attack Name**: Pattern Oscillation DoS
**Category**: Denial of Service
**Impact**: 4 (Session never completes, resources wasted)
**Feasibility**: 3 (Requires specific dimension scoring patterns)
**Risk Score**: 12 (Medium-High)

### Attacker Profile
- **Motivation**: Cause framework to consume excessive resources
- **Resources**: Understanding of pattern switching triggers
- **Method**: Craft inputs that cause continuous pattern switches

### Attack Sequence

1. **Reconnaissance**: Analyze pattern switch triggers
   - Switch triggers on delta < 5% for 2 iterations
   - IR-v2 re-scoring happens after trigger
   - Max 2 switches per session

2. **Weaponization**: Design problem with oscillating dimension scores
   ```
   Initial: ToT = 4.2, HE = 4.0
   After Iteration 1 (new info): ToT = 3.8, HE = 4.3 (switch to HE)
   After Iteration 2 (more info): ToT = 4.1, HE = 3.9 (switch back to ToT)
   ```

3. **Delivery**: Submit genuinely ambiguous problem
   - Real-world problems CAN have oscillating characteristics
   - Not necessarily malicious - could be accidental

4. **Exploitation**:
   - Iteration 1: ToT, low improvement
   - Switch to HE (switch count: 1)
   - Iteration 2: HE, low improvement
   - Switch back to ToT (switch count: 2) - max reached
   - Iteration 3: ToT, still low improvement
   - Can't switch, but ToT keeps failing
   - Repeat until MAX_ITERATIONS (5)

5. **Resource Consumption**:
   - 5 iterations at 50,000 tokens each = 250,000 tokens
   - Handover state accumulates for each switch
   - No useful output produced

### Detection Opportunities
- Monitor for A->B->A pattern in switch history
- Alert on 2 switches within 3 iterations

### Current Mitigations (Gaps)
- Max switches = 2 (but doesn't prevent A->B->A)
- Cooldown of 1 iteration (not sufficient)

### Recommended Countermeasures
1. **Prevention**: Detect oscillation (A->B->A counts as failure mode)
2. **Prevention**: Exponential backoff on switch cooldown
3. **Detection**: Flag sessions with 2 switches in short succession
4. **Response**: Force "Direct Analysis" mode after oscillation detected

---

## Scenario 3: Circular Handover Infinite Loop

**Attack Name**: Handover Cycle Attack
**Category**: Logic Loop / DoS
**Impact**: 5 (Infinite loop, potential disk exhaustion)
**Feasibility**: 3 (Requires specific pattern chain)
**Risk Score**: 15 (High)

### Attacker Profile
- **Motivation**: Cause session to never terminate
- **Resources**: Understanding of handover protocol
- **Method**: Create legitimate-seeming cycle in pattern chain

### Attack Sequence

1. **Setup**: Design problem requiring multiple patterns
   ```
   "Design and validate a security architecture"
   Natural flow: BoT -> ToT -> AR
   ```

2. **Initial Execution**:
   - BoT explores: 8 approaches
   - ToT optimizes: Selects JWT approach
   - AR validates: Finds CRITICAL vulnerability

3. **Trigger Cycle**: AR recommendation causes loop
   ```
   AR Output: "Critical vulnerability in JWT approach.
   Recommendation: Use BoT to explore alternative
   authentication architectures (not JWT-based)"
   ```

4. **Loop Begins**:
   - Handover: AR -> BoT (CYCLE STARTS)
   - BoT re-explores: 8 new approaches
   - ToT re-optimizes: Selects OAuth approach
   - AR re-validates: Finds different vulnerability
   - AR recommends: "Explore alternatives again"
   - Handover: AR -> BoT (CYCLE CONTINUES)

5. **Resource Exhaustion**:
   - Each cycle: ~60 minutes, ~100k tokens
   - Handover files: 001, 002, 003, ... growing
   - Evidence repository: Accumulating
   - Session never ends

### Detection Opportunities
- Track (from_pattern, to_pattern) pairs
- Detect same transition appearing twice

### Current Mitigations (Gaps)
- manifest.json tracks pattern_history (but no cycle check)
- No max_handovers limit specified

### Recommended Countermeasures
1. **Prevention**: Add cycle detection in orchestrator
2. **Prevention**: Max 10 handovers per session
3. **Detection**: Alert on duplicate (from, to) transitions
4. **Response**: Require user approval to continue cycle

---

## Scenario 4: Dimension Score Ambiguity Exploit

**Attack Name**: Maximum Ambiguity Input
**Category**: Decision Failure
**Impact**: 3 (Poor pattern selection, wasted effort)
**Feasibility**: 5 (Easy to score all dimensions equally)
**Risk Score**: 15 (High)

### Attack Sequence

1. **Input**: Score all 11 dimensions as 3
   ```
   Sequential Dependencies: 3
   Criteria Clarity: 3
   Solution Space Known: 3
   Single Answer Needed: 3
   Evidence Available: 3
   Opposing Valid Views: 3
   Problem Novelty: 3
   Robustness Required: 3
   Solution Exists: 3
   Time Pressure: 3
   Stakeholder Complexity: 3
   ```

2. **Formula Calculation** (all patterns):
   Due to (6-X) terms with X=3, and X terms with X=3:
   - (6-3) = 3 and 3 = 3 (identical)
   - All weights sum to 1.0
   - All patterns score exactly 3.0

3. **System Response**:
   - "Top 3 within 0.3" triggers uncertainty propagation
   - Uncertainty propagation: All patterns tie
   - No pattern can be selected
   - System paralysis

4. **Impact**:
   - User gets no recommendation
   - Or: System picks arbitrarily
   - Analysis quality degrades

### Recommended Countermeasures
1. Add tiebreaker: Pattern complexity order (simpler first)
2. Document: "All 3s = Direct Analysis"
3. Suggest: "Please provide more specific dimension scores"

---

## Scenario 5: Parallel Branch Corruption

**Attack Name**: Race Condition in Merge
**Category**: Data Integrity
**Impact**: 4 (Corrupted analysis results)
**Feasibility**: 2 (Requires precise timing)
**Risk Score**: 8 (Medium)

### Attack Sequence

1. **Setup**: Parallel BoT with 8 branches
2. **Timing Attack**:
   - Workers 1-7 complete
   - Merge phase begins reading branch-001 through branch-007
   - Worker 8 still writing to branch-008
   - Merge reads partial branch-008/findings.md
3. **Corruption**:
   - Merge synthesizes with incomplete data
   - Branch-008's valuable insight lost
   - Or: Parse error from partial JSON

### Recommended Countermeasures
1. Completion marker files (branch-008/COMPLETE)
2. Atomic writes with temp file + rename
3. Integrity hashes for all branch outputs

---

## Scenario 6: Evidence Chain Manipulation

**Attack Name**: Evidence Tampering
**Category**: Integrity
**Impact**: 4 (False conclusions from modified evidence)
**Feasibility**: 2 (Requires file system access)
**Risk Score**: 8 (Medium)

### Attack Sequence

1. **HE session in progress**: Testing hypotheses
2. **Attacker modifies**: evidence/gathered/E003-logs.txt
   - Original: "No timeout errors found"
   - Modified: "Multiple timeout errors at 14:02"
3. **HE continues**: Draws wrong conclusion based on tampered evidence
4. **Root cause**: Identified incorrectly

### Recommended Countermeasures
1. Hash all evidence on gather
2. Verify hash on evidence reference
3. Immutable evidence storage (append-only)

---

## Scenario 7: Handover Schema Injection

**Attack Name**: Malformed Handover Payload
**Category**: Input Validation
**Impact**: 3 (Pattern execution failure)
**Feasibility**: 3 (Requires control of handover write)
**Risk Score**: 9 (Medium)

### Attack Sequence

1. **Pattern A completes** and writes handover
2. **Attacker injects** malformed JSON:
   ```json
   {
     "deliverables": {
       "type": "approaches",
       "items": null,  // Expected array, got null
       "confidence_scores": "not_a_number"  // Expected object
     }
   }
   ```
3. **Pattern B attempts load**: Crash or undefined behavior

### Recommended Countermeasures
1. JSON Schema validation on read
2. Error handling with fallback to Direct Analysis
3. Log all validation failures

---

## Scenario 8: Time Pressure Override Abuse

**Attack Name**: False Emergency Mode
**Category**: Logic Bypass
**Impact**: 3 (Shallow analysis when depth needed)
**Feasibility**: 4 (Just set TimePressure = 5)
**Risk Score**: 12 (Medium-High)

### Attack Sequence

1. **User sets** TimePressure = 5 (emergency)
   - But problem is actually complex and not time-sensitive
   - Motive: Get faster response
2. **IR-v2 fast-path**: Selects RTR automatically
3. **RTR executes**: Quick decision, shallow analysis
4. **Impact**: Critical nuances missed

### Recommended Countermeasures
1. Warn when TimePressure=5 but other dimensions suggest complexity
2. Log RTR-triggering for audit
3. Require justification for emergency mode

---

## Scenario 9: Skill Loading Impersonation

**Attack Name**: Fake Skill Claim
**Category**: Trust Bypass
**Impact**: 2 (User trusts non-existent methodology)
**Feasibility**: 5 (Just write in agent definition)
**Risk Score**: 10 (Medium)

### Attack Sequence

1. **Agent definition claims**:
   ```
   **Skills Integration**: adversarial-reasoning, hypothesis-elimination
   ```
2. **Agent execution**: Never actually loads or uses AR/HE methodologies
3. **User trusts**: "This agent uses adversarial reasoning"
4. **Reality**: Ad-hoc analysis with no methodology

### Recommended Countermeasures
1. Runtime verification of skill loading
2. Skill execution traces in output
3. Confidence disclosure: "AR methodology applied: Yes/No"

---

## Scenario 10: Checkpoint Corruption Attack

**Attack Name**: Malicious Checkpoint
**Category**: Persistence Manipulation
**Impact**: 4 (Resumed session with corrupted state)
**Feasibility**: 2 (Requires file system access)
**Risk Score**: 8 (Medium)

### Attack Sequence

1. **Session paused**: Checkpoint written
2. **Attacker modifies** checkpoint-20260118-150000.json:
   - Changes winning_path to losing path
   - Modifies confidence upward
   - Removes evidence references
3. **Session resumed**: Loads corrupted checkpoint
4. **Continues from corrupted state**: Wrong conclusions

### Recommended Countermeasures
1. Validate integrity_check hashes before load
2. Signed checkpoints (with session key)
3. Checkpoint comparison on resume

---

## Attack Scenario Summary

| ID | Name | Risk Score | Mitigation Priority |
|----|------|------------|---------------------|
| 1 | Confidence Inflation | 20 | Critical |
| 2 | Pattern Oscillation DoS | 12 | High |
| 3 | Circular Handover Loop | 15 | Critical |
| 4 | Dimension Ambiguity | 15 | High |
| 5 | Parallel Branch Corruption | 8 | Medium |
| 6 | Evidence Tampering | 8 | Medium |
| 7 | Handover Schema Injection | 9 | Medium |
| 8 | False Emergency Mode | 12 | Medium |
| 9 | Skill Loading Impersonation | 10 | Medium |
| 10 | Checkpoint Corruption | 8 | Medium |

---

## Testing Matrix

| Scenario | Unit Test | Integration Test | Chaos Test |
|----------|-----------|------------------|------------|
| Confidence Inflation | Calculate formula at boundaries | Multi-pattern session | N/A |
| Pattern Oscillation | Switch counter logic | 5-iteration session | Random dimension shifts |
| Circular Handover | Cycle detection | Full chain session | Adversarial recommendations |
| Dimension Ambiguity | All-3s calculation | Pattern selection | Random dimension values |
| Branch Corruption | Completion markers | Parallel execution | Kill workers mid-write |
| Evidence Tampering | Hash validation | Evidence chain | File modification |
| Schema Injection | Schema validation | Load/save cycle | Fuzz handover JSON |
| Emergency Mode | TimePressure fast-path | RTR triggering | High TimePressure + complexity |
| Skill Impersonation | Skill presence check | Full agent run | Missing skill refs |
| Checkpoint Corruption | Hash validation | Save/resume | Modify checkpoint |
