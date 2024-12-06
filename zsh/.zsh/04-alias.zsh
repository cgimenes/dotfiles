# Tmux
alias ta='tmux list-sessions && tmux a || tmux'

# Git
alias gdsn='gds --name-only'
alias lzg='lazygit'
alias gg='ghq get -p'
alias ggs='ghq get -p --shallow'

# Vim/Nvim
alias vim='nvim'
alias v='nvim'
alias n='nvim'

# Changing 'ls' to 'eza'
alias ls='eza --icons --group-directories-first'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Adding flags
alias df='df -h'
alias free='free -m'
alias mkdir='mkdir -p'

# Hacks
alias fv='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim'
alias fcd='cd $(fd -H -t d | fzf-tmux -p --reverse)'
alias xargs='xargs ' # expands aliases for piping into xargs
alias c='clear'

# Docker Compose
alias lzd='lazydocker'

# Python
alias poetsh='source $(poetry env info --path)/bin/activate' # Activate poetry shell without subshell

# Kubernetes
alias k9s='k9s -c contexts' # Open k9s with contexts view
