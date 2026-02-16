vim.pack.add {
  { src = 'https://github.com/akinsho/toggleterm.nvim', version = vim.version.range '*' },
}
---@type ToggleTermConfig
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
  persist_size = false,
  on_create = function(term)
    vim.keymap.set('n', '<CR>', '<cmd>OpenPathOnWindow<cr>', {
      buffer = term.bufnr,
      desc = 'Open file on line number (pick window)',
      noremap = true,
      silent = true,
    })
    -- Disable winbar
    vim.api.nvim_set_option_value('winbar', '', { win = term.window })
  end,
}
Map { '<leader>.', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' }
Map { '<leader>>', '<cmd>ToggleTerm direction=vertical<cr>', desc = 'Toggle Vertical Terminal' }
