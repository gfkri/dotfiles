#!/bin/bash

source ./utils.sh

echo "🐋 Installing Guake"
apt_install guake
guake --restore-preferences=../guake_preferences.cfg
