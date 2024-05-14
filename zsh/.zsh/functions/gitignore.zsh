function gitignore() {
  template=$(curl -sL https://www.toptal.com/developers/gitignore/api/list | tr ',' '\n' | fzf-tmux -p --prompt="Select a template: " --reverse --header="Use TAB for multi-select" -m | paste -sd "," -)
  if [ -z "$template" ]; then
    return 1
  fi
  curl -sL "https://www.toptal.com/developers/gitignore/api/$template" > .gitignore
}
