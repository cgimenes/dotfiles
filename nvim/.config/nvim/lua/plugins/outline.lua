LazyLoad {
  'nvim-navbuddy',
  after = function()
    vim.pack.add {
      'https://github.com/SmiteshP/nvim-navic',
      'https://github.com/MunifTanjim/nui.nvim',
      'https://github.com/hasansujon786/nvim-navbuddy',
    }
    require('nvim-navbuddy').setup {
      lsp = { auto_attach = true },
      window = { size = '90%' },
    }
  end,
  keys = {
    { '<leader>lo', '<cmd>Navbuddy root<cr>', desc = 'Outline' },
  },
}
