#!/bin/bash
source ./utils.sh
echo "📦 Installing Gnome Tweaks (Require Gnome Restart)"

install_extension () {
    gnome-extensions enable "$1"
}

sudo add-apt-repository -y universe
apt_install gnome-tweaks
apt_install gnome-shell-extensions
apt_install gnome-shell-extension-manager

# Dependencies Gnome System Monitor
apt_install gir1.2-gtop-2.0 
apt_install gir1.2-nm-1.0 
apt_install gir1.2-clutter-1.0 
apt_install gnome-system-monitor

install_extension system-monitor-next@paradoxxx.zero.gmail.com