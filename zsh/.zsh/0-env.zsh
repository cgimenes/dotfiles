export TERM="xterm-256color"
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER="nvim +Man!"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/rg/config"

export DISABLE_AUTO_UPDATE=true

# Set Emacs mode
bindkey -e

# Better history
setopt INC_APPEND_HISTORY   # History file is updated immediately after a command is entered
setopt SHARE_HISTORY        # Allows multiple Zsh sessions to share the same command history 
setopt APPENDHISTORY        # Ensures that each command entered in the current session is appended to the history file immediately after execution
setopt HIST_IGNORE_DUPS     # Do not record an event that was just recorded again
setopt HIST_FIND_NO_DUPS    # Do not display a previously found event
setopt EXTENDED_HISTORY     # Write the history file in the ':start:elapsed;command' format
HISTSIZE=5000000
SAVEHIST=$HISTSIZE

# Shell integrations

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
