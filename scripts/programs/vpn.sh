#!/bin/bash
source ./utils.sh
echo "🔒 Setting up VPN dependencies"

apt_install openconnect 
apt_install network-manager-openconnect 
apt_install network-manager-openconnect-gnome