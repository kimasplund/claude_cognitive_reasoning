#!/bin/bash
# Skill Outcome Logger Hook
# Automatically logs task/skill outcomes to ChromaDB skill_memory collection
# Runs as PostToolUse hook for Task and Skill tools

# Read JSON input from stdin
INPUT=$(cat)

# Extract tool name and result
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
TOOL_INPUT=$(echo "$INPUT" | jq -r '.tool_input // empty' 2>/dev/null)
TOOL_RESULT=$(echo "$INPUT" | jq -r '.tool_result // empty' 2>/dev/null)

# Only process Task and Skill tools
if [[ "$TOOL_NAME" != "Task" && "$TOOL_NAME" != "Skill" ]]; then
    exit 0
fi

# Extract relevant info
if [[ "$TOOL_NAME" == "Task" ]]; then
    DESCRIPTION=$(echo "$TOOL_INPUT" | jq -r '.description // "unknown"' 2>/dev/null)
    AGENT_TYPE=$(echo "$TOOL_INPUT" | jq -r '.subagent_type // "unknown"' 2>/dev/null)
    TASK_TYPE="agent"
else
    DESCRIPTION=$(echo "$TOOL_INPUT" | jq -r '.skill // "unknown"' 2>/dev/null)
    AGENT_TYPE="skill"
    TASK_TYPE="skill"
fi

# Check if result indicates success (no error)
if echo "$TOOL_RESULT" | grep -qi "error\|failed\|exception"; then
    SUCCESS="false"
else
    SUCCESS="true"
fi

# Generate unique ID
TIMESTAMP=$(date +%s)
DOC_ID="outcome_${TASK_TYPE}_${TIMESTAMP}"

# Create document content
DOC_CONTENT="Task: ${DESCRIPTION}. Type: ${TASK_TYPE}. Agent/Skill: ${AGENT_TYPE}. Success: ${SUCCESS}. Timestamp: $(date -Iseconds)"

# Log to file for debugging (ChromaDB write would need Python/API)
LOG_FILE="/home/kim/.claude/logs/skill_outcomes.jsonl"
mkdir -p "$(dirname "$LOG_FILE")"

echo "{\"id\": \"${DOC_ID}\", \"task_type\": \"${TASK_TYPE}\", \"description\": \"${DESCRIPTION}\", \"agent\": \"${AGENT_TYPE}\", \"success\": ${SUCCESS}, \"timestamp\": \"$(date -Iseconds)\"}" >> "$LOG_FILE"

# Output nothing (don't modify response)
exit 0
