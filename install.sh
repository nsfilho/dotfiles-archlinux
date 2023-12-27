#!/bin/bash
DOTFILES_DIR=$(pwd -P)
WORKSPACE_DIR="$HOME/workspace/linux"

source $DOTFILES_DIR/utils.sh
source $DOTFILES_DIR/setup-packages.sh
source $DOTFILES_DIR/setup-shell.sh
source $DOTFILES_DIR/setup-git.sh
source $DOTFILES_DIR/setup-neovim.sh
source $DOTFILES_DIR/setup-hyprland.sh
source $DOTFILES_DIR/setup-locale.sh

# Enable some services
sudo systemctl enable --now gdm.service
sudo systemctl enable --now sshd.service
sudo systemctl enable --now docker.service

