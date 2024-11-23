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
stow aliks
stow autorandr
stow bat
stow bin
stow bspwm
stow dunst
stow emacs
stow git
stow gsimplecal
stow lazygit
stow nvim
stow picom
stow polybar
stow rg
stow rofi
stow starship
stow tmux
stow wezterm
stow yazi
stow zsh
