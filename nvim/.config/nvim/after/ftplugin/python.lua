vim.api.nvim_buf_set_keymap(0, 'n', '<leader>tS', '<cmd>TestSuite --ff<cr>', { noremap = true, silent = true, desc = '[T]est [S]uite Failed First' })
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>tF', '<cmd>TestSuite --lf<cr>', { noremap = true, silent = true, desc = '[T]est [F]ailed' })
