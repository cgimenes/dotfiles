#!/bin/bash

timedatectl set-timezone America/Sao_Paulo
systemctl enable autorandr
systemctl enable docker
systemctl enable bluetooth
systemctl enable syncthing.service --user
systemctl enable tailscaled
systemctl enable betterlockscreen@$USER

usermod -aG docker $USER
usermod -aG video $USER

# Allow video group to control backlight and leds
sudo cp 90-backlight.rules /etc/udev/rules.d/90-backlight.rules
