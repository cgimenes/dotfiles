local setlocal = vim.opt_local

setlocal.tabstop = 4
setlocal.shiftwidth = 4

vim.b[0].snacks_indent = false

vim.keymap.set({ 'n', 'x' }, '<cr>', '<Plug>(MarkdownPlusToggleCheckbox)', { buffer = true, desc = 'Toggle Checkbox' })
vim.keymap.set('n', 'o', '<Plug>(MarkdownPlusNewListItemBelow)', { buffer = true })
vim.keymap.set('n', 'O', '<Plug>(MarkdownPlusNewListItemAbove)', { buffer = true })
vim.keymap.set('i', '<CR>', '<Plug>(MarkdownPlusListEnter)', { buffer = true })
vim.keymap.set('i', '<A-CR>', '<Plug>(MarkdownPlusListShiftEnter)', { buffer = true })
vim.keymap.set('n', '<leader>mlr', '<Plug>(MarkdownPlusRenumberLists)', { buffer = true, desc = 'Renumber Lists' })
vim.keymap.set('n', '<leader>mld', '<Plug>(MarkdownPlusDebugLists)', { buffer = true, desc = 'Debug Lists' })
