#!/bin/bash

# Sourcing helper utils
source ./utils.sh

echo "Installing Zotero"

wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
sudo apt update
apt_install zotero

echo "[MANUAL] Put the content of data/zotero_bb_postscript.js to 'Zotero->Edit->Preferences->Better BibTex->Export->postscript'! "

