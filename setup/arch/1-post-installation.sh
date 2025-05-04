#!/bin/bash

sudo sed -i "s/^#Color/Color/" /etc/pacman.conf
sudo sed -i "s/^#ParallelDownloads = 5/ParallelDownloads = 2/" /etc/pacman.conf
sudo sed -i "s/^#VerbosePkgLists/VerbosePkgLists/" /etc/pacman.conf

chsh -s /bin/zsh $USER

cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru

cd $HOME
git clone https://github.com/cgimenes/dotfiles.git
cd $HOME/dotfiles
git remote set-url origin git@github.com:cgimenes/dotfiles.git

stow alacritty
stow aliks
stow atuin
stow autorandr
stow awesome
stow bat
stow bin
stow bspwm
stow btop
stow dunst
stow emacs
stow fonts
stow ghostty
stow git
stow gsimplecal
stow hyprland
stow kitty
stow lazygit
stow mpv
stow nvim
stow pet
stow picom
stow polybar
stow rg
stow rofi
stow starship
stow systemd
stow tmux
stow wezterm
stow xorg
stow yazi
stow zsh
