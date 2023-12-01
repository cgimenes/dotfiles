export TERM="xterm-256color"
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"

# Set VI mode
bindkey -v

export GOPATH="$HOME/dev"

if [ -x "$(command -v /opt/homebrew/bin/brew)" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -x "$(command -v go)" ]; then
    export PATH=$PATH:$(go env GOPATH)/bin
fi

if [ -x "$(command -v gem)" ]; then
    export PATH=$PATH:$(gem environment path | sed -e "s/:/\/bin:/")/bin
fi

