#!/usr/bin/env bash
# Ubuntu/Debian (apt-based) setup

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/utils.sh"

SUDO=$([ "$EUID" -eq 0 ] && echo "" || echo "sudo")
ARCH=$(uname -m)

# Core packages via apt
print_section 1 "📦 Packages"
APT_PACKAGES=(stow tmux fzf tig curl git zsh unzip)
if is_dryrun; then
    print_section 2 "⏭️  [DRY-RUN] Would apt install: ${APT_PACKAGES[*]}"
else
    $SUDO apt-get update -qq
    $SUDO apt-get install -y "${APT_PACKAGES[@]}"
fi

# eza — not in default Ubuntu repos, install binary from GitHub releases
if ! command_exists eza; then
    if is_dryrun; then
        print_section 2 "⏭️  [DRY-RUN] Would install eza"
    else
        print_section 2 "Installing eza..."
        curl -Lo /tmp/eza.tar.gz \
            "https://github.com/eza-community/eza/releases/latest/download/eza_${ARCH}-unknown-linux-gnu.tar.gz"
        $SUDO tar -xzf /tmp/eza.tar.gz -C /usr/local/bin ./eza
        rm /tmp/eza.tar.gz
        print_section 2 "✅ eza installed"
    fi
else
    print_section 2 "✅ eza already installed"
fi

# jless — JSON viewer
if ! command_exists jless; then
    if is_dryrun; then
        print_section 2 "⏭️  [DRY-RUN] Would install jless"
    else
        print_section 2 "Installing jless..."
        JLESS_TAG=$(curl -fsSL "https://api.github.com/repos/PaulJuliusMartinez/jless/releases/latest" \
            | grep '"tag_name"' | cut -d'"' -f4)
        if [[ "$ARCH" != "x86_64" ]]; then
            print_section 2 "⚠️  jless has no Linux release for $ARCH, skipping"
        else
            curl -Lo /tmp/jless.zip \
                "https://github.com/PaulJuliusMartinez/jless/releases/download/${JLESS_TAG}/jless-${JLESS_TAG}-x86_64-unknown-linux-gnu.zip"
            $SUDO unzip -o /tmp/jless.zip jless -d /usr/local/bin/
            $SUDO chmod +x /usr/local/bin/jless
            rm /tmp/jless.zip
            print_section 2 "✅ jless installed"
        fi
    fi
else
    print_section 2 "✅ jless already installed"
fi

# thefuck — shell command corrector (requires Python)
if ! command_exists thefuck; then
    if is_dryrun; then
        print_section 2 "⏭️  [DRY-RUN] Would install thefuck"
    else
        if command_exists pip3; then
            print_section 2 "Installing thefuck..."
            pip3 install thefuck --quiet
            print_section 2 "✅ thefuck installed"
        else
            print_section 2 "⚠️  pip3 not found, skipping thefuck"
        fi
    fi
else
    print_section 2 "✅ thefuck already installed"
fi
