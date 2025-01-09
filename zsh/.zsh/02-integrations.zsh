if [ -x "$(command -v /opt/homebrew/bin/brew)" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -x "$(command -v go)" ]; then
	export GOPATH="$HOME/dev"
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

if [ -x "$(command -v mise)" ]; then
	eval "$(mise activate zsh)"
fi

if [ -d "$HOME/dev/google-cloud-sdk/" ]; then
	export PATH=$PATH:$HOME/dev/google-cloud-sdk/bin
	source $HOME/dev/google-cloud-sdk/completion.zsh.inc
fi

if [ -x "$(command -v fzf)" ]; then
	export FZF_DEFAULT_OPTS="
	  --cycle
	  --bind=ctrl-u:half-page-up
	  --bind=ctrl-d:half-page-down
	  --color scrollbar:#dcd7ba,marker:#7fb4ca,fg:#dcd7ba,query:#dcd7ba:regular,hl+:#7fb4ca,bg+:#363646,hl:#7fb4ca,info:#54546d,prompt:#7fb4ca,separator:#dcd7ba,border:#dcd7ba,header:#dcd7ba,pointer:#7fb4ca,spinner:#7fb4ca
	"
	source <(fzf --zsh)
fi

if [ -x "$(command -v atuin)" ]; then
	eval "$(atuin init zsh --disable-up-arrow)"
fi

if [ -x "$(command -v zoxide)" ]; then
	eval "$(zoxide init zsh)"
fi

if [ -x "$(command -v starship)" ]; then
	eval "$(starship init zsh)"
fi
