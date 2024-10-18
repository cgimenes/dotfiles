#!/bin/bash

sudo su

timedatectl set-timezone America/Sao_Paulo
systemctl enable autorandr
systemctl enable docker
systemctl enable bluetooth

usermod -aG docker oliveira
usermod -aG video oliveira
chsh -s /bin/zsh oliveira

# Allow video group to control backlight and leds
cat > /etc/udev/rules.d/90-backlight.rules <<- EOM
SUBSYSTEM=="backlight", ACTION=="add", \
  RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness", \
  RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"
SUBSYSTEM=="leds", ACTION=="add", KERNEL=="*::kbd_backlight", \
  RUN+="/bin/chgrp video /sys/class/leds/%k/brightness", \
  RUN+="/bin/chmod g+w /sys/class/leds/%k/brightness"
EOM
