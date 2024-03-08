# download zgen
if [ ! -d "${HOME}/.zgen" ]; then
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
fi

export ZGEN_AUTOLOAD_COMPINIT=0

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init scipt doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/kubectl
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-completions
    zgen load zsh-users/zsh-autosuggestions
    zgen load chrissicool/zsh-256color
    zgen load superbrothers/zsh-kubectl-prompt
    zgen load Aloxaf/fzf-tab

    # save all to init script
    zgen save
fi

# plugin's config
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'
bindkey '^ ' autosuggest-accept
