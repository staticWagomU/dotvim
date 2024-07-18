#!/bin/sh
set -e

NEOVIM_DIR=~/dev/github.com/neovim/neovim

sudo apt-get install -y ninja-build gettext cmake unzip curl build-essential

# If ~/dev/github.com/neovim/neovim does not exist, clone it
if [ ! -d "$NEOVIM_DIR" ]; then
  ghq get https://github.com/neovim/neovim
fi

cd "$NEOVIM_DIR" && \
git pull && \
sudo make CMAKE_BUILD_TYPE=RelWithDebInfo && \
sudo make install
