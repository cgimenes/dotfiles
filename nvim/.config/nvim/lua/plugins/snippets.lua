return {
  {
    'chrisgrieser/nvim-scissors',
    lazy = false,
    opts = {
      snippetDir = vim.fn.stdpath 'config' .. '/snippets',
    },
    keys = {
      {
        '<leader>cse',
        function()
          require('scissors').editSnippet()
        end,
        desc = 'Edit Snippet',
      },
      {
        '<leader>csa',
        function()
          require('scissors').addNewSnippet()
        end,
        desc = 'Add Snippet',
        mode = { 'n', 'x' },
      },
    },
  },
}
