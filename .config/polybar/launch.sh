#!/usr/bin/env bash

pkill polybar

if type "xrandr"; then
    #for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        #MONITOR=$m polybar --reload mainbar-i3 -c ~/.config/polybar/config &
    #done
    
    # Primary bar
    MONITOR=$(xrandr | sed -n '/ connected/h;/\*/{g;p}' | awk '/primary/{print $1}') polybar --reload mainbar-i3 -c ~/.config/polybar/config &

    # Secundary bar
    for m in $(xrandr | sed -n '/ connected/h;/\*/{g;p}' | awk '!/primary/{print $1}'); do
        MONITOR=$m polybar --reload mainbar-i3-extra -c ~/.config/polybar/config &
    done
else
    polybar --reload mainbar-i3 -c ~/.config/polybar/config &
fi


