#!/bin/bash

sleep 0.5

# CMDs
host=$(cat /etc/hostname | cut -d'.' -f1)
user=$(whoami)

# Options
hibernate='󰤄 Hibernate'
shutdown='󰐥 Shutdown'
reboot='󰐦 Reboot'
lock='󰍁 Lock'
suspend='󰉃 Suspend'
logout='󰍃 Logout'
yes=' Yes'
no=' No'

# Confirmation CMD
confirm_cmd() {
	rofi \
        -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
        -theme $HOME/.config/rofi/power.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

rofi_cmd() {
	rofi \
        -theme-str "listview {columns: 1; lines: 6;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
        -dmenu \
		-p "💻 $user@$host" \
        -theme $HOME/.config/rofi/power.rasi
}

run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$hibernate\n$reboot\n$shutdown" | rofi_cmd
}

run_cmd() {
    selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
        sleep 0.5
        case $1 in
            --shutdown)
                systemctl poweroff
                ;;
            --reboot)
                systemctl reboot
                ;;
            --hibernate)
                systemctl hibernate
                ;;
            --lock)
                swaylock \
                    --screenshots \
                    --clock \
                    --indicator \
                    --indicator-radius 100 \
                    --indicator-thickness 7 \
                    --effect-blur 7x5 \
                    --effect-vignette 0.5:0.5 \
                    --ring-color bb00cc \
                    --key-hl-color 880033 \
                    --line-color 00000000 \
                    --inside-color 00000088 \
                    --separator-color 00000000 \
                    --grace 2 \
                    --fade-in 0.2
                ;;
            --suspend)
                systemctl suspend
                ;;
            --logout)
                hyprctl dispatch exit
                ;;
        esac
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $hibernate)
		run_cmd --hibernate
        ;;
    $lock)
        run_cmd --lock
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
