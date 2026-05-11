vim.pack.add {
  'gh:SmiteshP/nvim-navic',
  'gh:MunifTanjim/nui.nvim',
  'gh:hasansujon786/nvim-navbuddy',
}
require('nvim-navbuddy').setup {
  lsp = { auto_attach = true },
  window = { size = '90%' },
}
Map { '<leader>lO', '<cmd>Navbuddy<cr>', desc = 'Outline' }

vim.pack.add { 'gh:hedyhli/outline.nvim' }
vim.keymap.set('n', '<leader>lo', '<cmd>Outline<CR>', { desc = 'Toggle Outline' })
require('outline').setup {}
