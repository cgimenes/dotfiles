function clipcopy
    if test (uname) = Darwin; and command -q pbcopy
        cat $argv | pbcopy
    else if set -q WAYLAND_DISPLAY; and command -q wl-copy
        cat $argv | wl-copy
    else if set -q DISPLAY; and command -q xsel
        cat $argv | xsel --clipboard --input
    else if set -q DISPLAY; and command -q xclip
        cat $argv | xclip -selection clipboard -in
    else if command -q win32yank
        cat $argv | win32yank -i
    else if set -q TMUX; and command -q tmux
        cat $argv | tmux load-buffer -
    else
        echo "clipcopy: no clipboard tool found" >&2
        return 1
    end
end
