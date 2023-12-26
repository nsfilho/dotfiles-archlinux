#!/bin/bash

fpath="/usr/share/applications/discord.desktop"
if [ -f "$fpath" ]; then
    sudo sed -i 's/Exec=\/usr\/bin\/discord.*/Exec=\/usr\/bin\/discord --enable-features=UseOzonePlatform --ozone-platform=wayland/g' $fpath
fi
