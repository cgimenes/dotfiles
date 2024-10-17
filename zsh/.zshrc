if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

# load configs
source ~/.zsh/0-env.zsh
source ~/.zsh/1-zgen.zsh
source ~/.zsh/2-alias.zsh
source ~/.zsh/3-functions.zsh
source ~/.zsh/4-autocompletion.zsh
source ~/.zsh/5-prompt.zsh
source ~/.zsh/6-fzf.zsh
source ~/.zsh/7-oh-my-zsh-plugins.zsh
source ~/.zsh/8-zoxide.zsh
source ~/.zsh/999-custom.zsh

if [[ "$ZPROF" = true ]]; then
  zprof
fi

profzsh() {
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}

