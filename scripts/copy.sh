#!/bin/bash

# Up from scripts dir
cd ..

cp .pythonrc ${HOME}
cat .bashrc >> ${HOME}/.bashrc
cat .bash_aliases >> ${HOME}/.bash_aliases
