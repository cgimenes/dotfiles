if ! [ -x "$(command -v trans)" ]; then
    echo "Installing trans"
    mkdir -p $HOME/.local/bin
    wget git.io/trans -O $HOME/.local/bin/trans -q
    chmod +x $HOME/.local/bin/trans
fi
