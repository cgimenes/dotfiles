#!/bin/bash

curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | gpg --import -

aur_packages=(
	"spotify" "brave-bin" "betterlockscreen" "enpass-bin" "dragon-drop" "slack-desktop" "pet-bin" "librewolf-bin" "mise-bin" "lazydocker" "eww" "ttf-tabler-icons" "yaak" "shikane" "kanagawa-icon-theme-git" "kanagawa-gtk-theme-git" "ncspot-bin" "xidlehook"
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
cargo install wiremix

fc-cache -fv
bat cache --build

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
~/.config/emacs/bin/doom sync

ya pack -i
