#!/usr/bin/env bash

mkdir -p ~/.vim/plugin
mkdir -p ~/.vim/doc
mkdir -p ~/.vim/colors

# install/update fugitive.vim (Git wrapper for Vim)
wget -q https://raw.githubusercontent.com/tpope/vim-fugitive/master/plugin/fugitive.vim -O ~/.vim/plugin/fugitive.vim
wget -q https://raw.githubusercontent.com/tpope/vim-fugitive/master/doc/fugitive.txt -O ~/.vim/doc/fugitive.txt