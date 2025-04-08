return {
  {
    -- select words with Ctrl-N (like Ctrl-d in Sublime Text/VS Code)
    -- create cursors vertically with Ctrl-Down/Ctrl-Up
    -- select one character at a time with Shift-Arrows
    -- press n/N to get next/previous occurrence
    -- press [/] to select next/previous cursor
    -- press q to skip current and get next occurrence
    -- press Q to remove current cursor/selection
    -- start insert mode with i,a,I,A
    'mg979/vim-visual-multi',
  },
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
