# Rapid Triage Reasoning (RTR) Pattern Test

**Test Problem**: "Production is down! What do we do?"
**Test Requirements**: RAPID framework, 5-minute budget, decision made within time constraint

---

## Scenario Context

**Time**: 14:32 UTC
**Alert**: PagerDuty firing for 100% error rate on checkout API
**Symptom**: Users cannot complete purchases; all checkout attempts return 500 errors
**Business Impact**: E-commerce site; estimated $10,000/minute in lost revenue
**Available Time**: 5 minutes to make first decision

---

## R - Recognize Constraints

**Started**: 14:32:00

### Time Constraint Recognition

**Deadline**: 5 minutes (decision by 14:37:00)

**Cost of Delay**:
- $10,000/minute in lost revenue
- Customer trust erosion
- Support ticket flood
- Potential media/social attention

**Quality Floor**:
- Stop or reduce the bleeding
- Even partial fix is acceptable
- Not root cause, just triage

**Acceptable Sacrifice**:
- May need proper fix later
- May introduce temporary degradation elsewhere
- Forensic data collection is secondary to restoration

**Time Budget Allocation**:
- R (Recognize): 30 seconds [14:32:00 - 14:32:30]
- A (Assess): 1 minute [14:32:30 - 14:33:30]
- P (Prioritize): 30 seconds [14:33:30 - 14:34:00]
- I (Implement): 2.5 minutes [14:34:00 - 14:36:30]
- D (Document): 30 seconds ongoing [14:36:30 - 14:37:00]

**Time Check**: 14:32:30 - On schedule

---

## A - Assess Available Options

**Started**: 14:32:30

### Quick Reconnaissance (30 seconds)

**Immediate checks** (running in parallel in my head):
- Last deployment: 30 minutes ago (checkout-service v2.3.4)
- External dependencies: Payment gateway status = Green
- Error pattern: 100% failure (not intermittent)
- Error type: 500 Internal Server Error

### Viable Options (30 seconds)

| Option | Executable in Time? | Reversible? | Keep? |
|--------|---------------------|-------------|-------|
| 1: Rollback deployment | Yes (1-2 min) | Yes | **YES** |
| 2: Restart service | Yes (30 sec) | Yes | **YES** |
| 3: Scale up pods | Yes (1 min) | Yes | **YES** |
| 4: Debug and fix code | No (>5 min) | N/A | NO |
| 5: Failover to DR | Yes (2 min) | Partially | **YES** |
| 6: Do nothing/wait | Yes | Yes | **YES** |

**Discarded**: Option 4 (not executable in time)

### Option Details

#### Option 1: Rollback Deployment
- **Action**: `kubectl rollout undo deployment/checkout-service`
- **Time to Execute**: 1-2 minutes
- **Reversible**: Yes (can re-deploy v2.3.4)
- **Rationale**: Last deploy was 30 min ago; timing suspicious

#### Option 2: Restart Service
- **Action**: `kubectl rollout restart deployment/checkout-service`
- **Time to Execute**: 30 seconds
- **Reversible**: Yes
- **Rationale**: Clears transient state; quick first attempt

#### Option 3: Scale Up Pods
- **Action**: `kubectl scale deployment/checkout-service --replicas=10`
- **Time to Execute**: 1 minute
- **Reversible**: Yes
- **Rationale**: If resource exhaustion, more capacity helps

#### Option 5: Failover to DR
- **Action**: Switch DNS to disaster recovery site
- **Time to Execute**: 2 minutes + propagation
- **Reversible**: Partially (takes time to switch back)
- **Rationale**: Nuclear option if primary is unrecoverable

#### Option 6: Do Nothing / Wait
- **Action**: Monitor, gather more data
- **Rationale**: Only correct if problem is self-resolving OR external

**Time Check**: 14:33:30 - On schedule

---

## P - Prioritize by Reversibility

**Started**: 14:33:30

### Quick Assessment Matrix

| Option | Expected Outcome | Confidence | Reversibility | Score |
|--------|------------------|------------|---------------|-------|
| 1: Rollback | Restores if deploy caused | 70% | 3 (full) | 70 x 4/4 = **70** |
| 2: Restart | Fixes transient state | 40% | 3 (full) | 40 x 4/4 = **40** |
| 3: Scale up | Helps if resource issue | 20% | 3 (full) | 20 x 4/4 = **20** |
| 5: DR failover | Restores service | 80% | 2 (partial) | 80 x 3/4 = **60** |
| 6: Nothing | No improvement | 5% | 3 (full) | 5 x 4/4 = **5** |

**Score Formula**: Confidence x (Reversibility + 1) / 4

### Decision Logic

**Highest Score**: Option 1 (Rollback) at 70

**Rationale**:
- Deployment 30 minutes ago is highly suspicious timing
- Rollback is fully reversible
- High confidence correlation (even if not proven)
- Fastest path to potential resolution

**Backup if Rollback Fails**: Option 5 (DR Failover)

**Time Check**: 14:34:00 - On schedule

---

## I - Implement with Checkpoints

**Started**: 14:34:00

### Execution Log

**Action**: Rollback checkout-service deployment

```bash
$ kubectl rollout undo deployment/checkout-service -n production
deployment.apps/checkout-service rolled back
```

**Started**: 14:34:00
**Command completed**: 14:34:10

### Checkpoint 1 (25% - 14:34:40)

**Check**: Old pods terminating, new pods starting
```bash
$ kubectl get pods -n production -l app=checkout-service
NAME                               READY   STATUS        RESTARTS   AGE
checkout-service-abc123-1         0/1     Terminating   0          2m
checkout-service-abc123-2         0/1     Terminating   0          2m
checkout-service-xyz789-1         1/1     Running       0          30s
checkout-service-xyz789-2         1/1     Running       0          25s
```

- Working? **Partially** - Rollback in progress
- Continue? **Yes** - Proceeding as expected

### Checkpoint 2 (50% - 14:35:20)

**Check**: Service health and error rate
```bash
$ kubectl get pods -n production -l app=checkout-service
NAME                               READY   STATUS    RESTARTS   AGE
checkout-service-xyz789-1         1/1     Running   0          1m10s
checkout-service-xyz789-2         1/1     Running   0          1m5s
checkout-service-xyz789-3         1/1     Running   0          55s

$ curl -s checkout-service.production.svc/health
{"status": "healthy"}
```

**Grafana Check**: Error rate dropping - 100% -> 45% -> 12%

- Working? **Yes** - Error rate decreasing
- Continue? **Yes** - Wait for full recovery

### Checkpoint 3 (75% - 14:36:00)

**Check**: Error rate at acceptable level
```
Error rate: 2% (within normal variance)
Successful checkouts: Resuming
PagerDuty: Alert clearing
```

- Working? **Yes** - Service restored
- Continue? **Complete triage**, document and follow up

**Time Check**: 14:36:00 - Under budget!

---

## D - Document for Follow-up

**Completed**: 14:36:30

### RTR Decision Record

**Situation**: Checkout API 100% error rate, users unable to complete purchases

**Time Pressure**: $10,000/minute revenue loss

**Decision Made**: Rollback checkout-service from v2.3.4 to v2.3.3

**Rationale**: Deployment 30 minutes before incident is highest-probability cause; rollback is fully reversible

**Outcome**:
- Service restored in 2 minutes
- Error rate returned to baseline
- Revenue loss: ~$20,000 (2 min at full outage + 1 min degraded)

### Follow-up Required
- [ ] Root cause analysis: What in v2.3.4 caused failures?
- [ ] Review deployment pipeline: Should we have caught this?
- [ ] Canary analysis: Why didn't canary catch this?
- [ ] Postmortem: Schedule within 48 hours
- [ ] Fix forward: Address issue in v2.3.5 before re-deployment

### Hypotheses for Root Cause (for HE pattern later)
- Code bug introduced in v2.3.4
- Configuration error
- Database migration issue
- Dependency version conflict
- Resource exhaustion triggered by new code

**Time Check**: 14:37:00 - Completed within 5-minute budget

---

## Post-Incident Addendum

### What Happened (Later Analysis)

**Root Cause**: v2.3.4 included a migration that added NOT NULL constraint to a column that had NULL values in production. Migration ran but caused all reads to fail.

**Why Rollback Worked**: v2.3.3 didn't expect that column constraint.

**Prevention**:
- Migration testing against production data copy
- Staged rollout with health checks
- Feature flags for database changes

---

## Test Evaluation

### Methodology Verification

| Criterion | Expected | Actual | Pass/Fail |
|-----------|----------|--------|-----------|
| RAPID framework used | 5 phases | All 5 phases completed | PASS |
| Time budget specified | Per-phase allocation | Yes, totaling 5 minutes | PASS |
| Decision within deadline | 5 minutes | Completed in ~5 minutes | PASS |
| Options executable in time | Filtered by time | Yes, removed "debug and fix" | PASS |
| Reversibility prioritized | Scored by reversibility | Yes, formula included | PASS |
| Checkpoints executed | 25% and 50% | Three checkpoints done | PASS |
| Documentation concurrent | While acting | Yes, ongoing notes | PASS |
| Follow-up items captured | Required | 5 follow-up items listed | PASS |

### Time Budget Analysis

| Phase | Budgeted | Actual | Variance |
|-------|----------|--------|----------|
| R (Recognize) | 30s | ~30s | On target |
| A (Assess) | 60s | ~60s | On target |
| P (Prioritize) | 30s | ~30s | On target |
| I (Implement) | 150s | ~120s | 30s under |
| D (Document) | 30s | ~30s | On target |
| **Total** | **300s (5 min)** | **~270s (4.5 min)** | **30s under** |

### Gaps Identified

1. **Enhancement**: The scoring formula `Confidence x (Reversibility + 1) / 4` could be documented more clearly in the methodology.

2. **Minor Gap**: The checkpoint percentages (25%, 50%) work well for 2.5-minute implementation, but might need adjustment for shorter/longer time budgets.

3. **Strength**: The "Do Nothing" option being explicitly listed (and scored lowest) demonstrates the methodology prevents analysis paralysis.

### Output Quality

- Clear time constraints acknowledged upfront
- Multiple options generated and filtered by feasibility
- Prioritization by reversibility worked correctly
- Checkpoints prevented over-commitment to failing approach
- Documentation captures both immediate actions and follow-up needs

### RTR Quality Metrics Check

| Metric | Target | Actual | Result |
|--------|--------|--------|--------|
| Decision Time | Within 5 min | ~5 min | PASS |
| Quality Floor | Stop bleeding | Service restored | PASS |
| Reversibility | Preferred when uncertain | Rollback is fully reversible | PASS |
| Follow-up Rate | 100% documented | 5 items captured | PASS |
| Regret Rate | <20% | 0% (rollback was correct) | PASS |

### Test Result: **PASS**

The RTR methodology works as documented. The RAPID framework enabled decision-making within the 5-minute constraint. The scoring system correctly prioritized the rollback option (highest confidence x reversibility score). Checkpoints allowed verification of progress, and documentation was concurrent with action. The methodology successfully optimized for "good enough now" over "perfect later."
