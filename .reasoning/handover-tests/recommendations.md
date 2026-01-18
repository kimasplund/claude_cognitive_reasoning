# Reasoning Handover Protocol - Recommendations

**Test Date**: 2026-01-18
**Protocol Version**: 1.0
**Based On**: Edge case testing and failure mode analysis

---

## Executive Summary

The Reasoning Handover Protocol provides a solid foundation for multi-pattern cognitive reasoning, but testing revealed critical gaps in failure recovery and edge case handling. This document provides prioritized recommendations for protocol improvements.

---

## Critical Recommendations (P0)

### 1. Implement Atomic File Operations

**Problem**: File write failures can corrupt handovers and checkpoints with no recovery path.

**Solution**:
```python
def safe_write_json(path: str, data: dict) -> bool:
    """Write JSON atomically to prevent corruption."""
    temp_path = f"{path}.tmp.{os.getpid()}"
    try:
        # Write to temp file
        with open(temp_path, 'w') as f:
            json.dump(data, f, indent=2)
            f.flush()
            os.fsync(f.fileno())  # Ensure durability

        # Atomic rename
        os.rename(temp_path, path)

        # Verify
        with open(path, 'r') as f:
            parsed = json.load(f)
            if parsed != data:
                raise IntegrityError("Write verification failed")

        return True
    except Exception as e:
        # Cleanup temp file
        if os.path.exists(temp_path):
            os.remove(temp_path)
        raise HandoverWriteError(f"Failed to write {path}: {e}")
```

**Impact**: Prevents data corruption, enables reliable recovery

### 2. Add Write Verification

**Problem**: Silent write failures are undetectable.

**Solution**: After every write operation:
1. Verify file exists
2. Verify file size > 0
3. Verify JSON parses correctly
4. Verify required fields present
5. Log verification result

**Implementation**:
```python
def verify_handover_file(path: str, expected_schema: str) -> bool:
    """Verify handover file integrity after write."""
    if not os.path.exists(path):
        return False

    with open(path, 'r') as f:
        content = f.read()
        if len(content) == 0:
            return False

        data = json.loads(content)
        if data.get('$schema') != expected_schema:
            return False

        required_fields = ['handover_id', 'timestamp', 'source_pattern', 'target_pattern']
        for field in required_fields:
            if field not in data:
                return False

    return True
```

---

## High Priority Recommendations (P1)

### 3. Cap Cumulative Confidence Discount

**Problem**: Long chains can have confidence discounted below useful levels.

**Current Behavior**:
```
Each handover: -5% discount
Chain of 5: -25% cumulative (too harsh)
```

**Recommended Behavior**:
```
Maximum cumulative discount: -20%
Formula: min(chain_length * 0.05, 0.20)
```

**Rationale**: Even long chains should retain some confidence if work was valid.

### 4. Implement Manifest Versioning

**Problem**: Manifest corruption loses session state with no recovery.

**Solution**:
```
manifest.json        <- current version
manifest.json.1      <- previous version
manifest.json.2      <- version before that
```

**Implementation**:
```python
def update_manifest(manifest: dict) -> None:
    """Update manifest with versioning."""
    # Rotate old versions
    for i in range(2, 0, -1):
        old = f"manifest.json.{i-1}" if i > 1 else "manifest.json"
        new = f"manifest.json.{i}"
        if os.path.exists(old):
            shutil.copy2(old, new)

    # Write new manifest
    safe_write_json("manifest.json", manifest)
```

### 5. Enforce Checkpoint Validation

**Problem**: Checkpoint integrity checks exist but aren't enforced.

**Solution**: Add validation step to checkpoint recovery:
```python
def restore_checkpoint(checkpoint_path: str) -> Session:
    """Restore session from checkpoint with validation."""
    with open(checkpoint_path, 'r') as f:
        checkpoint = json.load(f)

    # Validate integrity
    actual_manifest_hash = sha256_file(checkpoint['session_state']['manifest_path'])
    if actual_manifest_hash != checkpoint['integrity_check']['manifest_hash']:
        raise CheckpointCorruptionError("Manifest hash mismatch")

    actual_state_hash = sha256_file(checkpoint['pattern_snapshot']['state_path'])
    if actual_state_hash != checkpoint['integrity_check']['pattern_state_hash']:
        raise CheckpointCorruptionError("Pattern state hash mismatch")

    # Restore
    return Session.from_checkpoint(checkpoint)
```

### 6. Add Pre-Handover Checkpoint

**Problem**: Handover failure loses work since last scheduled checkpoint.

**Solution**: Automatically checkpoint before every handover:
```python
def initiate_handover(self, from_pattern: str, to_pattern: str):
    # NEW: Checkpoint before handover
    self.checkpoint(reason="pre_handover")

    # Existing handover logic
    handover_data = self.active_pattern.prepare_handover()
    # ...
```

**Impact**: Maximum data loss is one pattern's work, not 15 minutes of work.

---

## Medium Priority Recommendations (P2)

### 7. Add Cycle Detection

**Problem**: Patterns can hand off in infinite loop.

**Solution**:
```python
def validate_handover_target(self, target_pattern: str) -> bool:
    """Ensure no cycle in handover chain."""
    MAX_SAME_PATTERN = 2  # Allow pattern to appear at most twice

    pattern_counts = Counter(self.manifest['orchestration']['pattern_history'])

    if pattern_counts.get(target_pattern, 0) >= MAX_SAME_PATTERN:
        raise CycleDetectedError(
            f"Pattern {target_pattern} already appeared {MAX_SAME_PATTERN} times in chain"
        )

    return True
```

### 8. Auto-DR for Contradictions

**Problem**: NO_AGREEMENT blocks progress, requires human.

**Solution**: Before flagging for human decision, attempt DR synthesis:
```python
def merge_parallel_branches(self, branch_results: list):
    agreement = self.analyze_agreement(branch_results)

    if agreement.type == "NO_AGREEMENT":
        # NEW: Try DR synthesis first
        dr_synthesis = self.run_dialectical_reasoning(
            thesis=branch_results[0].conclusion,
            antithesis=branch_results[1].conclusion,
            context=agreement.root_cause
        )

        if dr_synthesis.confidence > 0.60:
            return dr_synthesis

        # Fall back to human decision if DR fails
        return NoAgreementResult(requires_human=True)
```

### 9. Add Schema Validation

**Problem**: Schema mismatches can cause parse errors or silent data loss.

**Solution**: Use JSON Schema validation:
```python
from jsonschema import validate, ValidationError

HANDOVER_SCHEMA = {
    "type": "object",
    "required": ["$schema", "handover_id", "timestamp", "source_pattern", "target_pattern"],
    "properties": {
        "$schema": {"const": "reasoning-handover-v1"},
        "handover_id": {"type": "string", "pattern": "^\\d{3}-[a-z]+-to-[a-z]+$"},
        # ... full schema
    }
}

def validate_handover(data: dict) -> bool:
    try:
        validate(instance=data, schema=HANDOVER_SCHEMA)
        return True
    except ValidationError as e:
        raise InvalidHandoverError(f"Schema validation failed: {e.message}")
```

---

## Low Priority Recommendations (P3)

### 10. Evidence Repository Reconciliation

**Problem**: Evidence index can desync from actual files.

**Solution**: Add reconciliation command:
```python
def reconcile_evidence(session_path: str) -> ReconciliationReport:
    """Reconcile evidence index with actual files."""
    index_path = f"{session_path}/evidence/index.json"
    gathered_path = f"{session_path}/evidence/gathered/"

    with open(index_path, 'r') as f:
        index = json.load(f)

    indexed_files = {e['file_path'] for e in index['evidence']}
    actual_files = set(os.listdir(gathered_path))

    orphaned = actual_files - indexed_files
    missing = indexed_files - actual_files

    return ReconciliationReport(
        orphaned_files=list(orphaned),
        missing_files=list(missing),
        valid_count=len(indexed_files & actual_files)
    )
```

### 11. Session Cleanup Automation

**Problem**: Orphaned sessions consume disk space.

**Solution**: Add cleanup job:
```python
def cleanup_sessions(reasoning_dir: str, max_age_days: int = 30) -> CleanupReport:
    """Archive or delete old sessions."""
    cutoff = datetime.now() - timedelta(days=max_age_days)

    for session_dir in os.listdir(f"{reasoning_dir}/sessions"):
        manifest_path = f"{reasoning_dir}/sessions/{session_dir}/manifest.json"
        with open(manifest_path, 'r') as f:
            manifest = json.load(f)

        last_updated = datetime.fromisoformat(manifest['last_updated'])

        if last_updated < cutoff:
            if manifest['status'] != 'completed':
                # Archive abandoned sessions
                archive_session(session_dir)
            else:
                # Delete completed old sessions
                shutil.rmtree(f"{reasoning_dir}/sessions/{session_dir}")
```

### 12. Cross-File Consistency Validation

**Problem**: State files, handovers, and manifest can have inconsistent data.

**Solution**: Add consistency check:
```python
def validate_session_consistency(session_path: str) -> ConsistencyReport:
    """Validate all session files are consistent."""
    errors = []

    # Load all files
    manifest = load_json(f"{session_path}/manifest.json")

    for pattern in manifest['orchestration']['pattern_history']:
        state_path = f"{session_path}/pattern-state/{pattern['pattern'].lower()}/state.json"

        if not os.path.exists(state_path):
            errors.append(f"Missing state file for {pattern['pattern']}")
            continue

        state = load_json(state_path)

        # Check confidence consistency
        if abs(state.get('current_confidence', 0) -
               manifest['confidence']['by_pattern'].get(pattern['pattern'], 0)) > 0.05:
            errors.append(f"Confidence mismatch for {pattern['pattern']}")

    return ConsistencyReport(errors=errors, is_consistent=len(errors) == 0)
```

---

## Configuration Recommendations

### Recommended Default Configuration

```json
{
  "version": "1.1",

  "session_defaults": {
    "checkpoint_interval_minutes": 15,
    "auto_checkpoint_on_handover": true,
    "auto_checkpoint_on_pattern_complete": true,
    "max_session_duration_hours": 4,
    "archive_after_days": 30,
    "max_handovers_per_session": 10
  },

  "handover_settings": {
    "validate_schema": true,
    "require_confidence_transfer": true,
    "shared_assumption_discount": 0.05,
    "max_cumulative_discount": 0.20,
    "use_atomic_writes": true,
    "verify_after_write": true
  },

  "merge_settings": {
    "auto_dr_on_no_agreement": true,
    "dr_confidence_threshold": 0.60,
    "partial_agreement_minimum_overlap": 0.50
  },

  "evidence_settings": {
    "max_evidence_file_size_mb": 10,
    "index_update_on_gather": true,
    "reconcile_on_session_load": true
  },

  "parallel_settings": {
    "max_parallel_branches": 5,
    "merge_timeout_minutes": 30,
    "require_assumption_alignment": true
  },

  "recovery_settings": {
    "keep_checkpoint_versions": 3,
    "keep_manifest_versions": 3,
    "validate_checkpoint_on_restore": true,
    "allow_partial_restore": true
  },

  "logging": {
    "log_level": "INFO",
    "log_handovers": true,
    "log_checkpoints": true,
    "log_pattern_transitions": true,
    "log_file_operations": true
  }
}
```

---

## Implementation Roadmap

### Phase 1: Critical Fixes (Week 1-2)
- [ ] Implement atomic file writes
- [ ] Add write verification
- [ ] Add pre-handover checkpoint

### Phase 2: Recovery Improvements (Week 3-4)
- [ ] Manifest versioning
- [ ] Checkpoint validation enforcement
- [ ] Cumulative discount cap

### Phase 3: Edge Case Handling (Week 5-6)
- [ ] Cycle detection
- [ ] Auto-DR for contradictions
- [ ] Schema validation

### Phase 4: Maintenance Features (Week 7-8)
- [ ] Evidence reconciliation
- [ ] Session cleanup
- [ ] Consistency validation

---

## Testing Recommendations

### Required Test Cases for Each Change

1. **Atomic writes**: Test with simulated disk failure mid-write
2. **Manifest versioning**: Test rollback after corruption
3. **Checkpoint validation**: Test with corrupted checkpoint file
4. **Cycle detection**: Test BoT -> ToT -> BoT -> ToT chain
5. **Auto-DR**: Test with monolith vs microservices contradiction
6. **Reconciliation**: Test with orphaned evidence files

### Integration Test Scenarios

1. Complete session with 5 sequential handovers
2. Parallel execution with merge
3. Mid-session pattern switch
4. Recovery from simulated crash
5. Long-running session (>2 hours) with multiple checkpoints

---

## Conclusion

The Reasoning Handover Protocol is well-designed for normal operations but needs hardening for production use. The critical fixes (atomic writes, verification) should be implemented immediately. The recovery improvements and edge case handling can follow in subsequent releases.

**Estimated Implementation Effort**: 8 person-weeks for full roadmap
**Minimum Viable Hardening**: 2 person-weeks (Phase 1 only)
