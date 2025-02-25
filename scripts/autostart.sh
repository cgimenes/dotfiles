#!/bin/sh

pgrep -x sxhkd >/dev/null || sxhkd &
pgrep -x picom >/dev/null || picom &
pgrep -x nm-applet >/dev/null || nm-applet &
pgrep -x polybar >/dev/null || ~/dotfiles/scripts/polybar &
pgrep -x copyq >/dev/null || copyq &
pgrep -x lxsession >/dev/null || lxsession &
pgrep -x udiskie >/dev/null || udiskie &
pgrep -x enpass >/dev/null || enpass -minimize &
pgrep -f autorandr_launcher >/dev/null || autorandr_launcher 2>&1 >~/ar.log &
pgrep -f xidlehook >/dev/null || xidlehook \
  --not-when-fullscreen \
  --timer 120 \
  'brightnessctl -s set 10' \
  'brightnessctl -r' \
  --timer 180 \
  'brightnessctl -r; xset dpms force off' \
  '' \
  --timer 60 \
  'betterlockscreen -l dim' \
  '' \
  --timer 540 \
  'systemctl suspend' \
  '' &
nitrogen --restore &
autorandr -c &

# X configs
xsetroot -cursor_name left_ptr
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1 &
xinput set-prop "DELL0B56:00 04F3:317E Touchpad" "libinput Tapping Enabled" 1 &
xinput set-prop "pointer:Logitech MX Ergo" "libinput Accel Speed" -1 &
setxkbmap -layout 'us,br' -variant 'intl,thinkpad' -option 'grp:alt_space_toggle' -option 'ctrl:nocaps'
xset s off -dpms
xset r rate 250 50 # repeat rate
