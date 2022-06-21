#!/bin/bash

function apt_install {
 # which $1 &> /dev/null
  PKG_OK=$((dpkg-query -W --showformat='${Status}\n' $1 | grep "install ok installed") 2> /dev/null)

  if [ "" = "$PKG_OK" ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}


function snap_install {
  snap list $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo snap install $1
  else
    echo "Already installed: ${1}"
  fi
}
