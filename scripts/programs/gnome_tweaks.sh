#!/bin/bash
source ./utils.sh
echo "📦 Installing Gnome Tweaks"

sudo add-apt-repository -y universe
apt_install gnome-tweaks
apt_install gnome-shell-extensions
apt_install gnome-shell-extension-manager

