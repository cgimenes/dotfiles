if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

# load configs
source ~/.zsh/00-env.zsh
source ~/.zsh/01-opts.zsh
source ~/.zsh/02-integrations.zsh
source ~/.zsh/03-zgen.zsh
source ~/.zsh/04-alias.zsh
source ~/.zsh/05-functions.zsh
source ~/.zsh/06-autocompletion.zsh
source ~/.zsh/07-prompt.zsh
source ~/.zsh/08-fzf.zsh
source ~/.zsh/09-oh-my-zsh-plugins.zsh
source ~/.zsh/10-zoxide.zsh
source ~/.zsh/999-custom.zsh

if [[ "$ZPROF" = true ]]; then
  zprof
fi

profzsh() {
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}

