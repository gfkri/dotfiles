#!/bin/bash

# Sourcing helper utils
source ./utils.sh

apt_install zsh
chsh -s /usr/bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd ../data
cp -r .oh-my-zsh ${HOME}