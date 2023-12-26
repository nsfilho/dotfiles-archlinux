#!/bin/bash

source utils.sh

# Configure dunst notification
linkPath "configs/dunst" ".config/dunst"

# Configure kitty
linkPath "configs/kitty" ".config/kitty"

# Configure rofi
linkPath "configs/rofi" ".config/rofi"

# Configure swaylock
linkPath "configs/swaylock" ".config/swaylock"

# Configure waybar
linkPath "configs/waybar" ".config/waybar"

# Configure wofi
linkPath "configs/wofi" ".config/wofi"

# Configure starship
linkPath "configs/starship.toml" ".config/starship.toml"

# Configure hyprland
if [ -d $HOME/.config/hypr ] ; then
    rm -rf $HOME/.config/hypr
fi

if [ ! -L $HOME/.config/hypr ] ; then
    echo "📦 Creating link $DOTFILES_DIR/configs/hypr -> $HOME/.config/hypr"
    ln -s $DOTFILES_DIR/configs/hypr $HOME/.config/hypr
fi

if [ ! -f $HOME/.config/hypr/input.conf ] ; then
    cp $DOTFILES_DIR/configs/hypr/input.sample.conf $HOME/.config/hypr/input.conf
fi
if [ ! -f $HOME/.config/hypr/monitors.conf ] ; then
    cp $DOTFILES_DIR/configs/hypr/monitors.sample.conf $HOME/.config/hypr/monitors.conf
fi
