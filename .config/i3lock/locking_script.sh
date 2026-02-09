#!/bin/bash

img=/tmp/i3lock.png

# Do not lock the screen if the first argument is not manual.
# This is used to ensure that I control which process can lock the screen.
if [ "$1" != "manual" ]; then
    exit 0
fi

scrot -o $img

convert $img -scale 20% -blur 0x1.5 -scale 500% $img
convert $img ~/.config/i3lock/lock.png -gravity center -composite $img

i3lock --show-failed-attempts -i $img
