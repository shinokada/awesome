#!/usr/bin/env bash
# Demo script to showcase enhanced awesome features

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

clear

echo -e "${BOLD}${CYAN}╔════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${CYAN}║     Awesome Package Manager v0.6.0 - Demo                 ║${RESET}"
echo -e "${BOLD}${CYAN}╚════════════════════════════════════════════════════════════╝${RESET}"
echo

# Function to pause
pause() {
    echo -e "\n${YELLOW}Press Enter to continue...${RESET}"
    read -r
}

# Function to run command and show output
demo_command() {
    local cmd=$1
    local description=$2
    
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${RESET}"
    echo -e "${BOLD}Demo: ${description}${RESET}"
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${RESET}"
    echo -e "${CYAN}Command:${RESET} ${cmd}"
    echo
    
    # Execute command
    eval "$cmd"
    
    pause
}

echo -e "${BOLD}This demo will showcase the new features of Awesome v0.6.0${RESET}"
echo
echo "We'll demonstrate:"
echo "  1. Health check (doctor command)"
echo "  2. Package information (info command)"
echo "  3. Statistics (stats command)"
echo "  4. Enhanced help system"
echo "  5. Configuration example"
echo

pause

# Demo 1: Health Check
clear
demo_command "./awesome doctor" "Health Check System"

# Demo 2: Help System
clear
demo_command "./awesome --help" "Enhanced Help System"

# Demo 3: Package Info (if packages installed)
clear
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${RESET}"
echo -e "${BOLD}Demo: Package Information${RESET}"
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${RESET}"
echo

# Check if any packages installed
if command -v awesome &>/dev/null; then
    PACKAGES=($(awesome ls 2>/dev/null | head -3))
    if [ ${#PACKAGES[@]} -gt 0 ]; then
        echo -e "${CYAN}Command:${RESET} ./awesome info ${PACKAGES[0]}"
        echo
        ./awesome info "${PACKAGES[0]}" 2>/dev/null || echo -e "${YELLOW}Package info not available yet (need to migrate first)${RESET}"
    else
        echo -e "${YELLOW}No packages installed. Skipping info demo.${RESET}"
    fi
else
    echo -e "${YELLOW}Awesome not in PATH. Skipping info demo.${RESET}"
fi

pause

# Demo 4: Stats
clear
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${RESET}"
echo -e "${BOLD}Demo: Package Statistics${RESET}"
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${RESET}"
echo

if command -v awesome &>/dev/null; then
    echo -e "${CYAN}Command:${RESET} ./awesome stats"
    echo
    ./awesome stats 2>/dev/null || echo -e "${YELLOW}Stats not available yet (need to migrate first)${RESET}"
else
    echo -e "${YELLOW}Awesome not in PATH. Skipping stats demo.${RESET}"
fi

pause

# Demo 5: Configuration
clear
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${RESET}"
echo -e "${BOLD}Demo: Configuration System${RESET}"
echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${RESET}"
echo
echo -e "${CYAN}Configuration file:${RESET} ~/.config/awesome/config"
echo
echo -e "${BOLD}Example configuration:${RESET}"
echo
cat awesome.config.example | head -20
echo "..."

pause

# Demo 6: New Features Summary
clear
echo -e "${BOLD}${GREEN}╔════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${GREEN}║              New Features Summary                          ║${RESET}"
echo -e "${BOLD}${GREEN}╚════════════════════════════════════════════════════════════╝${RESET}"
echo
echo -e "${BOLD}Commands:${RESET}"
echo -e "  ${CYAN}awesome doctor${RESET}          - System health check"
echo -e "  ${CYAN}awesome info <pkg>${RESET}      - Package details"
echo -e "  ${CYAN}awesome stats${RESET}           - Package statistics"
echo -e "  ${CYAN}awesome update --all${RESET}    - Update all packages"
echo -e "  ${CYAN}awesome export${RESET}          - Backup package list"
echo -e "  ${CYAN}awesome import${RESET}          - Restore packages"
echo
echo -e "${BOLD}Features:${RESET}"
echo -e "  ${GREEN}✓${RESET} Configuration file support"
echo -e "  ${GREEN}✓${RESET} Automatic retry on failures"
echo -e "  ${GREEN}✓${RESET} Network connectivity checks"
echo -e "  ${GREEN}✓${RESET} Operation logging"
echo -e "  ${GREEN}✓${RESET} Package manifests"
echo -e "  ${GREEN}✓${RESET} Health diagnostics"
echo -e "  ${GREEN}✓${RESET} Batch operations"
echo -e "  ${GREEN}✓${RESET} Backup and restore"
echo -e "  ${GREEN}✓${RESET} Shell completion"
echo -e "  ${GREEN}✓${RESET} Enhanced error messages"
echo
echo -e "${BOLD}Documentation:${RESET}"
echo -e "  ${CYAN}QUICKSTART.md${RESET}           - Quick start guide"
echo -e "  ${CYAN}ENHANCEMENTS.md${RESET}         - Detailed documentation"
echo -e "  ${CYAN}IMPLEMENTATION_SUMMARY.md${RESET} - Overview of changes"
echo
echo -e "${GREEN}Thank you for using Awesome Package Manager! 🚀${RESET}"
echo
