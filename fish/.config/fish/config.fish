if status is-interactive
    starship init fish | source
    fzf --fish | source
    atuin init fish --disable-up-arrow | source
    zoxide init fish | source
end

# source ~/.zprofile

# load configs
# source ~/.zsh/02-integrations.zsh
source ~/.zsh/04-alias.zsh
# source ~/.zsh/05-functions.zsh
# source ~/.zsh/07-oh-my-zsh.zsh
# source ~/.zsh/08-termux.zsh
# [[ -f ~/.zcustom ]] && source ~/.zcustom
