# Reasoning Handover Protocol - Failure Modes Analysis

**Test Date**: 2026-01-18
**Protocol Version**: 1.0

---

## Overview

This document catalogs all identified failure modes in the Reasoning Handover Protocol, their likelihood, impact, and current/recommended mitigations.

---

## Failure Mode 1: Handover File Write Failure

### Description
The handover JSON file fails to write completely to disk due to timeout, disk full, permission error, or process termination.

### Likelihood: MEDIUM
- More likely on large handovers (complex BoT with many approaches)
- More likely on slow/unreliable storage
- More likely during resource contention

### Impact: HIGH
- Loss of all context transfer data
- Target pattern cannot initialize
- Session may be unrecoverable

### Current Mitigation
**NONE** - Protocol does not address this scenario

### Recommended Mitigation
```
1. Write to temporary file first
2. fsync() to ensure durability
3. Atomic rename to final location
4. Verify file exists and parses correctly
5. Only then update manifest
```

### Detection
- File does not exist after expected write
- File exists but JSON parse fails
- File size is 0 or unexpectedly small

### Recovery
1. Check if source pattern state still exists
2. Regenerate handover from source state
3. If source state lost, restore from checkpoint

---

## Failure Mode 2: Manifest Update Failure

### Description
Handover file written successfully, but manifest update fails.

### Likelihood: LOW
- Manifest is small, writes quickly
- But still possible under resource pressure

### Impact: MEDIUM
- Orphaned handover file exists
- Session tracking inconsistent
- Next pattern may not find handover

### Current Mitigation
**NONE** - Protocol does not address this scenario

### Recommended Mitigation
```
1. Implement manifest versioning (manifest.json.1, manifest.json.2)
2. Write new version before deleting old
3. Keep last N versions for rollback
4. On startup, scan for orphaned handovers and reconcile
```

### Detection
- Handover file exists in handovers/ but not in manifest.checkpoints
- pattern_history doesn't include expected entry

### Recovery
1. Scan handovers/ directory
2. Compare with manifest.pattern_history
3. Add missing entries
4. Verify chain integrity

---

## Failure Mode 3: Context Loss in Long Chains

### Description
After multiple handovers (>3), cumulative confidence discount and potential information loss degrades session quality.

### Likelihood: HIGH (for long sessions)
- Every handover loses some nuance
- Cumulative discount compounds
- Original problem framing may drift

### Impact: MEDIUM
- Confidence may drop below useful threshold
- Original constraints may be forgotten
- Final recommendation may not address original problem

### Current Mitigation
**PARTIAL** - Cumulative discount is applied, but no cap

### Recommended Mitigation
```
1. Cap cumulative confidence discount at -20%
2. Require re-reading original problem statement every 3 handovers
3. Add "original_problem_checksum" to verify drift
4. Allow human checkpoint validation on long chains
```

### Detection
- Confidence below 0.50 after chain
- Original constraints missing from latest handover
- Problem statement has semantically drifted

### Recovery
1. Return to last checkpoint with high confidence
2. Re-run from that point with explicit original problem reference
3. Consider consolidating chain into single synthesis

---

## Failure Mode 4: Contradictory Parallel Branches

### Description
Parallel patterns reach mutually exclusive conclusions that cannot be merged.

### Likelihood: MEDIUM
- More likely when problem is ambiguous
- More likely with patterns having different assumptions
- Expected in genuinely difficult decisions

### Impact: HIGH
- Session blocks (cannot proceed automatically)
- Requires human intervention
- May indicate problem is underspecified

### Current Mitigation
**PARTIAL** - NO_AGREEMENT detected, human decision flagged

### Recommended Mitigation
```
1. Before parallel execution, verify patterns share assumptions
2. Explicit assumption documentation per branch
3. Automatic DR (Dialectical Reasoning) as fallback
4. Clear escalation path to human decision
5. Provide structured decision framework, not just "please decide"
```

### Detection
- Semantic contradiction detected in merge
- Agreement type = "NO_AGREEMENT"
- Branches have opposite recommendations

### Recovery
1. Present both options with clear trade-offs
2. Identify root cause of disagreement (usually assumptions)
3. Seek stakeholder clarification on assumptions
4. Re-run with clarified assumptions

---

## Failure Mode 5: Checkpoint Corruption

### Description
Checkpoint file is corrupted or references invalid state.

### Likelihood: LOW
- Checkpoints are written atomically (if following protocol)
- Hash verification catches corruption

### Impact: HIGH
- Cannot recover session
- All work since last valid checkpoint lost
- May need to restart from beginning

### Current Mitigation
**PARTIAL** - Hash verification exists but not enforced

### Recommended Mitigation
```
1. Always verify hash before accepting checkpoint
2. Keep last 3 checkpoints (not just most recent)
3. Test checkpoint validity immediately after creation
4. Add checkpoint redundancy (write to two locations)
```

### Detection
- Hash mismatch on checkpoint read
- JSON parse failure
- Referenced files (pattern states) don't exist

### Recovery
1. Fall back to previous checkpoint
2. If all checkpoints corrupted, restart session
3. Alert user to data loss

---

## Failure Mode 6: Pattern State Inconsistency

### Description
Pattern state file and handover file have inconsistent data.

### Likelihood: LOW
- Should not happen if protocol followed
- Possible if manual edits or partial updates

### Impact: MEDIUM
- Target pattern may receive conflicting information
- May cause downstream errors
- Audit trail unreliable

### Current Mitigation
**NONE** - No validation between state and handover

### Recommended Mitigation
```
1. Add cross-reference checksums
2. Validate handover against source state before accepting
3. Add schema validation for all JSON files
4. Implement "handover test" that verifies round-trip
```

### Detection
- Confidence in handover doesn't match state
- Deliverables reference non-existent items
- Timestamps don't align

### Recovery
1. Regenerate handover from source state
2. If source state corrupted, restore from checkpoint
3. Log inconsistency for debugging

---

## Failure Mode 7: Evidence Repository Desync

### Description
Evidence index and actual evidence files are out of sync.

### Likelihood: MEDIUM
- More likely when multiple patterns write evidence
- Possible if index update fails after file write

### Impact: LOW-MEDIUM
- Evidence may not be findable
- Or index may reference missing files
- Affects audit trail completeness

### Current Mitigation
**PARTIAL** - index_update_on_gather setting exists

### Recommended Mitigation
```
1. Always update index atomically with file write
2. Periodic reconciliation (scan files vs index)
3. Add evidence file checksums to index
4. Implement evidence garbage collection
```

### Detection
- Index references file that doesn't exist
- File exists but not in index
- Evidence count mismatch

### Recovery
1. Scan evidence/gathered/ directory
2. Rebuild index from files
3. Mark missing evidence as "lost"

---

## Failure Mode 8: Infinite Loop in Handover Chain

### Description
Patterns hand off in a cycle (e.g., BoT -> ToT -> BoT -> ...) without termination.

### Likelihood: LOW
- Should be caught by IR-v2 orchestrator
- But possible with misconfigured session

### Impact: HIGH
- Session never completes
- Resources consumed indefinitely
- User waiting forever

### Current Mitigation
**NONE** - No explicit cycle detection

### Recommended Mitigation
```
1. Track pattern_history in manifest
2. Detect if same pattern appears twice (cycle)
3. Set maximum handovers per session (default: 10)
4. Require explicit override for >10 handovers
```

### Detection
- Same pattern appears multiple times in history
- Session duration exceeds max_session_duration_hours
- Handover count exceeds threshold

### Recovery
1. Alert user to potential loop
2. Force session to synthesis phase
3. Generate partial results with warning

---

## Failure Mode 9: Schema Version Mismatch

### Description
Handover file written with newer/older schema version than target pattern expects.

### Likelihood: LOW (currently)
- All patterns at v1.0
- Will increase as protocol evolves

### Impact: MEDIUM
- Parse may fail
- Required fields may be missing
- Unexpected fields may cause issues

### Current Mitigation
**MINIMAL** - $schema field exists but not enforced

### Recommended Mitigation
```
1. Enforce schema validation on all reads
2. Include schema version in manifest
3. Support schema migration (v1 -> v2)
4. Fail fast with clear error on version mismatch
```

### Detection
- $schema field doesn't match expected
- Required fields missing
- Unexpected field structure

### Recovery
1. Attempt schema migration if supported
2. Fall back to minimal handover (problem + confidence only)
3. Alert user to potential data loss

---

## Failure Mode 10: Orphaned Sessions

### Description
Session directory exists but session never completed or was abandoned.

### Likelihood: MEDIUM
- User may stop mid-session
- System crash
- Resource timeout

### Impact: LOW
- Disk space consumed
- Confusing directory listing
- Potential data recovery opportunity

### Current Mitigation
**MINIMAL** - archive_after_days=30 setting exists

### Recommended Mitigation
```
1. Mark sessions as "abandoned" after inactivity threshold
2. Implement session cleanup job
3. Before cleanup, offer recovery
4. Keep archived sessions compressed
```

### Detection
- Status != "completed" and last_updated > 24 hours ago
- No checkpoints in expected interval
- User confirms abandonment

### Recovery
1. Offer to resume session
2. If declined, archive
3. Delete after retention period

---

## Failure Mode Summary Table

| Failure Mode | Likelihood | Impact | Current Mitigation | Priority |
|--------------|------------|--------|-------------------|----------|
| File write failure | MEDIUM | HIGH | None | P0 |
| Manifest update failure | LOW | MEDIUM | None | P1 |
| Context loss in chains | HIGH | MEDIUM | Partial | P1 |
| Contradictory branches | MEDIUM | HIGH | Partial | P2 |
| Checkpoint corruption | LOW | HIGH | Partial | P1 |
| State inconsistency | LOW | MEDIUM | None | P2 |
| Evidence desync | MEDIUM | LOW | Partial | P3 |
| Infinite loop | LOW | HIGH | None | P2 |
| Schema mismatch | LOW | MEDIUM | Minimal | P3 |
| Orphaned sessions | MEDIUM | LOW | Minimal | P3 |

---

## Recommended Implementation Priority

### P0 - Critical (Implement First)
1. Atomic file writes for handovers and checkpoints
2. Write verification after all file operations

### P1 - High (Implement Second)
3. Manifest versioning and rollback
4. Checkpoint validation enforcement
5. Confidence discount cap for long chains

### P2 - Medium (Implement Third)
6. Cycle detection in handover chains
7. Schema version validation
8. Automatic DR fallback for contradictions

### P3 - Low (Implement Later)
9. Evidence repository reconciliation
10. Session cleanup automation
11. Cross-file consistency validation
