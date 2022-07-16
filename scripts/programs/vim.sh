#!/bin/bash

echo "📦 Installing Vundle"

cd ..
cp .vimrc ${HOME}
cp -r .vim ${HOME}

mkdir -p $HOME/.vim/bundle
cd $HOME/.vim/bundle
git clone git://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall

