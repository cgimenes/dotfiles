#!/bin/sh

pgrep -x sxhkd > /dev/null || sxhkd &
pgrep -x picom > /dev/null || picom &
pgrep -x nm-applet > /dev/null || nm-applet &
pgrep -x polybar > /dev/null || ~/dotfiles/scripts/polybar &
pgrep -x copyq > /dev/null || copyq &
pgrep -x lxsession > /dev/null || lxsession &
pgrep -x udiskie > /dev/null || udiskie &
pgrep -x blueman-applet > /dev/null || blueman-applet &
pgrep -x insync > /dev/null || insync start &
pgrep -x enpass > /dev/null || enpass -minimize &
pgrep -f autorandr_launcher > /dev/null || autorandr_launcher 2>&1 > /home/oliveira/ar.log &
nitrogen --restore &
autorandr -c &

# X configs
xsetroot -cursor_name left_ptr &
xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1 &
xinput set-prop "DELL0B56:00 04F3:317E Touchpad" "libinput Tapping Enabled" 1 &
setxkbmap -layout 'us,us,br,br' -variant ',intl,thinkpad,' -option 'grp:alt_space_toggle' -option 'ctrl:nocaps' &

