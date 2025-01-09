# loading plugins through zgen is too slow
source ~/.zsh/oh-my-zsh-plugins/sudo.plugin.zsh
source ~/.zsh/oh-my-zsh-plugins/git.plugin.zsh

# Changing/making/removing directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
