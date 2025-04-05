vim.api.nvim_buf_set_keymap(0, 'n', '<leader>tS', '<cmd>TestSuite --ff<cr>', { noremap = true, silent = true, desc = 'Test Suite Failed First' })
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>tF', '<cmd>TestSuite --lf<cr>', { noremap = true, silent = true, desc = 'Test Failed' })
