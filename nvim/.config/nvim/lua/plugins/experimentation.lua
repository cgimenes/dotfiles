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

-- CSV viewer
vim.pack.add { 'https://github.com/hat0uma/csvview.nvim' }
require('csvview').setup()

-- Unstack
vim.pack.add { 'https://github.com/relf108/nvim-unstack' }
require('nvim-unstack').setup {
  mapkey = '<leader>U',
  layout = 'tab',
}
