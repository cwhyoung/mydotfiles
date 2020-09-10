#!/bin/sh
[ $(wmctrl -m | grep "herbstluftwm" | wc -l) = 1 ] && herbstclient quit
[ $(wmctrl -m | grep "bspwm" | wc -l) = 1 ] && bspc quit
[ $(wmctrl -m | grep "xmonad" | wc -l) = 1 ] && doas killall xmonad
