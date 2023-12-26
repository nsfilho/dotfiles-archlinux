#!/bin/bash

wofi_cmd() {
	wofi --dmenu \
		-p "Wallpaper" \
        -c ~/.config/wofi/config -s ~/.config/wofi/style.css
}

run_wofi() {
    wallpapers=$(ls ~/Pictures/wallpapers)
	echo -e "$wallpapers" | wofi_cmd
}

# Actions
chosen="$(run_wofi)"
swww img ~/Pictures/wallpapers/$chosen
