#!/bin/bash

source utils.sh

if [ ! -d "$HOME/.config/i3" ]; then
	mkdir -p $HOME/.config/i3
fi

linkPath "configs/i3config" ".config/i3/config"
linkPath "configs/polybar" ".config/polybar"
