vim.api.nvim_buf_set_keymap(0, 'i', '<tab>', '<cmd>AutolistTab<cr>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'i', '<s-tab>', '<cmd>AutolistShiftTab<cr>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'i', '<CR>', '<CR><cmd>AutolistNewBullet<cr>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', 'o', 'o<cmd>AutolistNewBullet<cr>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', 'O', 'O<cmd>AutolistNewBulletBefore<cr>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', '<cmd>AutolistToggleCheckbox<cr><CR>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<C-r>', '<cmd>AutolistRecalculate<cr>', { noremap = true, silent = true })

-- cycle list types with dot-repeat
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>cn', '<cmd>AutolistCycleNext<cr>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>cp', '<cmd>AutolistCyclePrev<cr>', { noremap = true, silent = true })

-- functions to recalculate list on edit
vim.api.nvim_buf_set_keymap(0, 'n', '>>', '>><cmd>AutolistRecalculate<cr>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', '<<', '<<<cmd>AutolistRecalculate<cr>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'n', 'dd', 'dd<cmd>AutolistRecalculate<cr>', { noremap = true, silent = true })
vim.api.nvim_buf_set_keymap(0, 'v', 'd', 'd<cmd>AutolistRecalculate<cr>', { noremap = true, silent = true })
