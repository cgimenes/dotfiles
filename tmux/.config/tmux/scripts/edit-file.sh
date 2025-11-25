#!/usr/bin/env bash
set -eo pipefail

# This helper is invoked from copy-mode when the user presses Enter.
# It attempts to emulate the default behaviour of copying the current
# selection while also parsing file paths. If the selection looks like
# a file:line[:col] location, the script will open that file at the
# specified line in the nearest pane that is nvim instance.
current_pane=$(tmux display-message -p '#{pane_id}')
current_window=$(tmux display-message -p '#{window_id}')

# Must be in copy-mode and have a valid copy-mode cursor
cursor_y=$(tmux display-message -p -t "$current_pane" '#{?pane_in_mode,#{copy_cursor_y},}')
if [ -z "$cursor_y" ]; then
  tmux send -X cancel 2>/dev/null || true
  exit 0
fi
scroll_pos=$(tmux display-message -p -t "$current_pane" '#{scroll_position}')
cursor_y=$((cursor_y - scroll_pos))

# Capture current and around lines under the copy-mode cursor
start_y=$((cursor_y - 1))
end_y=$((cursor_y + 1))
text=$(tmux capture-pane -p -J -t "$current_pane" -S "$start_y" -E "$end_y" 2>/dev/null || echo "")

# Parse paths
extracted=$(echo "$text" | ~/.config/tmux/plugins/extrakto/extrakto.py -p)

# If nothing found, do nothing further
[ -z "$extracted" ] && exit 0

# Select using fzf-tmux from extracted paths if multiple
if [ "$(echo "$extracted" | wc -l)" -eq 1 ]; then
  full_path=$extracted
else
  full_path=$(echo "$extracted" | fzf-tmux -p || true)
fi

# If nothing selected, do nothing further
[ -z "$full_path" ] && exit 0

# First nvim pane in this window
target_pane=$(tmux list-panes -t "$current_window" -F '#{pane_id} #{pane_current_command}' |
  awk '$2=="nvim"{print $1; exit}')
[ -z "$target_pane" ] && exit 0

# Drive Neovim
tmux send-keys -t "$target_pane" Escape
tmux send-keys -t "$target_pane" ":e ${full_path}" Enter

# Switch focus to the Neovim pane
tmux send -X cancel 2>/dev/null || true
tmux select-pane -t "$target_pane" 2>/dev/null || true

exit 0
