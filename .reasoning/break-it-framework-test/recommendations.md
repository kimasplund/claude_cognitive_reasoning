# Recommendations for Cognitive Framework Hardening

**Target**: Cognitive Skills Framework
**Date**: 2026-01-18
**Based On**: Vulnerability Report and Attack Scenarios

---

## Executive Summary

This document provides prioritized recommendations to address the 24 identified vulnerabilities across the cognitive framework. Recommendations are organized by urgency and effort.

**Quick Reference**:
- **Immediate** (Before Production): 6 items
- **Short-Term** (Next Sprint): 8 items
- **Medium-Term** (Next Quarter): 6 items
- **Long-Term** (Backlog): 4 items

---

## Immediate Actions (Critical/High Priority)

### REC-001: Enforce Confidence Cap in Formula

**Addresses**: VULN-001 (Confidence Boundary Violation)
**Effort**: Low (Documentation change)
**Priority**: P0 - Immediate

**Current State**:
```markdown
Final Confidence = MAX(X, Y, Z) + 5%
Cap at 95%
```

**Recommended Change**:
```markdown
Final Confidence = MIN(MAX(X, Y, Z) + 5%, 95%)
```

**Action Items**:
1. Update IR-v2 SKILL.md line 461 to include MIN() in formula
2. Update pseudo-code at line 614 to match (already correct)
3. Add validation test: Assert final confidence <= 95%

**File**: `/portfolio/cognitive-skills/integrated-reasoning-v2/SKILL.md`

---

### REC-002: Add Pattern Oscillation Detection

**Addresses**: VULN-002 (Ralph-Loop Infinite Loop)
**Effort**: Medium (Logic addition)
**Priority**: P0 - Immediate

**Current State**:
- Max switches: 2
- Cooldown: 1 iteration
- No oscillation detection

**Recommended Change**:

Add to ralph-loop-integration/SKILL.md in "Switch Safeguards" section:

```markdown
### Oscillation Detection

**Definition**: Oscillation occurs when pattern A switches to B, then B switches back to A.

**Detection Rule**:
If pattern_history[-1].to_pattern == pattern_history[-3].from_pattern:
  → Oscillation detected

**Response to Oscillation**:
1. Log warning: "Pattern oscillation detected: {A} -> {B} -> {A}"
2. Force remaining iterations to use LAST selected pattern (no more switches)
3. Add -10% confidence penalty for oscillation uncertainty
4. Document in final output: "Analysis showed uncertainty between patterns"

**Alternative Response** (if oscillation at iteration 2):
Force "Direct Analysis" mode for remaining iterations
```

**File**: `/portfolio/cognitive-skills/ralph-loop-integration/SKILL.md`

---

### REC-003: Add Handover Cycle Detection

**Addresses**: VULN-003 (Circular Handover Chain)
**Effort**: Medium (Validation logic)
**Priority**: P0 - Immediate

**Recommended Addition** to reasoning-handover-protocol/SKILL.md:

```markdown
## Cycle Prevention

### Cycle Detection Rule

Before writing a new handover file:
1. Read manifest.json pattern_history
2. Extract all (from_pattern, to_pattern) pairs
3. Check if new handover creates a cycle:
   - If (new_from, new_to) already exists → Potential cycle
   - If new_to appears earlier in sequence → Cycle confirmed

### Cycle Response Options

**Option A: Block and Warn** (Default)
- Do not write handover
- Return error: "Cycle detected: {pattern} already visited"
- Require user decision: Continue or abort

**Option B: Allow with Limit**
- Allow cycle but increment cycle_count
- If cycle_count > 2: Block further cycles
- Apply -15% confidence penalty per cycle

**Option C: Force Synthesis**
- On cycle detection, force immediate synthesis
- Combine findings from all patterns in cycle
- Exit session with current best answer

### Configuration

```json
{
  "handover_settings": {
    "cycle_detection": true,
    "cycle_response": "block_and_warn",
    "max_cycles_allowed": 2,
    "max_handovers_per_session": 10
  }
}
```
```

**File**: `/portfolio/cognitive-skills/reasoning-handover-protocol/SKILL.md`

---

### REC-004: Document All-Dimensions-Equal Edge Cases

**Addresses**: VULN-004, VULN-011, VULN-012
**Effort**: Low (Documentation)
**Priority**: P1 - High

**Add to IR-v2 SKILL.md** after Step 2 (Pattern Selection):

```markdown
### Edge Case: Dimension Score Uniformity

**All Dimensions = 3 (Maximum Ambiguity)**:
When all dimensions score exactly 3, all patterns produce identical scores (3.0).

**Interpretation**: Problem characteristics are genuinely uncertain.

**Action**:
1. Use "Direct Analysis" - no specialized pattern needed
2. OR: Gather more information to differentiate dimensions
3. OR: If time permits, run 2-3 patterns in parallel and compare

**All Dimensions = 1 (Everything Low)**:
All patterns score ~1.0, below the 2.5 threshold.

**Interpretation**: Problem is simple or poorly defined.

**Action**: Use Direct Analysis or request problem clarification.

**All Dimensions = 5 (Everything Critical)**:
RTR auto-triggers due to TimePressure = 5.

**Warning**: If other dimensions are also 5 (high complexity), RTR may be inappropriate.

**Override**: If complexity dimensions (Novelty, OpposingViews, Robustness) are 4+,
require explicit confirmation before using RTR fast-path.
```

---

### REC-005: Add Confidence Floor Enforcement

**Addresses**: VULN-007 (Negative Confidence)
**Effort**: Low (Documentation)
**Priority**: P1 - High

**Update** handover-templates.md Confidence Transfer Rules:

```markdown
### Confidence Bounds (ALWAYS ENFORCED)

**Ceiling**: 95% (never exceed, even with boosts)
**Floor**: 10% (never go below, even with penalties)

**Application Order**:
1. Calculate raw confidence from pattern
2. Apply all adjustments (scope, backtracks, agreement, etc.)
3. Apply floor: `final = max(calculated, 10%)`
4. Apply ceiling: `final = min(final, 95%)`

**If calculated < 20%**:
- Flag for review
- Recommend problem decomposition
- Consider: Is the problem well-defined?
```

---

### REC-006: Add Parallel Branch Completion Markers

**Addresses**: VULN-006 (Race Condition in Merge)
**Effort**: Medium (Protocol addition)
**Priority**: P1 - High

**Add to** parallel-execution/SKILL.md:

```markdown
### Branch Completion Protocol

**Completion Marker**: Each branch writes a `COMPLETE` file when finished.

```
branch-001/
├── findings.md
├── confidence.json
└── COMPLETE          # Empty file indicating completion
```

**Merge Phase Protocol**:
1. Wait for ALL branches to have COMPLETE marker OR timeout
2. If timeout: Log which branches incomplete, merge available results
3. Calculate integrity hash of each branch before reading
4. Store hashes in merge-result.md for audit

**Atomic Write Pattern**:
1. Write to temp file: branch-001/findings.md.tmp
2. Rename to final: branch-001/findings.md
3. Write COMPLETE marker last

**Configuration**:
```json
{
  "parallel_settings": {
    "require_completion_markers": true,
    "incomplete_branch_handling": "merge_available",
    "integrity_hashing": true
  }
}
```
```

---

## Short-Term Actions (High/Medium Priority)

### REC-007: Add Schema Validation Error Handling

**Addresses**: VULN-008 (Handover Schema Violation)
**Effort**: Medium
**Priority**: P2

**Add to** reasoning-handover-protocol/SKILL.md:

```markdown
### Schema Validation Error Handling

**On Schema Validation Failure**:

1. **Log Error**:
   - File path
   - Expected schema
   - Actual value type
   - Field that failed

2. **Recovery Options** (configurable):

   a. `abort`: End session, require manual intervention
   b. `fallback`: Use Direct Analysis for remainder
   c. `retry`: Request handover re-write from source pattern
   d. `partial`: Use valid fields, ignore invalid ones

3. **Default**: `fallback` (safest, avoids data loss)

4. **Notification**: Alert user that handover failed
```

---

### REC-008: Improve Plateau Detection Algorithm

**Addresses**: VULN-009 (False Positive Plateau)
**Effort**: Medium
**Priority**: P2

**Replace current plateau detection** in ralph-loop-integration/SKILL.md:

```markdown
### Improved Plateau Detection

**Old Rule** (problematic):
3 consecutive iterations with delta < 2% each

**New Rule**:
Total improvement over 3-iteration window < 3% cumulative

**Example**:
| Iter | Confidence | Delta | Cumulative (3-window) | Plateau? |
|------|------------|-------|-----------------------|----------|
| 1 | 70% | - | - | No |
| 2 | 71% | +1% | - | No |
| 3 | 72.5% | +1.5% | 2.5% (iters 1-3) | No |
| 4 | 73% | +0.5% | 3% (iters 2-4) | No |
| 5 | 73.5% | +0.5% | 2.5% (iters 3-5) | YES |

**Additional Rule**: If within 5% of target, ignore plateau detection.
(Near-target: continue even with small improvements)
```

---

### REC-009: Add State File Rotation

**Addresses**: VULN-010 (Memory Exhaustion)
**Effort**: Medium
**Priority**: P2

**Add to** ralph-loop-integration/SKILL.md:

```markdown
### State File Management

**Active State Limit**: Keep only last 5 sessions in active state file

**Archival Protocol**:
1. On session completion, move to archive
2. Archive location: `.claude/ralph-loop-archive/`
3. Archive format: `session-{uuid}-{date}.md`
4. Retain archives for 30 days, then delete

**File Size Limit**:
- Max state file size: 500KB
- If exceeded: Archive oldest sessions automatically
- Log warning when approaching limit (80%)

**Configuration**:
```json
{
  "state_management": {
    "max_active_sessions": 5,
    "archive_completed": true,
    "archive_retention_days": 30,
    "max_state_file_kb": 500
  }
}
```
```

---

### REC-010: Add Pattern Timeout Limits

**Addresses**: VULN-016 (Individual Pattern Timeout)
**Effort**: Low
**Priority**: P2

**Add to** parallel-execution/SKILL.md:

```markdown
### Per-Pattern Timeout

**In addition to** max_total_time_minutes (session-level):

```json
{
  "pattern_timeouts": {
    "BoT": 15,      // minutes per BoT execution
    "ToT": 20,      // minutes per ToT execution
    "HE": 15,
    "SRC": 10,
    "AR": 15,
    "DR": 10,
    "AT": 10,
    "RTR": 5,       // RTR should be fast
    "NDF": 20
  }
}
```

**On Timeout**:
1. Save current state to checkpoint
2. Return partial results with confidence penalty (-10%)
3. Log timeout for review
```

---

### REC-011: Add Evidence Budget Limits

**Addresses**: VULN-018 (No Maximum for Evidence)
**Effort**: Low
**Priority**: P2

**Add to** hypothesis-elimination skill:

```markdown
### Evidence Gathering Budget

**Per-Hypothesis Limit**: Max 5 evidence items per hypothesis
**Session Limit**: Max 30 evidence items total

**On Limit Reached**:
1. Evaluate current evidence
2. Make best determination with available data
3. Document "evidence budget exhausted" in report
```

---

### REC-012: Add Skill Execution Tracing

**Addresses**: VULN-015 (Agent Skill Loading Not Verified)
**Effort**: Medium
**Priority**: P2

**Add to** INTEGRATION_GUIDE.md:

```markdown
### Skill Execution Verification

**Requirement**: Agents claiming skill integration MUST include skill markers in output.

**Skill Execution Marker Format**:
```
[SKILL:hypothesis-elimination:HEDAM-H] Generated 12 hypotheses
[SKILL:hypothesis-elimination:HEDAM-E] Prioritized 8 evidence sources
[SKILL:adversarial-reasoning:STRIKE-T] Applied STRIDE+ threat model
```

**Verification Check**:
- Output MUST contain at least one [SKILL:*] marker per claimed skill
- If marker missing: Skill not actually applied
- Confidence penalty: -10% for each claimed-but-unused skill

**Audit Trail**: Log all skill markers for post-hoc verification
```

---

### REC-013: Standardize Confidence Notation

**Addresses**: VULN-020 (Percentage vs Decimal)
**Effort**: Low
**Priority**: P3

**Add to** all skill documents:

```markdown
### Confidence Notation Standard

**Internal Calculations**: Use decimals (0.85)
**User-Facing Output**: Use percentages (85%)
**Storage (JSON)**: Use decimals (0.85)

**Never mix in same context**
```

---

### REC-014: Add Emergency Mode Confirmation

**Addresses**: Attack Scenario 8 (False Emergency Mode)
**Effort**: Low
**Priority**: P3

**Add to** IR-v2 SKILL.md:

```markdown
### Emergency Mode Safeguard

**When TimePressure = 5** AND **any of**:
- Novelty >= 4
- OpposingViews >= 4
- Robustness >= 4
- StakeholderComplexity >= 4

**Require Confirmation**:
"High complexity detected alongside time pressure.
RTR will provide quick decision but may miss nuances.
Confirm: Use RTR (Y) or override with deeper analysis (N)?"
```

---

## Medium-Term Actions (Next Quarter)

### REC-015: Implement Evidence Integrity Hashing

**Addresses**: Attack Scenario 6 (Evidence Tampering)
**Effort**: High
**Priority**: P2

**Implementation**:
1. Hash each evidence file on gather (SHA-256)
2. Store hash in evidence index
3. Verify hash on every evidence reference
4. Alert on hash mismatch

---

### REC-016: Add Checkpoint Signature Verification

**Addresses**: Attack Scenario 10 (Checkpoint Corruption)
**Effort**: High
**Priority**: P2

**Implementation**:
1. Generate session key on session start
2. Sign checkpoint integrity_check with session key
3. Verify signature on checkpoint load
4. Reject unsigned/invalid checkpoints

---

### REC-017: Build Automated Test Suite

**Addresses**: Multiple vulnerabilities
**Effort**: High
**Priority**: P2

**Test Categories**:
1. **Boundary Tests**: All formula edge cases
2. **Integration Tests**: Full pattern chains
3. **Chaos Tests**: Random input fuzzing
4. **Security Tests**: Attack scenario simulations

---

### REC-018: Add Version Compatibility Matrix

**Addresses**: VULN-023 (No Compatibility Matrix)
**Effort**: Medium
**Priority**: P3

**Create**: `cognitive-skills/COMPATIBILITY.md`

```markdown
# Skill Version Compatibility

| Skill A | Version | Skill B | Version | Compatible |
|---------|---------|---------|---------|------------|
| IR-v2 | 2.1 | Handover | 1.0 | Yes |
| Ralph | 1.0 | IR-v2 | 2.0 | No (needs 2.1) |
| ... | ... | ... | ... | ... |
```

---

### REC-019: Implement Archive Enforcement

**Addresses**: VULN-024 (Archive Policy Not Enforced)
**Effort**: Medium
**Priority**: P3

**Implementation**:
1. Add cleanup script
2. Run on session start
3. Archive sessions > 30 days old
4. Delete archives > 90 days old

---

### REC-020: Add DR Formula Clarification

**Addresses**: VULN-017 (MIN() Usage)
**Effort**: Low
**Priority**: P3

**Update DR formula documentation**:

```markdown
**DR Formula Explanation**:
MIN(SingleAnswer, OpposingViews) × 0.15

**Rationale**: DR is most valuable when BOTH:
- Single answer is needed (high SingleAnswer)
- Opposing views exist (high OpposingViews)

If OpposingViews is low, there's no tension to resolve (DR not needed).
If SingleAnswer is low, multiple answers are acceptable (no synthesis needed).

MIN() captures that DR needs BOTH conditions.
```

---

## Long-Term Actions (Backlog)

### REC-021: Formal Verification of Formula Properties

**Effort**: Very High
**Priority**: P4

Mathematically prove:
- No formula can produce negative scores
- All formulas bounded [0, 5]
- Distinct dimension profiles produce distinct rankings

---

### REC-022: Runtime Skill Loading Framework

**Effort**: Very High
**Priority**: P4

Build actual skill loading mechanism:
- Parse skill files at runtime
- Validate agent claims against loaded skills
- Inject skill prompts into agent context

---

### REC-023: Distributed Session State

**Effort**: Very High
**Priority**: P4

For production deployments:
- Session state in distributed store
- Concurrent session safety
- Cross-node handovers

---

### REC-024: Machine-Readable Skill Definitions

**Effort**: High
**Priority**: P4

Convert skills from markdown to structured format:
- JSON Schema for each skill
- Automated validation
- Tooling integration

---

## Implementation Priority Matrix

| Priority | Count | Effort (Total) | Timeline |
|----------|-------|----------------|----------|
| P0 (Immediate) | 6 | ~2 days | This week |
| P1 (High) | 2 | ~1 day | This week |
| P2 (Medium) | 6 | ~1 week | Next sprint |
| P3 (Lower) | 6 | ~1 week | Next month |
| P4 (Backlog) | 4 | ~2 months | Next quarter+ |

---

## Quick Wins (< 1 Hour Each)

1. Add MIN() to confidence formula in IR-v2 (REC-001)
2. Document all-dimensions-equal edge cases (REC-004)
3. Add confidence floor/ceiling statement (REC-005)
4. Standardize confidence notation (REC-013)
5. Add DR formula clarification (REC-020)

**Total Quick Win Effort**: ~3 hours
**Total Quick Win Impact**: 5 vulnerabilities addressed

---

## Verification Checklist

After implementing recommendations, verify:

- [ ] Confidence never exceeds 95% (test with multi-pattern agreement)
- [ ] Confidence never goes below 10% (test with max penalties)
- [ ] Oscillation A->B->A is detected and handled
- [ ] Handover cycles are detected and blocked
- [ ] All dimensions = 3 produces actionable guidance
- [ ] Parallel branches use completion markers
- [ ] Schema validation failures are handled gracefully
- [ ] Plateau detection uses cumulative window
- [ ] State files are rotated
- [ ] Per-pattern timeouts are enforced
- [ ] Evidence gathering has budget limits
- [ ] Skill execution is traced in output
- [ ] Emergency mode requires confirmation when complexity is high

---

## Conclusion

The cognitive framework is well-designed but has edge cases and integration gaps that could cause issues in production. The 24 identified vulnerabilities are addressable with focused effort.

**Highest ROI**: Implementing REC-001 through REC-006 (the P0/P1 items) would address all 3 Critical and 4 High severity vulnerabilities with approximately 3 days of work.

**Recommendation**: Treat this as a pre-production hardening phase. Address P0 items before any high-stakes usage of the framework.
