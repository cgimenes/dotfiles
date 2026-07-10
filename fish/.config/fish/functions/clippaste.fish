function clippaste
    if test (uname) = Darwin; and command -q pbpaste
        pbpaste
    else if set -q WAYLAND_DISPLAY; and command -q wl-paste
        wl-paste --no-newline
    else if set -q DISPLAY; and command -q xsel
        xsel --clipboard --output
    else if set -q DISPLAY; and command -q xclip
        xclip -out -selection clipboard
    else if command -q win32yank
        win32yank -o
    else if set -q TMUX; and command -q tmux
        tmux save-buffer -
    else
        echo "clippaste: no clipboard tool found" >&2
        return 1
    end
end
