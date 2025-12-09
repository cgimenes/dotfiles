vim.pack.add {
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/ThePrimeagen/refactoring.nvim',
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
