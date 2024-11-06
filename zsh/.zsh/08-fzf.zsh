export FZF_DEFAULT_OPTS="
  --cycle
  --bind=ctrl-u:half-page-up
  --bind=ctrl-d:half-page-down
  --color scrollbar:#dcd7ba,marker:#7fb4ca,fg:#dcd7ba,query:#dcd7ba:regular,hl+:#7fb4ca,bg+:#363646,hl:#7fb4ca,info:#54546d,prompt:#7fb4ca,separator:#dcd7ba,border:#dcd7ba,header:#dcd7ba,pointer:#7fb4ca,spinner:#7fb4ca
"

if [ -x "$(command -v fzf)" ]; then
	source <(fzf --zsh)
fi
