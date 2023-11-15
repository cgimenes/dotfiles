git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si
cd ..
rm -rf trizen

trizen -S brave-browser
trizen -S siji-ttf
trizen -S spotify
trizen -S qtile-extras
trizen -S betterlockscreen
trizen -S enpass-bin

stow qtile
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

gem install thor
