#!/bin/sh
#if [ $(xrandr | grep -sw 'connected' | wc -l) -eq 1 ] ;then
#	if [ $(xrandr | grep -sw '5120x1440' | wc -l) -ge 1 ] ;then
#		feh --bg-fill /home/w/Documents/wallpapers5120/aus5120scene2.jpg &
#	elif [ $(xrandr | grep -sw '2560x1440' | wc -l) -ge 1 ] ;then
#	  feh --bg-fill /home/w/Documents/wallpapers2560/austria-salzburg-city_2560x1440.jpg &
#	fi
#else
# nitrogen --restore &
#fi
#
#
[ $(xrandr | grep -sw 'connected' | wc -l) = 1 ] && [ $(xrandr | grep -sw '5120x1440' | wc -l) > 1 ] && feh --bg-fill /home/w/Documents/Wallpapers/wallpapers5120/aus5120scene2.jpg 
[ $(xrandr | grep -sw 'connected' | wc -l) = 1 ] && [ $(xrandr | grep -sw 'connected 2560x1440' | wc -l) = 1 ] && feh --bg-fill /home/w/Documents/Wallpapers/wallpapers2560/Hallstatt_Town_Day_2020_2560x1440.jpg 
[ $(xrandr | grep -sw 'connected' | wc -l) = 2 ] && feh --bg-center /home/w/Documents/Wallpapers/wallpapers2560/austria-salzburg-city_2560x1440.jpg /home/w/Documents/Wallpapers/wallpapers2560/ws_Hallstatt_Austria_2560x1440.jpg 
[ $(xrandr | grep -sw 'connected' | wc -l) = 3 ] && feh --bg-center /home/w/Documents/Wallpapers/wallpapers1920/Aus-Nature1920.jpg /home/w/Documents/Wallpapers/wallpapers2560/austria-salzburg-city_2560x1440.jpg /home/w/Documents/Wallpapers/wallpapers2560/ws_Hallstatt_Austria_2560x1440.jpg
[ $(xrandr | grep -sw 'connected' | wc -l) = 1 ] && [ $(xrandr | grep -sw 'HDMI-0 connected' | wc -l) = 1 ] && feh --bg-center /home/w/Documents/Wallpapers/wallpapers1920/Aus-Nature1920.jpg
