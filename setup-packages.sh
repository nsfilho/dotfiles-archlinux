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
    for package in $packagesNative; do
        if pacman -Q $package > /dev/null 2>&1; then
            echo "✅ $package is already installed"
        else
            echo "📦 Installing $package"
            sudo pacman -S --needed --noconfirm $package
        fi
    done
}

function installPackagesForeign() {
    echo "📦 Installing foreign packages"
    for package in $packagesForeign; do
        if yay -Q $package > /dev/null 2>&1; then
            echo "✅ $package is already installed"
        else
            echo "📦 Installing $package"
            yay -S --needed --noconfirm $package
        fi
    done
}

function installPackagesFlatpak() {
    echo "📦 Installing flatpak packages"
    for package in $packagesFlatpak; do
        # check if package is already installed
        if flatpak list | grep $package > /dev/null 2>&1; then
            echo "✅ $package is already installed"
            continue
        fi
        echo "📦 Installing $package"
        sudo flatpak install -y $package
    done
}

sudo pacman -Syu --noconfirm
installPackagesNative
installYay
installPackagesForeign
installPackagesFlatpak
