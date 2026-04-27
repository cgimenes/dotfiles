vim.pack.add {
  'gh:lewis6991/async.nvim',
  'gh:ThePrimeagen/refactoring.nvim',
}
require('refactoring').setup {}
Map {
  '<leader>lR',
  function() require('refactoring').select_refactor() end,
  desc = 'Refactor',
  mode = { 'n', 'x' },
}
