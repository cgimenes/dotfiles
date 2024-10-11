#!/bin/bash

cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru

cd $HOME
git clone https://github.com/cgimenes/dotfiles.git
cd $HOME/dotfiles
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
stow dunst
stow bin
stow rg
stow tmux
stow gh-dash
stow wezterm

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
