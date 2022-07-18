#!/bin/bash
# Run from scripts folder!

# Sourcing helper utils
source ./utils.sh

# Copy dotfiles
./copy.sh

# Update Ubuntu and get standard repository programs
sudo apt update && sudo apt full-upgrade -y

# Basics
apt_install awscli
apt_install curl
apt_install exfatprogs
apt_install file
apt_install git
apt_install gitg
apt_install htop
apt_install jq
apt_install nmap
apt_install openvpn
apt_install tree
apt_install vim
apt_install wget
apt_install unrar
apt_install valgrind
apt_install nemo
apt_install gnome-shell-pomodoro

# Build tools
apt_install build-essential
apt_install cmake
apt_install libatlas-base-dev
apt_install libboost-all-dev
apt_install libblas-dev
apt_install libeigen3-dev
apt_install liblapack-dev
apt_install libprotobuf-dev
apt_install byobu
apt_install pdfarranger

# Misc
apt_install mlocate
apt_install unzip
apt_install figlet
apt_install lolcat

# Image processing
apt_install libopencv-contrib-dev
apt_install libopencv-dev
apt_install gimp
apt_install jpegoptim
apt_install optipng
apt_install imagemagick
apt_install inkscape

# Audio and Video processing
apt_install audacity
apt_install ffmpeg
apt_install vlc

# Text processing
apt_install texlive
apt_install texstudio
apt_install zotero

# Tools
apt_install simplescreenrecorder
apt_install sshfs
apt_install xclip
apt_install virtualbox
apt_install virtualbox-qt
apt_install virtualbox-dkms
apt_install nextcloud-desktop
apt_install figlet
apt_install lolcat

# Run all scripts in programs
for f in programs/*.sh; do bash "$f" -H; done

# Get all upgrades
sudo apt upgrade -y
sudo apt autoremove -y

## Fun hello
figlet "... and we're back!" | lolcat
