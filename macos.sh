#!/usr/bin/env zsh
# macOS-specific setup script

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/utils.sh"

# Homebrew
print_section 1 "📦 Homebrew"
if ! command_exists brew; then
    if is_dryrun; then
        print_section 2 "⏭️  [DRY-RUN] Would install"
    else
        print_section 2 "Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv zsh)"
    fi
else
    print_section 2 "✅ Already installed"
fi

# Install Homebrew packages
print_section 1 "📦 Packages"
PACKAGES=(stow tmux thefuck fzf eza jless terminal-notifier tig cmake)
for pkg in "${PACKAGES[@]}"; do
    if ! command_exists "$pkg"; then
        if is_dryrun; then
            print_section 2 "⏭️  [DRY-RUN] Would install $pkg"
        else
            print_section 2 "Installing $pkg..."
            brew install "$pkg"
        fi
    else
        print_section 2 "✅ $pkg already installed"
    fi
done

# DMG installations
print_section 1 "💿 DMG Applications"

# TODO: fix dmg install
# VSCode
# install_dmg 2 "Visual Studio Code" "https://code.visualstudio.com/sha/download?build=stable&os=darwin-arm64-dmg"

# Firefox
# install_dmg 2 "Firefox" "https://download.mozilla.org/?product=firefox-latest-ssl&os=osx&lang=en-US"

# Docker
# install_dmg 2 "Docker" "https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64"

# Inkscape
# install_dmg 2 "Inkscape" "https://media.inkscape.org/dl/resources/file/inkscape-1.3.1-arm64.dmg"

# Add manual step for downloading Logi Options+
add_manual_step "Download and install Logi Options from https://www.logitech.com/en-us/software/mx-software"