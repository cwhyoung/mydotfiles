#!/bin/bash

directory=~/.local/share/Wallpaper/
monitor=`hyprctl monitors | grep Monitor | awk '{print $2}'`

if [ -d "$directory" ]; then
	sleep 2s
    random_background=$(ls $directory/*.jpg | shuf -n 1)

    hyprctl hyprpaper wallpaper "$monitor, $random_background"

fi
