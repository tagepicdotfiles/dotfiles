#!/bin/sh
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --config=$HOME/.config/polybar/polybar.ini -r main &
done

# polybar --config=$HOME/.config/polybar/polybar.ini main &
