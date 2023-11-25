FROM archlinux

RUN pacman-key --init

COPY mirrorlist /etc/pacman.d/mirrorlist

RUN pacman -Syuu --noconfirm
RUN pacman -S --noconfirm go starship git neovim eza tmux
