# Set Emacs mode
bindkey -e

# Better history
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
setopt INC_APPEND_HISTORY # History file is updated immediately after a command is entered
setopt SHARE_HISTORY      # Allows multiple Zsh sessions to share the same command history
setopt APPENDHISTORY      # Ensures that each command entered in the current session is appended to the history file immediately after execution
setopt HIST_IGNORE_DUPS   # Do not record an event that was just recorded again
setopt HIST_FIND_NO_DUPS  # Do not display a previously found event
setopt EXTENDED_HISTORY   # Write the history file in the ':start:elapsed;command' format
HISTFILE=~/.zsh_history
HISTSIZE=5000000
SAVEHIST=$HISTSIZE

# Makes the delete key work
typeset -g -A key
key[Delete]="${terminfo[kdch1]}"
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
