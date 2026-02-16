vim.pack.add { 'https://github.com/chrisgrieser/nvim-scissors' }
require('scissors').setup { snippetDir = vim.fn.stdpath 'config' .. '/snippets' }
Map {
  '<leader>Se',
  function()
    require('scissors').editSnippet()
  end,
  desc = 'Edit Snippet',
}
Map {
  '<leader>Sa',
  function()
    require('scissors').addNewSnippet()
  end,
  desc = 'Add Snippet',
  mode = { 'n', 'x' },
}
