# Tmux
alias ta='tmux a || tmux'
alias tn='tmux new-session'

# Git
alias gdsn='gds --name-only'
alias lzg='lazygit'
alias gdnd='git -c pager.diff="less -R" diff'
# Git clone and add to zoxide:
alias ggp='ghq get -p'
alias ggps='ghq get -p --shallow'
alias ggs='ghq get --shallow'
alias gz='ghq list | xargs -I {} zoxide add -s 0 $(ghq root)/{}'

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

# NPM
alias supabase='npx --yes supabase'
alias nest='npx --yes @nestjs/cli'
alias tsx='npx --yes tsx'
