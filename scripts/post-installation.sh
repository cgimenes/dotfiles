git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
rm -rf yay-bin

yay -S brave-browser
yay -S siji-ttf
yay -S spotify

#stow bspwm
#stow nvim
#stow picom
#stow polybar
#stow aliks
#stow git
#stow xorg
#stow zsh

gem install thor
