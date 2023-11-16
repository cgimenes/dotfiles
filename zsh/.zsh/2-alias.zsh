# Clipboard
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'

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

# Changing "ls" to "eza"
alias ls='eza --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -al --color=always --group-directories-first'  # long format

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

# termbin
alias tb="nc termbin.com 9999"
