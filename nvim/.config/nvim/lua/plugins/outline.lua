vim.pack.add {
  'gh:SmiteshP/nvim-navic',
  'gh:MunifTanjim/nui.nvim',
  'gh:hasansujon786/nvim-navbuddy',
}
require('nvim-navbuddy').setup {
  lsp = { auto_attach = true },
  window = { size = '90%' },
}
Map { '<leader>lo', '<cmd>Navbuddy<cr>', desc = 'Outline' }
Map { '<leader>lO', '<cmd>Navbuddy root<cr>', desc = 'Outline (Root)' }
