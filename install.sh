#!/bin/bash

PWD=$(pwd)

# Vim install
ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.vim ~/.vim

# Screen install
ln -s $PWD/.screenrc ~/.screenrc

# ZSH install
ln -s $PWD/.zshrc ~/.zshrc

# Git hooks install
ln -s $PWD/.git_template ~/.git_template
