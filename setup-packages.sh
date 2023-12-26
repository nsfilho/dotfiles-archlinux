#!/bin/bash

DOTFILES_DIR=$(pwd -P)
WORKSPACE_DIR="$HOME/workspace/linux"

packagesNative=$(cat $DOTFILES_DIR/packages-native.lst)
packagesForeign=$(cat $DOTFILES_DIR/packages-foreign.lst)
packagesFlatpak=$(cat $DOTFILES_DIR/packages-flatpak.lst)

function installYay() {
    if [ -d "$WORKSPACE_DIR/yay" ]; then
        echo "✅ yay is already installed"
        return
    fi
    echo "📦 Installing yay"
    mkdir -p $WORKSPACE_DIR
    cd $WORKSPACE_DIR
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
}

function installPackagesNative() {
    echo "📦 Installing native packages"
    sudo pacman -S --needed --noconfirm $packagesNative
}

function installPackagesForeign() {
    echo "📦 Installing foreign packages"
    yay -S --needed --noconfirm $packagesForeign
}

function installPackagesFlatpak() {
    echo "📦 Installing flatpak packages"
    for package in $packagesFlatpak; do
        flatpak install -y $package
    done
}

installPackagesNative
installYay
installPackagesForeign
installPackagesFlatpak
