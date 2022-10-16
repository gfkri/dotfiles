#!/bin/bash

# Sourcing helper utils
source ./utils.sh

echo "Installing Snap Stuff"
# Basics
snap_install blender --classic

# cloudcompare with drag&drop support to external media
snap_install cloudcompare
sudo snap connect  cloudcompare:removable-media  :removable-media

snap_install keepassxc
snap_install signal-desktop
snap_install meshlab
snap_install spotify
snap_install yq
snap_install telegram-desktop
# snap_install alacritty --classic
