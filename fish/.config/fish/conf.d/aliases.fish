# Tmux
alias ta='tmux a || tmux'
alias tn='tmux new-session'
function th
    tmux new-session -A -c ~ -s home ';' new-window
end

# Git
alias gdsn='git diff --staged --name-only'
alias lzg='lazygit'
alias gdnd='git -c pager.diff="less -R" diff'
alias gst='git status'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gp='git push'
alias gf='git fetch'
alias gl='git pull'
alias gcm='git checkout $(git_main_branch)'
alias gca='git commit --verbose --all'
alias gcmsg='git commit --message'

# Vim/Nvim
alias vim='nvim'
alias v='nvim'
alias n='nvim'

# ls -> eza
alias ls='eza --icons --group-directories-first'
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# flags
alias df='df -h'
alias free='free -m'
alias mkdir='mkdir -p'

# directory nav
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'

# hacks
alias fv='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim'
function fcd
    cd (fd -H -t d | fzf-tmux -p --reverse)
end
alias c='clear'

# Docker
alias lzd='lazydocker'
