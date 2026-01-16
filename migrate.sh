#!/usr/bin/env bash
# Migration script from awesome v0.5.3 to v0.6.0 (enhanced)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.awesome-migration-backup-$(date +%Y%m%d-%H%M%S)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

echo -e "${BOLD}${CYAN}╔════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${CYAN}║     Awesome Package Manager - Migration to v0.6.0         ║${RESET}"
echo -e "${BOLD}${CYAN}╚════════════════════════════════════════════════════════════╝${RESET}"
echo

# Check if we're in the right directory
if [[ ! -f "$SCRIPT_DIR/awesome" ]] || [[ ! -f "$SCRIPT_DIR/awesome-enhanced" ]]; then
  echo -e "${RED}Error: Run this script from the awesome directory${RESET}"
  echo "Expected files: awesome, awesome-enhanced, utils/lib-enhanced"
  exit 1
fi

echo -e "${BOLD}This script will:${RESET}"
echo "  1. Create a backup of your current installation"
echo "  2. Export your currently installed packages"
echo "  3. Replace awesome files with enhanced versions"
echo "  4. Set up configuration"
echo "  5. Run health check"
echo
echo -e "${YELLOW}Note: Your installed packages will NOT be affected${RESET}"
echo

read -p "Continue with migration? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Migration cancelled."
  exit 0
fi

echo

# Step 1: Create backup
echo -e "${BOLD}${BLUE}[1/6]${RESET} Creating backup..."
mkdir -p "$BACKUP_DIR"

if [[ -f "$SCRIPT_DIR/awesome" ]]; then
  cp "$SCRIPT_DIR/awesome" "$BACKUP_DIR/awesome"
  echo -e "  ${GREEN}✓${RESET} Backed up awesome script"
fi

if [[ -f "$HOME/.config/awesome/config" ]]; then
  cp "$HOME/.config/awesome/config" "$BACKUP_DIR/config"
  echo -e "  ${GREEN}✓${RESET} Backed up configuration"
fi

echo -e "  ${CYAN}Backup location: $BACKUP_DIR${RESET}"
echo

# Step 2: Export packages
echo -e "${BOLD}${BLUE}[2/6]${RESET} Exporting installed packages..."
PACKAGE_LIST="$BACKUP_DIR/installed-packages.txt"

if command -v awesome &>/dev/null; then
  awesome ls >"$PACKAGE_LIST" 2>/dev/null || true
  if [[ -f "$PACKAGE_LIST" ]] && [[ -s "$PACKAGE_LIST" ]]; then
    PKG_COUNT=$(wc -l <"$PACKAGE_LIST" | tr -d ' ')
    echo -e "  ${GREEN}✓${RESET} Exported $PKG_COUNT package(s)"
    echo -e "  ${CYAN}Package list: $PACKAGE_LIST${RESET}"
  else
    echo -e "  ${YELLOW}!${RESET} No packages found or export failed"
  fi
else
  echo -e "  ${YELLOW}!${RESET} awesome command not found, skipping export"
fi
echo

# Step 3: Replace files
echo -e "${BOLD}${BLUE}[3/6]${RESET} Installing enhanced versions..."

# Check if files exist
if [[ ! -f "$SCRIPT_DIR/awesome-enhanced" ]]; then
  echo -e "${RED}Error: awesome-enhanced not found${RESET}"
  exit 1
fi

if [[ ! -f "$SCRIPT_DIR/utils/lib-enhanced" ]]; then
  echo -e "${RED}Error: utils/lib-enhanced not found${RESET}"
  exit 1
fi

# Replace files
cp "$SCRIPT_DIR/awesome-enhanced" "$SCRIPT_DIR/awesome"
chmod +x "$SCRIPT_DIR/awesome"
echo -e "  ${GREEN}✓${RESET} Installed enhanced awesome script"

cp "$SCRIPT_DIR/utils/lib-enhanced" "$SCRIPT_DIR/utils/lib-enhanced"
chmod +x "$SCRIPT_DIR/utils/lib-enhanced"
echo -e "  ${GREEN}✓${RESET} Installed enhanced utils/lib-enhanced"
echo

# Step 4: Configuration
echo -e "${BOLD}${BLUE}[4/6]${RESET} Setting up configuration..."

mkdir -p "$HOME/.config/awesome"

if [[ ! -f "$HOME/.config/awesome/config" ]]; then
  if [[ -f "$SCRIPT_DIR/awesome.config.example" ]]; then
    cp "$SCRIPT_DIR/awesome.config.example" "$HOME/.config/awesome/config"
    echo -e "  ${GREEN}✓${RESET} Created configuration file"
    echo -e "  ${CYAN}Location: ~/.config/awesome/config${RESET}"
  else
    echo -e "  ${YELLOW}!${RESET} Example config not found, skipping"
  fi
else
  echo -e "  ${YELLOW}!${RESET} Configuration already exists, keeping current"
fi

# Create log directory
LOG_DIR="$HOME/.local/share/awesome/logs"
mkdir -p "$LOG_DIR"
echo -e "  ${GREEN}✓${RESET} Created log directory"
echo

# Step 5: Verify installation
echo -e "${BOLD}${BLUE}[5/6]${RESET} Verifying installation..."

if command -v awesome &>/dev/null; then
  VERSION=$(awesome --version 2>/dev/null || echo "unknown")
  echo -e "  ${GREEN}✓${RESET} awesome command is available"
  echo -e "  ${CYAN}Version: $VERSION${RESET}"
else
  echo -e "  ${RED}✗${RESET} awesome command not found in PATH"
  echo -e "  ${YELLOW}Add to your shell config: export PATH=\$HOME/.local/share/bin:\$PATH${RESET}"
fi
echo

# Step 6: Health check
echo -e "${BOLD}${BLUE}[6/6]${RESET} Running health check..."
echo

if command -v awesome &>/dev/null; then
  awesome doctor
else
  echo -e "${YELLOW}Skipping health check (awesome not in PATH)${RESET}"
fi

# Summary
echo
echo -e "${BOLD}${GREEN}╔════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BOLD}${GREEN}║              Migration Complete! ✓                         ║${RESET}"
echo -e "${BOLD}${GREEN}╚════════════════════════════════════════════════════════════╝${RESET}"
echo
echo -e "${BOLD}What's new:${RESET}"
echo "  • awesome doctor        - System health check"
echo "  • awesome info <pkg>    - Package information"
echo "  • awesome update --all  - Update all packages"
echo "  • awesome stats         - Package statistics"
echo "  • awesome export        - Backup packages"
echo "  • awesome import        - Restore packages"
echo
echo -e "${BOLD}Next steps:${RESET}"
echo "  1. Try: awesome doctor"
echo "  2. Review config: nano ~/.config/awesome/config"
echo "  3. Read docs: cat QUICKSTART.md"
echo "  4. Check logs: tail ~/.local/share/awesome/logs/awesome.log"
echo
echo -e "${BOLD}Backup location:${RESET}"
echo "  $BACKUP_DIR"
echo
echo -e "${BOLD}Rollback (if needed):${RESET}"
echo "  cp $BACKUP_DIR/awesome $SCRIPT_DIR/awesome"
echo "  cp $BACKUP_DIR/lib $SCRIPT_DIR/utils/lib"
echo
echo -e "${GREEN}Happy scripting! 🚀${RESET}"
