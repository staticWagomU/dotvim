#!/bin/sh

sudo apt-get install ninja-build gettext cmake unzip curl build-essential

# ~/dev/github.com/neovim/neovim が存在しなければクローン
if [ ! -d ~/dev/github.com/neovim/neovim ]; then
  ghq get https://github.com/neovim/neovim
fi

cd ~/dev/github.com/neovim/neovim

git pull

sudo make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make instal
