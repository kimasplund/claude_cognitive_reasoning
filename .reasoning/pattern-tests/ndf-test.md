# Negotiated Decision Framework (NDF) Pattern Test

**Test Problem**: "Engineering wants X, Product wants Y, Finance wants Z"
**Test Requirements**: ALIGN framework, stakeholder interests mapped, integrative solution found

---

## Scenario Context

**Decision**: How to allocate Q2 development resources

**Situation**:
- Engineering wants to spend Q2 on technical debt reduction (refactoring, upgrading dependencies, improving CI/CD)
- Product wants to ship three new customer-facing features (requested by top customers)
- Finance wants to reduce cloud costs by 30% and cut contractor spending

**Background**:
- Startup with 40 engineers, recently raised Series B
- Technical debt has been accumulating; some systems are fragile
- Three key customers (25% of revenue) are waiting on promised features
- Burn rate concerns from board; need to extend runway

---

## A - Analyze Stakeholder Landscape

### Power-Interest Grid

|           | Low Interest | High Interest |
|-----------|--------------|---------------|
| **High Power** | CFO (focused on big picture) | CEO (implicit), Engineering VP, Product VP |
| **Low Power** | Individual engineers | Customers (external), Individual PMs |

### Stakeholder Profiles

#### Stakeholder 1: VP of Engineering (Sarah)

- **Role**: Head of Engineering, 40 engineers
- **Power Level**: High (controls engineering resources)
- **Interest Level**: High (directly affected)
- **Stated Position**: "We need Q2 for tech debt. Systems are breaking."
- **Underlying Interest**:
  - Reduce on-call burden (team burnout)
  - Improve developer velocity (slowed by tech debt)
  - Prevent catastrophic failures (reputation)
  - Maintain engineering morale (attrition risk)
- **Success Criteria**: On-call incidents reduced 50%, deployment time cut in half
- **Potential Blockers**: Feature-only quarter, layoffs, ignored concerns
- **Potential Sweeteners**: Headcount for dedicated platform team, recognition of tech investment
- **Relationships**: Trusted by CEO, tension with Product over priorities

#### Stakeholder 2: VP of Product (Marcus)

- **Role**: Head of Product, manages roadmap
- **Power Level**: High (owns product direction)
- **Interest Level**: High (features = his success metric)
- **Stated Position**: "We promised customers these features. We'll lose them."
- **Underlying Interest**:
  - Retain key customers (25% of revenue)
  - Hit product milestones for board
  - Demonstrate market traction (Series B narrative)
  - Not be blamed for churn
- **Success Criteria**: All three features shipped, customers satisfied
- **Potential Blockers**: Tech debt quarter with no features, customer escalations
- **Potential Sweeteners**: Customer retention, board recognition, product wins
- **Relationships**: Pressure from CEO on revenue, frustration with Engineering pace

#### Stakeholder 3: CFO (Jennifer)

- **Role**: Finance, reports to CEO
- **Power Level**: High (controls budget)
- **Interest Level**: Medium-High (focused on runway, not details)
- **Stated Position**: "Cut cloud costs 30%, reduce contractors. Extend runway."
- **Underlying Interest**:
  - Extend runway to 24 months
  - Prepare for potential down-round or bridge
  - Demonstrate fiscal responsibility to board
  - Avoid layoffs (wants cost cuts, not people cuts)
- **Success Criteria**: 30% cloud cost reduction, 18+ month runway
- **Potential Blockers**: Any spending increase, new hires
- **Potential Sweeteners**: Cost savings that don't require headcount cuts
- **Relationships**: Allied with CEO on financial discipline

#### Stakeholder 4: CEO (David) - Implicit

- **Role**: CEO, final authority
- **Power Level**: Highest
- **Interest Level**: High (company survival)
- **Stated Position**: (Not directly at table, but sets context)
- **Underlying Interest**:
  - Company survival (runway)
  - Customer retention (revenue)
  - Team morale (retention)
  - Board confidence
- **Success Criteria**: Hit board milestones, extend runway, keep team
- **Potential Blockers**: Any outcome that causes board concern
- **Relationships**: Balances all interests

---

## L - Locate Zones of Agreement

### Shared Goals

1. **Company survival**: All stakeholders want the company to succeed and survive
2. **Customer retention**: Losing key customers hurts everyone
3. **Team retention**: Losing key engineers hurts everyone
4. **Avoiding catastrophic failures**: No one wants production outages

### Overlapping Interests

| Interest | Stakeholders Who Share |
|----------|------------------------|
| Extend runway | CFO, CEO, (indirectly) Engineering, Product |
| Retain key customers | Product, CEO, CFO (revenue) |
| Reduce engineering burden | Engineering, CEO (morale/retention) |
| Demonstrate progress to board | Product, CFO, CEO |
| Avoid layoffs | Engineering, CFO, CEO |

### Agreed Constraints

1. **Budget is constrained**: No significant new spending
2. **Can't ignore customers**: Losing 25% revenue is unacceptable
3. **Can't ignore tech debt**: Major outage would be worse
4. **Timeline is Q2**: 3 months to show results

### Foundation Statement

"We all agree that the company must survive, which means extending runway AND retaining key customers AND keeping the engineering team functional. Within Q2 and current budget, we need to make meaningful progress on all three fronts."

---

## I - Identify Irreducible Conflicts

### Conflict 1: Development Time Allocation

- **Parties**: Engineering vs Product
- **Type**: Resource Conflict (competing for same limited resource: developer time)
- **A's Position**: Q2 = tech debt
- **B's Position**: Q2 = features
- **Underlying Interests**:
  - Engineering really needs: Reduced fragility, improved velocity
  - Product really needs: Features shipped to retain customers
- **Compatible?**: Partially - not 100% of time can go to both, but some allocation is possible
- **Resolution Path**: Negotiate split, find efficiency gains, prioritize ruthlessly

### Conflict 2: Spending vs Cutting

- **Parties**: Engineering/Product vs Finance
- **Type**: Resource Conflict
- **A's Position**: We need resources to build things
- **B's Position**: We need to cut spending
- **Underlying Interests**:
  - Engineering/Product need: Developer capacity
  - Finance needs: Reduced burn, extended runway
- **Compatible?**: Yes - if tech debt work REDUCES cloud costs, interests align
- **Resolution Path**: Find tech debt work that cuts costs

### Conflict 3: Short-term vs Long-term

- **Parties**: Product (short-term features) vs Engineering (long-term stability)
- **Type**: Value Conflict (different time horizons)
- **A's Position**: Ship now to keep customers
- **B's Position**: Invest now to be faster later
- **Underlying Interests**:
  - Product: Immediate customer retention
  - Engineering: Sustainable development pace
- **Compatible?**: Yes - with clear timeline for payback
- **Resolution Path**: Phased approach; some now, more later

---

## G - Generate Integrative Options

### Option 1: The 60/30/10 Split

**How it works**:
- 60% of engineering time on tech debt (with focus on cost-reducing work)
- 30% on highest-priority feature (1 of 3, most important to key customer)
- 10% on cloud cost optimization specifically

**Satisfies Engineering**: Majority of time on tech debt
**Satisfies Product**: Most critical feature delivered
**Satisfies Finance**: Tech debt includes cost optimization
**Trade-offs**: Product only gets 1 feature, not 3

**Feasibility**: High - clear allocation, measurable

---

### Option 2: Tech Debt That Enables Features

**How it works**:
- Prioritize tech debt that unblocks features
- Example: Refactor authentication system (debt) that's needed for SSO feature (customer request)
- Two birds, one stone

**Satisfies Engineering**: Debt gets addressed
**Satisfies Product**: Features get delivered (eventually)
**Satisfies Finance**: Efficient use of resources
**Trade-offs**: Requires finding overlap; might not address worst debt

**Feasibility**: Medium - depends on finding genuine overlap

---

### Option 3: Contractor-Funded Feature Sprint

**How it works**:
- FTEs focus 100% on tech debt and cost reduction
- Hire 2 contractors for 3 months to ship features
- Net cost: Contractors offset by cloud savings

**Satisfies Engineering**: Full focus on debt
**Satisfies Product**: Features get shipped
**Satisfies Finance**: Cost-neutral if savings materialize
**Trade-offs**: Contractors need ramp-up; knowledge transfer; Finance may resist

**Feasibility**: Medium - requires CFO buy-in on ROI

---

### Option 4: Phased Approach (6-week sprints)

**How it works**:
- Weeks 1-6: Tech debt focus (80%) with 1 feature (20%)
- Weeks 7-12: Features focus (60%) with maintenance (40%)
- Commit to customers: Feature 1 in Week 6, Feature 2 in Week 10

**Satisfies Engineering**: First half prioritizes stability
**Satisfies Product**: Features delivered, just later
**Satisfies Finance**: Runway extended early via cost optimization
**Trade-offs**: Product waits longer; risk of backsliding

**Feasibility**: High - clear phases, predictable

---

### Comparison Matrix

| Option | Engineering (1-5) | Product (1-5) | Finance (1-5) | Feasibility |
|--------|-------------------|---------------|---------------|-------------|
| 1: 60/30/10 | 4 | 2 (only 1 feature) | 4 | High |
| 2: Overlap | 3 | 3 | 4 | Medium |
| 3: Contractors | 5 | 4 | 2 (spending) | Medium |
| 4: Phased | 4 | 3 | 4 | High |

**Best Options**: Option 4 (highest combined score with high feasibility) or Option 1 (clearer, simpler)

---

## N - Negotiate Commitment

### BATNA Analysis

**Engineering's BATNA**: Escalate to CEO; threaten key engineer departures
- Assessment: Weak BATNA (creates conflict, CEO may not side with them)

**Product's BATNA**: Go to customers with delays; request more resources
- Assessment: Moderate (customers may accept delays, but risk of churn)

**Finance's BATNA**: Mandate cuts regardless; force layoffs
- Assessment: Strong but destructive (can do it, but hurts everyone)

**Implication**: Finance has strongest BATNA, so solution must satisfy their core interest (runway extension). But mutual destruction is possible, so integrative solution is in everyone's interest.

### Proposed Agreement: Modified Option 4

**Hybrid of Option 4 (Phased) + Option 1 (60/30/10) + Option 2 (Overlap)**

#### The Deal

**Phase 1 (Weeks 1-6): Stabilize + Quick Win**
- 70% tech debt focus, prioritizing:
  - Items that reduce cloud costs (estimated 15% savings)
  - Items that unblock critical feature (SSO)
- 30% on Feature 1 (SSO - overlaps with tech debt)
- Deliverable: SSO shipped Week 6, cloud costs down 15%

**Phase 2 (Weeks 7-12): Accelerate**
- 50% continued tech debt (different areas)
- 50% on Features 2 and 3
- Deliverable: Feature 2 Week 10, Feature 3 Week 12 (if possible) or Week 14

**Cost Commitment**:
- Engineering commits to 15% cloud savings in Phase 1, additional 15% in Phase 2
- Total 30% cloud cost reduction target met
- No new contractors (Finance win)

**Customer Commitment**:
- Feature 1 (SSO): Week 6
- Feature 2: Week 10
- Feature 3: Week 12-14 (negotiate with customer)

---

### Stakeholder Commitments

| Stakeholder | Commitment Level | What They Get | What They Give |
|-------------|------------------|---------------|----------------|
| Engineering | Endorse | 70% -> 50% tech debt time; cloud optimization counts | Accept feature work; own cost targets |
| Product | Accept | All 3 features delivered (2 on time, 1 delayed) | Accept 4-week delay on Feature 3 |
| Finance | Endorse | 30% cloud cost reduction; no new spend | No contractor cuts; trust Engineering on savings |

### Conditions and Contingencies

1. **Cloud savings review at Week 6**: If <10% achieved, revisit Phase 2 allocation
2. **Feature 1 at Week 6**: If slips >2 weeks, Product can request resource shift
3. **Customer communication**: Product handles expectation setting with customers
4. **Quarterly review**: Full assessment at end of Q2

### Dispute Resolution

If disagreement arises: Escalate to CEO with both positions documented; CEO decides.

---

## Output Summary

# NDF Decision Record: Q2 Resource Allocation

## Stakeholder Landscape

| Stakeholder | Interest | Power | Final Support Level |
|-------------|----------|-------|---------------------|
| VP Engineering | Tech debt + reduced burden | High | Endorse |
| VP Product | Ship features, retain customers | High | Accept |
| CFO | Extend runway, cut costs | High | Endorse |
| CEO (implicit) | Company survival | Highest | (Implicit support) |

## Zones of Agreement

- Company must survive (all agree)
- Can't lose 25% of revenue (all agree)
- Can't have major outages (all agree)
- Need to extend runway (all agree)

## Conflicts Addressed

| Conflict | Type | Resolution |
|----------|------|------------|
| Dev time (Eng vs Product) | Resource | Phased allocation: 70/30 -> 50/50 |
| Spending vs Cutting (All vs Finance) | Resource | Tech debt includes cost optimization |
| Short-term vs Long-term | Value | Phased approach with checkpoints |

## Negotiated Solution

**Phased Q2 Approach**:

**Phase 1 (Weeks 1-6)**:
- 70% tech debt (cost-reducing, feature-unblocking)
- 30% Feature 1 (SSO)
- Deliverables: SSO shipped, 15% cloud cost reduction

**Phase 2 (Weeks 7-12)**:
- 50% tech debt (continued)
- 50% Features 2 & 3
- Deliverables: Feature 2 Week 10, Feature 3 Week 12-14, +15% cloud savings

### Value Distribution

| Stakeholder | What They Get | What They Give |
|-------------|---------------|----------------|
| Engineering | Majority tech debt time, cost work counts | Feature commitment, own cost targets |
| Product | All 3 features (1 delayed 4 weeks) | Accept delays, help set customer expectations |
| Finance | 30% cloud cost reduction, no new spend | No contractor cuts, patience for Phase 1 |

## Commitments and Conditions

1. Week 6 checkpoint: Review cloud savings and Feature 1 delivery
2. Feature 3 may slip to Week 14 (Product to manage customer)
3. Escalation to CEO if checkpoint conditions not met

## Implementation Notes

- Engineering owns cloud cost metrics dashboard
- Product owns customer communication on timeline
- Finance releases budget hold contingent on Phase 1 results
- Weekly cross-functional sync for first 3 weeks

## Confidence: 82%

**Justification**:
- Integrative solution that addresses all core interests
- All parties at Accept or Endorse level
- Clear checkpoints and conditions reduce risk
- Remaining uncertainty: Actual cloud savings may vary

---

## Test Evaluation

### Methodology Verification

| Criterion | Expected | Actual | Pass/Fail |
|-----------|----------|--------|-----------|
| ALIGN framework used | 5 phases | All 5 phases completed | PASS |
| Stakeholder mapping | Power-interest grid | Yes, 4 stakeholders profiled | PASS |
| Underlying interests | Not just positions | Each stakeholder has deeper interests | PASS |
| Zones of agreement | Identified | 4 shared goals documented | PASS |
| Conflicts classified | By type | 3 conflicts with types | PASS |
| Integrative options | Multiple | 4 options generated | PASS |
| Comparison matrix | Stakeholder scores | Yes, 4 options x 3 stakeholders | PASS |
| BATNA considered | Per stakeholder | Yes, 3 BATNAs analyzed | PASS |
| Commitment levels | Specified | Endorse/Accept/etc. documented | PASS |
| Conditions | Included | 3 conditions with triggers | PASS |

### Gaps Identified

1. **Enhancement**: Could add more explicit "What if conditions fail?" escalation paths beyond "go to CEO."

2. **Minor Gap**: The distinction between "stated position" and "underlying interest" is the core of NDF; this test demonstrated it well (e.g., Product doesn't really need all 3 features in Q2, they need customer retention).

3. **Strength**: The hybrid solution combining elements of multiple options demonstrates integrative negotiation well.

### Output Quality

- 4 stakeholders fully profiled with interests and blockers
- 4 zones of agreement establish common ground
- 3 conflicts classified and addressed
- 4 integrative options generated with comparison matrix
- Final solution is genuinely integrative (not just splitting the difference)
- Clear commitments with conditions and checkpoints

### Integrative Quality Check

**Is this a compromise or integrative solution?**
- **Compromise would be**: "Each gets 33% of resources"
- **Integrative is**: "Tech debt that reduces costs AND unblocks features serves multiple interests simultaneously"

This solution is genuinely integrative because:
1. Cloud optimization counts as tech debt (Engineering + Finance aligned)
2. SSO is both tech debt AND feature (Engineering + Product aligned)
3. Phased approach gives early wins to Finance while preserving Engineering time
4. All three features still delivered (Product satisfied)

### Test Result: **PASS**

The NDF methodology works as documented. ALIGN framework effectively mapped stakeholder interests beyond positions, identified zones of agreement, classified conflicts, and generated integrative options. The final solution satisfies all stakeholder core interests through creative combination (tech debt that cuts costs AND unblocks features), not mere compromise.
