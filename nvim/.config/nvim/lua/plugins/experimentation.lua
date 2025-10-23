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

-- store
vim.pack.add { 'https://github.com/alex-popov-tech/store.nvim' }
require('store').setup { plugin_manager = 'vim.pack' }
