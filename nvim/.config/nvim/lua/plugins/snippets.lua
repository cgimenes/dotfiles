vim.pack.add { 'https://github.com/chrisgrieser/nvim-scissors' }
require('scissors').setup { snippetDir = vim.fn.stdpath 'config' .. '/snippets' }
Map {
  '<leader>cse',
  function()
    require('scissors').editSnippet()
  end,
  desc = 'Edit Snippet',
}
Map {
  '<leader>csa',
  function()
    require('scissors').addNewSnippet()
  end,
  desc = 'Add Snippet',
  mode = { 'n', 'x' },
}
