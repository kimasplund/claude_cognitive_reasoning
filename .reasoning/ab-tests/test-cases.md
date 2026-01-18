# IR-v2 A/B Test Suite: Test Cases

**Test Date**: 2026-01-18
**Purpose**: Validate IR-v2 pattern selection accuracy with 20 diverse problems
**Success Criteria**: >=85% accuracy = PASS, 70-84% = NEEDS IMPROVEMENT, <70% = FAIL

---

## Formula Reference

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

**Dimensions (scored 1-5):**
1. Sequential - Step dependencies
2. Criteria - Clarity of evaluation criteria
3. SpaceKnown - How well solution space is understood
4. SingleAnswer - Need for single answer (vs multiple)
5. Evidence - Availability of discriminating evidence
6. OpposingViews - Legitimate competing perspectives
7. Novelty - Problem uniqueness (1=common, 5=unprecedented)
8. Robustness - Need for stress-testing
9. SolutionExists - Candidate solution available (for AR)
10. TimePressure - Urgency (5=emergency triggers RTR fast-path)
11. StakeholderComplexity - Multi-party coordination needs

---

## Test Case 1: Debug Memory Leak

**Problem**: Users report app slowing down over time. Memory usage grows unbounded.

**Expected Pattern**: HE (Hypothesis-Elimination)
**Rationale**: Classic diagnostic problem - form hypotheses about leak sources, eliminate via evidence (heap dumps, profiler).

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 4 | Debug flow: reproduce -> profile -> isolate -> fix |
| Criteria | 4 | Clear: memory should be stable, no unbounded growth |
| SpaceKnown | 3 | Common leak patterns known (closures, listeners, etc) |
| SingleAnswer | 5 | Need to find THE cause |
| Evidence | 5 | Heap snapshots, allocation logs available |
| OpposingViews | 1 | No debate - there's a bug to find |
| Novelty | 2 | Memory leaks well-understood |
| Robustness | 3 | Verify fix resolves issue |
| SolutionExists | 2 | Still searching for cause |
| TimePressure | 2 | Annoying but not emergency |
| StakeholderComplexity | 1 | Single tech team |

---

## Test Case 2: Choose Tech Stack for Startup

**Problem**: New startup needs to choose between React/Node, Django/Vue, or Rails/React.

**Expected Pattern**: ToT (Tree of Thoughts)
**Rationale**: Known options, clear criteria (performance, team skills, ecosystem), need single best answer.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 2 | Comparisons parallelizable |
| Criteria | 4 | Can define: cost, learning curve, ecosystem |
| SpaceKnown | 5 | Options fully enumerated |
| SingleAnswer | 5 | Must pick ONE stack |
| Evidence | 4 | Benchmarks, case studies available |
| OpposingViews | 3 | Each stack has advocates |
| Novelty | 1 | Extremely common decision |
| Robustness | 4 | Hard to switch later |
| SolutionExists | 3 | Have candidate stacks |
| TimePressure | 2 | Strategic, not urgent |
| StakeholderComplexity | 2 | Tech leadership decides |

---

## Test Case 3: Production Outage

**Problem**: Website returning 500 errors. Thousands of users affected RIGHT NOW.

**Expected Pattern**: RTR (Rapid Triage Reasoning)
**Rationale**: TimePressure = 5 triggers RTR fast-path. Need "good enough now" over "perfect later".

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 3 | Some sequence: assess -> stabilize -> diagnose |
| Criteria | 4 | Clear: site should return 200, not 500 |
| SpaceKnown | 3 | Common failure modes known |
| SingleAnswer | 5 | Need to fix THE issue |
| Evidence | 4 | Logs, metrics, alerts available |
| OpposingViews | 1 | No debate during incident |
| Novelty | 2 | Server errors are common domain |
| Robustness | 2 | Speed trumps perfection now |
| SolutionExists | 2 | No fix identified yet |
| TimePressure | **5** | **EMERGENCY - NOW** |
| StakeholderComplexity | 1 | On-call decides |

---

## Test Case 4: Explore Machine Learning Approaches

**Problem**: Need to solve NLP task but unsure which approach (transformer, RNN, traditional ML).

**Expected Pattern**: BoT (Breadth of Thought)
**Rationale**: Unknown which approach best, need exhaustive exploration before commitment.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 2 | Explorations parallelizable |
| Criteria | 2 | Hard to define without testing |
| SpaceKnown | 2 | Many approaches, unclear which fit |
| SingleAnswer | 3 | Eventually need one, but exploring first |
| Evidence | 2 | Limited benchmark data for our use case |
| OpposingViews | 2 | Some methodological debate |
| Novelty | 4 | Novel application of ML |
| Robustness | 3 | Will need validation later |
| SolutionExists | 1 | No clear candidate |
| TimePressure | 2 | R&D phase |
| StakeholderComplexity | 1 | ML team decides |

---

## Test Case 5: Team Conflict on Architecture

**Problem**: Backend team wants REST, frontend team wants GraphQL. Project blocked.

**Expected Pattern**: NDF (Negotiated Decision Framework)
**Rationale**: Multiple stakeholders with competing interests, need consensus not just technical answer.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 2 | Negotiation, not linear |
| Criteria | 3 | Some technical criteria but also preferences |
| SpaceKnown | 4 | Options known (REST, GraphQL, gRPC) |
| SingleAnswer | 4 | Need ONE API design |
| Evidence | 3 | Can benchmark but much subjective |
| OpposingViews | 5 | Both teams have valid perspectives |
| Novelty | 1 | Common API decision |
| Robustness | 3 | Durable solution needed |
| SolutionExists | 3 | Each team has proposal |
| TimePressure | 2 | Blocking but not emergency |
| StakeholderComplexity | **4** | **Multiple teams competing** |

---

## Test Case 6: Monolith vs Microservices Migration

**Problem**: Large monolith showing scaling issues. Debate over full rewrite vs incremental extraction.

**Expected Pattern**: DR (Dialectical Reasoning)
**Rationale**: Genuine trade-off with valid arguments on both sides. Need synthesis.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 3 | Some migration sequence matters |
| Criteria | 3 | Multiple competing concerns (speed, risk, cost) |
| SpaceKnown | 4 | Options known (monolith, micro, hybrid) |
| SingleAnswer | 4 | Need to commit to approach |
| Evidence | 3 | Industry data exists but context-dependent |
| OpposingViews | **5** | **Strong valid arguments both ways** |
| Novelty | 2 | Common architectural challenge |
| Robustness | 4 | Major commitment, hard to reverse |
| SolutionExists | 3 | Have both proposals |
| TimePressure | 2 | Strategic decision |
| StakeholderComplexity | 3 | Multiple teams affected |

---

## Test Case 7: Novel AI Ethics Policy

**Problem**: Need to create AI ethics guidelines for unprecedented use case with no industry standard.

**Expected Pattern**: AT (Analogical Transfer)
**Rationale**: No precedent in domain, must draw from analogous fields (medical ethics, financial regulations).

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 2 | Policy development non-linear |
| Criteria | 2 | Hard to define for unprecedented case |
| SpaceKnown | 1 | No established framework |
| SingleAnswer | 3 | Need policy but exploring first |
| Evidence | 1 | No precedent = no evidence |
| OpposingViews | 3 | Some ethical debate |
| Novelty | **5** | **Unprecedented by definition** |
| Robustness | 4 | Need defensible policy |
| SolutionExists | 1 | Building from scratch |
| TimePressure | 2 | Important but not urgent |
| StakeholderComplexity | 3 | Multiple stakeholders |

---

## Test Case 8: Prove Algorithm Correctness

**Problem**: Need to formally verify a sorting algorithm implementation handles all edge cases.

**Expected Pattern**: SRC (Self-Reflecting Chain)
**Rationale**: Sequential proof steps with dependencies, need careful logical reasoning with backtracking.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | **5** | **Proof steps depend on previous steps** |
| Criteria | 5 | Clear: algorithm must be correct |
| SpaceKnown | 4 | Proof techniques known |
| SingleAnswer | 5 | Either correct or not |
| Evidence | 4 | Can construct proofs |
| OpposingViews | 1 | Mathematical truth, no debate |
| Novelty | 2 | Formal verification established field |
| Robustness | 5 | Proof must be airtight |
| SolutionExists | 3 | Have algorithm to verify |
| TimePressure | 2 | Research timeline |
| StakeholderComplexity | 1 | Technical decision |

---

## Test Case 9: Security Audit Before Launch

**Problem**: Application ready for deployment, need security validation before going live.

**Expected Pattern**: AR (Adversarial Reasoning)
**Rationale**: Solution exists, need stress-testing via adversarial attacks (STRIKE framework).

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 3 | Some attack sequence matters |
| Criteria | 4 | Clear: no critical vulnerabilities |
| SpaceKnown | 4 | Known attack vectors |
| SingleAnswer | 4 | Secure or not secure |
| Evidence | 4 | Penetration test results |
| OpposingViews | 1 | Security is objective |
| Novelty | 2 | Security audits common |
| Robustness | **5** | **Must withstand attacks** |
| SolutionExists | **4** | **App ready for testing** |
| TimePressure | 3 | Launch deadline approaching |
| StakeholderComplexity | 2 | Security team + dev team |

---

## Test Case 10: Simple API Endpoint Design

**Problem**: Add a new /users endpoint to existing well-designed REST API.

**Expected Pattern**: Direct Analysis
**Rationale**: All scores low, routine task with clear patterns, no cognitive framework needed.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 2 | Straightforward design |
| Criteria | 2 | Follow existing patterns |
| SpaceKnown | 2 | REST conventions known |
| SingleAnswer | 2 | One endpoint needed |
| Evidence | 2 | Existing API as template |
| OpposingViews | 1 | No debate on simple endpoint |
| Novelty | 1 | Routine CRUD |
| Robustness | 2 | Standard testing |
| SolutionExists | 2 | Copy existing patterns |
| TimePressure | 1 | Normal sprint work |
| StakeholderComplexity | 1 | Single developer |

---

## Test Case 11: Database Query Optimization

**Problem**: Critical query taking 30 seconds, need to reduce to under 1 second.

**Expected Pattern**: HE (Hypothesis-Elimination)
**Rationale**: Diagnostic problem - hypothesize causes (missing index, N+1, full scan), eliminate via EXPLAIN.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 4 | Profile -> hypothesize -> test -> fix |
| Criteria | 5 | Clear: query < 1 second |
| SpaceKnown | 3 | Common optimization patterns |
| SingleAnswer | 5 | Need to find THE bottleneck |
| Evidence | 5 | EXPLAIN plans, query logs |
| OpposingViews | 1 | Performance is measurable |
| Novelty | 2 | Query optimization well-understood |
| Robustness | 3 | Verify improvement persists |
| SolutionExists | 2 | Still diagnosing |
| TimePressure | 3 | Blocking feature release |
| StakeholderComplexity | 1 | DBA team |

---

## Test Case 12: Vendor Selection (Enterprise Software)

**Problem**: Choose between Salesforce, HubSpot, or Microsoft Dynamics for CRM.

**Expected Pattern**: ToT (Tree of Thoughts)
**Rationale**: Known options, clear criteria (cost, features, integrations), need single winner.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 2 | Evaluations parallelizable |
| Criteria | 5 | RFP criteria defined |
| SpaceKnown | 5 | Vendors enumerated |
| SingleAnswer | 5 | Must choose ONE vendor |
| Evidence | 4 | Demos, references, pricing |
| OpposingViews | 2 | Each vendor has internal advocates |
| Novelty | 1 | Very common decision |
| Robustness | 4 | Multi-year commitment |
| SolutionExists | 3 | Have vendor shortlist |
| TimePressure | 2 | Procurement timeline |
| StakeholderComplexity | 3 | Sales, IT, Finance involved |

---

## Test Case 13: Critical Bug in Production (non-emergency)

**Problem**: Bug causing data inconsistency, no user impact yet but needs fix before Monday.

**Expected Pattern**: HE (Hypothesis-Elimination)
**Rationale**: Diagnostic but not emergency (TimePressure < 5). Form hypotheses, test systematically.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 4 | Debug sequence: reproduce -> isolate -> fix |
| Criteria | 5 | Clear: data should be consistent |
| SpaceKnown | 3 | Could be race condition, logic error, etc |
| SingleAnswer | 5 | Find THE bug |
| Evidence | 5 | Logs, database state, tests |
| OpposingViews | 1 | Bug exists objectively |
| Novelty | 2 | Data bugs are common |
| Robustness | 4 | Regression tests needed |
| SolutionExists | 2 | Still investigating |
| TimePressure | 3 | Weekend deadline, not NOW |
| StakeholderComplexity | 1 | Engineering team |

---

## Test Case 14: Research State of Art in Field

**Problem**: Survey all approaches to federated learning to understand current landscape.

**Expected Pattern**: BoT (Breadth of Thought)
**Rationale**: Need exhaustive exploration, no single answer, unknown what's out there.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 1 | Papers can be read in any order |
| Criteria | 2 | Hard to rank without knowing field |
| SpaceKnown | 1 | Don't know what exists |
| SingleAnswer | 1 | Want comprehensive survey, not one answer |
| Evidence | 3 | Papers exist but need to find them |
| OpposingViews | 3 | Different methodological camps |
| Novelty | 3 | Moderately new field |
| Robustness | 2 | Survey, not production system |
| SolutionExists | 1 | Building knowledge base |
| TimePressure | 2 | Research timeline |
| StakeholderComplexity | 1 | Researcher |

---

## Test Case 15: Department Reorganization

**Problem**: Engineering org needs restructure. Multiple VPs have different visions.

**Expected Pattern**: NDF (Negotiated Decision Framework)
**Rationale**: High stakeholder complexity, political considerations, need consensus.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 2 | Org design iterative |
| Criteria | 2 | Multiple valid structures possible |
| SpaceKnown | 3 | Common org patterns exist |
| SingleAnswer | 4 | Need ONE structure |
| Evidence | 2 | Org science somewhat subjective |
| OpposingViews | 4 | VPs have competing interests |
| Novelty | 2 | Reorgs are common |
| Robustness | 4 | Affects many people |
| SolutionExists | 3 | Each VP has proposal |
| TimePressure | 2 | Strategic timeline |
| StakeholderComplexity | **5** | **Multiple VPs, many teams** |

---

## Test Case 16: Design New Programming Language Feature

**Problem**: Adding pattern matching to language. No prior implementation in this language family.

**Expected Pattern**: AT (Analogical Transfer)
**Rationale**: Novel for this domain, must learn from how other languages (Scala, Rust) solved it.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 3 | Some design dependencies |
| Criteria | 3 | Ergonomics, performance, compatibility |
| SpaceKnown | 2 | Many possible designs |
| SingleAnswer | 4 | Need one coherent design |
| Evidence | 2 | No existing implementation to measure |
| OpposingViews | 3 | Language design debates |
| Novelty | 4 | New for this language |
| Robustness | 4 | Can't change once released |
| SolutionExists | 2 | Still designing |
| TimePressure | 2 | Version timeline |
| StakeholderComplexity | 2 | Language committee |

---

## Test Case 17: Merge Conflict Resolution (Technical)

**Problem**: Git merge conflict in complex algorithm. Both branches have valid changes.

**Expected Pattern**: DR (Dialectical Reasoning)
**Rationale**: Two valid implementations need synthesis, not winner-take-all.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 3 | Merge has some order |
| Criteria | 4 | Both features must work |
| SpaceKnown | 4 | Limited options (pick A, B, or merge) |
| SingleAnswer | 5 | Need ONE merged result |
| Evidence | 4 | Can test both versions |
| OpposingViews | **5** | **Both branches valid** |
| Novelty | 2 | Merge conflicts common |
| Robustness | 4 | Must not break either feature |
| SolutionExists | 3 | Both branches work |
| TimePressure | 3 | Blocking PR |
| StakeholderComplexity | 2 | Two developers |

---

## Test Case 18: Customer Emergency Escalation

**Problem**: CEO of biggest customer on phone demanding immediate fix for their issue.

**Expected Pattern**: RTR (Rapid Triage Reasoning)
**Rationale**: TimePressure = 5, executive escalation is emergency.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 3 | Triage sequence |
| Criteria | 4 | Customer satisfied |
| SpaceKnown | 3 | Common support issues |
| SingleAnswer | 5 | Fix their problem |
| Evidence | 4 | Customer logs, support history |
| OpposingViews | 1 | Fix the issue |
| Novelty | 2 | Support escalations happen |
| Robustness | 2 | Speed over perfection |
| SolutionExists | 2 | Still diagnosing |
| TimePressure | **5** | **CEO on phone NOW** |
| StakeholderComplexity | 2 | Customer + support |

---

## Test Case 19: Mathematical Proof Review

**Problem**: Verify correctness of submitted proof for distributed consensus algorithm.

**Expected Pattern**: SRC (Self-Reflecting Chain)
**Rationale**: Sequential logic verification, each step depends on previous, need backtracking on errors.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | **5** | **Each lemma depends on previous** |
| Criteria | 5 | Proof valid or invalid |
| SpaceKnown | 4 | Proof techniques established |
| SingleAnswer | 5 | Binary: correct or not |
| Evidence | 4 | Can verify each step |
| OpposingViews | 1 | Math is objective |
| Novelty | 2 | Proofs are standard practice |
| Robustness | 5 | No errors allowed |
| SolutionExists | 4 | Have proof to verify |
| TimePressure | 2 | Publication timeline |
| StakeholderComplexity | 1 | Research team |

---

## Test Case 20: API Deprecation Strategy

**Problem**: Need to deprecate v1 API but 40% of users still on it. Multiple customer segments affected.

**Expected Pattern**: NDF (Negotiated Decision Framework)
**Rationale**: Multiple stakeholder groups (enterprise, SMB, internal), need coordinated transition.

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| Sequential | 3 | Migration has phases |
| Criteria | 3 | Balance speed vs customer impact |
| SpaceKnown | 4 | Deprecation patterns known |
| SingleAnswer | 4 | Need ONE migration plan |
| Evidence | 3 | Usage analytics available |
| OpposingViews | 4 | Different customers have different needs |
| Novelty | 2 | API deprecation common |
| Robustness | 4 | Can't strand customers |
| SolutionExists | 3 | Have draft timeline |
| TimePressure | 2 | Planned, not emergency |
| StakeholderComplexity | **4** | **Multiple customer segments** |

---

## Test Case Summary Table

| # | Problem | Expected | Rationale |
|---|---------|----------|-----------|
| 1 | Debug memory leak | HE | Diagnostic |
| 2 | Choose tech stack | ToT | Optimization with clear criteria |
| 3 | Production outage | RTR | TimePressure = 5 |
| 4 | Explore ML approaches | BoT | Unknown solution space |
| 5 | Team conflict | NDF | Stakeholder complexity |
| 6 | Monolith vs microservices | DR | Genuine trade-off |
| 7 | Novel AI ethics policy | AT | No precedent |
| 8 | Prove algorithm correctness | SRC | Sequential proof |
| 9 | Security audit | AR | Stress-test existing solution |
| 10 | Simple API endpoint | Direct | All scores low |
| 11 | Database query optimization | HE | Diagnostic |
| 12 | Vendor selection | ToT | Known options, clear criteria |
| 13 | Critical bug (non-emergency) | HE | Diagnostic, not RTR |
| 14 | Research state of art | BoT | Exhaustive exploration |
| 15 | Department reorganization | NDF | High stakeholder complexity |
| 16 | Design new language feature | AT | Novel for domain |
| 17 | Merge conflict resolution | DR | Two valid implementations |
| 18 | Customer emergency | RTR | TimePressure = 5 |
| 19 | Mathematical proof review | SRC | Sequential verification |
| 20 | API deprecation strategy | NDF | Multiple stakeholder groups |

---

## Expected Pattern Distribution

- **HE**: 3 (Cases 1, 11, 13)
- **ToT**: 2 (Cases 2, 12)
- **RTR**: 2 (Cases 3, 18)
- **BoT**: 2 (Cases 4, 14)
- **NDF**: 3 (Cases 5, 15, 20)
- **DR**: 2 (Cases 6, 17)
- **AT**: 2 (Cases 7, 16)
- **SRC**: 2 (Cases 8, 19)
- **AR**: 1 (Case 9)
- **Direct**: 1 (Case 10)

**Total**: 20 test cases covering all 9 patterns + Direct analysis
