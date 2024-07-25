#!/bin/sh
set -e

VIM_DIR=~/dev/github.com/vim/vim

# If ~/dev/github.com/neovim/neovim does not exist, clone it
if [ ! -d "$VIM_DIR" ]; then
  ghq get https://github.com/neovim/neovim
fi

cd "$VIM_DIR" && \
git pull && \
cd src && \
make && \
sudo make install

