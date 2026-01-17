# CLAUDE.md - Cognitive Framework Quick Reference

## LLM Limitations Acknowledgment

- **Context window limits**: Long conversations lose early context; summarize and checkpoint
- **Hallucination risk**: LLMs confidently generate plausible-sounding nonsense
- **Confidence != correctness**: High certainty in response does not mean accuracy
- **Always verify, never assume**: Check facts, test code, validate outputs
- **Prefer research over guessing**: Use web search, read docs, grep codebase - don't fabricate

## Cognitive Skills Available

| Pattern | Purpose |
|---------|---------|
| **ToT** (Tree of Thoughts) | Find best solution through branching exploration |
| **BoT** (Breadth of Thought) | Exhaustively explore all viable options |
| **SRC** (Self-Reflecting Chain) | Sequential reasoning with backtracking |
| **HE** (Hypothesis Exploration) | Test competing hypotheses systematically |
| **AR** (Analogical Reasoning) | Transfer solutions from similar domains |
| **DR** (Dialectical Reasoning) | Resolve tensions through thesis-antithesis-synthesis |
| **AT** (Abductive Thinking) | Infer best explanation from observations |
| **RTR** (Rapid Triage Reasoning) | Fast decisions under time pressure |
| **NDF** (Negotiated Decision Framework) | Multi-stakeholder consensus building |

**IR-v2** = Meta-orchestrator that selects optimal pattern(s) for any problem

**Parallel execution**: Multiple patterns can run simultaneously via Task tool

## Testing Philosophy

- **TEST, TEST, TEST** - No code is done until tested
- **"Poke it until it breaks"** - Actively try to break your own code
- **Use break-it-tester agent** - Dedicated adversarial testing for code
- **Never trust untested code** - Assume bugs until proven otherwise
- Edge cases, error paths, malicious input - test them all

## Research Best Practices

- **Verify claims before stating** - Don't echo uncertain info as fact
- **Use web search for current info** - Knowledge cutoff means stale data
- **Cross-reference multiple sources** - Single source = single point of failure
- **Document uncertainty** - "I'm unsure", "based on X", "needs verification"
- When in doubt, say so

## Parallel Execution

- **Task tool** spawns parallel agents for independent work
- **Fan-out pattern**: Distribute work, collect results
- **Merge strategy**: Explicit plan for combining parallel outputs
- Good for: research, analysis, independent file edits
- Bad for: sequential dependencies, shared state

## Key Files

- `cognitive-skills/INTEGRATION_GUIDE.md` - How to use cognitive patterns
- `cognitive-skills/integrated-reasoning-v2/SKILL.md` - IR-v2 meta-orchestrator details
- `cognitive-skills/reasoning-handover-protocol/SKILL.md` - Handoff between reasoning modes
