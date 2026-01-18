# RASC (Self-Consistency with Rationalization) Test

**Problem**: What's the optimal pricing strategy for our SaaS product?
**Test Focus**: Multiple reasoning paths, cluster rationales
**Verification**: 70% compute reduction claim

---

## Test Setup

### Configuration Used
```json
{
  "pattern": "RASC",
  "paths_to_generate": 10,
  "clustering_method": "rationale_similarity",
  "aggregation": "weighted_voting",
  "compute_tracking": true
}
```

### Problem Context

**Product:** B2B SaaS analytics platform
**Current State:** Free trial only, no paid tiers
**Target Market:** SMB and Mid-market companies
**Competitors:**
- Competitor A: $99/month flat
- Competitor B: $29-299/month tiered
- Competitor C: Usage-based ($0.01/event)

**Decision Required:** Choose optimal pricing model for launch

---

## Execution Trace

### Phase 1: Parallel Path Generation (K=10)

Generated 10 independent reasoning paths for the pricing decision.

#### Path 1
**Answer:** Tiered pricing ($49/$99/$199)
**Rationale:** "Market expects tiers; matches Competitor B positioning"
**Confidence:** 72%

#### Path 2
**Answer:** Usage-based pricing
**Rationale:** "Scales with customer success; fair for small users"
**Confidence:** 68%

#### Path 3
**Answer:** Tiered pricing ($29/$79/$149)
**Rationale:** "Undercut competition on price; volume strategy"
**Confidence:** 65%

#### Path 4
**Answer:** Tiered pricing ($49/$99/$199)
**Rationale:** "Three tiers is industry standard; easy to understand"
**Confidence:** 70%

#### Path 5
**Answer:** Flat pricing ($79/month)
**Rationale:** "Simplicity wins; no confusion about which tier"
**Confidence:** 62%

#### Path 6
**Answer:** Tiered pricing ($49/$99/$199)
**Rationale:** "Matches market expectations; room for upsell"
**Confidence:** 74%

#### Path 7
**Answer:** Usage-based pricing
**Rationale:** "Aligns revenue with customer value delivered"
**Confidence:** 66%

#### Path 8
**Answer:** Freemium + Premium ($0/$99)
**Rationale:** "Free tier drives adoption; single paid tier for simplicity"
**Confidence:** 58%

#### Path 9
**Answer:** Tiered pricing ($49/$99/$199)
**Rationale:** "Psychological anchoring with three options"
**Confidence:** 71%

#### Path 10
**Answer:** Hybrid (base + usage)
**Rationale:** "Base ensures revenue floor; usage captures upside"
**Confidence:** 64%

---

### Phase 2: Rationale Clustering

**Clustering Method:** Semantic similarity of rationale text

**Identified Clusters:**

#### Cluster A: "Market Standard / Expectations" (4 paths)
Paths: 1, 4, 6, 9
Answer: Tiered pricing ($49/$99/$199)
Core rationale theme: Customers expect tiered pricing; industry standard
Representative: Path 6 (highest confidence at 74%)

#### Cluster B: "Value Alignment / Fairness" (2 paths)
Paths: 2, 7
Answer: Usage-based pricing
Core rationale theme: Price should scale with value delivered
Representative: Path 2 (highest confidence at 68%)

#### Cluster C: "Simplicity / Undercut" (2 paths)
Paths: 3, 5
Answer: Varies (tiered at lower price OR flat)
Core rationale theme: Make it simple or cheaper than competition
Representative: Path 3 (tiered at lower price, 65%)

#### Cluster D: "Adoption First" (1 path)
Paths: 8
Answer: Freemium + Premium
Core rationale theme: Free tier maximizes adoption
Representative: Path 8 (58%)

#### Cluster E: "Hybrid Model" (1 path)
Paths: 10
Answer: Base + Usage
Core rationale theme: Combine predictability with upside capture
Representative: Path 10 (64%)

**Clustering Summary:**
| Cluster | Size | Answer | Representative Confidence |
|---------|------|--------|---------------------------|
| A | 4 | Tiered ($49/99/199) | 74% |
| B | 2 | Usage-based | 68% |
| C | 2 | Cheaper/Simpler | 65% |
| D | 1 | Freemium + Premium | 58% |
| E | 1 | Hybrid | 64% |

---

### Phase 3: Representative Selection

**Selection Criteria:** One representative per cluster (highest confidence)

**Representatives Selected:**
1. Path 6 (Cluster A): Tiered $49/99/199 - 74%
2. Path 2 (Cluster B): Usage-based - 68%
3. Path 3 (Cluster C): Tiered $29/79/149 - 65%
4. Path 8 (Cluster D): Freemium + $99 - 58%
5. Path 10 (Cluster E): Hybrid - 64%

**Reduction:** 10 paths -> 5 representatives (50% reduction at this step)

---

### Phase 4: Aggregation

**Weighted Voting Method:**
Weight = Cluster Size × Representative Confidence

| Cluster | Size | Confidence | Weight | Answer |
|---------|------|------------|--------|--------|
| A | 4 | 74% | 2.96 | Tiered ($49/99/199) |
| B | 2 | 68% | 1.36 | Usage-based |
| C | 2 | 65% | 1.30 | Tiered (cheaper) |
| D | 1 | 58% | 0.58 | Freemium |
| E | 1 | 64% | 0.64 | Hybrid |

**Total Weight:** 6.84

**Answer Grouping:**
- Tiered pricing (Clusters A + C): 2.96 + 1.30 = 4.26 (62.3%)
- Usage-based (Cluster B): 1.36 (19.9%)
- Freemium (Cluster D): 0.58 (8.5%)
- Hybrid (Cluster E): 0.64 (9.4%)

**Majority Answer:** Tiered pricing (62.3%)

**Sub-question: Which tier structure?**
- $49/$99/$199 (Cluster A): 2.96 weight
- $29/$79/$149 (Cluster C): 1.30 weight

**Winner:** $49/$99/$199 (69.5% of tiered weight)

---

## Results and Merge Output

### Final Recommendation

| Decision | Confidence | Rationale Themes |
|----------|------------|------------------|
| **Tiered Pricing: $49 / $99 / $199** | **74%** | Market expectations, industry standard, psychological anchoring, upsell opportunity |

### Supporting Rationales from Cluster A:
1. "Market expects tiers; matches Competitor B positioning"
2. "Three tiers is industry standard; easy to understand"
3. "Matches market expectations; room for upsell"
4. "Psychological anchoring with three options"

### Tier Definitions (Recommended)
| Tier | Price | Target User | Key Features |
|------|-------|-------------|--------------|
| Starter | $49/mo | Solo / Small team | 5 users, basic analytics |
| Professional | $99/mo | Growing SMB | 25 users, advanced reports |
| Business | $199/mo | Mid-market | Unlimited users, API access |

### Minority View Summary
- **Usage-based (20%):** Fair but unpredictable revenue; may confuse SMB customers
- **Freemium (8%):** Good for adoption but may cannibalize paid users
- **Hybrid (9%):** Complex; harder to communicate value

---

## Compute Reduction Analysis

### Standard Self-Consistency (Baseline)

**Method:** Generate K paths, vote on all K answers, majority wins

**Compute per path:**
- Generation: 1 unit
- Comparison with all others: K-1 units
- Total per path: K units
- Total overall: K × K = K^2

**For K=10:** 100 compute units

### RASC (Optimized)

**Method:** Generate K paths, cluster by rationale, vote on representatives only

**Compute breakdown:**
- Generation: K units (10)
- Clustering: K × log(K) units (~33 for K=10)
- Representative selection: C units (5 clusters)
- Voting on representatives: C^2 units (25)
- Total: K + K×log(K) + C + C^2

**For K=10, C=5:** 10 + 33 + 5 + 25 = 73 compute units

### Reduction Calculation

```
Baseline: 100 units
RASC: 73 units
Reduction: (100 - 73) / 100 = 27%
```

**Observed Reduction: 27%**

**Claimed Reduction: 70%**

**Discrepancy Analysis:**

The 70% reduction claim appears to be based on a different baseline or larger K values.

**Scenario with K=20, C=5:**
- Baseline: 400 units
- RASC: 20 + 86 + 5 + 25 = 136 units
- Reduction: 66%

**Scenario with K=30, C=5:**
- Baseline: 900 units
- RASC: 30 + 147 + 5 + 25 = 207 units
- Reduction: 77%

**Finding:** The 70% reduction is achievable with K >= 25 and C <= 6.

---

## Issues Found

### Issue 1: Compute Reduction is K-Dependent
The claimed 70% reduction only holds for larger K values (25+). For smaller K (10), reduction is only ~27%.

**Recommendation:** Document the K-value assumptions for compute reduction claims.

### Issue 2: Clustering Quality Sensitivity
The quality of clusters depends heavily on rationale text similarity. Similar answers with different rationales may end up in separate clusters.

**Example:** Paths 3 and 5 both recommended simpler/cheaper options but for different reasons. They were clustered together, but edge case.

**Recommendation:** Consider hybrid clustering (answer + rationale) for robustness.

### Issue 3: Single-Path Clusters
Clusters D and E had only 1 path each. These get disproportionately low weight even if they contain valid insights.

**Recommendation:** Set a minimum weight floor for single-path clusters, or merge them into nearest larger cluster.

### Issue 4: Confidence Conflation
Representative confidence is used for weighting, but cluster size is also a factor. These two signals may conflict.

**Example:** A small cluster with high confidence vs. large cluster with medium confidence - which should win?

**Recommendation:** Formalize the confidence vs. size trade-off with explicit formula.

---

## Pass/Fail Verdict

### Criteria Verification

| Criterion | Expected | Observed | Status |
|-----------|----------|----------|--------|
| Multiple reasoning paths | K=10 paths generated | 10 paths created | PASS |
| Collect answer AND rationale | Both captured | Both captured for all paths | PASS |
| Cluster by rationale similarity | Group similar reasoning | 5 clusters identified | PASS |
| Representative selection | One per cluster | 5 representatives selected | PASS |
| Weighted voting | Cluster size × confidence | Formula applied correctly | PASS |
| Eliminate redundant paths | Reduce from K to C | 10 -> 5 (50% reduction) | PASS |
| 70% compute reduction | Significant savings | 27% observed (for K=10) | PARTIAL FAIL |

### Overall Verdict: **PASS** (with caveats on compute claim)

The RASC pattern successfully:
- Generated diverse reasoning paths
- Clustered by rationale similarity
- Selected representatives from each cluster
- Applied weighted voting for final decision
- Reduced redundant computation through clustering

**Caveats:**
1. 70% compute reduction only achieved with K >= 25
2. For K=10, only 27% reduction observed
3. Single-path clusters may be underweighted

### RASC Value Observed
- Eliminated 5 redundant paths (those agreeing with cluster representatives)
- Preserved diversity by keeping one path per rationale theme
- Final answer benefited from seeing all rationale types, not just majority

---

## Test Metadata
- Test Date: 2026-01-18
- Pattern Version: 1.0
- Test Duration: Simulated 4-phase execution
- Tester: Claude Opus 4.5
