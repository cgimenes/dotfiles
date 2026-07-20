#!/bin/bash

aur_packages=(
	"betterlockscreen"
	"brave-bin"
	"bruno-bin"
	"dragon-drop"
	"eww"
	"kanagawa-gtk-theme-git"
	"kanagawa-icon-theme-git"
	"librewolf-bin"
	"pet-bin"
	"simple-mtpfs"
	"slack-desktop"
	"ttf-tabler-icons"
	"xidlehook"
)
echo "The following packages will be installed from the AUR: ${aur_packages[*]}"
for package in "${aur_packages[@]}"; do
	if ! paru -Qi "$package" &>/dev/null; then
		paru -S --noconfirm "$package"
	else
		echo "$package is already installed. Skipping..."
	fi
done

rm -rf .config/autostart/**

gem install thor # for polybar
gem install erb  # for polybar
go install github.com/x-motemen/ghq@latest
go install github.com/jesseduffield/lazydocker@latest
go install github.com/neur0map/glazepkg/cmd/gpk@latest
cargo install wiremix

fc-cache -fv
bat cache --build

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
~/.config/emacs/bin/doom sync

ya pack -i
