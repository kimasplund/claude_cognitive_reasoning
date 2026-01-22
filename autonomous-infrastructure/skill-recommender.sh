#!/bin/bash
# Skill Recommender Hook
# Analyzes task descriptions and recommends relevant skills/agents
# Runs as PreToolUse hook for Task tool

# Read JSON input from stdin
INPUT=$(cat)

# Extract the prompt from Task tool input
PROMPT=$(echo "$INPUT" | jq -r '.tool_input.prompt // empty' 2>/dev/null)

# If no prompt, exit silently
if [ -z "$PROMPT" ]; then
    exit 0
fi

# Convert to lowercase for matching
PROMPT_LOWER=$(echo "$PROMPT" | tr '[:upper:]' '[:lower:]')

# Initialize recommendations
RECOMMENDATIONS=""

# Debug/Investigation patterns
if echo "$PROMPT_LOWER" | grep -qE "debug|bug|error|fail|broken|crash|exception|not working"; then
    RECOMMENDATIONS="Consider using: root-cause-analyzer agent, debug:parallel skill"
fi

# Implementation patterns
if echo "$PROMPT_LOWER" | grep -qE "implement|build|create|add feature|develop"; then
    if [ -n "$RECOMMENDATIONS" ]; then
        RECOMMENDATIONS="$RECOMMENDATIONS\n"
    fi
    RECOMMENDATIONS="${RECOMMENDATIONS}Consider using: plan:parallel skill, confidence-check-skills, implementor agent"
fi

# Research patterns
if echo "$PROMPT_LOWER" | grep -qE "research|investigate|explore|compare|alternatives"; then
    if [ -n "$RECOMMENDATIONS" ]; then
        RECOMMENDATIONS="$RECOMMENDATIONS\n"
    fi
    RECOMMENDATIONS="${RECOMMENDATIONS}Consider using: research:deep skill, research-specialist agent"
fi

# Architecture patterns
if echo "$PROMPT_LOWER" | grep -qE "architect|design|structure|trade-?off|which approach"; then
    if [ -n "$RECOMMENDATIONS" ]; then
        RECOMMENDATIONS="$RECOMMENDATIONS\n"
    fi
    RECOMMENDATIONS="${RECOMMENDATIONS}Consider using: integrated-reasoning-v2 skill, architect-agent"
fi

# Security patterns
if echo "$PROMPT_LOWER" | grep -qE "security|vulnerab|threat|audit|attack"; then
    if [ -n "$RECOMMENDATIONS" ]; then
        RECOMMENDATIONS="$RECOMMENDATIONS\n"
    fi
    RECOMMENDATIONS="${RECOMMENDATIONS}Consider using: security-analysis-skills, security-agent, break-it-tester"
fi

# Parallel execution hint
if echo "$PROMPT_LOWER" | grep -qE " and | also |multiple|several"; then
    if [ -n "$RECOMMENDATIONS" ]; then
        RECOMMENDATIONS="$RECOMMENDATIONS\n"
    fi
    RECOMMENDATIONS="${RECOMMENDATIONS}Hint: Task may benefit from parallel agent execution"
fi

# Output recommendations as additionalContext if any
if [ -n "$RECOMMENDATIONS" ]; then
    echo "{\"additionalContext\": \"Skill recommendations based on task patterns:\\n$RECOMMENDATIONS\"}"
fi
