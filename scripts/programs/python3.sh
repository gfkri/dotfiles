#!/bin/bash

# Sourcing helper utils
source ./utils.sh

echo "🐍 Installing Python"
apt_install python3-venv
apt_install python3-pip
apt_install python3-dev
apt_install python3-opencv
apt_install python3-numpy
apt_install python3-wheel
apt_install python3-ipython
/usr/bin/python3 -m pip install --upgrade pip

sudo add-apt-repository -y ppa:deadsnakes/ppa
apt_install python3.9
apt_install python3.9-dev
