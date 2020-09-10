#!/bin/sh
[ $(wmctrl -m | grep "herbstluftwm" | wc -l) = 1 ] && herbstclient reload
[ $(wmctrl -m | grep "bspwm" | wc -l) = 1 ] && bspc wm -r
[ $(wmctrl -m | grep "xmonad" | wc -l) = 1 ] && xmonad --recompile; xmonad --restart
