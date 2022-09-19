#!/bin/bash

# Sourcing helper utils
source ./utils.sh

apt_install zsh
chsh -s /usr/bin/zsh
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd ../data
cp .zshrc ${HOME}
cp -r .oh-my-zsh ${HOME}

# plugin installation
apt_install fzf
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sudo pip install thefuck
