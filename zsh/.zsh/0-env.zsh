export TERM="xterm-256color"
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/rg/config"

export DISABLE_AUTO_UPDATE=true

# Set Emacs mode
bindkey -e

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

if [ -x "$(command -v pyenv)" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi
