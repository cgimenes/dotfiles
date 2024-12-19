#!/bin/sh

ffmpeg -i $(playerctl metadata mpris:artUrl) '/tmp/.music_cover.png' -y >/dev/null 2>&1
echo '/tmp/.music_cover.png'
