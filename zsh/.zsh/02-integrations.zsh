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
