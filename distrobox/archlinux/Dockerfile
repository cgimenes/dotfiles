FROM archlinux

RUN pacman-key --init

COPY /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist

RUN pacman -Syuu --noconfirm
RUN pacman -S --noconfirm go starship git neovim eza tmux zoxide ripgrep lazygit
