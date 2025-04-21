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
    '2kabhishek/exercism.nvim',
    dependencies = {
      '2kabhishek/utils.nvim', -- required, for utility functions
      '2kabhishek/termim.nvim', -- optional, better UX for running tests
    },
    opts = {},
    keys = {
      { '<leader>el', '<cmd>ExercismLanguages<cr>', desc = 'List Languages' },
      { '<leader>eS', '<cmd>ExercismSubmit<cr>', desc = 'Submit' },
      { '<leader>et', '<cmd>ExercismTest<cr>', desc = 'Test' },
      { '<leader>eL', '<cmd>ExercismList<cr>', desc = 'List Exercises' },
    },
  },
  {
    'abecodes/tabout.nvim',
    event = 'InsertCharPre',
    config = true,
  },
  {
    'yioneko/nvim-vtsls',
    ft = { 'typescript', 'javascript' },
    keys = {
      { '<leader>lg', '<cmd>VtsExec goto_source_definition<cr>', desc = 'Go to Source Definition' },
      { '<leader>lo', '<cmd>VtsExec organize_imports<cr>', desc = 'Organize Imports' },
    },
  },
}
