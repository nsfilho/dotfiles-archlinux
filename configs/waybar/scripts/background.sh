#!/bin/bash

sleep 0.5

rofi_cmd() {
	rofi -dmenu \
		-p "Wallpaper" \
        -theme $HOME/.config/rofi/style.rasi
}

run_rofi() {
    wallpapers=$(ls ~/Pictures/wallpapers)
	echo -e "$wallpapers" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
if [ -f $HOME/Pictures/wallpapers/$chosen ]; then
    echo "Setting wallpaper to $chosen"
    swww img ~/Pictures/wallpapers/$chosen
else
    echo "No wallpaper selected"
    exit 1
fi
