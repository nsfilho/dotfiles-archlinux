#!/bin/bash

# update operational system packages
sudo pacman -Syu

# fix discord for wayland
fix_discord.sh
