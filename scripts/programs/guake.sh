#!/bin/bash

source ./utils.sh

echo "🐋 Installing Guake"
sudo add-apt-repository -y ppa:linuxuprising/guake
apt_install guake
guake --restore-preferences=../data/guake_preferences.cfg
