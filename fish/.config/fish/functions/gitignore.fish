function gitignore
    set template (curl -sL https://www.toptal.com/developers/gitignore/api/list | tr ',' '\n' | fzf-tmux -p --prompt="Select a template: " --reverse --header="Use TAB for multi-select" -m | paste -sd "," -)
    if test -z "$template"
        return 1
    end
    curl -sL "https://www.toptal.com/developers/gitignore/api/$template" > .gitignore
end
