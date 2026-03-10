-- CSV viewer
vim.pack.add { 'https://github.com/hat0uma/csvview.nvim' }
require('csvview').setup()

-- Unstack
vim.pack.add { 'https://github.com/relf108/nvim-unstack' }
require('nvim-unstack').setup {
  mapkey = '<leader>U',
  layout = 'tab',
}

-- Neogit
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/NeogitOrg/neogit',
}
Map { '<leader>gG', '<cmd>Neogit<cr>', desc = 'Neogit' }
