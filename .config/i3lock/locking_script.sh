#!/bin/bash

img=/tmp/i3lock.png

scrot -o $img

convert $img -scale 20% -blur 0x1.5 -scale 500% $img
convert $img ~/.config/i3lock/lock.png -gravity center -composite $img

i3lock --show-failed-attempts -i $img
