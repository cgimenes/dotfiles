if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

# load configs
for config (~/.zsh/*.zsh) source $config

if [[ "$ZPROF" = true ]]; then
  zprof
fi

profzsh() {
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
