#!/bin/bash

source ./utils.sh

echo "🐋 Installing Guake"
apt_install guake
guake --restore-preferences=../data/guake_preferences.cfg
