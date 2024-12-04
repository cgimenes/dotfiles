#!/bin/sh

# configure key repetition speeds
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 14

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# dotfiles
git clone https://github.com/cgimenes/dotfiles.git
cd dotfiles

stow bat
stow btop
stow emacs
stow git
stow lazygit
stow nvim
stow rg
stow skhd
stow starship
stow tmux
stow wezterm
stow yazi
stow zsh

# run brew bundle
cd scripts/mac; brew bundle

# install doom emacs
ln -s /usr/local/opt/emacs-mac/Emacs.app /Applications/Emacs.app

git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# install bat theme
bat cache --build

# skhd
skhd --start-service
