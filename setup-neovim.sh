#!/bin/bash

source utils.sh

# Preparing requirements for neovim
# sudo npm install -g neovim @fsouza/prettierd eslint_d
cargo install tree-sitter-cli
linkPath "configs/nvim" ".config/nvim"
