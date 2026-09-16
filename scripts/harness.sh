#!/usr/bin/env bash
# ==============================================================================
# Claude Code Harness Manager & Workspace Injector
# ==============================================================================
# Allows seamless injection, switching, and management of specialized Claude Code
# workspace harness profiles into your target project.
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
WORKSPACES_DIR="${ROOT_DIR}/examples/workspaces"

COLOR_RESET="\033[0m"
COLOR_BOLD="\033[1m"
COLOR_CYAN="\033[36m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_RED="\033[31m"
COLOR_MAGENTA="\033[35m"

print_banner() {
    echo -e "${COLOR_CYAN}${COLOR_BOLD}"
    echo "  ╔══════════════════════════════════════════════════════════════════╗"
    echo "  ║             CLAUDE CODE HARNESS WORKSPACE MANAGER                ║"
    echo "  ╚══════════════════════════════════════════════════════════════════╝"
    echo -e "${COLOR_RESET}"
}

usage() {
    print_banner
    echo -e "${COLOR_BOLD}Usage:${COLOR_RESET} ./scripts/harness.sh [command] [options]"
    echo ""
    echo -e "${COLOR_BOLD}Commands:${COLOR_RESET}"
    echo -e "  ${COLOR_GREEN}list${COLOR_RESET}                     List all available workspace presets"
    echo -e "  ${COLOR_GREEN}info <preset>${COLOR_RESET}            View details and contents of a workspace preset"
    echo -e "  ${COLOR_GREEN}apply <preset> [target]${COLOR_RESET}  Inject a workspace preset into target directory (default: current dir)"
    echo -e "  ${COLOR_GREEN}audit [target]${COLOR_RESET}           Audit harness configuration in target directory"
    echo -e "  ${COLOR_GREEN}export <name> [source]${COLOR_RESET}   Export current .claude/ and CLAUDE.md as a new workspace preset"
    echo ""
    echo -e "${COLOR_BOLD}Available Presets:${COLOR_RESET}"
    if [ -d "${WORKSPACES_DIR}" ]; then
        for ws in "${WORKSPACES_DIR}"/*; do
            if [ -d "$ws" ]; then
                local name
                name=$(basename "$ws")
                local desc="Custom workspace profile"
                if [ -f "$ws/DESCRIPTION" ]; then
                    desc=$(head -n 1 "$ws/DESCRIPTION")
                fi
                printf "  • ${COLOR_CYAN}%-26s${COLOR_RESET} %s\n" "$name" "$desc"
            fi
        done
    else
        echo "  (No workspaces found in ${WORKSPACES_DIR})"
    fi
    echo ""
}

cmd_list() {
    print_banner
    echo -e "${COLOR_BOLD}Available Workspace Presets:${COLOR_RESET}\n"
    for ws in "${WORKSPACES_DIR}"/*; do
        if [ -d "$ws" ]; then
            local name
            name=$(basename "$ws")
            local desc="Custom workspace profile"
            if [ -f "$ws/DESCRIPTION" ]; then
                desc=$(cat "$ws/DESCRIPTION")
            fi
            echo -e "${COLOR_BOLD}${COLOR_CYAN}[ $name ]${COLOR_RESET}"
            echo -e "  Description : $desc"

            local agent_count
            agent_count=$(find "$ws/.claude/agents" -type f 2>/dev/null | wc -l | tr -d ' ')
            local cmd_count
            cmd_count=$(find "$ws/.claude/commands" -type f 2>/dev/null | wc -l | tr -d ' ')
            local rule_count
            rule_count=$(find "$ws/.claude/rules" -type f 2>/dev/null | wc -l | tr -d ' ')
            local hook_count
            hook_count=$(find "$ws/.claude/hooks" -type f 2>/dev/null | wc -l | tr -d ' ')

            echo -e "  Components  : ${COLOR_GREEN}${agent_count} Agents${COLOR_RESET}, ${COLOR_GREEN}${cmd_count} Commands${COLOR_RESET}, ${COLOR_GREEN}${rule_count} Rules${COLOR_RESET}, ${COLOR_GREEN}${hook_count} Hooks${COLOR_RESET}"
            echo ""
        fi
    done
}

cmd_info() {
    local preset="${1:-}"
    if [ -z "$preset" ]; then
        echo -e "${COLOR_RED}Error: Please specify a workspace preset name.${COLOR_RESET}"
        usage
        exit 1
    fi

    local ws_path="${WORKSPACES_DIR}/${preset}"
    if [ ! -d "$ws_path" ]; then
        echo -e "${COLOR_RED}Error: Workspace preset '${preset}' does not exist.${COLOR_RESET}"
        exit 1
    fi

    print_banner
    echo -e "${COLOR_BOLD}Workspace Preset:${COLOR_RESET} ${COLOR_CYAN}${preset}${COLOR_RESET}\n"

    if [ -f "$ws_path/DESCRIPTION" ]; then
        echo -e "${COLOR_BOLD}Overview:${COLOR_RESET}"
        cat "$ws_path/DESCRIPTION"
        echo -e "\n"
    fi

    echo -e "${COLOR_BOLD}Included Files & Structure:${COLOR_RESET}"
    (cd "$ws_path" && find . -not -path '*/.*' -o -name '.claude*' | sort | sed -e 's;[^/]*/;|____;g;s;____|; |;g')
    echo ""

    if [ -f "$ws_path/CLAUDE.md" ]; then
        echo -e "${COLOR_BOLD}CLAUDE.md Preview (First 20 lines):${COLOR_RESET}"
        echo -e "${COLOR_YELLOW}------------------------------------------------------------${COLOR_RESET}"
        head -n 20 "$ws_path/CLAUDE.md"
        echo -e "${COLOR_YELLOW}------------------------------------------------------------${COLOR_RESET}"
    fi
}

cmd_apply() {
    local preset="${1:-}"
    local target="${2:-.}"

    if [ -z "$preset" ]; then
        echo -e "${COLOR_RED}Error: Please specify a workspace preset name to apply.${COLOR_RESET}"
        usage
        exit 1
    fi

    local ws_path="${WORKSPACES_DIR}/${preset}"
    if [ ! -d "$ws_path" ]; then
        echo -e "${COLOR_RED}Error: Workspace preset '${preset}' does not exist.${COLOR_RESET}"
        exit 1
    fi

    target="$(cd "$target" && pwd)"
    print_banner
    echo -e "Injecting workspace preset ${COLOR_CYAN}${preset}${COLOR_RESET} into ${COLOR_BOLD}${target}${COLOR_RESET}...\n"

    # Create destination directories
    mkdir -p "$target/.claude"

    # Backup existing CLAUDE.md or settings.json if present
    if [ -f "$target/CLAUDE.md" ]; then
        local timestamp
        timestamp=$(date +%Y%m%d_%H%M%S)
        echo -e "${COLOR_YELLOW}Backing up existing CLAUDE.md -> CLAUDE.md.bak_${timestamp}${COLOR_RESET}"
        cp "$target/CLAUDE.md" "$target/CLAUDE.md.bak_${timestamp}"
    fi

    if [ -f "$target/.claude/settings.json" ]; then
        local timestamp
        timestamp=$(date +%Y%m%d_%H%M%S)
        echo -e "${COLOR_YELLOW}Backing up existing settings.json -> settings.json.bak_${timestamp}${COLOR_RESET}"
        cp "$target/.claude/settings.json" "$target/.claude/settings.json.bak_${timestamp}"
    fi

    # Copy files
    echo -e "Copying workspace configuration files..."
    if [ -d "$ws_path/.claude" ]; then
        cp -R "$ws_path/.claude"/* "$target/.claude/" 2>/dev/null || true
    fi

    if [ -f "$ws_path/CLAUDE.md" ]; then
        cp "$ws_path/CLAUDE.md" "$target/CLAUDE.md"
    fi

    # Copy supporting scripts or rules if any
    for extra in rules agents commands skills hooks; do
        if [ -d "$ws_path/$extra" ]; then
            mkdir -p "$target/.claude/$extra"
            cp -R "$ws_path/$extra"/* "$target/.claude/$extra/" 2>/dev/null || true
        fi
    done

    # Make hook scripts executable
    if [ -d "$target/.claude/hooks" ]; then
        find "$target/.claude/hooks" -name "*.sh" -exec chmod +x {} + 2>/dev/null || true
    fi

    echo -e "\n${COLOR_GREEN}✓ Successfully applied workspace preset '${preset}' to ${target}${COLOR_RESET}"
    echo -e "You can now launch ${COLOR_BOLD}claude${COLOR_RESET} in this directory to start using the customized harness!"
}

cmd_audit() {
    local target="${1:-.}"
    target="$(cd "$target" && pwd)"
    print_banner
    echo -e "${COLOR_BOLD}Auditing Claude Code Harness in:${COLOR_RESET} ${COLOR_CYAN}${target}${COLOR_RESET}\n"

    local score=0
    local total=5

    # Check 1: CLAUDE.md
    if [ -f "$target/CLAUDE.md" ]; then
        local lines
        lines=$(wc -l < "$target/CLAUDE.md" | tr -d ' ')
        echo -e "${COLOR_GREEN}✓ CLAUDE.md present (${lines} lines)${COLOR_RESET}"
        score=$((score + 1))
    else
        echo -e "${COLOR_RED}✗ CLAUDE.md missing (Recommended for workspace memory and rules)${COLOR_RESET}"
    fi

    # Check 2: .claude directory
    if [ -d "$target/.claude" ]; then
        echo -e "${COLOR_GREEN}✓ .claude directory present${COLOR_RESET}"
        score=$((score + 1))
    else
        echo -e "${COLOR_RED}✗ .claude directory missing${COLOR_RESET}"
    fi

    # Check 3: settings.json
    if [ -f "$target/.claude/settings.json" ]; then
        echo -e "${COLOR_GREEN}✓ .claude/settings.json present${COLOR_RESET}"
        score=$((score + 1))
    else
        echo -e "${COLOR_YELLOW}⚠ .claude/settings.json missing (Optional, used for hooks & sandbox config)${COLOR_RESET}"
    fi

    # Check 4: Agents & Commands
    local agents_count=0
    local commands_count=0
    [ -d "$target/.claude/agents" ] && agents_count=$(find "$target/.claude/agents" -type f 2>/dev/null | wc -l | tr -d ' ')
    [ -d "$target/.claude/commands" ] && commands_count=$(find "$target/.claude/commands" -type f 2>/dev/null | wc -l | tr -d ' ')

    if [ "$agents_count" -gt 0 ] || [ "$commands_count" -gt 0 ]; then
        echo -e "${COLOR_GREEN}✓ Agents & Commands configured (${agents_count} agents, ${commands_count} commands)${COLOR_RESET}"
        score=$((score + 1))
    else
        echo -e "${COLOR_YELLOW}⚠ No custom agents or slash commands found in .claude/${COLOR_RESET}"
    fi

    # Check 5: Hooks & Security
    local hooks_count=0
    [ -d "$target/.claude/hooks" ] && hooks_count=$(find "$target/.claude/hooks" -type f 2>/dev/null | wc -l | tr -d ' ')

    if [ "$hooks_count" -gt 0 ]; then
        echo -e "${COLOR_GREEN}✓ Hooks configured (${hooks_count} hook scripts found)${COLOR_RESET}"
        score=$((score + 1))
    else
        echo -e "${COLOR_YELLOW}⚠ No automated security/productivity hooks found in .claude/hooks/${COLOR_RESET}"
    fi

    echo -e "\n${COLOR_BOLD}Harness Health Score:${COLOR_RESET} ${COLOR_CYAN}${score}/${total}${COLOR_RESET}"
}

cmd_export() {
    local name="${1:-}"
    local source="${2:-.}"

    if [ -z "$name" ]; then
        echo -e "${COLOR_RED}Error: Please specify a name for the new workspace preset.${COLOR_RESET}"
        exit 1
    fi

    local target_ws="${WORKSPACES_DIR}/${name}"
    mkdir -p "$target_ws/.claude"

    echo -e "Exporting workspace configuration into ${COLOR_CYAN}${target_ws}${COLOR_RESET}..."

    if [ -f "$source/CLAUDE.md" ]; then
        cp "$source/CLAUDE.md" "$target_ws/CLAUDE.md"
    fi

    if [ -d "$source/.claude" ]; then
        cp -R "$source/.claude"/* "$target_ws/.claude/" 2>/dev/null || true
    fi

    echo "Custom exported workspace: ${name}" > "$target_ws/DESCRIPTION"

    echo -e "${COLOR_GREEN}✓ Successfully exported preset '${name}'!${COLOR_RESET}"
}

# Main routing
COMMAND="${1:-}"
shift || true

case "$COMMAND" in
    list)
        cmd_list
        ;;
    info)
        cmd_info "$@"
        ;;
    apply)
        cmd_apply "$@"
        ;;
    audit)
        cmd_audit "$@"
        ;;
    export)
        cmd_export "$@"
        ;;
    help|--help|-h|"")
        usage
        ;;
    *)
        echo -e "${COLOR_RED}Unknown command: ${COMMAND}${COLOR_RESET}"
        usage
        exit 1
        ;;
esac
