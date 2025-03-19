export TERM="xterm-256color"

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="brave"
if [[ "$OSTYPE" == "darwin"* ]]; then
	export MACOS=true
	export BROWSER="vivaldi"
fi
export READER="zathura"
export FILE="yazi"
export VISUAL="nvim"
export PAGER="less -R"
export MANPAGER="nvim +Man!"

export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
