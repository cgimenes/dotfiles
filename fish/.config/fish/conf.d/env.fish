set -gx TERM xterm-256color

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx TERMINAL alacritty
set -gx BROWSER brave
set -gx READER zathura
set -gx FILE yazi
set -gx PAGER 'less -R'
set -gx MANPAGER 'nvim +Man!'

fish_add_path $HOME/.local/bin
set -gx XDG_CONFIG_HOME $HOME/.config

set -gx RIPGREP_CONFIG_PATH $XDG_CONFIG_HOME/rg/config
set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx QT_AUTO_SCREEN_SCALE_FACTOR 0
set -gx GTK2_RC_FILES $HOME/.gtkrc-2.0

set -gx LEDGER_FILE $HOME/ledger/current.hledger
set -gx TIMELOG_DIR $HOME/Public/Timeclock

# Fix Java applications not resizing properly
set -gx _JAVA_AWT_WM_NONREPARENTING 1
