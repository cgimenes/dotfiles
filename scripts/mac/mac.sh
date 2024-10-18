#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle

ln -s /usr/local/opt/emacs-mac/Emacs.app /Applications/Emacs.app

git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

git clone https://github.com/cgimenes/dotfiles.git
cd dotfiles

stow emacs
stow git
stow nvim
stow rg
stow starship
stow tmux
stow wezterm
stow zsh
