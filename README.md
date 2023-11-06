# Backup Cinnamon

`dconf dump /org/cinnamon/ > cinnamon_desktop_backup`

# Restore Cinnamon

`dconf load /org/cinnamon/ < cinnamon_desktop_backup`

# Restore System

`stow -t / system`
