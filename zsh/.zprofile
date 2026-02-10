export TERM="xterm-256color"

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="brave"
if [[ "$OSTYPE" == "darwin"* ]]; then
	export MACOS=true
fi
export READER="zathura"
export FILE="yazi"
export VISUAL="nvim"
export PAGER="less -R"
export MANPAGER="nvim +Man!"

export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/rg/config"
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

export LEDGER_FILE="$HOME/ledger/current.hledger"
export TIMELOG_DIR="$HOME/Public/Timeclock"
