#!/usr/bin/env bash
# Tutorial for setting up git bare repository for dotfiles
# https://www.atlassian.com/git/tutorials/dotfiles

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Parse command-line arguments
for arg in "$@"; do
    case "$arg" in
        --dry-run|-d)    export DRYRUN=1 ;;
        --minimal|-m)    export MINIMAL=1 ;;
        --force-stow|-f) export FORCE_STOW=1 ;;
    esac
done

source "${SCRIPT_DIR}/utils.sh"
MANUAL_STEPS=""

echo "🚀 Dotfiles Setup"
if is_dryrun; then
    print_section 0 "⏭️  DRY-RUN MODE - No changes will be made"
fi
if is_minimal; then
    print_section 0 "📦 MINIMAL MODE - Skipping heavy shell setup"
fi
echo "═══════════════════════════════════════"
echo ""

# Detect OS and run platform-specific setup
if [[ "$OSTYPE" == "darwin"* ]]; then
    print_section 0 "🍎 macOS Setup"
    source "${SCRIPT_DIR}/macos.sh"
    echo ""
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    print_section 0 "🐧 Ubuntu Setup"
    source "${SCRIPT_DIR}/ubuntu.sh"
    echo ""
fi

if ! is_minimal; then
    # Oh My Zsh
    print_section 0 "📦 Oh My Zsh"
    if ! dir_exists "${HOME}/.oh-my-zsh"; then
        if is_dryrun; then
            print_section 1 "⏭️  [DRY-RUN] Would install"
        else
            print_section 1 "Installing..."
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        fi
    else
        print_section 1 "✅ Already installed"
    fi

    # Tmux setup
    print_section 0 "🔧 Tmux"
    if ! dir_exists "${HOME}/.tmux/plugins/tpm"; then
        if is_dryrun; then
            print_section 1 "⏭️  [DRY-RUN] Would install plugin manager"
        else
            mkdir -p "${HOME}/.tmux/plugins"
            print_section 1 "Installing plugin manager..."
            git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
        fi
    else
        print_section 1 "✅ Plugin manager already installed"
    fi

    if [ -f "${HOME}/.tmux.conf" ]; then
        if ! is_dryrun; then
            tmux source-file "${HOME}/.tmux.conf" 2>/dev/null || true
        fi
    else
        print_section 1 "⚠️  ~/.tmux.conf not found"
    fi

    # Powerlevel10k theme
    print_section 0 "🎨 Powerlevel10k"
    THEME_DIR="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/powerlevel10k"
    if ! dir_exists "$THEME_DIR"; then
        if is_dryrun; then
            print_section 1 "⏭️  [DRY-RUN] Would install theme"
        else
            print_section 1 "Installing theme..."
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEME_DIR"
        fi
    else
        print_section 1 "✅ Already installed"
    fi

    # Zsh plugins
    print_section 0 "📦 Zsh Plugins"

    AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    if ! dir_exists "$AUTOSUGGESTIONS_DIR"; then
        if is_dryrun; then
            print_section 1 "⏭️  [DRY-RUN] Would install zsh-autosuggestions"
        else
            print_section 1 "Installing zsh-autosuggestions..."
            git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGESTIONS_DIR"
        fi
    else
        print_section 1 "✅ zsh-autosuggestions already installed"
    fi

    EZA_PLUGIN_DIR="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/eza"
    if ! dir_exists "$EZA_PLUGIN_DIR"; then
        if is_dryrun; then
            print_section 1 "⏭️  [DRY-RUN] Would install zsh-eza plugin"
        else
            print_section 1 "Installing zsh-eza plugin..."
            git clone https://github.com/wushenrong/zsh-eza.git "$EZA_PLUGIN_DIR"
        fi
    else
        print_section 1 "✅ zsh-eza plugin already installed"
    fi

    echo ""
fi

# Stow dotfiles
print_section 0 "🔗 Stow Dotfiles"
STOW_FOLDERS=(git ohmyzsh p10k tmux vim zsh)
[[ "$OSTYPE" == "darwin"* ]] && STOW_FOLDERS=(ghostty "${STOW_FOLDERS[@]}")
cd "$SCRIPT_DIR" || exit 1

for folder in "${STOW_FOLDERS[@]}"; do
    if [ -d "$folder" ]; then
        if is_dryrun; then
            print_section 1 "⏭️  [DRY-RUN] Would stow $folder"
        else
            print_section 1 "➜ Stowing $folder..."
            if is_force_stow; then
                stow --adopt --restow --target="$HOME" --dir="$SCRIPT_DIR" "$folder" 2>&1 | sed 's/^/    /'
            else
                STOW_OUT=$(stow --restow --target="$HOME" --dir="$SCRIPT_DIR" "$folder" 2>&1)
                if [ $? -ne 0 ]; then
                    print_section 2 "⚠️  Conflict — skipping $folder (use --force-stow to overwrite)"
                else
                    echo "$STOW_OUT" | sed 's/^/    /'
                fi
            fi
        fi
    else
        print_section 1 "⚠️  $folder not found (skipping)"
    fi
done
if is_force_stow; then
    git -C "$SCRIPT_DIR" checkout -- . 2>/dev/null || true
fi

# Tools (cross-platform)
print_section 0 "🛠️  Tools"

# uv (Python project manager)
if ! command_exists uv; then
    if is_dryrun; then
        print_section 1 "⏭️  [DRY-RUN] Would install uv"
    else
        print_section 1 "Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
else
    print_section 1 "✅ uv already installed"
fi

echo ""

# macOS-only manual steps
if [[ "$OSTYPE" == "darwin"* ]]; then
    add_manual_step "Disable autocorrect: System Settings > Keyboard > Input Sources > Edit > Uncheck 'Correct Spelling Automatically'"
    add_manual_step "Enable Ghostty accessibility: System Settings > Privacy & Security > Accessibility > Add ghostty to the list"
fi

echo "🎉 Setup complete!"
print_manual_steps
