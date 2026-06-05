#!/bin/bash
# Shared utility functions for dotfiles setup

set -euo pipefail

DRYRUN="${DRYRUN:-0}"

# Helper to check if in dry-run mode
is_dryrun() {
    [ "${DRYRUN:-0}" = "1" ]
}

# Helper to check if in minimal mode
is_minimal() {
    [ "${MINIMAL:-0}" = "1" ]
}

# Helper to check if force-stow mode is active
is_force_stow() {
    [ "${FORCE_STOW:-0}" = "1" ]
}

# Execute command or show what would execute
run_cmd() {
    if is_dryrun; then
        echo "  [DRY-RUN] $*"
    else
        "$@"
    fi
}

# Print with indentation level
# Usage: print_section 1 "📦 Title"
print_section() {
    local level="$1"
    local text="$2"
    local indent=$((level * 2))
    printf "%*s%s\n" "$indent" "" "$text"
}

# Add a manual step to the collection
add_manual_step() {
    MANUAL_STEPS+="• $1\n"
}

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if a directory exists
dir_exists() {
    [ -d "$1" ]
}

# Print manual steps at the end of setup
print_manual_steps() {
    if [ -n "$MANUAL_STEPS" ]; then
        echo ""
        echo "📋 Manual Steps Required:"
        echo "═══════════════════════════════════════"
        printf "%b" "$MANUAL_STEPS"
    fi
}

# Install macOS application from DMG
install_dmg() {
    local level="$1"
    local app_name="$2"
    local download_url="$3"
    local app_path="/Applications/${app_name}.app"
    
    if [ -d "$app_path" ]; then
        print_section "$level" "✅ $app_name already installed"
        return 0
    fi
    
    if is_dryrun; then
        print_section "$level" "⏭️  [DRY-RUN] Would install $app_name"
        return 0
    fi
    
    print_section "$level" "📦 Installing $app_name..."
    
    local dmg_file="/tmp/${app_name}.dmg"
    local mount_point="/Volumes/${app_name}"
    
    # Download DMG with minimal headers
    curl -L -o "$dmg_file" "$download_url" 2>/dev/null || {
        print_section "$level" "❌ Failed to download $app_name"
        return 1
    }
    
    # Mount and copy
    hdiutil attach "$dmg_file" -nobrowse -noautoopen > /dev/null
    cp -r "$mount_point/${app_name}.app" "$app_path"
    hdiutil detach "$mount_point" > /dev/null
    
    # Cleanup
    rm "$dmg_file"
    
    print_section "$level" "✅ $app_name installed successfully"
}
