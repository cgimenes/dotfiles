if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/oliveira/miniconda3/bin/conda
    eval /home/oliveira/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

