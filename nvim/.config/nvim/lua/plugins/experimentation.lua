-- toggleterm
vim.pack.add {
  { src = 'https://github.com/akinsho/toggleterm.nvim', version = vim.version.range '*' },
}
require('toggleterm').setup {
  size = function(term)
    if term.direction == 'horizontal' then
      return 10
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    else
      return 20
    end
  end,
  auto_scroll = false,
}
Map { '<leader>.', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' }
Map { '<leader>>', '<cmd>ToggleTerm direction=vertical<cr>', desc = 'Toggle Vertical Terminal' }

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
