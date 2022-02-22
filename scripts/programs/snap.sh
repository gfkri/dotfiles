#!/bin/bash

function install {
  snap list $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo snap install $1
  else
    echo "Already installed: ${1}"
  fi
}

# Basics
install blender
install cloudcompare
install keepassxc
install signal-desktop
install meshlab
install spotify