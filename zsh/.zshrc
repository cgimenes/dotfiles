if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi
source ~/.zprofile

# load configs
source ~/.zsh/01-opts.zsh
source ~/.zsh/02-integrations.zsh
source ~/.zsh/03-zgen.zsh
source ~/.zsh/04-alias.zsh
source ~/.zsh/05-functions.zsh
source ~/.zsh/06-autocompletion.zsh
source ~/.zsh/07-oh-my-zsh.zsh
[[ -f ~/.zcustom ]] && source ~/.zcustom

if [[ "$ZPROF" = true ]]; then
  zprof
fi

profzsh() {
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}
