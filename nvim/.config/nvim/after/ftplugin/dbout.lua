vim.keymap.set('n', '<localleader>e', '<Plug>(DBUI_ToggleResultLayout)', { buffer = true, desc = 'Toggle expanded results display' })
vim.keymap.set('n', '<localleader>j', '<Plug>(DBUI_JumpToForeignKey)', { buffer = true, desc = 'Jump to foreign key' })
vim.keymap.set('n', '<localleader>h', '<Plug>(DBUI_YankHeader)', { buffer = true, desc = 'Yank header' })
vim.keymap.set('n', 'vic', '<Plug>(DBUI_YankCellValue)', { buffer = true, desc = 'Select and yank cell value' })
