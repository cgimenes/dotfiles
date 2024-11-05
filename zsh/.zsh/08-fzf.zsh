export FZF_DEFAULT_OPTS="--cycle --bind=ctrl-u:half-page-up --bind=ctrl-d:half-page-down"

if [ -x "$(command -v fzf)" ]; then
	source <(fzf --zsh)
fi
