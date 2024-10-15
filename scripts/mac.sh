#!/bin/sh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

curl -L https://nixos.org/nix/install | sh

brew install --cask brave-browser
brew install --cask burp-suite
brew install --cask discord
brew install --cask docker
brew install --cask enpass
brew install --cask flameshot
brew install --cask iina
brew install --cask infra
brew install --cask jordanbaird-ice
brew install --cask librewolf
brew install --cask notion-calendar
brew install --cask obsidian
brew install --cask qbittorrent
brew install --cask raycast
brew install --cask rectangle
brew install --cask signal
brew install --cask soundsource
brew install --cask spotify
brew install --cask sublime-text
brew install --cask syncthing
brew install --cask tailscale
brew install --cask telegram
brew install --cask tradingview
brew install --cask vial
brew install --cask visual-studio-code
brew install --cask wezterm
brew install --cask whatsapp
brew install --cask yaak
brew install bat
brew install croc
brew install eza
brew install fastfetch
brew install fzf
brew install gh
brew install ghq
brew install git
brew install go
brew install highlight
brew install httpie
brew install k9s
brew install lazygit
brew install mpv
brew install neovim
brew install node
brew install ouch
brew install raylib
brew install ripgrep
brew install starship
brew install stow
brew install tmux
brew install yazi
brew install zoxide

git config --global ghq.root '~/dev/src'

brew tap railwaycat/emacsmacport
brew install emacs-mac --with-modules
ln -s /usr/local/opt/emacs-mac/Emacs.app /Applications/Emacs.app

git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

git clone https://github.com/cgimenes/dotfiles.git
cd dotfiles

stow ag
stow emacs
stow gh-dash
stow git
stow lf
stow nvim
stow rg
stow starship
stow tmux
stow wezterm
stow zsh
