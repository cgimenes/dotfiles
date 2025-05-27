#!/bin/sh

# Manual todo list:
# - switch caps lock to control
# - change "Click wallpaper to reveal desktop" to "Stage Manager"
# - reduce motion on accessibility settings
# - Bluesnooze launch at login
# - Ice launch at login
# - Rectangle launch at login
# - Configure Syncthing and launch at login

# configure key repetition speeds
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 14
# configure dock
defaults write com.apple.dock "orientation" -string "left"
defaults write com.apple.dock "show-recents" -bool "false"
defaults write com.apple.dock "tilesize" -int "36"
# configure spaces
defaults write com.apple.dock "mru-spaces" -bool "false" && killall Dock
killall Dock

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# dotfiles
git clone https://github.com/cgimenes/dotfiles.git
cd dotfiles

brew install stow

# create symlinks
stow atuin
stow bat
stow btop
stow emacs
stow ghostty
stow git
stow kitty
stow lazygit
stow nvim
stow pet
stow rg
stow skhd
stow starship
stow tmux
stow wezterm
stow yazi
stow zsh

# install rosetta
sudo softwareupdate --install-rosetta

# run brew bundle
cd setup/mac; brew bundle

# install doom emacs
ln -s /opt/homebrew/opt/emacs-mac/Emacs.app /Applications/Emacs.app

git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# install bat theme
bat cache --build

# skhd
skhd --start-service
