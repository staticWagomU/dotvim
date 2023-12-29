#!/bin/bash

brew upgrade vim --fetch-HEAD
brew upgrade neovim --fetch-HEAD
brew cleanup neovim
brew cleanup vim
