#!/bin/bash
status="$(playerctl -p $1 status 2>&1 | grep -v WARNING)"
if [ "$status" = "No players found" ]; then
  echo ""
  return 0
fi

if [ "$status" = "Stopped" ]; then
  echo ""
  return 0
fi

if [ "$status" != "Playing" ]; then
  echo "$status"
  return 0
fi

title="$(playerctl -p $1 metadata xesam:title | sed 's/\(.\{15\}\).*/\1.../')"
artist="$(playerctl -p $1 metadata xesam:artist)"
echo "$artist: $title"
