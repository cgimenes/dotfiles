#!/bin/bash

cd /tmp
git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si --noconfirm
cd ..
rm -rf trizen

cd $HOME
git clone https://github.com/cgimenes/dotfiles.git
cd $HOME/dotfiles
stow qtile
stow nvim
stow picom
stow bspwm
stow polybar
stow aliks
stow git
stow xorg
stow zsh
stow autorandr
stow gsimplecal
stow rofi
stow lf
stow dunst
stow bin

cd $HOME/dotfiles/distrobox/
make archlinux
make php

trizen -S --noconfirm brave-browser
trizen -S --noconfirm siji-ttf
trizen -S --noconfirm spotify
trizen -S --noconfirm qtile-extras
trizen -S --noconfirm betterlockscreen
trizen -S --noconfirm enpass-bin
trizen -S --noconfirm dragon-drop
gem install thor
go install github.com/cheat/cheat/cmd/cheat@latest
