#!/bin/bash

echo "🐋 Installing VSCode"
wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install ./vscode.deb
rm -rf ./vscode.deb
