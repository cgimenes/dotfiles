# Tmux
alias ta='tmux list-sessions && tmux a || tmux'

# Git
alias gdsn="gds --name-only"

# Highlight
alias hat='highlight -O ansi --force'

# Hotspot
alias hsup='nmcli con up id Hotspot'
alias hsdown='nmcli con down id Hotspot'

# Update system
alias upd-dist='yay -Syua --noconfirm'

# Vim/Nvim
alias vim="nvim"
alias v="nvim"
alias n="nvim"

# Python
alias actvenv='source $(poetry env info --path)/bin/activate'

# Changing "ls" to "eza"
alias ls='eza --icons --group-directories-first'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias mkdir="mkdir -p"

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# lazygit
alias lg="lazygit"

# hacks
alias fv='fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim'
alias fcd='cd $(fd -H -t d | fzf-tmux -p --reverse)'
alias updatemirrors='curl -s "https://archlinux.org/mirrorlist/?country=BR&protocol=https" | sed -e "s/^#Server/Server/" -e "/^#/d" | rankmirrors - | sudo tee /etc/pacman.d/mirrorlist'
alias xargs='xargs ' # expands aliases for piping into xargs
