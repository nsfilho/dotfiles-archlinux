#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# delay for detect monitors properly
sleep 3

# launch polybar on all monitors
for m in $(polybar --list-monitors | cut -d":" -f1); do
	echo "Launching polybar on monitor $m"
	MONITOR=$m polybar --reload mybar &
done
