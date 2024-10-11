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
