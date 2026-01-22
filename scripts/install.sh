#!/bin/bash
#
# Claude Cognitive Reasoning Framework - Installation Script
# https://github.com/kimasplund/claude_cognitive_reasoning
#
# Usage:
#   ./scripts/install.sh          # Full installation
#   ./scripts/install.sh --skills # Skills only
#   ./scripts/install.sh --agents # Agents only
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"
CLAUDE_DIR="$HOME/.claude"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Claude Cognitive Reasoning Framework - Installer v3.0     ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if ~/.claude exists
if [ ! -d "$CLAUDE_DIR" ]; then
    echo -e "${YELLOW}Creating ~/.claude directory...${NC}"
    mkdir -p "$CLAUDE_DIR"
fi

# Parse arguments
INSTALL_SKILLS=true
INSTALL_AGENTS=true
INSTALL_FRAMEWORKS=true

if [ "$1" == "--skills" ]; then
    INSTALL_AGENTS=false
    INSTALL_FRAMEWORKS=false
elif [ "$1" == "--agents" ]; then
    INSTALL_SKILLS=false
    INSTALL_FRAMEWORKS=false
elif [ "$1" == "--help" ] || [ "$1" == "-h" ]; then
    echo "Usage: ./install.sh [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --skills     Install cognitive skills only"
    echo "  --agents     Install agents only"
    echo "  -h, --help   Show this help message"
    echo ""
    echo "Default: Install everything (skills, agents, frameworks)"
    exit 0
fi

# Install cognitive skills
if [ "$INSTALL_SKILLS" = true ]; then
    echo -e "${GREEN}Installing cognitive skills...${NC}"
    mkdir -p "$CLAUDE_DIR/skills"

    if [ -d "$REPO_DIR/cognitive-skills" ]; then
        for skill_dir in "$REPO_DIR/cognitive-skills"/*/; do
            if [ -d "$skill_dir" ]; then
                skill_name=$(basename "$skill_dir")
                echo "  - $skill_name"
                cp -r "$skill_dir" "$CLAUDE_DIR/skills/"
            fi
        done

        # Copy integration guide
        if [ -f "$REPO_DIR/cognitive-skills/INTEGRATION_GUIDE.md" ]; then
            cp "$REPO_DIR/cognitive-skills/INTEGRATION_GUIDE.md" "$CLAUDE_DIR/skills/"
        fi

        echo -e "${GREEN}  ✓ Cognitive skills installed${NC}"
    else
        echo -e "${RED}  ✗ cognitive-skills directory not found${NC}"
    fi
    echo ""
fi

# Install skill frameworks
if [ "$INSTALL_FRAMEWORKS" = true ]; then
    echo -e "${GREEN}Installing skill frameworks...${NC}"
    mkdir -p "$CLAUDE_DIR/skills"

    if [ -d "$REPO_DIR/skill-frameworks" ]; then
        for framework_dir in "$REPO_DIR/skill-frameworks"/*/; do
            if [ -d "$framework_dir" ]; then
                framework_name=$(basename "$framework_dir")
                echo "  - $framework_name"
                cp -r "$framework_dir" "$CLAUDE_DIR/skills/"
            fi
        done
        echo -e "${GREEN}  ✓ Skill frameworks installed${NC}"
    else
        echo -e "${YELLOW}  ! skill-frameworks directory not found (optional)${NC}"
    fi
    echo ""
fi

# Install agents
if [ "$INSTALL_AGENTS" = true ]; then
    echo -e "${GREEN}Installing agents...${NC}"
    mkdir -p "$CLAUDE_DIR/agents"

    if [ -d "$REPO_DIR/agent-examples" ]; then
        for agent_file in "$REPO_DIR/agent-examples"/*.md; do
            if [ -f "$agent_file" ]; then
                agent_name=$(basename "$agent_file")
                echo "  - $agent_name"
                cp "$agent_file" "$CLAUDE_DIR/agents/"
            fi
        done
        echo -e "${GREEN}  ✓ Agents installed${NC}"
    else
        echo -e "${RED}  ✗ agent-examples directory not found${NC}"
    fi
    echo ""
fi

# Install commands
if [ -d "$REPO_DIR/commands" ]; then
    echo -e "${GREEN}Installing commands...${NC}"
    mkdir -p "$CLAUDE_DIR/commands"

    for cmd_file in "$REPO_DIR/commands"/*.md; do
        if [ -f "$cmd_file" ]; then
            cmd_name=$(basename "$cmd_file")
            echo "  - $cmd_name"
            cp "$cmd_file" "$CLAUDE_DIR/commands/"
        fi
    done
    echo -e "${GREEN}  Commands installed${NC}"
    echo ""
fi

# Copy CLAUDE.md (optional)
if [ -f "$REPO_DIR/CLAUDE.md" ]; then
    echo -e "${YELLOW}Found CLAUDE.md quick reference.${NC}"
    read -p "Copy to ~/.claude/CLAUDE.md? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cp "$REPO_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
        echo -e "${GREEN}  ✓ CLAUDE.md copied${NC}"
    else
        echo -e "${YELLOW}  - Skipped CLAUDE.md${NC}"
    fi
    echo ""
fi

# Install autonomous-infrastructure (optional)
if [ -d "$REPO_DIR/autonomous-infrastructure" ]; then
    echo -e "${YELLOW}Found autonomous-infrastructure (self-improving orchestration).${NC}"
    echo "This adds hooks for auto-skill recommendations and outcome logging."
    echo "Requires: jq, Python 3, chromadb package"
    read -p "Install autonomous-infrastructure? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Check dependencies
        if ! command -v jq &> /dev/null; then
            echo -e "${RED}  ✗ jq not found. Please install: sudo apt install jq${NC}"
        else
            mkdir -p "$CLAUDE_DIR/hooks"
            cp "$REPO_DIR/autonomous-infrastructure/skill-triggers.yaml" "$CLAUDE_DIR/"
            cp "$REPO_DIR/autonomous-infrastructure/"*.sh "$CLAUDE_DIR/hooks/"
            cp "$REPO_DIR/autonomous-infrastructure/sync-outcomes-to-chroma.py" "$CLAUDE_DIR/hooks/"
            chmod +x "$CLAUDE_DIR/hooks/"*.sh "$CLAUDE_DIR/hooks/"*.py
            echo -e "${GREEN}  ✓ Hooks installed to ~/.claude/hooks/${NC}"
            echo -e "${YELLOW}  ! Add hooks to ~/.claude/settings.json (see autonomous-infrastructure/README.md)${NC}"
        fi
    else
        echo -e "${YELLOW}  - Skipped autonomous-infrastructure${NC}"
    fi
    echo ""
fi

# Summary
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║  Installation Complete!                                     ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Installed to: $CLAUDE_DIR"
echo ""
echo "Skills:   $(ls -1 "$CLAUDE_DIR/skills" 2>/dev/null | wc -l) installed"
echo "Agents:   $(ls -1 "$CLAUDE_DIR/agents" 2>/dev/null | wc -l) installed"
echo "Commands: $(ls -1 "$CLAUDE_DIR/commands" 2>/dev/null | wc -l) installed"
echo ""
echo -e "${GREEN}Usage:${NC}"
echo "  - Skills activate automatically when Claude detects matching problems"
echo "  - Use /skill-name to invoke skills manually"
echo "  - Agents are used automatically via the Task tool"
echo ""
echo -e "${GREEN}Key commands:${NC}"
echo "  /integrated-reasoning-v2  - Meta-orchestrator for complex problems"
echo "  /tree-of-thoughts         - Systematic solution exploration"
echo "  /adversarial-reasoning    - Security validation"
echo ""
echo "Documentation: https://github.com/kimasplund/claude_cognitive_reasoning"
