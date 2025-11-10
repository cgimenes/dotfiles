vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/mistweaverco/kulala.nvim',
}
require('kulala').setup {
  global_keymaps = true,
  global_keymaps_prefix = '<leader>R',
  ui = {
    default_winbar_panes = { 'body', 'headers', 'verbose', 'script_output', 'stats', 'report' },
    show_variable_info_text = 'float',
  },
  debug = 0,
}
Map {
  '<leader>Rb',
  function()
    require('kulala').scratchpad()
  end,
  desc = 'Open scratchpad',
}
