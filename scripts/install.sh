#!/bin/bash

# Copy dotfiles
./copy.sh

# Update Ubuntu and get standard repository programs
sudo apt update && sudo apt full-upgrade -y

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

# Basics
install awscli
install curl
install exfat-utils
install file
install git
install htop
install jq
install yq
install nmap
install openvpn
install tree
install vim
install wget

# Build tools
install build-essential
install cmake
install gcc
install g++
install libatlas-base-dev
install libboost-all-dev
install libblas-dev
install libeigen3-dev
install liblapack-dev
install libprotobuf-dev

# Misc
install mlocate
install unzip
install figlet
install lolcat
install guake

# Image processing
install libopencv-contrib-dev
install libopencv-dev
install gimp
install jpegoptim
install optipng
install imagemagick

install nextcloud-desktop

# Run all scripts in programs/
for f in programs/*.sh; do bash "$f" -H; done

# Get all upgrades
sudo apt upgrade -y
sudo apt autoremove -y

## Fun hello
figlet "... and we're back!" | lolcat