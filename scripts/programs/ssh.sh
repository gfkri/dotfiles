#!/bin/bash

# Sourcing helper utils
source ./utils.sh

echo "🔒 Setting up ssh"
apt_install openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
