#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install --cask enpass
brew install --cask kitty
brew install --cask brave-browser
brew install --cask wezterm
brew install --cask notion-calendar
brew install --cask obsidian
brew install --cask google-drive
brew install --cask flameshot
brew install --cask visual-studio-code
brew install --cask whatsapp
brew install --cask spotify
brew install --cask rectangle
brew install --cask soundsource
brew install --cask vial
brew install --cask signal
brew install --cask telegram
brew install neovim
brew install stow
brew install tmux
brew install fastfetch
brew install zoxide
brew install starship
brew install eza
brew install fzf
brew install gh
brew install node
brew install ripgrep
brew install golang
brew install lazygit
brew install raylib

git clone https://github.com/cgimenes/dotfiles.git
cd dotfiles

stow ag
stow kitty
stow gh-dash
stow git
stow nvim
stow lf
stow rg
stow starship
stow taskwarrior
stow tmux
stow zsh
stow wezterm