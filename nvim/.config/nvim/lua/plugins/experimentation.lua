-- <M-h> <M-j> <M-k> <M-l> to move lines and blocks
vim.pack.add { 'https://github.com/nvim-mini/mini.move' }
require('mini.move').setup {}

-- Yank selection replacing latest put region [Y [y ]y ]Y
-- File on disk [F [f ]f ]F
-- Comment block [C [c ]c ]C
-- Conflict marker [X [x ]x ]X
vim.pack.add { 'https://github.com/nvim-mini/mini.bracketed' }
require('mini.bracketed').setup {
  quickfix = { suffix = '' },
}

-- Set a different colorscheme per filetype
vim.pack.add { 'https://github.com/folke/styler.nvim' }
require('styler').setup {
  themes = {
    markdown = { colorscheme = 'tokyonight', background = 'dark' },
    help = { colorscheme = 'tokyonight', background = 'dark' },
  },
}
