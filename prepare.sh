#!/bin/bash

CURRENT_DIR=$(pwd -P)

# Monta lista de pacotes
pacman -Qqen >$CURRENT_DIR/packages-native.lst
yay -Qqem >$CURRENT_DIR/packages-foreign.lst
flatpak list --app --columns=application >$CURRENT_DIR/packages-flatpak.lst

blacklist="yay glade hyprpaper nitrogen vim"

# Remove pacotes da lista negra
for pkg in $blacklist; do
	sed -i "/^$pkg$/d" $CURRENT_DIR/packages-native.lst
	sed -i "/^$pkg$/d" $CURRENT_DIR/packages-foreign.lst
done
