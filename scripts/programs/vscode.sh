#!/bin/bash

echo "🐋 Installing VSCode"
wget -O vscode.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install ./vscode.deb
rm -rf ./vscode.deb

code --install-extension ms-python.python
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cpptools-extension-pack
code --install-extension twxs.cmake
code --install-extension james-yu.latex-workshop
code --install-extension ms-azuretools.vscode-docker
code --install-extension 076923.python-image-preview
code --install-extension eamodio.gitlens
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension ms-vscode-remote.remote-containers
code --install-extension visualstudioexptteam.intellicode-api-usage-examples
code --install-extension valentjn.vscode-ltex                                       # tex support
code --install-extension YuTengjing.open-in-external-app                            # open files with external/system application on right click
