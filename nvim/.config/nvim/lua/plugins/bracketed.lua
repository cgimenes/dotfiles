-- File on disk [F [f ]f ]F
vim.pack.add { 'https://github.com/nvim-mini/mini.bracketed' }
require('mini.bracketed').setup {
  file = { suffix = 'f' },
  yank = { suffix = '' },
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

