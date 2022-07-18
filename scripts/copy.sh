#!/bin/bash

# Up from scripts dir
cd ../data

cp .pythonrc ${HOME}
cp .alacritty.yml ${HOME}
cat .bashrc >> ${HOME}/.bashrc
cat .bash_aliases >> ${HOME}/.bash_aliases
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf
