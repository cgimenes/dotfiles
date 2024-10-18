#!/bin/bash

curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | gpg --import -
paru -S --noconfirm spotify
paru -S --noconfirm brave-bin
paru -S --noconfirm siji-ttf
paru -S --noconfirm betterlockscreen
paru -S --noconfirm enpass-bin
paru -S --noconfirm dragon-drop
paru -S --noconfirm slack-desktop
paru -S --noconfirm insync

rm -rf .config/autostart/**

gem install thor

fc-cache -fv
