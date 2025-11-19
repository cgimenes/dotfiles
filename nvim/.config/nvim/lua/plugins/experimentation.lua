-- <M-h> <M-j> <M-k> <M-l> to move lines and blocks
vim.pack.add { 'https://github.com/nvim-mini/mini.move' }
require('mini.move').setup {}

-- Yank selection replacing latest put region [Y [y ]y ]Y
-- File on disk [F [f ]f ]F
vim.pack.add { 'https://github.com/nvim-mini/mini.bracketed' }
require('mini.bracketed').setup {
  file = { suffix = 'f' },
  yank = { suffix = 'y' },
  buffer = { suffix = '' },
  comment = { suffix = '' },
  conflict = { suffix = '' },
  diagnostic = { suffix = '' },
  indent = { suffix = '' },
  jump = { suffix = '' },
  location = { suffix = '' },
  oldfile = { suffix = '' },
  quickfix = { suffix = '' },
  treesitter = { suffix = '' },
  undo = { suffix = '' },
  window = { suffix = '' },
}

-- Outline
require('lz.n').load {
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
