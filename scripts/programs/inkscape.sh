#!/bin/bash

source ./utils.sh

echo "📁 Installing Inkscape"
sudo add-apt-repository -y ppa:inkscape.dev/stable
sudo apt update
apt_install inkscape
apt_install gir1.2-gtksource-3.0

wget https://github.com/textext/textext/releases/download/1.8.2/TexText-Linux-1.8.2.tar.gz
tar -xvf TexText-Linux-1.8.2.tar.gz
cd textext-1.8.2
python3 setup.py 
cd ..
rm -rf TexText-Linux-1.8.2.tar.gz textext-1.8.2
