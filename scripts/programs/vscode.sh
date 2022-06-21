#!/bin/bash

echo "🐋 Installing VSCode"
wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install ./vscode.deb
rm -rf ./vscode.deb

code --install-extension ms-python.python
code --install-extension ms-vscode.cpptools
code --install-extension james-yu.latex-workshop
code --install-extension ms-azuretools.vscode-docker
code --install-extension 076923.python-image-preview
code --install-extension eamodio.gitlens
