#!/bin/sh

if pgrep -x bspwm >/dev/null; then
    bspc desktop -f $1
fi

if pgrep -x Hyprland >/dev/null; then
    hyprctl dispatch workspace $1
fi
