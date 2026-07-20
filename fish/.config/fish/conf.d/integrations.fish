if status is-interactive
    # Starship
    if command -q starship
        starship init fish | source
    end

    # FZF
    if command -q fzf
        fzf --fish | source
    end

    # Atuin
    if command -q atuin
        atuin init fish --disable-up-arrow | source
    end

    # Zoxide
    if command -q zoxide
        zoxide init fish | source
    end
end

# fzf walks the tree via fd when present.
if command -v fd >/dev/null 2>&1
    set -gx FZF_DEFAULT_COMMAND 'fd --hidden --follow --exclude .git'
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git'
end

set -gx FZF_DEFAULT_OPTS "
--cycle
--bind=ctrl-u:half-page-up
--bind=ctrl-d:half-page-down
--color scrollbar:#dcd7ba,marker:#7fb4ca,fg:#dcd7ba,query:#dcd7ba:regular,hl+:#7fb4ca,bg+:#363646,hl:#7fb4ca,info:#54546d,prompt:#7fb4ca,separator:#dcd7ba,border:#dcd7ba,header:#dcd7ba,pointer:#7fb4ca,spinner:#7fb4ca
"

# Go
if command -q go
    set -gx GOPATH $HOME/dev
    fish_add_path (go env GOPATH)/bin
end

# Ruby gems
if command -q gem
    for p in (gem environment path | string split :)
        fish_add_path $p/bin
    end
end

# pyenv
if command -q pyenv
    set -gx PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    pyenv init - | source
end

# mise
if command -q mise
    mise activate fish | source
end

# gcloud
if test -d $HOME/dev/google-cloud-sdk
    fish_add_path $HOME/dev/google-cloud-sdk/bin
end

# Android LEDGER_FILE override
if string match -q Android (uname -o 2>/dev/null)
    set -gx LEDGER_FILE $HOME/storage/shared/Documents/Ledger/2026.hledger
end
