export TERM="xterm-256color"
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"

# Set VI mode
bindkey -v

export GOPATH="$HOME/dev"
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$PATH:$(gem environment user_gemhome)/bin

[[ $- != *i* ]] && return

