#!/bin/bash
set -e

# Clones and installs dotfiles into $HOME. Safe to re-run.
# Usage: ./provision.sh [install.sh flags]

cd "${HOME}"

rm -rf .dotfiles
git clone https://github.com/gfkri/dotfiles.git .dotfiles
./.dotfiles/install.sh --force-stow "$@"
sudo usermod -s "$(which zsh)" "$(whoami)"
TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/" ~/.tmux/plugins/tpm/bin/install_plugins
