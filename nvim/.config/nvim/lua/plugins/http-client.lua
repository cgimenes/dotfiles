vim.pack.add {
  'gh:nvim-treesitter/nvim-treesitter',
  'gh:mistweaverco/kulala.nvim',
}
require('kulala').setup {
  global_keymaps = true,
  global_keymaps_prefix = '<leader>H',
  ui = {
    default_winbar_panes = { 'body', 'headers', 'verbose', 'script_output', 'stats', 'report' },
    show_variable_info_text = 'float',
  },
  debug = 0,
}
Map {
  '<leader>Hb',
  function()
    require('kulala').scratchpad()
  end,
  desc = 'Open scratchpad',
}
