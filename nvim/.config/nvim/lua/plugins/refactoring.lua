vim.pack.add {
  'gh:nvim-treesitter/nvim-treesitter',
  'gh:nvim-lua/plenary.nvim',
  'gh:ThePrimeagen/refactoring.nvim',
}
require('refactoring').setup {}
Map {
  '<leader>lR',
  function()
    require('refactoring').select_refactor()
  end,
  desc = 'Refactor',
  mode = { 'n', 'x' },
}
