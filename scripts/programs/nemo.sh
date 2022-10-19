#!/bin/bash

source ./utils.sh

echo "📁 Installing Nemo"
apt_install nemo
apt_install dconf-editor
apt_install gnome-tweaks

xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
gsettings set org.gnome.desktop.background show-desktop-icons false
gsettings set org.nemo.desktop show-desktop-icons true

echo "[MANUAL] Disable 'Desktop Icon' in 'Extensions'"
