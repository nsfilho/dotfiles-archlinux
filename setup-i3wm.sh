#!/bin/bash

source utils.sh

if [ ! -d "$HOME/.config/i3" ]; then
	mkdir -p $HOME/.config/i3
fi

linkPath "configs/i3config" ".config/i3/config"
linkPath "configs/polybar" ".config/polybar"

echo Installing my apps
cargo install --git https://github.com/nsfilho/i3_move_next.git
cargo install --git https://github.com/nsfilho/i3_new_workspace.git
