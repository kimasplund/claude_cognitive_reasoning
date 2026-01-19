# Human Memory Consolidation Mechanisms and Their Relevance to AI Agent Memory Systems

**Research Date**: January 19, 2026
**Researcher**: Research Specialist Agent
**Scope**: Comprehensive analysis of human memory consolidation neuroscience and its application to LLM agent memory architectures

---

## Executive Summary

This research explores how human memory consolidation mechanisms can inform the design of better AI agent memory systems. Current LLM agent memory (e.g., ChromaDB-based systems) functions primarily as passive storage and retrieval, lacking the active consolidation, pruning, and schema formation processes that make biological memory so effective. By understanding the neuroscience of memory consolidation, we can identify concrete improvements for agent memory architectures.

**Key Findings**:
1. Human memory uses a two-stage system (hippocampus + neocortex) with active consolidation during sleep that AI lacks
2. Synaptic homeostasis (selective pruning during sleep) prevents interference and maintains memory capacity - agents have no equivalent
3. Schema formation allows humans to abstract general principles from specific experiences - agents store raw instances without generalization
4. Spaced repetition and replay strengthen important memories - agents neither replay nor strengthen patterns based on usage

**Overall Confidence**: 85%

---

## Part 1: Human Memory Consolidation Mechanisms

### 1.1 The Three Stages of Memory

Memory operates through a multi-staged process that includes encoding, consolidation, retrieval, and forgetting:

**Encoding**: The process of converting incoming information into a mental representation. Neurons are preferentially recruited in memory encoding based on specialized intrinsic properties. This is an energetically costly process - our memory systems have evolved to adaptively encode only the most salient information, such as environmental cues associated with threatening or rewarding experiences.

**Consolidation**: The process where short-term memories are transformed into long-term memories. According to systems consolidation theory, memories initially dependent on the hippocampus are reorganized over time. The hippocampus gradually becomes less important for storage and retrieval, and more permanent memory develops in distributed regions of the neocortex.

**Retrieval**: Biologically, memories are stored as spatiotemporal patterns of activity across neuronal networks. Being in the same state or context activates part of the neuronal pattern associated with the memory, facilitating full activation of the memory trace for retrieval.

### 1.2 Sleep-Based Consolidation and Hippocampal Replay

Sleep plays a critical role in memory consolidation through several mechanisms:

**Hippocampal Replay**: During sleep (and rest), the brain reactivates neural patterns linked to past events. A 2024 Science study found that the brain has parallel circuits regulated by two types of interneurons - one that regulates memory, the other that allows for resetting of memories. During certain times in deep sleep, parts of the hippocampus go silent, allowing neurons to reset.

**Active Systems Consolidation**: Memory representations initially reliant on the hippocampus are redistributed to neocortex during sleep for long-term storage. A 2025 review in Annual Reviews highlighted that human replay prioritizes past experiences for offline learning, generates hypothesized solutions to current problems, and factorizes structural representations for future generalization.

**Reward-Biased Replay**: Research in Nature Communications (2025) demonstrated that reward-prediction signals shape which memories are replayed during sleep, supporting sleep-dependent learning over multiple days.

**Hippocampal-Prefrontal Synchrony**: Studies using closed-loop deep brain stimulation showed that synchronizing stimulation to slow waves enhanced sleep spindles, boosted neural synchrony, and improved recognition memory accuracy.

### 1.3 Synaptic Homeostasis Hypothesis (SHY)

The Synaptic Homeostasis Hypothesis, developed by Drs. Chiara Cirelli and Giulio Tononi, proposes that:

- Waking experiences are encoded through experience-dependent Long-Term Potentiation (strengthening of synapses)
- Synapse strength is then restored to baseline during sleep through global but selective scaling-down (weakening)
- "Sleep is the price the brain pays for plasticity"

**Differential Sleep Stage Roles**:
- **NREM Sleep**: Selectively downscales highly active neurons while memory-related synaptic assemblies are reactivated, preserving their strength
- **REM Sleep**: Induces broader network-wide synaptic weakening
- The balance between global downscaling and memory-specific upscaling supports both synaptic homeostasis and memory reorganization

**2024-2025 Evidence**: A Nature study (2024) on zebrafish confirmed that synaptic genes, proteins, and post-translational modifications are upregulated during waking and renormalized during sleep. A PNAS study (2025) showed that during sleep, task-irrelevant connections are pruned while surviving synaptic connections are collectively scaled down to maintain firing rate homeostasis.

### 1.4 Spaced Repetition Mechanisms

Spaced repetition enhances memory through several neural mechanisms:

**Synaptic Spine Remodeling**: The learning process includes a refractory period during which a second closely spaced stimulus would be ineffective. Spaced repetitions allow this refractory period to be overcome, leading to repeated enlargement of dendritic spines and strengthening of synaptic connections.

**Neural Pattern Similarity**: Research shows that spaced learning increases the similarity of ventromedial prefrontal cortex representations across stimulus encounters, and these increases parallel and predict the behavioral benefits of spacing.

**Contextual Encoding**: Spaced repetitions lead to a greater variety of contextual elements being integrated into memory compared to massed repetitions, producing better retention on delayed tests.

**Neurogenesis**: Newly generated cells in the dentate gyrus appear to play a role in the retention and/or retrieval of memories from spaced learning.

### 1.5 Interference Theory

Interference theory states that forgetting occurs because memories interfere with and disrupt one another:

**Retroactive Interference**: New information impairs the ability to retrieve previously acquired memory traces.

**Proactive Interference**: Previously acquired memory traces interfere with the ability to retrieve new information.

**Neural Mechanisms**: The memory literature has identified both passive interference (competition from similar memories) and active inhibition (goal-directed forgetting) as sources of forgetting. The hippocampus may be involved in binding item information to context information, which helps distinguish similar memories.

**Catastrophic Interference in AI**: Unlike humans who experience only partial forgetting, early connectionist models exhibited catastrophic interference where new learning produced almost complete forgetting of previously learned information. This led to proposals of complementary learning systems with distinct hippocampal and neocortical components.

### 1.6 Schema Formation

Schemas are superordinate knowledge structures that reflect abstracted commonalities across multiple experiences:

**Neural Networks for Schemas**: The ventromedial prefrontal cortex (vmPFC), hippocampus, angular gyrus, and posterior cortical regions form the schema network. The medial prefrontal cortex plays a key role in gradually integrating commonalities extracted by the hippocampus into stable, abstract schemas over longer timescales.

**Memory Transformation**: From the onset of encoding, schemas drive the process of gist extraction - inconsequential unique details are weakened while schema-congruent components are strengthened. Reiterative processes of gist extraction can ultimately lead to concept abstraction.

**Reinforcement Learning Principles**: Three RL principles govern schema learning:
1. Learning via prediction errors
2. Constructing hierarchical knowledge using hierarchical RL
3. Dimensionality reduction through learning a simplified, abstract representation of the world

---

## Part 2: Current State of AI Agent Memory Systems

### 2.1 Vector Database Memory (ChromaDB and Alternatives)

Current LLM agent memory systems primarily use vector databases for storage and retrieval:

**How They Work**:
- Raw experiences/improvements are embedded as vectors
- Storage is append-only with metadata tagging
- Retrieval uses approximate nearest neighbor (ANN) search based on semantic similarity
- ChromaDB, FAISS, Qdrant, Weaviate, and Milvus are leading options

**Limitations Identified**:
- No active consolidation process - memories remain as stored
- No automatic pruning beyond manual deprecation flags
- No schema formation or abstraction from specific cases
- No replay or strengthening based on usage patterns
- "Hot" and "cold" memories treated equivalently

### 2.2 Recent Memory Systems Research (2024-2025)

**Memory Evolution Framework**: Research explores memory lifecycle through Formation (extraction), Evolution (consolidation & forgetting), and Retrieval (access strategies).

**A-MEM (2025)**: Applies Zettelkasten principles to create interconnected knowledge networks through dynamic indexing and linking of memories.

**Mem0**: A scalable memory architecture that dynamically extracts, consolidates, and retrieves important information from conversations. Demonstrates 26% accuracy boost, 91% lower p95 latency, and 90% token savings.

**Challenges Identified**:
- Systems often lack automated forgetting policies, memory summarization, or redundancy management
- Handling commonsense knowledge, dynamic schema adaptation, and factual drift remains difficult
- Periodically consolidating external memory contents into LLM parameters without forgetting previous knowledge is an open research question

### 2.3 Catastrophic Forgetting in AI

**The Problem**: Neural networks abruptly erase previously learned information when trained on new tasks. Unlike humans who integrate new knowledge without losing past skills, AI models often overwrite old weights.

**Replay as a Solution**: The most widely used approach for continual learning is replay (rehearsal), which approximates interleaved learning by complementing current training data with data representative of previous tasks.

**Recent Methods**:
- **CORE (2024)**: Cognitive Replay inspired by human memory processes
- **Goldilocks Method (2024)**: Keeps examples learned at an optimal pace to reduce forgetting
- **Experience Replay**: Storing previously seen data in a memory buffer and revisiting them

**LLM-Specific Findings**: Despite impressive capabilities, LLMs struggle to generalize to future unseen data, particularly in the face of temporal or domain shifts. They also struggle to retain complete knowledge of past experiences when adapting to new domains, though they show more robustness against catastrophic forgetting than traditional neural networks.

### 2.4 Sleep-Inspired AI Memory Research

**Sleep Replay Consolidation (SRC) Algorithm**: Researchers tested implementing a sleep-like phase in ANNs and showed that occasional off-line periods mimicking sleep enable continual learning of multiple tasks without catastrophic forgetting.

**"Language Models Need Sleep" (2025)**: Introduced a paradigm allowing models to continually learn and transfer short-term fragile memories into stable long-term knowledge through:
1. Memory Consolidation via parameter expansion
2. A "Dreaming" process with Knowledge Seeding distillation

**NeuroDream (2024)**: A sleep-inspired memory consolidation framework for artificial neural networks.

### 2.5 Complementary Learning Systems in AI

**VAE+MHN Architecture (2024-2025)**: Integrates hippocampal (Modern Hopfield Network) and neocortical (variational auto-encoder) components, enabling simulation of dynamic neocortical-hippocampal interactions during memory encoding and retrieval.

**Recall-Gated Consolidation**: A model where synaptic updates are consolidated into long-term memory depending on their consistency with knowledge already stored, prioritizing reliable patterns that are consistently reinforced over time.

**Generalization Trade-off**: Research reveals that unregulated memory transfer can cause overfitting - memories should only consolidate when it aids generalization.

### 2.6 Memory Interference in RAG Systems

**Context-Memory Conflict**: When retrieved context contradicts the LLM's parametric knowledge, models often fail to resolve the conflict. CARE (Conflict-Aware REtrieval-Augmented Generation) was developed to address this using a context assessor.

**Conflicting Evidence**: RAG systems often propagate misinformation if retrieved documents contain errors, or arbitrarily choose an answer when documents provide conflicting claims.

**Semantic Deduplication**: Tools like SemHash and techniques using embedding similarity (documents with cosine similarity above threshold) help prune redundant content from vector databases.

---

## Part 3: Gap Analysis - What Human Consolidation Teaches Us

### 3.1 The Consolidation Gap

| Human Memory | Current Agent Memory (ChromaDB) | Gap |
|--------------|--------------------------------|-----|
| Two-stage system (hippocampus -> neocortex) | Single-stage storage | No redistribution to more efficient representations |
| Active replay during sleep | Passive storage | No strengthening of important patterns |
| Selective pruning of weak connections | Manual deprecation flags | No automatic removal of low-value memories |
| Schema formation across experiences | Instance-level storage | No abstraction to general principles |
| Context-sensitive retrieval | Similarity-only retrieval | Limited conflict detection and resolution |
| Spaced reinforcement | Single encoding | No strengthening through repeated access |
| Interference protection | Append-only storage | Conflicting memories coexist unresolved |

### 3.2 Specific Gaps Identified

**Gap 1: No Consolidation Phase**
- ChromaDB stores raw improvements without any post-storage processing
- Human memory actively reorganizes during sleep
- Agent memory never "sleeps" to consolidate

**Gap 2: No Replay Mechanism**
- Agents retrieve on-demand but don't proactively "replay" important patterns
- Human replay during sleep strengthens and transforms memories
- Without replay, all memories decay equivalently regardless of importance

**Gap 3: No Synaptic Homeostasis Equivalent**
- Agents accumulate memories indefinitely
- No mechanism to prune conflicting/outdated learnings
- No "global downscaling" to maintain capacity

**Gap 4: No Schema Formation**
- Each learning is stored as a specific instance
- No process to extract common patterns across experiences
- No hierarchical organization of abstract vs. concrete knowledge

**Gap 5: No Interference Management**
- New learnings can contradict old ones without detection
- No mechanism to resolve conflicts between memories
- Context-memory conflicts in RAG remain a known challenge

**Gap 6: No Spaced Strengthening**
- Memories accessed frequently are not strengthened
- No usage-based reinforcement of valuable patterns
- Access patterns don't influence memory persistence

---

## Part 4: Recommendations for Agent Memory Architecture

### 4.1 Implement Consolidation Phases

**Recommendation**: Add periodic "sleep cycles" where the agent reviews and consolidates memories.

```
CONSOLIDATION_CYCLE:
1. Query recent memories (last N interactions)
2. Identify patterns that appear across multiple experiences
3. Strengthen memories used successfully
4. Merge similar memories into consolidated representations
5. Update confidence scores based on corroboration
```

**Biological Inspiration**: Hippocampal replay during slow-wave sleep redistributes memories to neocortex.

### 4.2 Implement Usage-Based Reinforcement

**Recommendation**: Track memory access patterns and strengthen frequently-used, successful memories.

```
MEMORY_METADATA_EXTENSIONS:
- access_count: int
- last_accessed: timestamp
- success_rate: float (when retrieved, did it help?)
- reinforcement_score: float (access_count * success_rate * recency_weight)
```

**Biological Inspiration**: Spaced repetition strengthens synaptic connections through repeated activation.

### 4.3 Add Automatic Pruning (Synaptic Homeostasis)

**Recommendation**: Implement tiered memory with automatic downscaling of low-value memories.

```
PRUNING_ALGORITHM:
1. Calculate memory value = (confidence * access_frequency * recency) / conflict_count
2. Identify memories below threshold
3. For low-value memories:
   - If conflicting with high-value memory: deprecate
   - If rarely accessed: move to cold storage or delete
   - If old but uncorroborated: reduce confidence
```

**Biological Inspiration**: During sleep, task-irrelevant connections are pruned while surviving connections are scaled down.

### 4.4 Implement Schema Extraction

**Recommendation**: Periodically analyze specific memories to extract abstract principles.

```
SCHEMA_FORMATION:
1. Cluster similar memories by topic/context
2. For each cluster with N > threshold experiences:
   a. Identify common patterns across instances
   b. Extract abstract principle
   c. Store as schema with link to supporting instances
   d. Use schema for future retrieval when specific match unavailable
3. Schemas influence confidence of new memories (schema-congruent = higher confidence)
```

**Biological Inspiration**: vmPFC gradually integrates commonalities into stable, abstract schemas.

### 4.5 Conflict Detection and Resolution

**Recommendation**: Actively detect and resolve conflicting memories.

```
CONFLICT_RESOLUTION:
1. On new memory insertion:
   a. Query for semantically similar existing memories
   b. Check for factual contradictions
   c. If conflict detected:
      - Compare source credibility
      - Compare recency
      - Compare corroboration levels
      - Keep higher-confidence version, deprecate lower
      - Log conflict for potential human review
```

**Biological Inspiration**: Complementary learning systems prevent catastrophic interference through hippocampal-neocortical interaction.

### 4.6 Implement Replay-Based Learning

**Recommendation**: Periodically "replay" successful task patterns to reinforce learning.

```
REPLAY_MECHANISM:
1. Select memories marked as high-value (successful, frequently accessed)
2. Re-embed with current model (accounts for any model updates)
3. Analyze for new connections to other memories
4. Update relationship graphs between memories
5. Consider generating synthetic variations (data augmentation)
```

**Biological Inspiration**: Awake and sleep replay reactivates and strengthens important memory traces.

### 4.7 Two-Stage Memory Architecture

**Recommendation**: Implement complementary short-term and long-term memory systems.

```
DUAL_MEMORY_ARCHITECTURE:
SHORT_TERM (like hippocampus):
- Fast encoding of new experiences
- High detail, low abstraction
- Limited capacity (recent N experiences)

LONG_TERM (like neocortex):
- Consolidated, schema-aligned memories
- Lower detail, higher abstraction
- Larger capacity, more stable

CONSOLIDATION_PROCESS:
- During "sleep", transfer valuable short-term to long-term
- Schema-congruent memories transfer faster
- Conflicting memories trigger resolution before transfer
```

**Biological Inspiration**: McClelland et al.'s complementary learning systems with distinct hippocampal and neocortical components.

---

## Part 5: Implementation Priorities

### Priority 1: Usage Tracking and Reinforcement (High Value, Low Effort)
Add metadata tracking for access patterns and success rates. Implement simple scoring to identify high-value memories.

### Priority 2: Automatic Pruning (High Value, Medium Effort)
Implement tiered storage with automatic deprecation of low-scoring memories. Critical for maintaining memory quality at scale.

### Priority 3: Conflict Detection (High Value, Medium Effort)
Add contradiction checking on memory insertion. Essential for knowledge integrity.

### Priority 4: Consolidation Cycles (High Value, Higher Effort)
Implement periodic review and merging of memories. Requires defining consolidation triggers and merge strategies.

### Priority 5: Schema Formation (Medium-High Value, Higher Effort)
Add abstraction layer to extract principles from instances. Most complex but provides generalization benefits.

### Priority 6: Dual Memory Architecture (Highest Value, Highest Effort)
Full architectural redesign with complementary learning systems. Long-term goal for robust continual learning.

---

## Confidence Assessment

**Overall Confidence**: 85%

**High Confidence Areas**:
- Neuroscience of memory consolidation (well-established research)
- Gaps between current agent memory and biological systems (clearly documented)
- Value of sleep-based consolidation for AI (emerging but validated research)

**Medium Confidence Areas**:
- Specific implementation recommendations (theoretical, not yet validated in production)
- Priority ordering (depends on specific use cases)

**Lower Confidence Areas**:
- Optimal parameters for pruning/consolidation thresholds
- Whether schema formation can be effectively automated for diverse domains

**Research Limitations**:
- Most sleep-inspired AI memory research is still in early stages (2024-2025)
- Limited production-scale validation of consolidated memory systems
- Trade-offs between consolidation overhead and retrieval performance not fully characterized

---

## Sources

### Sleep-Based Consolidation and Hippocampal Replay
- [Sleep resets neurons for new memories the next day | Cornell Chronicle](https://news.cornell.edu/stories/2024/08/sleep-resets-neurons-new-memories-next-day)
- [Awake replay: off the clock but on the job | Trends in Neurosciences](https://www.cell.com/trends/neurosciences/fulltext/S0166-2236(25)00037-2)
- [Replay and Ripples in Humans | Annual Reviews](https://www.annualreviews.org/doi/pdf/10.1146/annurev-neuro-112723-024516)
- [Augmenting hippocampal-prefrontal neuronal synchrony during sleep | Nature Neuroscience](https://www.nature.com/articles/s41593-023-01324-5)
- [Post-learning replay of hippocampal-striatal activity is biased by reward-prediction signals | Nature Communications](https://www.nature.com/articles/s41467-025-65354-2)
- [Systems memory consolidation during sleep | PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC12576410/)

### Synaptic Homeostasis
- [Two-factor synaptic consolidation reconciles robustness with pruning and homeostatic scaling | PNAS](https://www.pnas.org/doi/10.1073/pnas.2422602122)
- [Sleep pressure modulates single-neuron synapse number in zebrafish | Nature](https://www.nature.com/articles/s41586-024-07367-3)
- [Sleep and the Price of Plasticity | PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC3921176/)
- [Remembering and forgetting in sleep: Selective synaptic plasticity | PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC9826981/)

### Memory Encoding, Consolidation, and Retrieval
- [Engram neurons: Encoding, consolidation, retrieval, and forgetting | Molecular Psychiatry](https://www.nature.com/articles/s41380-023-02137-5)
- [Memory Consolidation | PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC4526749/)
- [An overview of neuro-cognitive processes in memory | Behavioral and Brain Functions](https://link.springer.com/article/10.1186/1744-9081-8-35)

### Spaced Repetition
- [The right time to learn: mechanisms and optimization of spaced learning | PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC5126970/)
- [Spaced Learning Enhances Episodic Memory by Increasing Neural Pattern Similarity | PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC6607761/)
- [Benefits of spaced learning predicted by re-encoding in vmPFC | ScienceDirect](https://www.sciencedirect.com/science/article/pii/S2211124925000038)
- [Neurogenesis and the spacing effect | PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC1876761/)

### Interference Theory and Catastrophic Forgetting
- [Interference Theory | ScienceDirect Topics](https://www.sciencedirect.com/topics/neuroscience/interference-theory)
- [Catastrophic interference | Wikipedia](https://en.wikipedia.org/wiki/Catastrophic_interference)
- [The Mechanisms Underlying Interference and Inhibition | PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC8467325/)
- [The Cost of Learning: Interference Effects in Memory Development | PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC4388774/)

### Schema Formation
- [Neurobiology of Schemas and Schema-Mediated Memory | Trends in Cognitive Sciences](https://www.cell.com/trends/cognitive-sciences/abstract/S1364-6613(17)30086-4)
- [Schemas, reinforcement learning and the medial prefrontal cortex | Nature Reviews Neuroscience](https://www.nature.com/articles/s41583-024-00893-z)
- [Schema formation in a neural population subspace | PMC](https://pmc.ncbi.nlm.nih.gov/articles/PMC11559441/)

### AI Agent Memory Systems
- [Agent Memory Paper List | GitHub](https://github.com/Shichun-Liu/Agent-Memory-Paper-List)
- [A-MEM: Agentic Memory for LLM Agents | GitHub](https://github.com/agiresearch/A-mem)
- [AI Memory Research: 26% Accuracy Boost | Mem0](https://mem0.ai/research)
- [A Survey on the Memory Mechanism of LLM-based Agents | ACM](https://dl.acm.org/doi/10.1145/3748302)
- [Enhancing memory retrieval in generative agents | Frontiers](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2025.1591618/full)

### Continual Learning and Catastrophic Forgetting in AI
- [Continual Learning Inspired by Brain Functionality: A Survey | Wiley](https://onlinelibrary.wiley.com/doi/10.1155/int/3145236)
- [Continual Learning of Large Language Models: A Survey | ACM](https://dl.acm.org/doi/10.1145/3735633)
- [Continual Learning and Catastrophic Forgetting | arXiv](https://arxiv.org/html/2403.05175v1)
- [FOREVER: Forgetting Curve-Inspired Memory Replay | arXiv](https://arxiv.org/html/2601.03938)

### Sleep-Inspired AI Memory
- [Sleep-like unsupervised replay reduces catastrophic forgetting | Nature Communications](https://www.nature.com/articles/s41467-022-34938-7)
- [Language Models Need Sleep | OpenReview](https://openreview.net/forum?id=iiZy6xyVVE)
- [NeuroDream: Sleep-Inspired Memory Consolidation | SSRN](https://papers.ssrn.com/sol3/Delivery.cfm/5377250.pdf?abstractid=5377250&mirid=1)

### Complementary Learning Systems
- [Organizing memories for generalization in complementary learning systems | Nature Neuroscience](https://www.nature.com/articles/s41593-023-01382-9)
- [A Neural Network Model of Complementary Learning Systems | arXiv](https://arxiv.org/html/2507.11393)
- [Selective consolidation of learning via recall-gated plasticity | eLife](https://elifesciences.org/articles/90793)
- [Memory consolidation from a reinforcement learning perspective | Frontiers](https://www.frontiersin.org/journals/computational-neuroscience/articles/10.3389/fncom.2024.1538741/full)

### RAG and Memory Interference
- [Retrieval-Augmented Generation with Conflicting Evidence | arXiv](https://arxiv.org/html/2504.13079)
- [Conflict-Aware Soft Prompting for RAG | arXiv](https://arxiv.org/abs/2508.15253)
- [RAG Survey: Architectures, Enhancements, and Robustness | arXiv](https://arxiv.org/html/2506.00054v1)

### Semantic Deduplication
- [SemHash: Semantic Text Deduplication | GitHub](https://github.com/MinishLab/semhash)
- [Semantic Deduplication | NVIDIA NeMo-Curator](https://docs.nvidia.com/nemo/curator/latest/curate-text/process-data/deduplication/semdedup.html)
- [MinHash LSH in Milvus | Milvus Blog](https://milvus.io/blog/minhash-lsh-in-milvus-the-secret-weapon-for-fighting-duplicates-in-llm-training-data.md)
