#!/bin/bash

curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | gpg --import -
paru -S --noconfirm spotify
paru -S --noconfirm brave-bin
paru -S --noconfirm siji-ttf
paru -S --noconfirm betterlockscreen
paru -S --noconfirm enpass-bin
paru -S --noconfirm dragon-drop
paru -S --noconfirm slack-desktop
paru -S --noconfirm pet-bin
paru -S --noconfirm librewolf-bin
paru -S --noconfirm mise-bin
paru -S --noconfirm lazydocker

rm -rf .config/autostart/**

gem install thor
gem install erb

fc-cache -fv
bat cache --build

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
~/.config/emacs/bin/doom sync
